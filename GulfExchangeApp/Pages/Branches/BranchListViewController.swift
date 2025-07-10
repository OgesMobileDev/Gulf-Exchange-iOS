//
//  BranchListViewController.swift
//  GulfExchangeApp
//
//  Created by Philip on 27/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import MapKit

class BranchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    var timer = Timer()
    let defaults = UserDefaults.standard
    
    var timerGesture = UITapGestureRecognizer()

    

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var branchListTableView: UITableView!
    private var dateCellExpanded: Bool = false

    var arrLocation:[String]=[]
    var arrBranch:[[String:AnyObject]]=[]
    var locations:[String:Any] = [:]
    var temArr : [[String:Any]] = []
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var indexPath1 : IndexPath?
    var selectedIndex:Int?
   // var flg:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        branchListTableView.delegate = self
        branchListTableView.dataSource = self
        branchListTableView.estimatedRowHeight = 120
//        branchListTableView.rowHeight = UITableView.automaticDimension
        branchListTableView.tableFooterView = UIView()
        
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        resetTimer()

    }
    
    
    @objc func userIsInactive() {
        // Alert user
//        let alert = UIAlertController(title: "You have been inactive for 5 minutes. We're going to log you off for security reasons.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
//        //Log user off
//        }))
//        present(alert, animated: true)
        
        timer.invalidate()
//
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
//
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
                self.navigationController?.pushViewController(nextViewController, animated: true)


        timer.invalidate()
     }

    @objc func resetTimer() {
        print("Reset")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }

    
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = false
        self.title = NSLocalizedString("locations", comment: "")
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        
//        self.callbranchListApi(complete: { () -> () in
//
//           self.showMap()
//
//        })
//        self.callbranchListApi { _,_ in (() -> ()).self in
//            self.showMap()
//        }
        self.callbranchListApi()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showMap()
    }

//MARK:- button action
    @objc func heplVCAction(){
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func showTime(sender: UIButton){
        let dic = arrBranch[sender.tag]
        let buttonPosition = sender.convert(CGPoint.zero, to: self.branchListTableView)
        let indexPath = self.branchListTableView.indexPathForRow(at:buttonPosition)
        let cell1 = self.branchListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath!) as! BranchListTableViewCell
         indexPath1 = IndexPath(row: sender.tag, section: 0)
  
        let cell = self.branchListTableView.cellForRow(at: indexPath1!) as! BranchListTableViewCell
        cell.workingTime.attributedText = (dic["branch_timing_en"] as? String ?? "").convertToAttributedString()

        print(cell.downArrowBtn)//print or get item
        selectedIndex = sender.tag
        if sender.isSelected == false{
         //   flg = true
            sender.isSelected = true
            cell.workingTime.isHidden = false
  //          branchListTableView.rowHeight = 160
            cell.downArrowBtn.setImage(UIImage(named:"upWd.png"), for: .normal)
            cell.viewHeight.constant = 100 + cell.workingTime.frame.height //150 //
//            cell.frame.size.height = 160
//            self.branchListTableView.rectForRow(at: indexPath!)
   //         indexPath1 = []
            self.branchListTableView.beginUpdates()
            self.branchListTableView.endUpdates()
        }else{
         //   flg = false
            sender.isSelected = false
            cell.workingTime.isHidden = true
//            cell.frame.size.height = 120
            cell.downArrowBtn.setImage(UIImage(named:"down_arrow1.png"), for: .normal)
            cell.viewHeight.constant = 120
//            self.branchListTableView.rectForRow(at: indexPath!)
                //       indexPath1 = []
//            branchListTableView.rowHeight = 100
            self.branchListTableView.beginUpdates()
            self.branchListTableView.endUpdates()

        }
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

//MARK:- Tableview delegate & datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBranch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BranchListTableViewCell
        let dic = arrBranch[indexPath.row]
        
//        locations = ["title": dic["branch_name_en"] as? String ?? "",
//                     "latitude": dic["lattitude"] as? Double ?? 0.0 ,
//                     "longitude":dic["longitude"] as? Double ?? 0.0
//                    ]
//        self.temArr.append(locations)

        cell.branchTitle.text = dic["branch_name_en"] as? String ?? ""
        cell.branchLocation.attributedText = (dic["branch_address_en"] as? String ?? "").convertToAttributedString()
//        cell.workingTime.attributedText = (dic["branch_timing_en"] as? String ?? "").convertToAttributedString()
//        cell.workingTime.isHidden = true
        cell.downArrowBtn.addTarget(self, action: #selector(showTime), for: .touchUpInside)
        cell.downArrowBtn.tag = indexPath.row
        cell.workingTime.attributedText = (dic["branch_timing_en"] as? String ?? "").convertToAttributedString()
        cell.workingTime.isHidden = true
        cell.mapBtn.addTarget(self, action: #selector(mapVcNav), for: .touchUpInside)
        cell.mapBtn.tag = indexPath.row
        cell.downArrowBtn.setImage(UIImage(named:"down_arrow1.png"), for: .normal)
                   cell.viewHeight.constant = 120

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
//MARK:- Userdefined Functions
    
    
    func callbranchListApi(){//completion: @escaping (_ response:String, _ error:String)->Void){//(completion: (_ success: Bool) -> Void){
        self.activityIndicator("Loading")

        let data:BranchDataModel = BranchDataModel()
        if Connectivity.isNetworkAvailable{
            data.FetchDataJson(completionHandler: { response in
                switch response{
                case .success(let arrRes):
                    print(arrRes)
                    self.arrBranch = arrRes
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

                        self.branchListTableView.reloadData()
                            self.showMap()
                        })
                    
                    self.effectView.removeFromSuperview()
                  //  completion("Success","error")

                case .failure( _): break
                    self.effectView.removeFromSuperview()
                }
            })


        }
//        self.activityIndi.stopAnimating()
//        self.activityIndi.isHidden = true

    
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
extension UIViewController {
        open override func awakeFromNib() {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
extension UITableView {

  @IBInspectable
  var isEmptyRowsHidden: Bool {
        get {
          return tableFooterView != nil
        }
        set {
          if newValue {
              tableFooterView = UIView(frame: .zero)
          } else {
              tableFooterView = nil
          }
       }
    }
    
}

extension UIViewController {
    func setTitle(_ title: String, andImage image: UIImage) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
  //      let titleView = UIStackView(arrangedSubviews: [imageView, titleLbl])
//        let titleView1 =
//        titleView.axis = .horizontal
//        titleView.spacing = 100.0
        navigationItem.titleView = imageView
    }
}
//extension BranchListViewController: HierarchyTableViewCellDelegate{
//func didTapOnMoreButton(cell: BranchListTableViewCell) {
//    guard let index = branchListTableView.indexPath(for: cell)else{return}
//    if selectedIndex == index.row{
//        selectedIndex = -1
//    }else{
//        selectedIndex = index.row
//    }
//    branchListTableView.reloadRows(at: [index], with: .fade)
//}
//}
