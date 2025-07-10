//
//  SettingsVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 23/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield

class SettingsVC: UIViewController, LogoutAlertPopupViewDelegate {
    
    
    
    //MARK: - variable declaration
    
    @IBOutlet var hideLbls: [UILabel]!
    @IBOutlet var hideImgs: [UIImageView]!
    
    
    @IBOutlet weak var screenshotView: UIView!
    @IBOutlet var biometriclabel: UILabel!
    @IBOutlet var sampleswitch: UISwitch!
    @IBOutlet weak var changeSeqQusBtn: UIButton!
    @IBOutlet weak var changeMobileBtn: UIButton!
    @IBOutlet weak var changeSecQusLbl: UILabel!
    @IBOutlet weak var changeMobileLbl: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileImgView: UIView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
//    @IBOutlet weak var changeLanguageBtn: UIButton!
    @IBOutlet weak var changePasswBtn: UIButton!
    @IBOutlet weak var changepinBtn: UIButton!
    @IBOutlet weak var changeEmailBtn: UIButton!
    @IBOutlet weak var blockAccBtn: UIButton!
    @IBOutlet weak var abtBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var feedbackBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
//    @IBOutlet weak var changeLanguageLbl: UILabel!
    @IBOutlet weak var changePasswLbl: UILabel!
    @IBOutlet weak var changePinLbl: UILabel!
    @IBOutlet weak var changeEmailLbl: UILabel!
    @IBOutlet weak var blockAccLbl: UILabel!
    @IBOutlet weak var abtLbl: UILabel!
    @IBOutlet weak var helpLbl: UILabel!
    @IBOutlet weak var feedbackLbl: UILabel!
    @IBOutlet weak var termsLbl: UILabel!
    @IBOutlet weak var moreLbl: UILabel!
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet var emptyBtns: [UIButton]!
    
    
    var udid:String!
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    var userName:String = "----"
    var email:String = "----"
    var temrsContent = ""
    
    let confirmationpopUpView = Bundle.main.loadNibNamed("LogoutAlertPopupView", owner: SettingsVC.self, options: nil)?.first as! LogoutAlertPopupView
    let popUpView2 = Bundle.main.loadNibNamed("TermsPopupUIView", owner: SettingsVC.self, options: nil)?.first as! TermsPopupUIView
    //MARK: - view life cycle
    
    
    func overrideHorizontalSizeClassIfNeeded() {
            if #available(iOS 18.0, *) {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    self.traitOverrides.horizontalSizeClass = .unspecified
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideHorizontalSizeClassIfNeeded()
        
        setView()
        for btn in emptyBtns{
            btn.setTitle("", for: .normal)
        }
//        getTermsandConditions()
        confirmationpopUpView.delegate = self
        self.userName = defaults.string(forKey: "GLUserName") ?? ""
        self.email = defaults.string(forKey: "GLEmail") ?? ""
        userNameLbl.text = userName
        userEmail.text = email
        profileImg.isHidden = true
        createAvatar(username: userName, view: profileImgView, font: 30)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.udid = UIDevice.current.identifierForVendor!.uuidString
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
        ScreenShield.shared.protect(view: self.profileImgView)
        for labl in hideLbls{
            ScreenShield.shared.protect(view: labl)
        }
        for image in hideImgs{
            ScreenShield.shared.protect(view: image)
        }
        
        
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    
    
    
    
    //MARK: - button Actions
    
    @IBAction func Feedbackbtnacttapped(_ sender: Any)
    {
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("Feedback", languageCode: "en")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Your code to execute after a 2-second delay
            print("This will print after 2 seconds")
            UIApplication.shared.openURL(NSURL(string: "https://gulfexchange.com.qa/en/customer-service")! as URL)
        }
        
        
    }
    
    
    
    @IBAction func changeLanguageBtnTapped(_ sender: Any) {
        
     
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main11", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LanguageSelectorViewController") as! LanguageSelectorViewController
        nextViewController.isFromSettings = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func blockBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("block account", languageCode: "en")
        }
        
        confirmationpopUpView.setView(isLogout: false)
        confirmationpopUpView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        view.addSubview(confirmationpopUpView)
    }
    @IBAction func logoutBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("log out", languageCode: "en")
        }
        
        confirmationpopUpView.setView(isLogout: true)
        confirmationpopUpView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        view.addSubview(confirmationpopUpView)
    }
    @IBAction func aboutUsBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("About us", languageCode: "en")
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main11", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func helpBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("help", languageCode: "en")
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main11", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HelpCenterVC") as! HelpCenterVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func changePasswordBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("change password", languageCode: "en")
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdatePasswordVC") as! UpdatePasswordVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func changePinBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("change pin", languageCode: "en")
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdatePINVC") as! UpdatePINVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func changeEmailBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("change email", languageCode: "en")
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateEmailVC") as! UpdateEmailVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func moreBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("more", languageCode: "en")
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MoreSettingsVC") as! MoreSettingsVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func termsBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("Terms and condition", languageCode: "en")
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
//        if temrsContent != ""{
//            nextViewController.content = temrsContent
//        }else{
//            nextViewController.content = ""
//        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
//        terms
//        popUpView2.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
//        popUpView2.alpha = 0.0
//        popUpView2.isSettings = true
//        if temrsContent != ""{
//            popUpView2.setView(content: temrsContent)
//        }else{
//            popUpView2.setView(content: "")
//        }
//        view.addSubview(popUpView2)
//        UIView.animate(withDuration: 0.3, animations: {
//            self.popUpView2.alpha = 1.0
//        })
    }
    
    func LogoutAlertPopupView(_ vc: LogoutAlertPopupView, isLogout: Bool) {
        if isLogout{
            // old logout
//            self.callLogout()
//            self.getTokenNewGE(num: 1)
            self.callLogout()
        }else{
            print("block.....")
            self.getToken(num: 1)
        }
    }
    
    //MARK: - functions
    func handleSessionErrorLogout(){
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
    func setView(){
        changePasswLbl.text = NSLocalizedString("change_password_settings", comment: "")
        changePinLbl.text = NSLocalizedString("change_pin_settings", comment: "")
        changeEmailLbl.text = NSLocalizedString("change_email", comment: "")
        blockAccLbl.text = NSLocalizedString("BlockAccount", comment: "")
        abtLbl.text = NSLocalizedString("about_us_title", comment: "")
        helpLbl.text = NSLocalizedString("help", comment: "")
        feedbackLbl.text = NSLocalizedString("Feedback", comment: "")
        termsLbl.text = NSLocalizedString("terms_conditions2", comment: "")
        moreLbl.text = NSLocalizedString("More", comment: "")
        logoutLbl.text = NSLocalizedString("logout", comment: "")
    }
    
    //MARK: - api calls
    func callLogout(){
        APIManager.shared.fetchToken { token in
            if let token = token {
                // Call login session update
                APIManager.shared.updateSession(sessionType: "2", accessToken: token) { responseCode in
                    if responseCode == "S333" {
                        self.handleSessionErrorLogout()
                    } else {
                        self.handleSessionErrorLogout()
                    }
                }
            } else {
                print("Failed to fetch token")
            }
        }
    }
    /*func callLogout() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "login_session_delete"
        let params:Parameters = ["id_no":self.defaults.string(forKey: "USERID") ?? "","session_id":self.udid ?? ""]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp",response)
            switch response.result{
            case .success:
                
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
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                //                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                //                    let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
                //                    //        self.navigationController?.pushViewController(nextViewController, animated: true)
                //                            self.navigationController?.pushViewController(nextViewController, animated: true)
                
                
                //  UIControl().sendAction(#selector(NSXPCConnection.suspend),
                //  to: UIApplication.shared, for: nil)
                
                break
            case .failure:
                break
            }
        })
    }*/
    
    func getTermsandConditions() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "contents_listing"
        let params:Parameters = ["type":"9","lang":"en"]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("historytremsconditionapi",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["contents_listing"]
                for i in resultArray.arrayValue{
                    let content = i["contents_desc_en"].stringValue
                    self.temrsContent = content
                }
                break
            case .failure:
                break
            }
        })
    }
    
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
//        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
//        let str_encode_val = auth_client_id + ":" + auth_client_secret
//        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
//        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("tokenResp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("accresss toceke\(token)")
                if(num == 1)
                {
                    self.Blockacctapi(access_token: token)
                }
           
                break
            case .failure:
                break
            }
        })
    }
    
    
    func Blockacctapi(access_token:String){
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let dateTime:String = getCurrentDateTime()
        let appVersion = AppInfo.version
              print("appVersion",appVersion)
        let url = ge_api_url_new + "utilityservice/accountDelete"
//        let params:Parameters =  ["idNumber":self.str_id_no,"idExpiryDate":self.expdatestr,"mobileNumber":"974" + mobiletxtfdfpage.text!,"partnerId":partnerId,"token":token,"requestTime":dateTime,"deviceType":"IOS","versionName":appVersion]
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!]
        
        //"2022-09-15"
        
         print("accountblockurl",url)
        print("paramsaccountblockurl",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        print("headersuuuaccountblockurl",headers)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("responseaccountblock",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
              print("responseaccountblckcode",respCode)
            
            
//
//            if myResult!["status"].stringValue.isEmpty
//            {
//
//            }
//            else
//            {
//              let statusstr:String = myResult!["status"].string!
//                self.statusstrr = myResult!["status"].string!
//            }
           // if self.statusstrr == "ACTIVE"
           // {
            
            /////
         
            
            ////
            
//            if(respCode == "S104")
            if(respCode == "S200")
            {
                let respMsg = myResult!["responseMessage"].stringValue
                
                
//                if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
//                {
//                    
//                }
                //else
               // {
                self.defaults.set("", forKey: "USERID")
                self.defaults.set("", forKey: "PASSW")
                self.defaults.set("", forKey: "PIN")
                self.defaults.set("", forKey: "REGNO")
                //}
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
            
            else
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
       
                return
            }
            
            
        })
    }

    
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        return formattedDate
    }
}
/*
 func getTokenNewGE(num:Int) {
     
     self.activityIndicator(NSLocalizedString("loading", comment: ""))
     let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
     
     print("tokenurl",url)
     
     
     let str_encode_val = auth_client_id + ":" + auth_client_secret
     let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
     let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
     
     HomePageViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
         print("responsegetTokennewae",response)
         self.effectView.removeFromSuperview()
         switch response.result{
         case .success:
             let myresult = try? JSON(data: response.data!)
             
             let token:String = myresult!["access_token"].string!
             print("token  ",token)
             print("numtt  ",num)
             if(num == 1)
             {
                 self.loginNewDevicenewae(access_token: token)
             }
             else if(num == 2)
             {
                 self.loginNewDevicenewaelogoutt(access_token: token)
                 
             }

             break
         case .failure:
             break
         }
         
     })
 }
 
 func loginNewDevicenewae(access_token:String) {
     self.activityIndicator(NSLocalizedString("loading", comment: ""))
     let url = ge_api_url_new + "utilityservice/updateSession"
     let params:Parameters =  ["partnerId":partnerId,"token":token,"customerUserId":defaults.string(forKey: "USERID")!,"loginSessionId":self.udid!,"sessionType":"1"]
     let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
     //
     print("urlupdatesessionone",url)
     print("paramsupdate sessionone",params)
     HomePageViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
         let myResult = try? JSON(data: response.data!)
         let respCode = myResult!["responseCode"]
         print("loginNewDevicenewae resp",response)
         self.effectView.removeFromSuperview()
         if(respCode == "S111")
         {
             // session valid
         }
         else
         {
             self.defaults.set("", forKey: "USERID")
             self.defaults.set("", forKey: "PASSW")
             self.defaults.set("", forKey: "PIN")
             self.defaults.set("", forKey: "REGNO")
             UserDefaults.standard.set(false, forKey: "isLoggedIN")
             self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
             let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
             self.navigationController?.pushViewController(nextViewController, animated: true)
         }
         
     })
 }
 
 func loginNewDevicenewaelogoutt(access_token:String) {
     self.udid = UIDevice.current.identifierForVendor!.uuidString
     self.activityIndicator(NSLocalizedString("loading", comment: ""))
     let dateTime:String = getCurrentDateTime()
     let url = ge_api_url_new + "utilityservice/updateSession"
     let params:Parameters =  ["partnerId":partnerId,"token":token,"customerUserId":defaults.string(forKey: "USERID")!,"loginSessionId":self.udid!,"sessionType":"2"]
     
     print("urlupdatesessiontwo",url)
     print("paramsupdate sessiontwo",params)
     
     let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
     
     //beneficiarySerialNo
     
     HomePageViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
         let myResult = try? JSON(data: response.data!)
         let respCode = myResult!["responseCode"]
         print("resp",response)
         self.effectView.removeFromSuperview()
         if(respCode == "S222")
         {
             
             //
             //                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
             //                UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
             //                let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
             //                self.navigationController?.pushViewController(vc, animated: true)
             
         }
         else if (respCode == "S333")
         {
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
             self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
             let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
             self.navigationController?.pushViewController(nextViewController, animated: true)
         }
         
         else
         {
             
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
             
             
             
             UserDefaults.standard.set(false, forKey: "isLoggedIN")
             self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
             let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
             self.navigationController?.pushViewController(nextViewController, animated: true)
             
         }
         
     })
 }
 */
