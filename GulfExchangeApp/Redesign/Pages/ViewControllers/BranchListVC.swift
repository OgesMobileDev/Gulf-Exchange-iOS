//
//  BranchListVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 26/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import MapKit
import ScreenShield

class BranchListVC: UIViewController, MKMapViewDelegate {
    
    //MARK: - Variable Declaration
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var branchListTableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var closeBtn: UIButton!
    
    var timer = Timer()
    let defaults = UserDefaults.standard
    var timerGesture = UITapGestureRecognizer()
    var arrLocation:[String]=[]
    var arrBranch:[[String:AnyObject]]=[]
    var arrSearchBranch:[[String:AnyObject]]=[]
    var processedBranches: [processedBranch] = []
    var processedSearchBranches: [processedBranch] = []
    var locations:[String:Any] = [:]
    var temArr : [[String:Any]] = []
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var indexPath1 : IndexPath?
    var selectedIndex:Int?
    var selectionIndex: Int? = nil
    var searchData:[MapSearch] = []
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        searchTF.delegate = self
        addNavbar()
        searchTF.placeholder = "Search Branch"
        closeBtn.setTitle("", for: .normal)
        self.branchListTableView?.register(UINib.init(nibName: "BranchesListTableViewCell", bundle: .main), forCellReuseIdentifier: "BranchesListTableViewCell")
        branchListTableView?.delegate = self
        branchListTableView?.dataSource = self
        branchListTableView.showsVerticalScrollIndicator = false
        //timer required
    }
    override func viewWillAppear(_ animated: Bool) {
        APIManager.shared.fetchToken { token in
            if let token = token {
                // Call login session update
                APIManager.shared.updateSession(sessionType: "1", accessToken: token) { responseCode in
                    if responseCode == "S222" {
                        print("Session Valid")
                    } else {
                        self.handleSessionError()
                    }
                }
            } else {
                print("Failed to fetch token")
            }
        }
        self.callbranchListApi()
        ScreenShield.shared.protect(view: mapView)
        ScreenShield.shared.protectFromScreenRecording()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.showMap()
    }
    
    func handleSessionError() {
        //        if !defaults.string(forKey: "biometricenabled") == "biometricenabled"{
        //
        //        }
                if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
                {
                    
                }
                else
                {
                self.defaults.set("", forKey: "USERID")
                self.defaults.set("", forKey: "PASSW")
                self.defaults.set("", forKey: "PIN")
                self.defaults.set("", forKey: "REGNO")
                }
        self.defaults.set("logoutbiometrc", forKey: "logoutbiometrc")
                UserDefaults.standard.set(false, forKey: "isLoggedIN")
        //        UserDefaults.standard.removeObject(forKey: "biometricenabled")
                
                if let navigationController = self.navigationController {
                    for controller in navigationController.viewControllers {
                        if let tabController = controller as? MainLoginViewController {
                            navigationController.popToViewController(tabController, animated: true)
                            return
                        }
                    }
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
    }
    //MARK: - Button Actions
    @IBAction func closeBtnTapped(_ sender: Any) {
        searchTF.resignFirstResponder()
        
//        arrBranch = arrSearchBranch
//        branchListTableView.reloadData()
    }
    
    
    
    //MARK: - Functions
    
    
    func setBranchData(){
        processedBranches.removeAll()
        processedSearchBranches.removeAll()
        var branchName:NSAttributedString?
        var branchAddress:NSAttributedString?
        var branchTiming:NSAttributedString?
        
        for dic in arrBranch {
            let rawHtmlNameString = dic["branch_name_en"] as? String ?? ""
            let rawHtmlAddressString = dic["branch_address_en"] as? String ?? ""
            let rawHtmlTimingString = dic["branch_timing_en"] as? String ?? ""
            
            if let htmlAttributedString = rawHtmlNameString.htmlToAttributedStringWithRedURLs {
                branchName = htmlAttributedString
            }
            
            if let htmlAttributedString = rawHtmlAddressString.htmlToAttributedStringWithRedURLs {
                branchAddress = htmlAttributedString
            }
            
            if let htmlAttributedString = rawHtmlTimingString.htmlToAttributedStringWithRedURLs {
                branchTiming = htmlAttributedString
            }
            let branch = processedBranch(
                branchName: dic["branch_name_en"] as? String ?? "",
//                branchName: branchName ?? NSAttributedString(string: "Invalid content"),
                branchAddress: branchAddress ?? NSAttributedString(string: "Invalid content"),
                branchTiming: branchTiming ?? NSAttributedString(string: "Invalid content")
            )
            processedBranches.append(branch)
            processedSearchBranches.append(branch)
        }
        
        if processedBranches.count == arrBranch.count{
            branchListTableView.reloadData()
        }else{
            showAlert(title: "Error", message: "Failed to process data. Please try again")
        }
        

    }
    
    
    
    
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        var notificationIMg = "notification_y"
        if notificationCount{
            notificationIMg = "notification_y"
        }else{
            notificationIMg = "notification_n"
        }
        let notificationBtn = UIBarButtonItem(image: UIImage(named: notificationIMg), style: .done, target: self, action: #selector(notificationAction))
        let helpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItems  = [helpBtn, notificationBtn]
        self.navigationItem.title = NSLocalizedString("branches", comment: "")
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func heplVCAction(){
        
//        if defaults.bool(forKey: "accessibilityenabled"){
//            SpeechHelper.shared.speak("help", languageCode: "en")
//        }
//        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HelpVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func notificationAction(){
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("notification", languageCode: "en")
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: NotificationListVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationListVC") as! NotificationListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - API Calls
    func callbranchListApi(){//completion: @escaping (_ response:String, _ error:String)->Void){//(completion: (_ success: Bool) -> Void){
        self.activityIndicator("Loading")
        
        let data:BranchDataModel = BranchDataModel()
        if Connectivity.isNetworkAvailable{
            data.FetchDataJson(completionHandler: { response in
                switch response{
                case .success(let arrRes):
                    print(arrRes)
                    self.arrBranch = arrRes
                    self.arrSearchBranch = arrRes
                    //                    DispatchQueue.main.async {
                    //  defer {
                    for dic in arrRes{
                        self.locations = ["title": dic["branch_name_en"] as? String ?? "",
                                          "latitude": dic["lattitude"] as? Double ?? 0.0 ,
                                          "longitude":dic["longitude"] as? Double ?? 0.0
                        ]
                        self.temArr.append(self.locations)
                    }
                    DispatchQueue.main.async(execute: {
                        
                        self.setBranchData()
//                        self.branchListTableView.reloadData()
                        self.showMap()
                    })
                    
                    self.effectView.removeFromSuperview()
                    //  completion("Success","error")
                    
                case .failure( _): break
                    self.effectView.removeFromSuperview()
                }
            })
        }
    }
    
    func showMap(){
        print(temArr)
      mapView.delegate = self
        for location in temArr {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            
            
            mapView.addAnnotation(annotation)
         //   mapView.selectAnnotation(annotation, animated: true)
            
            let span = MKCoordinateSpan(latitudeDelta: 1.8, longitudeDelta: 1.8)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double), span: span)
//
//            mapView.showsUserLocation = true
//            mapView.userTrackingMode = .follow
            
            
//          if #available(iOS 11.0, *) {
//            mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//          } else {
//            // Fallback on earlier versions
//
//          }

            mapView.setRegion(region, animated: true)

            
        }
    }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
  if annotation is MKUserLocation {
      return nil
  }

  if #available(iOS 11.0, *) {
    return nil
  } else {
      let reuseId = "DefaultIdentifier"
      var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
      if pinView == nil {
          pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
          pinView?.canShowCallout = true
      } else {
          pinView?.annotation = annotation
      }

      return pinView
  }
}
    func activityIndicator(_ title: String) {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
}


extension BranchListVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
           
           // Calculate the new text
           let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
           
           // Filter the arrSearchBranch array
           if updatedText.isEmpty {
               // If the text field is empty, reset the filtered branches
               arrBranch = arrSearchBranch
               processedBranches = processedSearchBranches
           } else {
               arrBranch = arrSearchBranch.filter { branch in
                   if let branchName = branch["branch_name_en"] as? String {
                       return branchName.lowercased().contains(updatedText.lowercased())
                   }
                   return false
               }
               processedBranches = processedSearchBranches.filter { branch in
                   if let branchName = branch.branchName {
                       return branchName.lowercased().contains(updatedText.lowercased())
                   }
                   return false
               }
           }
           
           // Reload your table view or update the UI as needed to show filteredBranches
           print(arrBranch) // Debugging: Show filtered results
        selectedIndex = nil
        branchListTableView.reloadData()
        return true // Allow the text field to update
    }
    
    
    
}


extension BranchListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBranch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchesListTableViewCell", for: indexPath) as! BranchesListTableViewCell
        let dic = arrBranch[indexPath.row]
        let data = processedBranches[indexPath.row]
        
        if indexPath.row == selectionIndex{
            cell.bgView.backgroundColor = UIColor.rgba(249, 249, 249, 1)
        }else{
            cell.bgView.backgroundColor = UIColor.rgba(255, 255, 255, 1)
        }
        print(dic["open_status"] as? Int ?? 100)
        if dic["open_status"] as? Int ?? 0 == 0{
            cell.setOpenStatus(isOpen: false)
        }else{
            cell.setOpenStatus(isOpen: true)
        }
        cell.branchNameLbl.text = dic["branch_name_en"] as? String ?? ""
//        cell.configureTitleLbl(with: dic["branch_name_en"] as? String ?? "", size: 14, font: .regular)
//        cell.configureAddressLbl(with: dic["branch_address_en"] as? String ?? "", size: 10, font: .medium)
//        cell.configureTimingLbl(with: dic["branch_timing_en"] as? String ?? "", size: 10, font: .medium)

//        cell.configureTitleLbl1(with: data.branchName, size: 14, font: .regular)
        cell.configureAddressLbl1(with: data.branchAddress, size: 10, font: .medium)
        cell.configureTimingLbl1(with: data.branchTiming, size: 10, font: .medium)
        
        cell.directionBtn.addTarget(self, action: #selector(mapVcNav), for: .touchUpInside)
        cell.directionBtn.tag = indexPath.row
        cell.callBtn.addTarget(self, action: #selector(mobileNavigation), for: .touchUpInside)
        cell.callBtn.tag = indexPath.row
        cell.selectionBtn.addTarget(self, action: #selector(moveToLoc), for: .touchUpInside)
        cell.selectionBtn.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("seekcmkdcnd")
    }
    @objc func mapVcNav(sender: UIButton){
        let dic = arrBranch[sender.tag]
        let latitudeDest = String(dic["lattitude"] as? Double ?? 0.0)
        let longitudeDest = String(dic["longitude"] as? Double ?? 0.0)
        let defaults = UserDefaults.standard
        let userLatitude = defaults.string(forKey: "USERLATITUDE") ?? "0.0"
        let userLongitude = defaults.string(forKey: "USERLONGITUDE") ?? "0.0"
        //        let latiudeDouble = NumberFormatter().number(from: String(dic["lattitude"] as? Double ?? 0.0))?.doubleValue
        //        let longitudeDouble = NumberFormatter().number(from: String(dic["longitude"] as? Double ?? 0.0))?.doubleValue
        
        //        let coordinate = CLLocationCoordinate2DMake(latiudeDouble!, longitudeDouble!)
        //               let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        //               mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
        //let appledirectionsURL = "http://maps.apple.com/?saddr=\(userLatitude),\(userLongitude)&daddr=\(latitudeDest),\(longitudeDest)"
        
        let browerUrl =  "http://maps.google.com/?saddr=\(userLatitude),\(userLongitude)&daddr=\(latitudeDest),\(longitudeDest)&directionsmode=driving"
        
        let googleDirectionsURL = "comgooglemaps://?saddr=\(userLatitude),\(userLongitude)&daddr=\(latitudeDest),\(longitudeDest)"
        var directionsURL = ""
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
            directionsURL = googleDirectionsURL
        } else {
            directionsURL = browerUrl
        }
        guard let url = URL(string: directionsURL) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    @objc func mobileNavigation(sender: UIButton){
        let dic = arrBranch[sender.tag]
        let phoneNumber = dic["tel_phone"] as? String ?? ""
        let formattedNumber = phoneNumber.replacingOccurrences(of: " ", with: "") // Remove spaces
           if let phoneURL = URL(string: "tel://\(formattedNumber)"),
              UIApplication.shared.canOpenURL(phoneURL) {
               UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
           } else {
               print("Cannot open the phone app")
           }
    }
    @objc func moveToLoc(sender: UIButton){
        selectionIndex = sender.tag
        branchListTableView.reloadData()
        let dic = arrBranch[sender.tag]
        let latitudeDest = String(dic["lattitude"] as? Double ?? 0.0)
        let longitudeDest = String(dic["longitude"] as? Double ?? 0.0)
        guard let lat = Double(latitudeDest),
              let lon = Double(longitudeDest) else {
            print("Invalid coordinates")
            return
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        UIView.animate(withDuration: 2.0) {
            self.mapView.setRegion(region, animated: true)
        }
    }
}
struct MapSearch{
    var title:String
    var index:Int
}
struct processedBranch {
    let branchName: String?
    let branchAddress: NSAttributedString
    let branchTiming: NSAttributedString
}
