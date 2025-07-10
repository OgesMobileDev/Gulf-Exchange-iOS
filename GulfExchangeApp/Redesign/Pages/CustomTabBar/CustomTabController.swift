//
//  CustomTabController.swift
//  GulfExchangeApp
//
//  Created by macbook on 09/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield
import Kingfisher
import Photos
import Toast_Swift

class CustomTabController: UITabBarController, SendMoneyViewDelegate, AlertPopupViewDelegate {
    
    
    
    
    @IBOutlet weak var screenshootViews: UIView!
    
    @IBOutlet var screenShootImgs: [UIImageView]!
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var cardLbl: UILabel!
    @IBOutlet weak var popupImg: UIImageView!
    @IBOutlet weak var popupLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var settingsImg: UIImageView!
    @IBOutlet weak var settingsLbl: UILabel!
    
    @IBOutlet var customTabView: UIView!
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var cardBtn: UIButton!
    @IBOutlet weak var popupBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    
    static var  sharedTabbar:CustomTabController?
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    var udid:String!
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let tag = 40
    let defaults = UserDefaults.standard
    let tabBarHeight:CGFloat = 100
    var transferSelection:HomeValidationSelection = .none
    var count:Int = 0
    var profileSelection = 0
    
    let popUpView = Bundle.main.loadNibNamed("SendMoneyView", owner: CustomTabController.self, options: nil)?.first as! SendMoneyView
    let confirmationpopUpView = Bundle.main.loadNibNamed("AlertPopupView", owner: CustomTabController.self, options: nil)?.first as! AlertPopupView
    let ErrorPopupView = Bundle.main.loadNibNamed("ErrorAlertPopupView", owner: HomePageViewController.self, options: nil)?.first as! ErrorAlertPopupView
    var loggedIn = false
    var notificMessageList:[String] = []
    var shouldShowPopup = false
    
    func overrideHorizontalSizeClassToCompact() {
            if #available(iOS 18.0, *) {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    self.traitOverrides.horizontalSizeClass = .compact
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideHorizontalSizeClassToCompact()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginChange(_:)), name: loginChangedNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationChange(_:)), name: notificationChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlayerFinish(_:)), name: playerFinishNotification, object: nil)
        popUpView.delegate = self
        confirmationpopUpView.delegate = self
        self.tabBar.isHidden = true
        setTabBarUI()
        if loggedIn == true{
//            self.getToken(num: <#T##Int#>)
        }
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        self.navigationItem.hidesBackButton = true
//        self.navigationItem.setLeftBarButton(nil, animated: false)
        //        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        self.navigationController?.isNavigationBarHidden = false
        //        self.navigationController?.navigationItem.hidesBackButton = true
        self.selectedIndex = 0
        showTabBar()
        //        self.navigationController?.navigationItem.hidesBackButton = true
        print("shouldShowPopupLoad\(shouldShowPopup)")
        setUI()
//        addNavbar()
//        addNavBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ScreenShield.shared.protect(view: self.homeImg)
        ScreenShield.shared.protect(view: self.homeLbl)
        ScreenShield.shared.protect(view: self.cardImg)
        ScreenShield.shared.protect(view: self.cardLbl)
        ScreenShield.shared.protect(view: self.popupImg)
        ScreenShield.shared.protect(view: self.popupLbl)
        ScreenShield.shared.protect(view: self.profileImg)
        ScreenShield.shared.protect(view: self.profileLbl)
        ScreenShield.shared.protect(view: self.settingsImg)
        ScreenShield.shared.protect(view: self.settingsLbl)
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.setLeftBarButton(nil, animated: false)
        loggedIn = (UserDefaults.standard.object(forKey: "isLoggedIN") as? Bool) ?? false
        addNavbar()
        if loggedIn == true{
            handleLoginChange()
            getToken(num: 2)
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
        }else{
//            addNavbar()
        }
//        addNavBarItems()
        
//        self.navigationController?.isNavigationBarHidden = false
        self.tabBar.isHidden = true
        print("shouldShowPopupAppear\(shouldShowPopup)")
        if shouldShowPopup {
                DispatchQueue.main.async {
                    self.confirmationpopUpView.setView()
                    self.confirmationpopUpView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    self.view.addSubview(self.confirmationpopUpView)
                }
                shouldShowPopup = false  // Reset flag
            }
        showTabBar()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CustomTabController.sharedTabbar = self
    }
    
    //MARK: - Button Functions
    
    
    @IBAction func onBtnClick(_ sender: UIButton) {
        switch sender.tag{
        case 20 :
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("home", languageCode: "en")
            }
            let tag = sender.tag - 20
            self.selectedIndex = tag
            self.setTabSelections(currentIndex: tag)
            if isLoggedIN == .yes{addNavbarLoggedin()}
        case 21:
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("master card", languageCode: "en")
            }
            
            if isLoggedIN == .yes{
                self.view.makeToast(NSLocalizedString("Coming Soon", comment: ""), duration: 3.0, position: .center)
//                let tag = sender.tag - 20
//                self.selectedIndex = tag
//                self.setTabSelections(currentIndex: tag)
//                if isLoggedIN == .yes{addNavbarLoggedin()}
            }else{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            print("MainLoginViewController")
        }
            
        case 22:
            print("send money popup tapped")
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("send money", languageCode: "en")
            }
            
            if isLoggedIN == .yes{
                popUpView.setView(baseView: view)
                popUpView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
                popUpView.alpha = 0.0
                view.addSubview(popUpView)
                print("SendMoneyView")
                UIView.animate(withDuration: 0.3, animations: {
                    self.popUpView.alpha = 1.0
                })

            }else{
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                print("MainLoginViewController")
            }
                
            
        case 23:
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("profile", languageCode: "en")
            }
            
            if isLoggedIN == .yes{
                let tag = sender.tag - 21
                self.selectedIndex = tag
                self.setTabSelections(currentIndex: tag)
                if isLoggedIN == .yes{addNavbarLoggedin()}
            }else{
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                print("MainLoginViewController")
            }
            
        case 24:
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("settings", languageCode: "en")
            }
            
            if isLoggedIN == .no{
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                print("MainLoginViewController")
            }else{
                let tag = sender.tag - 21
                self.selectedIndex = tag
                self.setTabSelections(currentIndex: tag)
                if isLoggedIN == .yes{addNavbarLoggedin()}
            }
            
            
        default:
            break
        }
        
        
    }
    func handleLoginChange(){
//        if let app = UIApplication.shared as? CustomApplication {
//               app.startSessionTimer()
//           }
//        confirmationpopUpView.setView()
//        confirmationpopUpView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
//        view.addSubview(confirmationpopUpView)
//        UserDefaults.standard.set(true, forKey: "isLoggedIN")
//        UserDefaults.standard.set(true, forKey: "BackgroundLoggedIN")
        
       
    }
    @objc func handleLoginChange(_ notification: Notification){
        if let data = notification.userInfo as? [String:Any] {
            isLoggedIN = data["isLoggedIN"] as! IsLoggedin
            if isLoggedIN == .yes{
                if let app = UIApplication.shared as? CustomApplication {
                       app.startSessionTimer()
                   }
//                shouldShowPopup = true  // Set flag to show popup later
//                DispatchQueue.main.async {
//                    self.confirmationpopUpView.setView()
//                    self.confirmationpopUpView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
//                    self.view.addSubview(self.confirmationpopUpView)
//                }
            }
            
        }
    }
    @objc func handleNotificationChange(_ notification: Notification){
        if let data = notification.userInfo as? [String:Any] {
            let check = data["notificationRead"] as! Bool
            if check{
                notificationCount = true
            }else{
                notificationCount = false
            }
            if isLoggedIN == .yes{addNavbarLoggedin()}
        }
    }
    @objc func handlePlayerFinish(_ notification: Notification){
        if let data = notification.userInfo as? [String:Any] {
            let player = data["player"] as! Bool
            if player{
                let tag = 2
                self.selectedIndex = tag
                self.setTabSelections(currentIndex: tag)
                if isLoggedIN == .yes{addNavbarLoggedin()}
            }
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
    func SendMoneyView(_ vc: SendMoneyView, action: SendMoneyPopupAction) {
        switch action {
        case .cashPickup:
            transferSelection = .cashPickup
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("cash pick up", languageCode: "en")
            }
            
            getToken(num: 1)
            print("cashPickup from send money popup tapped")
            
            
            
        case .bankTranfer:
            transferSelection = .bankTransfer
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("bank transfer", languageCode: "en")
            }
            
            getToken(num: 1)
            print("bankTransfer from send money popup tapped")
            
          
            
            
        case .mobileWallet:
            transferSelection = .mobileWallet
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("mobile wallet transfer", languageCode: "en")
            }
            
            getToken(num: 1)
            print("mobilewallet from send money popup tapped")
            
        }
    }
    func AlertPopupView(_ vc: AlertPopupView, action: Bool) {
        confirmationpopUpView.removeFromSuperview()
       
        self.getPopupNotificationList()
    }
    func showTabBar() {
        self.tabBar.isHidden = true
        customTabView.isHidden = false
    }
    
    func setUI(){
        homeBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        cardBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        profileBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        settingsBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        popupBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        //        customTabView.frame = CGRect.init(x:0,y:UIScreen.main.bounds.size.height - 100,width:UIScreen.main.bounds.size.width,height: 100)
        homeLbl.text =  NSLocalizedString("home", comment: "")
//        cardLbl.text =  NSLocalizedString("Master Card", comment: "")
        cardLbl.text =  "Cash Passport"
        profileLbl.text =  NSLocalizedString("profile", comment: "")
        settingsLbl.text =  NSLocalizedString("settings", comment: "")
        popupLbl.text =  NSLocalizedString("Send", comment: "")
        
        
        customTabView.layer.shadowRadius = 10
        customTabView.layer.shadowColor = UIColor.black.cgColor
        customTabView.layer.shadowOpacity = 0.2
        customTabView.layer.shadowOffset = .zero
    }
    func setTabBarUI() {
        
        self.view.addSubview(customTabView)
        customTabView.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.size.height - tabBarHeight, width: UIScreen.main.bounds.size.width, height: tabBarHeight)
        self.selectedIndex = profileSelection
    }
   
    
    @objc func heplVCAction(){
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
    @objc func loginSignupAction() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        print("Login/Signup button tapped")
    }
    func setTabSelections(currentIndex: Int){
        homeImg.image = UIImage(named: unSelectedTabArray[0])
        cardImg.image = UIImage(named: unSelectedTabArray[1])
        profileImg.image = UIImage(named: unSelectedTabArray[2])
        settingsImg.image = UIImage(named: unSelectedTabArray[3])
        switch currentIndex{
        case 0:
            homeImg.image = UIImage(named: selectedTabArray[0])
        case 1:
            cardImg.image = UIImage(named: selectedTabArray[1])
        case 2:
            profileImg.image = UIImage(named: selectedTabArray[2])
        case 3:
            settingsImg.image = UIImage(named: selectedTabArray[3])
        default:
            break
        }
    }
    func navigateFromValidation(){
        switch transferSelection {
        case .bankTransfer:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
            vc.currentSelection = .bankTransfer
            self.navigationController?.pushViewController(vc, animated: true)
        case .cashPickup:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
            vc.currentSelection = .cashPickup
            self.navigationController?.pushViewController(vc, animated: true)
        case .mobileWallet:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
            vc.currentSelection = .mobileWallet
            self.navigationController?.pushViewController(vc, animated: true)
        case .benefDetails:
            print("")
        case .none:
            print("")
        }
    }
    func addErrorPopup(msg:String,subMsg:String){
        ErrorPopupView.setView(msg: msg, subMsg: subMsg)
        ErrorPopupView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        ErrorPopupView.alpha = 0.0
        view.addSubview(ErrorPopupView)
        UIView.animate(withDuration: 0.3, animations: {
            self.ErrorPopupView.alpha = 1.0
        })
        
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
    //MARK: - API Calls
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        print("tokenurl",url)
        //        self.olduserchkstr = "0"
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token  ",token)
                if(num == 1)
                {
                    self.validateRemittanceStatus(check: 1, accessToken: token)
                }
                else if(num == 2)
                {
                    self.getNotificationCount(accessToken: token)
                }
                break
            case .failure:
                break
            }
            
        })
    }
    func validateRemittanceStatus(check:Int,accessToken:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        
        let appVersion = AppInfo.version
                     print("appVersion",appVersion)
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"", "customerMobile":appVersion, "customerPhone":"IOS","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"ISREMITALLOWED","isExistOrValid":"0"]
        
        print("paramsvalidationutility ",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
             print("respCoderespCoderespCode ",respCode)
            let respMsg = myResult!["responseMessage"].stringValue
            if(respCode == "S1111")
            {
                let CustomerCode = myResult!["casmexCustomerCode"].stringValue
//                self.casmexCustomerCode = CustomerCode
                self.defaults.set(CustomerCode, forKey: "casmexCustomerCode")
                
                let sessionId = myResult!["casmexSessionId"].stringValue
//                self.casmexSessionId = sessionId
                self.defaults.set(sessionId, forKey: "casmexSessionId")
                
                let token = myResult!["casmexToken"].stringValue
//                self.casmexToken = token
                self.defaults.set(token, forKey: "casmexToken")
                
                if(check == 1)
                {
                    self.navigateFromValidation()
                }
                else if(check == 2)
                {
                    
                }
                else if(check == 3)
                {
                    
                }
            }
            else if(respCode == "S2222")
            {
                let CustomerCode = myResult!["casmexCustomerCode"].stringValue
//                self.casmexCustomerCode = CustomerCode
                self.defaults.set(CustomerCode, forKey: "casmexCustomerCode")
                
                let sessionId = myResult!["casmexSessionId"].stringValue
//                self.casmexSessionId = sessionId
                self.defaults.set(sessionId, forKey: "casmexSessionId")
                
                let token = myResult!["casmexToken"].stringValue
//                self.casmexToken = token
                self.defaults.set(token, forKey: "casmexToken")
                
                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                let okAction = UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .cancel){ (action:UIAlertAction) in
                            
                    
                    self.navigateFromValidation()
                                    
                }
                        commonAlert.addAction(okAction)
                self.present(commonAlert, animated: true, completion: nil)
            }
            else if(respCode == "E9999")
            {
                   // AlertView.instance.showAlert(msg: respMsg, action: .attention)
                   // self.getPopupNotificationList()
                    self.getNewVersionalertList()
            }
            else if(respCode == "E7112")
            {
                self.addErrorPopup(msg: respMsg, subMsg: "")
                //original
//                AlertView.instance.showAlert(msg: respMsg, action: .attention)
                
//                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
//                let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
//
//                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                   // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                    let vc: ActualOccupationViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActualOccupationViewController") as! ActualOccupationViewController
//                    self.navigationController?.pushViewController(vc, animated: true)
//
//                }
//                        commonAlert.addAction(okAction)
//                self.present(commonAlert, animated: true, completion: nil)
               
            }
            
            else if(respCode == "E7002")
            {
                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                  
                    self.selectedIndex = 2
                    self.setTabSelections(currentIndex: 2)
                    if isLoggedIN == .yes{self.addNavbarLoggedin()}
                                    
                }
                        commonAlert.addAction(okAction)
                self.present(commonAlert, animated: true, completion: nil)
            }
            
            
            else if(respCode == "E7003")
            {
                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                  
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                   // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let vc: ActualOccupationViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActualOccupationViewController") as! ActualOccupationViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                }
                        commonAlert.addAction(okAction)
                self.present(commonAlert, animated: true, completion: nil)
            }
            
            else
            {
                self.addErrorPopup(msg: NSLocalizedString("u_r_not_allowed", comment: ""), subMsg: NSLocalizedString("contact_customer_care", comment: ""))
//                AlertView.instance.showAlert(msg: NSLocalizedString("u_r_not_allowed", comment: "") + NSLocalizedString("contact_customer_care", comment: ""), action: .attention)
            }
            
        
        })
    }
    
    func getNotificationCount(accessToken:String) {
        print("notification count......")
        self.count = 0
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            let dateTime:String = getCurrentDateTime()
            let url = ge_api_url_new + "utilityservice/listordeletenotification"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW") ?? "","mpin":defaults.string(forKey: "PIN") ?? "","notificationID":"","messageReadFag":" ","actionType":"LIST"]
            let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
            
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                
                self.effectView.removeFromSuperview()
                print("validateemail ",response)
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["responseCode"]
                let respMsg = myResult!["responseMessage"].stringValue
                print("respCode...",respCode)
                print("respMsg...",respMsg)
                if(respCode == "S120")
                {
                    let resultArray = myResult!["notificationList"]
                    for i in resultArray.arrayValue{
                        if(i["messageReadFlag"].stringValue == "UNREAD")
                        {
                            self.count = self.count + 1
                            print("countt",self.count)
                            
                            
                        }
                    }
                    
                    if(self.count == 0)
                    {
                        notificationCount = false
                        
                    }
                    else
                    {
                        notificationCount = true
                    }
                }
                self.addNavbar()
                
            })
        }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        return formattedDate
    }
    //newvresion alert
    func getNewVersionalertList() {
       var notificMessageList1: [String] = []
       let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
             let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               self.activityIndicator(NSLocalizedString("loading", comment: ""))
               let url = api_url + "application_update_notification"
        let params:Parameters = ["lang": appLang,"device_type":"IOS"]
                 AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
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
//                               print("NullcontentpopupNEWVER",self.oncecheckpopupstr)
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
    
    func getPopupNotificationList() {
//        self.activityIndicator(NSLocalizedString("loading", comment: ""))
       var notificMessageList: [String] = []
       let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
             let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               
               let url = api_url + "popup_notification_listing"
           let params:Parameters = ["lang": appLang]
                 AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                   print("popup_notification_listing response",response)
//                     self.activityIndicator.removeFromSuperview()
                   switch response.result{
                   case .success:
                       guard let responseData = response.data else {
                           return
                       }
                       guard let myResult = try? JSON(data: responseData) else {
                           return
                       }
                       let popupListing = myResult["popup_notification_listing"]
                       if(popupListing.count > 0) {
                           for popupObject in popupListing.arrayValue {
                               let currentItemKey = "popup_notf_desc_" + appLang
                               let currentItemEn = "popup_notf_desc_en"
                               let desc = popupObject[currentItemKey].stringValue
                               let desc2 = popupObject[currentItemEn].stringValue
                               if(desc != "") {
                               let descString = desc
                               notificMessageList.append(descString)
                                    print("descprint",descString)
//                                self.showPopupAlert(desc: descString)
                               } else if(desc2 != "") {
                               let desc2String = desc
                               notificMessageList.append(desc2String)
                                   print("descprint2",desc2String)
//                                self.showPopupAlert(desc: desc2String)
                           }
                       }
                           
                           let a = ["", "", ""]
                           let b = notificMessageList
                        if a == b {
                             print("Nullcontentpopup",notificMessageList)
                        }
                           else
                        {
                           if notificMessageList.count > 0 {
//                               self.notificMessageList = notificMessageList
                           self.showPopupAlert(descArray: notificMessageList)
                                 print("contentpopup",notificMessageList)
                               
//                               self.oncecheckpopupstr = "1"
                               //
//                               print("Nullcontentpopup",self.oncecheckpopupstr)
                           }
                           }
                           
                           
                           
                       }
                   break
                   case .failure:
                       break
                   
                   }
                 })
       }
    
    func showPopupAlert(descArray: [String]) {
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
            UserDefaults.standard.set(true, forKey: "IS_POPUP_SHOWN")
            let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
            let popup : PopupViewController = storyBoard.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
            self.presentOnRoot(with: popup, descArray: arrayFilter)
        }
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
}
extension CustomTabController{
    
    func addNavbar(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomePageVC") as? HomePageViewController {
            nextViewController.topTableView?.reloadData()
        }
        
        if isLoggedIN == .yes{
            addNavbarLoggedin()
        }else{
            addNavbarLogin()
        }
    }
    func addNavbarLogin(){
        let imageView = UIImageView(image: UIImage(named: "ge_logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let leftBarButtonItem = UIBarButtonItem(customView: imageView)
        let loginButton = UIButton(type: .system)
        loginButton.setAttributedTitle(buttonTitleSet(title: "Login / Sign up", size: 8, font: .semiBold), for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = colorRed
        loginButton.layer.cornerRadius = 5
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.rgba(19, 56, 82, 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = UIColor.rgba(198, 23, 30, 1)
        loginButton.addTarget(self, action: #selector(loginSignupAction), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: loginButton)
        
        navigationItem.rightBarButtonItem = barButtonItem
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    func addNavbarLoggedin(){

        switch selectedIndex{
        case 0:
            let imageView = UIImageView(image: UIImage(named: "ge_logo"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
    
            let leftBarButtonItem = UIBarButtonItem(customView: imageView)
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            self.navigationItem.title = ""
        case 1:
            self.navigationController?.isNavigationBarHidden = false
            if let backImage = UIImage(named: "back_arrow") {
                let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                    backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
                }
                let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
                self.navigationItem.leftBarButtonItem = backButton
            }
            self.navigationItem.title = "Master Card"
        case 2:
            self.navigationController?.isNavigationBarHidden = false
            if let backImage = UIImage(named: "back_arrow") {
                let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                    backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
                }
                let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
                self.navigationItem.leftBarButtonItem = backButton
            }
            self.navigationItem.title = NSLocalizedString("profile", comment: "")
        case 3:
            self.navigationController?.isNavigationBarHidden = false
            if let backImage = UIImage(named: "back_arrow") {
                let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                    backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
                }
                let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
                self.navigationItem.leftBarButtonItem = backButton
            }
            self.navigationItem.title = NSLocalizedString("settings", comment: "")
        default:
            break
        }
//
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.rgba(19, 56, 82, 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = UIColor.rgba(198, 23, 30, 1)
        
        var notificationIMg = "notification_y"
        if notificationCount{
            notificationIMg = "notification_y"
        }else{
            notificationIMg = "notification_n"
        }
        let notificationBtn = UIBarButtonItem(image: UIImage(named: notificationIMg), style: .done, target: self, action: #selector(notificationAction))
        let helpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItems  = [helpBtn, notificationBtn]
        
    }
    @objc func customBackButtonTapped() {
        self.selectedIndex = 0
        self.setTabSelections(currentIndex: 0)
        if isLoggedIN == .yes{addNavbarLoggedin()}
    }
    func addNavBarItems() {
//        let button1 = UIButton(type: .system)
//        button1.setImage(UIImage(named: "notification_y"), for: .normal)
//        button1.imageView?.contentMode = .scaleAspectFit
//        button1.translatesAutoresizingMaskIntoConstraints = false
//        button1.addTarget(self, action: #selector(heplVCAction), for: .touchUpInside)
//        
//        let button2 = UIButton(type: .system)
//        button2.setImage(UIImage(named: "faq 1"), for: .normal)
//        button2.imageView?.contentMode = .scaleAspectFit
//        button2.translatesAutoresizingMaskIntoConstraints = false
//        button2.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
//        
//        let imageView = UIImageView(image: UIImage(named: "ge_logo"))
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        let leftBarButtonItem = UIBarButtonItem(customView: imageView)
//        
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        
//        containerView.addSubview(button1)
//        containerView.addSubview(button2)
//        
//        NSLayoutConstraint.activate([
//            button1.widthAnchor.constraint(equalToConstant: 20),
//            button1.heightAnchor.constraint(equalToConstant: 20),
//            button1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            button1.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            
//            button2.widthAnchor.constraint(equalToConstant: 30),
//            button2.heightAnchor.constraint(equalToConstant: 30),
//            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 8),
//            button2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            button2.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            
//            imageView.widthAnchor.constraint(equalToConstant: 153),
//            imageView.heightAnchor.constraint(equalToConstant: 40),
////            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
////            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8) // Adjust if needed
//        ])
//        containerView.isUserInteractionEnabled = true
//        button1.isUserInteractionEnabled = true
//        button2.isUserInteractionEnabled = true
////        imageView.isUserInteractionEnabled = true
//        let barButtonItem = UIBarButtonItem(customView: containerView)
//        navigationItem.rightBarButtonItem = barButtonItem
//        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

//    func addNavBarItems(){
//        let button1 = UIButton(type: .system)
//        if notification{
//            button1.setImage(UIImage(named: "notification_y"), for: .normal)
//        }else{
//            button1.setImage(UIImage(named: "notification_n"), for: .normal)
//        }
//        
//        button1.imageView?.contentMode = .scaleAspectFill
//        button1.translatesAutoresizingMaskIntoConstraints = false
//        button1.addTarget(self, action: #selector(heplVCAction), for: .touchUpInside)
//        
//        let button2 = UIButton(type: .system)
//        button2.setImage(UIImage(named: "faq 1"), for: .normal)
//        button2.imageView?.contentMode = .scaleAspectFit
//        button2.translatesAutoresizingMaskIntoConstraints = false
//        button2.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
//        let imageView = UIImageView(image: UIImage(named: "ge_logo"))
//        imageView.contentMode = .scaleAspectFit
//        
//        // Create a UIBarButtonItem with the image view
//        let leftBarButtonItem = UIBarButtonItem(customView: imageView)
//        
//        // Optionally, set constraints for the image view if needed
//        imageView.translatesAutoresizingMaskIntoConstraints = false
////        NSLayoutConstraint.activate([
////            
////        ])
//        
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//
//        containerView.addSubview(button1)
//        containerView.addSubview(button2)
//        NSLayoutConstraint.activate([
//            button1.widthAnchor.constraint(equalToConstant: 20),
//            button1.heightAnchor.constraint(equalToConstant: 20),
//            button1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            button1.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            
//            button2.widthAnchor.constraint(equalToConstant: 30),
//            button2.heightAnchor.constraint(equalToConstant: 30),
//            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 8), // Adjust spacing as needed
//            button2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            button2.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            
//            imageView.widthAnchor.constraint(equalToConstant: 153), // Adjust size as needed
//            imageView.heightAnchor.constraint(equalToConstant: 40)
//        ])
//      
//                // Set the leftBarButtonItem on the navigationItem
//                
//        
//        let barButtonItem = UIBarButtonItem(customView: containerView)
//        navigationItem.rightBarButtonItem = barButtonItem
//        navigationItem.leftBarButtonItem = leftBarButtonItem
       
//    }
}




let selectedTabArray = ["home_selected","card_selected","profile_selected","settings_selected"]
let unSelectedTabArray = ["home_nselected","card_nselected","profile_nselected","settings_nselected"]
