//
//  UpdateIDVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 13/03/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import AVKit
import Alamofire
import SwiftyJSON
import Kingfisher
import AVFoundation
import Photos
import Toast_Swift
import ScreenShield

class UpdateIDVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var idTypeLbl: UILabel!
    @IBOutlet weak var idTypeTF: UITextField!
    @IBOutlet weak var idNumberLbl: UILabel!
    @IBOutlet weak var idNumberTF: UITextField!
    @IBOutlet weak var idIssuerLbl: UILabel!
    @IBOutlet weak var idIssuerTF: UITextField!
    @IBOutlet weak var idExpDateLbl: UILabel!
    @IBOutlet weak var idExpDateTF: UITextField!
    

    @IBOutlet weak var idFrontLbl: UILabel!
    @IBOutlet weak var idBackLbl: UILabel!
    @IBOutlet weak var updateIdLbl: UILabel!
    @IBOutlet weak var idFrontView: UIView!
    @IBOutlet weak var idBackView: UIView!
    @IBOutlet weak var idFrontImgView: UIImageView!
    @IBOutlet weak var idBackImgView: UIImageView!
    @IBOutlet weak var UpdateBtn: UIButton!
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    
    
    var str_id_issuer:String = ""
    var str_id_no:String = ""
    var str_id_exp_date:String = ""
    var str_name_en:String = ""
    var str_name_ar:String = ""
    var strEmail:String = ""
    var str_dob:String = ""
    var str_nationality:String = ""
    var str_address:String = ""
    var str_city:String = ""
    var str_country:String = ""
    var str_gender:String = ""
    var str_country_code:String = ""
    var str_employer:String = ""
    var str_occupation:String = ""
    var str_actualoccupation:String = ""
    var str_occupationtext:String = ""
    var str_working_address:String = ""
    var str_buildingnotxtfd:String = ""
    var str_income:String = ""
    var str_zone:String = ""
    var strMobile:String = ""
    var dualnationalityselstr:String = ""
//    no change
    var str_customerBirthPlace:String = ""
    var str_customerIDIssuedCountry:String = ""
    var str_customerFirstName:String = ""
    var str_customerLastName:String = ""
    var str_customerMiddleName:String = ""
    var str_customerPhone :String = ""
    var str_customerZipCode :String = ""
    var str_visaExpiryDate :String = ""
    var str_visaIssuedBy :String = ""
    var str_visaIssuedDate :String = ""
    var str_visaNo :String = ""
    var str_visaType :String = ""
    var str_workingAddress3 :String = ""
    
    var strBase64videoProfile:String!
    var strBase64:String!
    var strBase641:String!
    var strBase642:String!
    var strBase64Selfie:String!
    
    var testfirstnamestr:String = ""
    var testlastnamestr:String = ""
    var testmiddlenamestr:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleupdateChange(_:)), name: IdUpdateNotification, object: nil)
        addNavbar()
        UpdateBtn.setTitle("", for: .normal)
        updateIdLbl.text = "Update Your ID"
        idFrontLbl.text = "Front ID image"
        idBackLbl.text = "Back ID image"
        
        setLabelWithAsterisk(label: idTypeLbl, text: NSLocalizedString("id_type", comment: ""))
        setLabelWithAsterisk(label: idNumberLbl, text: NSLocalizedString("id_number", comment: ""))
        setLabelWithAsterisk(label: idIssuerLbl, text: NSLocalizedString("id_issuer", comment: ""))
        setLabelWithAsterisk(label: idExpDateLbl, text: NSLocalizedString("id_exp_date", comment: ""))
        
        self.getToken(num: 1)
        setNewImages()
//        self.callSequentialAPIs()
        // Do any additional setup after loading the view.
    }
    @IBAction func updateBtnTapped(_ sender: Any) {
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let vc: UpdateIDVC = UIStoryboard.init(name: "Main10", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateIDVC") as! UpdateIDVC
//        self.navigationController?.pushViewController(vc, animated: true)
        getToken(num: 2)
    }
    
    //MARK: Functions
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "ID Updation"
    }
    @objc func customBackButtonTapped() {
        
        if let navigationController = self.navigationController {
            // Check if ProfileVC exists in the navigation stack
            if let tabController = navigationController.viewControllers.first(where: { $0 is CustomTabController }) as? CustomTabController {
                tabController.selectedIndex = 2
                tabController.profileSelection = 2
                tabController.setTabSelections(currentIndex: 2)
                navigationController.popToViewController(tabController, animated: true)
            } else {
                // If not in stack, push ProfileVC
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyboard = UIStoryboard(name: "Main10", bundle: nil)
                if let nextViewController = storyboard.instantiateViewController(withIdentifier: "CustomTabController") as? CustomTabController {
                    nextViewController.profileSelection = 2
                    nextViewController.selectedIndex = 2
                    nextViewController.setTabSelections(currentIndex: 2)
                    navigationController.pushViewController(nextViewController, animated: true)
                }
            }
        } else {
            print("❌ Error: navigationController is nil. Ensure this view is inside a UINavigationController.")
        }

        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
//        if let viewControllers = self.navigationController?.viewControllers {
//            for viewController in viewControllers {
//                if viewController is ProfileVC {
//                    self.navigationController?.popToViewController(viewController, animated: true)
//                    break
//                }
//            }
//        }else{
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
//            self.navigationController?.pushViewController(nextViewController, animated: true)
//        }
    }
    
    @objc func handleupdateChange(_ notification: Notification){
        if let data = notification.userInfo as? [String:Any] {
            let update = data["IdUpdated"] as! Bool
            if update{
               setNewImages()
            }else{
                
            }
        }
    }
//    func setStoredImages(){
//        
//    }
    
    
    func setNewImages(){
        
        idNumberTF.text = defaults.string(forKey: "USERID")
        idExpDateTF.text = defaults.string(forKey: "shufti_update_id_exp_date")
        
        strBase64 = defaults.string(forKey: "strBase64")
        strBase641 = defaults.string(forKey: "strBase641")
//            strBase642 = defaults.string(forKey: "strBase642")
    strBase64Selfie = defaults.string(forKey: "strBase64video")
//        strBase64Selfie = defaults.string(forKey: "strBase64Selfie")check
        
        //new
        
        
        if defaults.object(forKey: "frontimage") == nil
        {
            print("No value in Userdefault serviceproviderBANKname")
        }
        else
        {
            let imageData = defaults.data(forKey: "frontimage")
            let orgImage : UIImage = UIImage(data: imageData!)!
            idFrontImgView.image = orgImage

        }
        
        
        if defaults.object(forKey: "backimage") == nil
        {
            print("No value in Userdefault serviceproviderBANKname")
        }
        else
        {
        
        let imageDataback = defaults.data(forKey: "backimage")
        let orgImageback : UIImage = UIImage(data: imageDataback!)!
        idBackImgView.image = orgImageback
        }
        
    }
    
    func setTxtToSpeech(){
        let tapGesture18 = UITapGestureRecognizer(target: self, action: #selector(identificationdetailsLblTapped(_:)))
        titleLbl.isUserInteractionEnabled = true
        titleLbl.addGestureRecognizer(tapGesture18)
    }
    @objc func identificationdetailsLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("identification details", languageCode: "en")
            }
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
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    
    func convertDateFormater(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return  dateFormatter.string(from: date!)
    }
    func convertDateFormater1(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
    }
    
    
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    
    func showPopupAlertone(descArray: [String]) {
        var arrayFilter = descArray
        if arrayFilter.count > 0 {
            //        let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: arrayFilter[0], preferredStyle: .alert)
            //        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { action in
            //            arrayFilter.remove(at: 0)
            //            self.showPopupAlert(descArray: arrayFilter)
            //        }))
            //        self.present(alert, animated: true)
            
            //create view controller
            //            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController")
            //            //remove black screen in background
            //            vc.modalPresentationStyle = .overCurrentContext
            //            //add clear color background
            //            vc.view.backgroundColor = UIColor.clear
            //            //present modal
            //            self.present(vc, animated: true, completion: nil)
            
            
            //            let vc: WEBVIEWHomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
            //            vc.descArray = descArray
            //
            //            self.navigationController?.pushViewController(vc, animated: true)
            
            let vc: WEBTEXTVViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBTEXTVViewController") as! WEBTEXTVViewController
            vc.descArray = descArray
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            
            
            //            let popupone : WEBVIEWHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
            //            self.presentOnRoot(with: popupone, descArray: arrayFilter)
        }
    }
    
    func extractName(){
        let string = str_name_en
        testmiddlenamestr = ""
        testlastnamestr = ""
        testfirstnamestr = ""
        let result = string.components(separatedBy: " ")
        
        
        if result.count == 0
        {
            //middle name ""
            testmiddlenamestr = ""
            testlastnamestr = ""
            testfirstnamestr = ""
        }
        
        
        
        
        if result.count == 8
        {
            testmiddlenamestr = result[1] as! String
            testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String + " " + result[5] as! String + " " + result[6] as! String + " " + result[7] as! String
            print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
        }
        
        
        if result.count == 7
        {
            testmiddlenamestr = result[1] as! String
            testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String + " " +  result[5] as! String + " " + result[6] as! String
            print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
        }
        
        if result.count == 6
        {
            testmiddlenamestr = result[1] as! String
            testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String  + " " + result[5] as! String
            print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
        }
        //newaboves
        
        
        
        if result.count == 5
        {
            testmiddlenamestr = result[1] as! String
            testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String
            print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
        }
        
        
        if result.count == 4
        {
            testmiddlenamestr = result[1] as! String
            testlastnamestr = result[2] as! String + " " + result[3] as! String
            print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
        }
        
        
        if result.count == 3
        {
            print(result[0])
            print(result[1])
            print(result[2])
            print("total3: \(result.count)")
            testlastnamestr = result[2] as! String
            print("total3testnamestr: \(testlastnamestr)")
            testmiddlenamestr = result[1] as! String
            testfirstnamestr = result[0] as! String
        }
        
        if result.count == 2
        {
            //middle name ""
            testmiddlenamestr = ""
            testlastnamestr = result[1] as! String
            testfirstnamestr = result[0] as! String
        }
        
        if result.count == 1
        {
            //middle name "",last name ""
            testmiddlenamestr = ""
            testlastnamestr = ""
            testfirstnamestr = result[0] as! String
        }
    }
    
    //MARK: - API Calls
    
    func getToken(num:Int) {
//        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
//            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token  ",token)
                if(num == 1)
                {
//                    self.callSequentialAPIs(access_token: token)
                    self.getProfileInfo(access_token: token)
                }
                else if(num == 2)
                {
                    self.updateProfile(access_token: token)
                }
                else if(num == 3)
                {
                    self.profileimageviewapi(access_token: token, customerImgType: "F")
                }
                else if(num == 3)
                {
                    self.profileimageviewapi(access_token: token, customerImgType: "B")
                }
                
                
                break
            case .failure:
                break
            }
            
        })
    }
    func getProfileInfo(access_token:String) {
//        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
//            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let respCode = myResult!["responseCode"]
                if(respCode == "S104")
                {
                    
                    //store local in app
                    
                    
                    
                    // self.emailTextField.text = myResult!["email"].stringValue
                    UserDefaults.standard.removeObject(forKey: "strEmailnew")
                    self.strEmail = myResult!["email"].stringValue
                    self.defaults.set(self.strEmail, forKey: "strEmailnew")
                    
                   
                    
                    
                    
                    UserDefaults.standard.removeObject(forKey: "strEmailnew")
                    self.str_name_en = myResult!["workingAddress3"].stringValue
                    
                    self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
                    self.str_name_ar = myResult!["customerNameArabic"].stringValue
                    self.str_dob = myResult!["customerDOB"].stringValue
//                    self.str_dob = self.convertDateFormater1(self.str_dob)
//                    self.str_id_exp_date = self.convertDateFormater(self.str_id_exp_date)
//                    self.str_id_exp_date = self.convertDateFormater1(self.str_id_exp_date)
                    
                    //   xgfghfhg
                    
                    if(myResult!["street"].stringValue == "-")
                    {
                       
                        self.str_address = ""
                    }else{
                        self.str_address = myResult!["street"].stringValue
                    }
                    
                    if(myResult!["customerCity"].stringValue == "-" ) || (myResult!["customerCity"].stringValue == "Municipality")
                    {
                        
                        self.str_city = ""
                        //                self.municipalityBtn.titleLabel?.text = "Municipality"
                        //                    self.municipalityBtn.setTitleColor(UIColor.gray, for: .normal)
                    }
                    else
                    {
                        //                    self.municipalityBtn.setTitle(myResult!["customerCity"].stringValue, for: .normal)
                        self.str_city = myResult!["customerCity"].stringValue
                        //                    self.municipalityBtn.setTitleColor(UIColor.black, for: .normal)
                    }
                    
                    if(myResult!["mZone"].stringValue == "-") || (myResult!["mZone"].stringValue == "Zone")
                    {
                        self.str_zone = "-"
                    }
                    else
                    {
                        self.str_zone = myResult!["mZone"].stringValue
                    }
                    
                    if(myResult!["buildingNo"].stringValue == "-") || (myResult!["buildingNo"].stringValue == "<null>") || (myResult!["buildingNo"].stringValue.isEmpty == true)
                        
                    {
                        self.str_buildingnotxtfd = ""
                    }
                    else
                    {
                        self.str_buildingnotxtfd = myResult!["buildingNo"].stringValue
                    }
                    self.str_gender = myResult!["gender"].stringValue
                    self.strMobile = myResult!["customerMobile"].stringValue
                    self.str_employer = myResult!["employerName"].stringValue
                    self.str_income = myResult!["expectedIncome"].stringValue
                    self.str_working_address = myResult!["workingAddress1"].stringValue
                    self.str_occupationtext = myResult!["occupation"].stringValue
                    self.str_occupation = myResult!["occupation"].stringValue
                    self.str_actualoccupation = myResult!["actualOccupation"].stringValue
                    print("3 letter code",myResult!["customerNationality"].stringValue)
//                    self.secNationalityTF.text = myResult!["customerCountry"].stringValue
//                    self.getCountryName(code: myResult!["customerNationality"].stringValue, from: 1)
                    self.str_nationality = myResult!["customerNationality"].stringValue
                    self.str_country = myResult!["customerCountry"].stringValue
//                    self.getCountryName(code: myResult!["customerCountry"].stringValue, from: 2)
                    self.dualnationalityselstr = myResult!["customerCountry"].stringValue
                    // store
    //                self.i.text = myResult!["customerIDType"].stringValue
    //                self.idTypeBtn.setTitle(myResult!["customerIDType"].stringValue, for: .normal)
    //                self.idTypeBtn.setTitleColor(UIColor.black, for: .normal)
                    self.str_id_issuer = myResult!["customerIDIssuedBy"].stringValue
                    self.str_id_no = myResult!["customerIDNo"].stringValue
                    self.str_id_exp_date = myResult!["customerIDExpiryDate"].stringValue
                    self.str_id_exp_date = self.convertDateFormater(self.str_id_exp_date)
                    self.str_id_exp_date = self.convertDateFormater1(self.str_id_exp_date)
                    
                    self.str_customerBirthPlace = myResult!["customerBirthPlace"].stringValue
                    self.str_customerIDIssuedCountry = myResult!["customerIDIssuedCountry"].stringValue
                    self.str_customerFirstName = myResult!["customerFirstName"].stringValue
                    self.str_customerLastName = myResult!["customerLastName"].stringValue
                    self.str_customerMiddleName = myResult!["customerMiddleName"].stringValue
                    self.str_customerPhone = myResult!["customerPhone"].stringValue
                    self.str_customerZipCode = myResult!["customerZipCode"].stringValue
                     self.str_visaExpiryDate = myResult!["visaExpiryDate"].stringValue
                    self.str_visaIssuedBy = myResult!["visaIssuedBy"].stringValue
                    self.str_visaIssuedDate = myResult!["visaIssuedDate"].stringValue
                    self.str_visaNo = myResult!["visaNo"].stringValue
                    self.str_visaType = myResult!["visaType"].stringValue
                    self.str_workingAddress3 = myResult!["workingAddress3"].stringValue
                    if(self.str_id_issuer == "QATAR MOI")
                    {
                        self.idIssuerTF.text = "Ministry of Interior"
                    }
                    else if(self.str_id_issuer == "QATAR MOFA")
                    {
                        self.idIssuerTF.text = "Ministry of Foreign Affairs"
                    }
                    self.idTypeTF.text = myResult!["customerIDType"].stringValue
//                    self.idExpTF.text = self.convertDateFormater(myResult!["customerIDExpiryDate"].stringValue)
//                    self.str_id_exp_date = myResult!["customerIDExpiryDate"].stringValue
                    
                }
            case .failure:
                break
            }

            
        })
    }
    func updateProfile(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "customer/updatecustomer"
       
        print("1",str_id_no)
        print("2",defaults.string(forKey: "REGNO")!)
        print("3",str_name_en)
        print("4",str_name_ar)
        print("5",str_address)
        print("6",str_city)
        print("7",strMobile)
        //print("7",str_country)
        print("8",str_dob)
        print("9",str_nationality)
        print("9.1",self.dualnationalityselstr)
        print("10",str_gender)
        print("11",str_occupation)
        print("12",strEmail)
        print("13",str_id_exp_date)
        print("14",str_id_issuer)
        print("15",defaults.string(forKey: "PASSW")!)
        print("16",defaults.string(forKey: "PIN")!)
        print("17",str_employer)
        print("18",str_working_address)
        print("19",str_income)
        print("20",str_zone)
        
        
        if let savedValue = defaults.string(forKey: "shufti_update_nationality"){
            str_nationality = savedValue
        } else {
            defaults.set("", forKey: "shufti_update_nationality")
        }
        
        if let savedValue = defaults.string(forKey: "shufti_update_dob"){
            str_dob = convertDateFormater1(savedValue)
//            "2004-05-09 00:00:00.0";
        } else {
            defaults.set("", forKey: "shufti_update_dob")
        }
        
        if let savedValue = defaults.string(forKey: "shufti_update_name_en"){
            str_name_en = savedValue
            extractName()
        } else {
            defaults.set("", forKey: "shufti_update_name_en")
            
            testmiddlenamestr = str_customerMiddleName
            testlastnamestr = str_customerLastName
            testfirstnamestr = str_customerFirstName
            
        }
        
        if let savedValue = defaults.string(forKey: "shufti_update_name_ar"){
            str_name_ar = savedValue
        } else {
            defaults.set("", forKey: "shufti_update_name_ar")
        }
        
        if let savedValue = defaults.string(forKey: "shufti_update_id_exp_date"){
            
            str_id_exp_date = self.convertDateFormater1(savedValue)
        } else {
            defaults.set("", forKey: "shufti_update_id_exp_date")
        }
        
        if let savedValue = defaults.string(forKey: "shufti_update_id_no"){
            str_id_no = savedValue
        } else {
            defaults.set("", forKey: "shufti_update_id_no")
        }
        
        /*
        //frontphotocheck
        let userdefaultfrontlabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultfrontlabelphotostr.string(forKey: "strBase64photo"){
            print("Here you will get saved value")
            
            strBase64 = defaults.string(forKey: "strBase64photo")
            
        } else {
            strBase64 = ""
            
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultfrontlabelphotostr.set("", forKey: "key")
        }
        
        
        
        //backphotocheck
        let userdefaultbacklabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultbacklabelphotostr.string(forKey: "strBase641photo1"){
            print("Here you will get saved value")
            
            strBase641 = defaults.string(forKey: "strBase641photo1")
            
        } else {
            strBase641 = ""
            
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultbacklabelphotostr.set("", forKey: "key")
        }
        
        
        
        //selfiphotocheck
        let userdefaultselfielabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultselfielabelphotostr.string(forKey: "strBase64videoProfile"){
            print("Here you will get saved value")
            
            strBase64videoProfile = defaults.string(forKey: "strBase64videoProfile")
            
        } else {
            
            strBase64videoProfile = ""
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultselfielabelphotostr.set("", forKey: "key")
        }
        */
        
        
        let appVersion = AppInfo.version
        print("appVersion",appVersion)
        print("testfirstnamestr",testfirstnamestr)
        
        let params:Parameters =  [
            "partnerId":partnerId,
            "token":token,
            "requestTime":dateTime,
            "customerIDNo":str_id_no,
            "customerRegNo":defaults.string(forKey: "REGNO")!,
            "customerFullName":str_name_en,
            "customerFirstName":testfirstnamestr,
            "customerMiddleName":testmiddlenamestr,
            "customerLastName":testlastnamestr,
            "customerFullNameArabic":str_name_ar,
            "customerAddress":str_address,
            "customerCity":str_city,
            "customerMobile":strMobile,
            "customerPhone":appVersion,
            "customerZipCode":"IOS",
//            "customerZipCode":self.str_customerZipCode,
            "customerCountry":self.dualnationalityselstr,
            "customerDOB":self.str_dob,
            "customerCountryOfBirth":"VIDEOS",
            "customerBirthPlace":str_nationality,
            "gender":str_gender,
            "customerNationality":str_nationality,
            "occupation":str_occupation,
            "email":strEmail,
            "customerIDType":"QID",
            "customerIDIssuedDate":self.str_id_exp_date,
            "customerIDExpiryDate":self.str_id_exp_date,
            "customerIDIssuedBy":self.str_id_issuer,
            "customerIDIssuedCountry":self.str_customerIDIssuedCountry,
            "visaNo":self.str_visaNo,
            "visaIssuedBy":self.str_visaIssuedBy,
            "visaIssuedDate":self.str_visaIssuedDate,
            "visaExpiryDate":self.str_visaExpiryDate,
            "visaType":self.str_visaType,
            "password":defaults.string(forKey: "PASSW")!,
            "mpin":defaults.string(forKey: "PIN")!,
            "idImageFront":strBase64 ?? "",
            "idImageBack":strBase641 ?? "",
            "idImageSelfie":strBase64videoProfile ?? "",
            "idDocAdditional1":"",
            "idDocAdditional2":"",
            "employerName":str_employer,
            "workingAddress1":str_working_address,
            "workingAddress2":str_actualoccupation,
            "workingAddress3":self.str_workingAddress3,
            "expectedIncome":str_income,
            "mZone":str_zone,
            "securityQuestion3":str_buildingnotxtfd]
        
        print("urlupdate",url)
        print("paramsupdate",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("respupdate",response)
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let responseCode = myResult!["responseCode"].stringValue
                let respMsg = myResult!["responseMessage"].stringValue
               
                
                
                
                if(responseCode == "E9999")
                {
                    // AlertView.instance.showAlert(msg: respMsg, action: .attention)
                    // self.getPopupNotificationList()
                    self.getNewVersionalertList()
                }
                
                if(responseCode.contains("S"))
                {
                    // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                    
                    let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { action in
                        
                        
                        //self.disableFields()
                        
                        UserDefaults.standard.removeObject(forKey: "frontlabelphotostr")
                        UserDefaults.standard.removeObject(forKey: "backlabelphotostr")
                        UserDefaults.standard.removeObject(forKey: "selfielabelphotostr")
                        
                        UserDefaults.standard.removeObject(forKey: "strBase64photo")
                        UserDefaults.standard.removeObject(forKey: "strBase641photo1")
                        UserDefaults.standard.removeObject(forKey: "strBase642photo2")
                        
                        self.defaults.removeObject(forKey: "shufti_update_nationality")
                        self.defaults.removeObject(forKey: "shufti_update_dob")
                        self.defaults.removeObject(forKey: "shufti_update_name_en")
                        self.defaults.removeObject(forKey: "shufti_update_name_ar")
                        self.defaults.removeObject(forKey: "shufti_update_id_exp_date")
                        self.defaults.removeObject(forKey: "shufti_update_id_no")
                        
                        
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        let vc: CustomTabController = UIStoryboard.init(name: "Main10", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                }
                else if(responseCode.contains("E")){
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                    
                    UserDefaults.standard.removeObject(forKey: "frontlabelphotostr")
                    UserDefaults.standard.removeObject(forKey: "backlabelphotostr")
                    UserDefaults.standard.removeObject(forKey: "selfielabelphotostr")
                    
                    UserDefaults.standard.removeObject(forKey: "strBase64photo")
                    UserDefaults.standard.removeObject(forKey: "strBase641photo1")
                    UserDefaults.standard.removeObject(forKey: "strBase642photo2")
                    
                    self.defaults.removeObject(forKey: "shufti_update_nationality")
                    self.defaults.removeObject(forKey: "shufti_update_dob")
                    self.defaults.removeObject(forKey: "shufti_update_name_en")
                    self.defaults.removeObject(forKey: "shufti_update_name_ar")
                    self.defaults.removeObject(forKey: "shufti_update_id_exp_date")
                    self.defaults.removeObject(forKey: "shufti_update_id_no")
                }
                
                
                
                else{
                    //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("acc_verif", comment: ""), action: "Ok")
                    
                    let respMsg = myResult!["responseMessage"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                    
                    // self.disableFields()
                    
                    UserDefaults.standard.removeObject(forKey: "frontlabelphotostr")
                    UserDefaults.standard.removeObject(forKey: "backlabelphotostr")
                    UserDefaults.standard.removeObject(forKey: "selfielabelphotostr")
                    
                    UserDefaults.standard.removeObject(forKey: "strBase64photo")
                    UserDefaults.standard.removeObject(forKey: "strBase641photo1")
                    UserDefaults.standard.removeObject(forKey: "strBase642photo2")
                    
                    self.defaults.removeObject(forKey: "shufti_update_nationality")
                    self.defaults.removeObject(forKey: "shufti_update_dob")
                    self.defaults.removeObject(forKey: "shufti_update_name_en")
                    self.defaults.removeObject(forKey: "shufti_update_name_ar")
                    self.defaults.removeObject(forKey: "shufti_update_id_exp_date")
                    self.defaults.removeObject(forKey: "shufti_update_id_no")
                }
                
            case .failure:
                break
            }
            
        })
    }
    func getNewVersionalertList() {
        var notificMessageList1: [String] = []
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "application_update_notification"
        let params:Parameters = ["lang": appLang,"device_type":"IOS"]
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("NEWVERRESPONSE",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                guard let responseData = response.data else {
                    return
                }
                guard let myResult = try? JSON(data: responseData) else {
                    return
                }
                let popupListing1 = myResult["application_update_notification"]
                if(popupListing1.count > 0) {
                    for popupObject in popupListing1.arrayValue {
                        let currentItemKey = "app_notf_desc_" + appLang
                        let currentItemEn = "app_notf_desc_en"
                        let desc = popupObject[currentItemKey].stringValue
                        let desc2 = popupObject[currentItemEn].stringValue
                        if(desc != "") {
                            let descString = desc
                            notificMessageList1.append(descString)
                            print("descprint",descString)
                            //                                self.showPopupAlert(desc: descString)
                        } else if(desc2 != "") {
                            let desc2String = desc
                            notificMessageList1.append(desc2String)
                            print("descprint2",desc2String)
                            //                                self.showPopupAlert(desc: desc2String)
                        }
                    }
                    
                    //                           let a = ["", "", ""]
                    //                           let b = notificMessageList
                    //                        if a == b {
                    //                             print("Nullcontentpopup",notificMessageList)
                    //                        }
                    // else
                    //{
                    
                    
                    //                        let vc: WEBVIEWHomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
                    //
                    //
                    //                        self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                    
                    
                    
                    ///
                    if notificMessageList1.count > 0 {
                        self.showPopupAlertone(descArray: notificMessageList1)
                        print("contentpopupNEWVER",notificMessageList1)
                        
                        
                        //
                        
                    }
                    ////
                    
                    
                    // }
                    print("contentpopupNEWVERout",notificMessageList1)
                    
                    
                }
                break
            case .failure:
                break
                
            }
        })
    }
    
//    func callSequentialAPIs(access_token: String) {
//        let serialQueue = DispatchQueue(label: "com.yourapp.profileImageQueue")
//
//        serialQueue.async {
//            self.getProfileInfo(access_token: access_token)
//        }
//        
//        serialQueue.async {
//            self.profileimageviewapi(access_token: access_token, customerImgType: "F")
//        }
//        
//        serialQueue.async {
//            self.profileimageviewapi(access_token: access_token, customerImgType: "B")
//        }
//    }
    
//    func callSequentialAPIs(access_token: String) {
    func callSequentialAPIs() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let serialQueue = DispatchQueue(label: "com.yourapp.profileImageQueue")
        
        serialQueue.async {
            self.getToken(num: 1)
//            self.getProfileInfo(access_token: access_token)

            DispatchQueue.main.async {
                self.getToken(num: 3)
//                self.profileimageviewapi(access_token: access_token, customerImgType: "F")
            }

            DispatchQueue.main.async {
                self.getToken(num: 4)
//                self.profileimageviewapi(access_token: access_token, customerImgType: "B")
            }
        }
        activityIndicator.removeFromSuperview()
    }
    func profileimageviewapi(access_token: String, customerImgType: String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "customer/viewcustomerImage"
        let params: Parameters = ["customerIDNo": str_id_no, "customerImgType": customerImgType]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(access_token)"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            DispatchQueue.main.async {  // 🚀 Ensure UI updates happen on main thread
                let myResult = try? JSON(data: response.data!)
//                print("profileimageviewapi resp", response)
                
                self.effectView.removeFromSuperview() // UI update ❗️ Needs main thread
                switch response.result{
                
                case .success:
                    guard let resultArray = myResult?[] else { return }
                    let respCode = myResult?["responseCode"]
                    
                    if myResult!["idImage"].stringValue.isEmpty {
                        print("respnullll", "nullll")
                    } else if respCode == "S105" {
                        // Handle special case if needed
                    } else {
                        let baseimagestr: String = myResult?["idImage"].stringValue ?? ""
                        print("64444", baseimagestr)
                        
                        if let imageData = Data(base64Encoded: baseimagestr) {
                            if customerImgType == "F" {
                                self.idFrontImgView.image = UIImage(data: imageData) // UI update ❗️ Needs main thread
                                self.idFrontImgView.contentMode = .scaleAspectFit
                                self.idFrontImgView.translatesAutoresizingMaskIntoConstraints = false
                            } else if customerImgType == "B" {
                                self.idBackImgView.image = UIImage(data: imageData) // UI update ❗️ Needs main thread
                                self.idBackImgView.contentMode = .scaleAspectFit
                                self.idBackImgView.translatesAutoresizingMaskIntoConstraints = false
                            }
                        }
                    }
                case .failure:
                    break
                }
                
            }
        }
    }

    
    /*func profileimageviewapi(access_token:String, customerImgType:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "customer/viewcustomerImage"
        let params:Parameters =  ["customerIDNo":str_id_no,"customerImgType": customerImgType]
        print("urlurl",url)
        print("paramsurl",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            
            print("profileimageviewapi resp",response)
            
            
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            let respCode = myResult!["responseCode"]
            if myResult!["idImage"].stringValue.isEmpty
            {
                print("respnullll","nullll")
            }
            else if(respCode == "S105"){
                //                    let base64 = myResult!["idImage"].stringValue
                //                    self.showVideoFromBase64(base64String: base64)
            }else{
                
                
                
                let baseimagestr:String =  myResult!["idImage"].string!
                
                print("64444",baseimagestr)
                let base64EncodedString = baseimagestr // Your Base64 Encoded String
                
                // 1
                
                let url : String = base64EncodedString
                let urlStr : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                let convertedURL : URL = URL(string: urlStr)!
                print("64444URLLLL",convertedURL)
                
                if let imageData = Data(base64Encoded: base64EncodedString) {
                    
                    if customerImgType == "F"{
                        self.idFrontImgView.image = UIImage(data: imageData)
                        self.idFrontImgView.contentMode = .scaleAspectFit // Keeps aspect ratio while zooming
                        self.idFrontImgView.translatesAutoresizingMaskIntoConstraints = false
                    }else if customerImgType == "B"{
                        self.idBackImgView.image = UIImage(data: imageData)
                        self.idBackImgView.contentMode = .scaleAspectFit // Keeps aspect ratio while zooming
                        self.idBackImgView.translatesAutoresizingMaskIntoConstraints = false
                    }
                    
                    
                    //}
                    
                }}
            
            
            
        })
    }*/
}

/*

resp success({
    actualOccupation = ACCOUNTANT;
    actualOccupationDesc = "<null>";
    buildingNo = 1;
    customerBirthPlace = Indian;
    customerBranch = ONLINE;
    customerCity = "-";
    customerCountry = "<null>";
    customerCountryOfBirth = VIDEOS;
    customerDOB = "2004-05-09 00:00:00.0";
    customerFirstName = SHERIN;
    customerIDExpiryDate = "2025-08-27 00:00:00.0";
    customerIDIssuedBy = "QATAR MOFA";
    customerIDIssuedCountry = QAT;
    customerIDNo = 12345678001;
    customerIDType = QID;
    customerLastName = BOSE;
    customerMiddleName = "<null>";
    customerMobile = 97498765432;
    customerNameArabic = "\U0634\U064a\U0631\U064a\U0646 \U0628\U0648\U0633\U064a";
    customerNationality = Indian;
    customerPhone = 97498765432;
    customerRegNo = 54144848;
    customerZipCode = "<null>";
    email = "testbose@gmail.com";
    employerName = ogeee;
    expectedIncome = 1000;
    gender = Male;
    mZone = 1;
    messageDetail = "<null>";
    occupation = ACCOUNTANT;
    responseCode = S104;
    responseMessage = "CUSTOMER TRANSACTION IS VIEWED SUCCESSFULLY";
    street = 1;
    visaExpiryDate = "1990-01-01 00:00:00.0";
    visaIssuedBy = "<null>";
    visaIssuedDate = "1990-01-01 00:00:00.0";
    visaNo = "27-08-2025";
    visaType = "09-05-2004";
    workingAddress1 = kochi;
    workingAddress2 = "<null>";
    workingAddress3 = "SHERIN BOSE";
})
*/


/*
 ["securityQuestion3": "25",
 "visaIssuedDate": "1990-01-01 00:00:00.0",
 "partnerId": "GULFEXC123",
 "customerMiddleName": "",
 "occupation": "ACCOUNTANT",
 "visaType": "09-05-2004",
 "requestTime": "2025-03-15 11:40:42",
 "customerCountry": "",
 "customerCity": "",
 "idImageBack": Optional(""),
 "customerCountryOfBirth": "VIDEOS",
 "customerRegNo": "54144848",
 "customerFullNameArabic": "شيرين بوسي",
 "customerIDExpiryDate": "2025-08-27",
 "workingAddress1": "kochi",
 "expectedIncome": "1000",
 "customerFullName": "SHERIN BOSE",
 "gender": "Male",
 "employerName": "ogeee",
 "customerPhone": Optional("1.0"),
 "customerIDIssuedDate": "2025-08-27",
 "visaExpiryDate": "1990-01-01 00:00:00.0",
 "customerIDNo": "12345678001",
 "customerDOB": "2004-05-09",
 "customerIDIssuedBy": "QATAR MOFA",
 "visaNo": "27-08-2025",
 "password": "Abc12345*",
 "idImageSelfie": Optional(""),
 "idDocAdditional1": "",
 "customerZipCode": "IOS",
 "customerAddress": "1",
 "customerIDIssuedCountry": "QAT",
 "visaIssuedBy": "",
 "idImageFront": Optional(""),
 "token": "1234567",
 "customerMobile": "97498000092",
 "customerFirstName": "SHERIN",
 "customerLastName": "BOSE",
 "idDocAdditional2": "",
 "email": "testbose@gmail.com",
 "workingAddress2": "ACCOUNTANT",
 "customerBirthPlace": "Indian",
 "customerNationality": "Indian",
 "mZone": "1",
 "customerIDType": "QID",
 "mpin": "1234",
 "workingAddress3": "SHERIN BOSE"]
 
 
 ["email": "testbose@gmail.com", 
 "idDocAdditional2": "",
 "customerRegNo": "54144848",
 "customerAddress": "1",
 "customerMobile": "97498000092",
 "customerDOB": "12-07-1990",
 "gender": "Male",
 "customerIDNo": "12345678001",
 "customerCity": "",
 "visaNo": "27-08-2025",
 "visaIssuedBy": "",
 "visaIssuedDate": "1990-01-01 00:00:00.0",
 "visaType": "09-05-2004",
 "idDocAdditional1": "",
 "mZone": "1",
 "customerIDExpiryDate": "2025-04-17",
 "token": "1234567",
 "partnerId": "GULFEXC123",
 "customerFirstName": "ESTRELLITA",
 "customerMiddleName": "VILCHEZ",
 "customerLastName": "DELACRUZ",
 "employerName": "ogeee",
 "expectedIncome": "1000",
 "customerIDIssuedBy": "QATAR MOFA",
 "customerCountry": "", 
 "password": "Abc12345*",
 "customerIDIssuedDate": "2025-04-17",
 "customerCountryOfBirth": "VIDEOS",
 "customerNationality": "FILIPINO",
 "workingAddress2": "ACCOUNTANT",
 "customerPhone": Optional("1.0"),
 "customerIDType": "QID",
 "occupation": "ACCOUNTANT",
 "customerIDIssuedCountry": "QAT",
 "securityQuestion3": "25",
 "customerZipCode": "IOS",
 "visaExpiryDate": "1990-01-01 00:00:00.0",
 "workingAddress1": "kochi",
 "workingAddress3": "SHERIN BOSE",
 "requestTime": "2025-03-15 11:41:33",
 "idImageSelfie": "",
 "customerFullName": "ESTRELLITA VILCHEZ DELACRUZ",
 "customerFullNameArabic": "فيلشيز استربلينا ديلاکروز",
 "idImageFront": "",
 "idImageBack": "",
 "customerBirthPlace": "FILIPINO",
 "mpin": "1234"]
 
 */
