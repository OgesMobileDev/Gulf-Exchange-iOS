//
//  LoginViewController.swift
//  GulfExchangeApp
//
//  Created by macbook on 12/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import LocalAuthentication
import MediaPlayer
import Toast_Swift
import ScreenShield
import CryptoKit

class MainLoginViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var qidLbl: UILabel!
    
    @IBOutlet weak var getStartedLbl: UILabel!
    @IBOutlet weak var signInLbl: UILabel!
    @IBOutlet weak var forgotPassLbl: UILabel!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var resgisterBtn: UIButton!
    @IBOutlet weak var dontHvAccLbl: UILabel!
    @IBOutlet weak var pleaseRegLbl: UILabel!
    @IBOutlet weak var resetLbl: UILabel!
    
    @IBOutlet var emptyBts: [UIButton]!
    @IBOutlet weak var passwordEyeBtn: UIButton!
    @IBOutlet weak var passEyeImg: UIImageView!
    
    // previous
    
    //    @IBOutlet var mainView: UIView!
    @IBOutlet weak var idNumTextField: UITextField!
    @IBOutlet weak var passwTextField: UITextField!
    
    var testname:String = ""
    var timer = Timer()
    var neworexistcuststr:String = ""
    var passwEyeClick = true
    var pinEyeClick = true
    var lockStatus:String!
    var userId:String!
    var passw:String!
    var pin:String!
    var udid:String!
    var str_country:String = ""
    let defaults = UserDefaults.standard
    var locationManager = CLLocationManager()
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var latitude:Double?
    var longitude:Double?
    var addressString : String = ""
    var str1:String = ""
    var str2:String = ""
    var lats : String = ""
    var longs : String = ""
    var loginBtnTapped:Bool = false
    var checkLoginSecond:Int = 0
    var loginLocationCount:Int = 0
    
    //test
    static let AlamoFireManager: Alamofire.Session = {
        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator(),
                                                          "ws.gulfexchange.com.qa": DisabledEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    //production
//              static let AlamoFireManager: Alamofire.Session = {
//            //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
//                    let configuration = URLSessionConfiguration.af.default
//                    return Session(configuration: configuration)
//            //        return Session(configuration: configuration, serverTrustManager: manager)
//                }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavbar()
        setView()
        loginLocationCount = 0
        timer.invalidate()
        self.awakeFromNib()
        self.checkBiometric()
        
        self.checkLanguage()
        
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        idNumTextField.delegate = self
        passwTextField.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        handleFirstLogin()
        enableTextToSpeech()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkBiometric()
        self.checkLanguage()
        ScreenShield.shared.protect(view: self.getStartedLbl)
        ScreenShield.shared.protect(view: self.signInLbl)
        ScreenShield.shared.protect(view: self.forgotPassLbl)
        ScreenShield.shared.protect(view: self.resetLbl)
        ScreenShield.shared.protect(view: self.resgisterBtn)
        ScreenShield.shared.protect(view: self.dontHvAccLbl)
        ScreenShield.shared.protect(view: self.pleaseRegLbl)
        ScreenShield.shared.protect(view: self.idNumTextField)
        ScreenShield.shared.protect(view: self.passwTextField)
        ScreenShield.shared.protectFromScreenRecording()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //        self.checkBiometric()
        self.checkLanguage()
        UserDefaults.standard.removeObject(forKey: "neworexistcuststr")
        // timer.invalidate()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            //            getAddressFromLatLon(pdblLatitude: self.lats ?? "", withLongitude: self.longs ?? "")
        }
        setTitle("", andImage: UIImage(named: "ge_logo")!)
    }
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)  ///< Don't for get this BTW!
        var moviePlayer: MPMoviePlayerController?
        if let player = moviePlayer {
            player.stop()
        }
    }
    
    
    @IBAction func resetPasswordBtnTapped(_ sender: Any) {
        print("resetPasswordBtnTapped")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.isNavigationBarHidden = false
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main11", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPinPasswordViewController") as! ResetPinPasswordViewController
        nextViewController.currentPage = .password
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    
    // checking required
    @IBAction func loginBtnTapped(_ sender: Any) {
        print("loginBtnTapped")
        loginBtnTapped = true
        
        //        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
        //
        //            UserDefaults.standard.set(true, forKey: "isLoggedIN")
        //          isLoggedIN = .yes
        //          let data = ["isLoggedIN": isLoggedIN] as [String : Any]
        //          NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
        //            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
        //            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
//        nextViewController.shouldShowPopup = true
        //            self.navigationController?.pushViewController(nextViewController, animated: true)
        
        //          getNewVersionalertList()
        
        checkLogin()
    }
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        print("registerBtnTapped")
//        fatalError("Test crash")
        // redesign
        
               redirectToRegisterNew()

        // original
//                redirectToRegister()
        
        
    }
    
    
    @IBAction func passwordEyeBtnTapped(_ sender: Any) {
        if passwEyeClick {
            passwTextField.isSecureTextEntry = false
            passEyeImg.image = UIImage(named: "show pswrd")
        } else {
            passwTextField.isSecureTextEntry = true
            passEyeImg.image = UIImage(named: "hide pswrd")
        }
        passwEyeClick.toggle()
    }
    
    //MARK: - Functions
    func redirectToRegisterNew(){
        
        
        
        
        let alert = UIAlertController(title: "Register", message: "Are you an existing Gulf Exchange customer?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
            //self.loginNewDevice()
            
            self.neworexistcuststr = "B"
            UserDefaults.standard.removeObject(forKey: "neworexistcuststr")
            UserDefaults.standard.set(self.neworexistcuststr, forKey: "neworexistcuststr")
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IDVerificationBaseVC") as! IDVerificationBaseVC
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IDVerificationBaseVC1") as! IDVerificationBaseVC
            
            nextViewController.verificationType = .register
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
            print("No....")
            
            self.neworexistcuststr = "N"
            
            UserDefaults.standard.removeObject(forKey: "neworexistcuststr")
            UserDefaults.standard.set(self.neworexistcuststr, forKey: "neworexistcuststr")
            //
            //
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IDVerificationBaseVC") as! IDVerificationBaseVC
            
            nextViewController.verificationType = .register
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }))
        self.present(alert, animated: true)
        
    }
    func redirectToRegister(){
        
        
        /*let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "registerr") as! RegisterViewController
         self.present(nextViewController, animated:true, completion:nil)*/
        
        
        
        
        let alert = UIAlertController(title: "Register", message: "Are you an existing Gulf Exchange customer?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
            //self.loginNewDevice()
            
            self.neworexistcuststr = "B"
            UserDefaults.standard.removeObject(forKey: "neworexistcuststr")
            UserDefaults.standard.set(self.neworexistcuststr, forKey: "neworexistcuststr")
            //
            print("neworexistcuststr",UserDefaults.standard.string(forKey: "neworexistcuststr"))
            let vc: RegisternewenhViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisternewenhViewController") as! RegisternewenhViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            //originalllll
            //
            //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            //            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "photo1") as! Photo1ViewController
            //            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
            //originalllllOCR
            //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            //            let vc: IDverificationRegisterVC = UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "IDverificationRegisterVC") as! IDverificationRegisterVC
            //            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
            print("No....")
            
            self.neworexistcuststr = "N"
            
            UserDefaults.standard.removeObject(forKey: "neworexistcuststr")
            UserDefaults.standard.set(self.neworexistcuststr, forKey: "neworexistcuststr")
            //
            //
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: RegisterViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerr") as! RegisterViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            //original
            
            //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            //            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "photo1") as! Photo1ViewController
            //            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            //originalllllOCR
            //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            //            let vc: IDverificationRegisterVC = UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "IDverificationRegisterVC") as! IDverificationRegisterVC
            //            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        self.present(alert, animated: true)
        
    }
    func checkLanguage(){
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            idNumTextField.textAlignment = .right
            passwTextField.textAlignment = .right
            forgotPassLbl.textAlignment = .left
            resetPasswordBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        } else {
            idNumTextField.textAlignment = .left
            passwTextField.textAlignment = .left
            forgotPassLbl.textAlignment = .right
            resetPasswordBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        }
    }
    func checkBiometric(){
        if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
        {
            
            print("typed","typedbtn")
            //biometric
            let context = LAContext()
            var error:NSError? = nil
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error)
            {
                let reason = "Please Autherise With Touch Id"
                //context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason), reply: weak<#T##(Bool, Error?) -> Void#>)
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [weak self] success, error in
                    DispatchQueue.main.async { [self] in
                        guard success, error == nil else{
                            return
                            
                        }
                        self!.loginBtnTapped = false
                        self!.checkLoginBiometric()
                    }
                }
            }
            else
            {
                let ac = UIAlertController(title: "Unavailable", message: "You Cant Use This Feature!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
                
            }
        }
    }
    
    
    func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
        
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        let helpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItems  = [helpBtn]
        //        let imageView = UIImageView(image: UIImage(named: "ge_logo"))
        //        imageView.contentMode = .scaleAspectFit
        //        imageView.translatesAutoresizingMaskIntoConstraints = false
        //        let leftBarButtonItem = UIView(customView: imageView)
        //        self.navigationItem.titleView?.addSubview(imageView)
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HelpVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func customBackButtonTapped() {
        isLoggedIN = .no
        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        //        let imageView = UIImageView(frame: CGRect(x: 220, y: 20, width: 40, height: 40))
        //        imageView.image = UIImage(named: "attention")
        //
        //        alert.view.addSubview(imageView)
        self.present(alert, animated: true)
    }
    func alertMessage(title: String, msg: String, action: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { _ in
            // Execute the completion handler if provided
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func setView(){
        idNumTextField.keyboardType = .numberPad
        passwTextField.isSecureTextEntry = true
        passwordEyeBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        for button in emptyBts{
            button.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        }
        loginBtn.setAttributedTitle(buttonTitleSet(title: "Login", size: 14, font: .semiBold), for: .normal)
        
        
        signInLbl.text = (NSLocalizedString("Sign in to continue", comment: ""))
       dontHvAccLbl.text = (NSLocalizedString("Don’t have an account ?", comment: ""))
        
        forgotPassLbl.text = (NSLocalizedString("forgot_password", comment: ""))
        pleaseRegLbl.text = (NSLocalizedString("pls_register", comment: ""))
        passwTextField.placeholder  = (NSLocalizedString("password", comment: ""))
        
        
        
    }
    
    func handleFirstLogin() {
        
        let hasEnabledTextToSpeech:Bool = defaults.bool(forKey: "hasEnabledTextToSpeech")
        
        if !hasEnabledTextToSpeech {
            enableTextToSpeech()
            UserDefaults.standard.set(true, forKey: "hasEnabledTextToSpeech")
            UserDefaults.standard.synchronize() // Ensures the value is saved immediately
        }
    }
    func enableTextToSpeech(){
        //showAlertText(title: NSLocalizedString("gulf_exchange", comment: ""), message: "This application has a\nText-to-Speech feature.\nTo enable it, please press Enable.")
        
        UserDefaults.standard.set(false, forKey: "accessibilityenabled")
        
    }
    
    func showAlertText(title: String, message: String) {
        let commonAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            UserDefaults.standard.set(false, forKey: "accessibilityenabled")
        }
        let EnableAction = UIAlertAction(title: "Enable", style: .default) { _ in
            UserDefaults.standard.set(true, forKey: "accessibilityenabled")
        }
        
        commonAlert.addAction(cancelAction)
        commonAlert.addAction(EnableAction)
        UIApplication.shared.windows.first?.rootViewController?.present(commonAlert, animated: true, completion: nil)
    }
    func md5(_ string: String) -> String {
        let inputData = Data(string.utf8)
        let hashed = Insecure.MD5.hash(data: inputData)
        let hashString = hashed.map { String(format: "%02hhx", $0) }.joined()
        return hashString
    }
    func checkLoginBiometric(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                
                let alertController = UIAlertController(title: "GulfExchangeApp Location Permission Required", message: "For better experience, turn on device location in app.", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                    //Redirect to Settings app
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                alertController.addAction(cancelAction)
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
                
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                if Connectivity.isNetworkAvailable{
                    if(isConnectedToVpn)
                    {
                        self.view.makeToast(NSLocalizedString("no_vpn_network", comment: ""), duration: 3.0, position: .top)
                        
                        //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("no_vpn_network", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                    }else{
                        //                       getLoginFailedCount()
                        self.getToken()
                    }
                }
            }
        }
        else {
            print("Location services are not enabled")
            
            // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("turn_on_location", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            
            
            
            let alertController = UIAlertController(title: "GulfExchangeApp Location Permission Required", message: "For better experience, turn on device location.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }
    }
    func checkLogin(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                
                let alertController = UIAlertController(title: "GulfExchangeApp Location Permission Required", message: "For better experience, turn on device location in app.", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                    //Redirect to Settings app
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                alertController.addAction(cancelAction)
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
                
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                
                
                
                
                if Connectivity.isNetworkAvailable{
                    
                    //new
                    if idNumTextField.text?.isEmpty == true
                    {
                        // timer.invalidate()
                        self.idNumTextField.layer.borderColor = UIColor.red.cgColor
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                            if #available(iOS 13.0, *) {
                                self.idNumTextField.layer.borderColor = UIColor.systemGray4.cgColor
                            } else {
                                // Fallback on earlier versions
                            }
                            
                        }
                    }
                    else
                    {
                        
                        if #available(iOS 13.0, *) {
                            self.idNumTextField.layer.borderColor = UIColor.systemGray4.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    guard let id_no = idNumTextField.text,idNumTextField.text?.count != 0 else
                    {
                        self.view.makeToast(NSLocalizedString("enter_id_no", comment: ""), duration: 3.0, position: .top)
                        idNumTextField.becomeFirstResponder()
                        // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_no", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        loginBtnTapped = false
                        return
                    }
                    
                    
                    var charSetidNum = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                    var string2 = id_no
                    
                    if let strvalue = string2.rangeOfCharacter(from: charSetidNum)
                    {
                        print("true")
                        
                        self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .top)
                        
                        self.idNumTextField.layer.borderColor = UIColor.red.cgColor
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                            if #available(iOS 13.0, *) {
                                self.idNumTextField.layer.borderColor = UIColor.systemGray4.cgColor
                            } else {
                                // Fallback on earlier versions
                            }
                            
                        }
                        
                        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        loginBtnTapped = false
                        return
                    }
                    else
                    {
                        if #available(iOS 13.0, *) {
                            self.idNumTextField.layer.borderColor = UIColor.systemGray4.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                        
                    }
                    
                    
                    if (!validate (value: self.idNumTextField.text!))
                    {
                        self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .top)
                        
                        self.idNumTextField.layer.borderColor = UIColor.red.cgColor
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                            if #available(iOS 13.0, *) {
                                self.idNumTextField.layer.borderColor = UIColor.systemGray4.cgColor
                            } else {
                                // Fallback on earlier versions
                            }
                            
                        }
                        
                        
                        // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        loginBtnTapped = false
                        return
                        
                    }
                    else
                    {
                        if #available(iOS 13.0, *) {
                            self.idNumTextField.layer.borderColor = UIColor.systemGray4.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    //                    let count = idNumTextField.text?.count
                    //                    if(count != 11)
                    //                    {
                    //                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    //                        return
                    //                    }
                    
                    
                    //new
                    if passwTextField.text?.isEmpty == true
                    {
                        // timer.invalidate()
                        self.passwTextField.layer.borderColor = UIColor.red.cgColor
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                            if #available(iOS 13.0, *) {
                                self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
                            } else {
                                // Fallback on earlier versions
                            }
                            
                        }
                    }
                    else
                    {
                        
                        if #available(iOS 13.0, *) {
                            self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    
                    guard let password = passwTextField.text,passwTextField.text?.count != 0 else
                    {
                        
                        self.view.makeToast(NSLocalizedString("enter_password", comment: ""), duration: 3.0, position: .top)
                        
                        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        loginBtnTapped = false
                        return
                    }
                    
                    
                    
                    self.userId = id_no
                    self.passw = password
                    self.pin = ""
                    if(isConnectedToVpn)
                    {
                        self.view.makeToast(NSLocalizedString("no_vpn_network", comment: ""), duration: 3.0, position: .top)
                        
                        //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("no_vpn_network", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        loginBtnTapped = false
                        return
                    }
                    
                    
                    
                    
                    else{
                        //                       getLoginFailedCount()
                        self.getToken()
                    }
                }
                
            }
        }
        else {
            print("Location services are not enabled")
            
            // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("turn_on_location", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            
            
            
            let alertController = UIAlertController(title: "GulfExchangeApp Location Permission Required", message: "For better experience, turn on device location.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }
        //
        //        else{
        //
        //        }
        
        
    }
    // MARK: phone no Validation :
    func validate(value: String) -> Bool {
        //let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let PHONE_REGEX = "^[0-9]{0,15}$"
        //let PHONE_REGEX = "[a-zA-z]"
        
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        // set the value of latitude and longitude
        latitude = location.latitude
        longitude = location.longitude
        str1 = String(location.latitude)
        str2 = String(location.longitude)
        self.defaults.set(self.str1, forKey: "USERLATITUDE")
        self.defaults.set(self.str2, forKey: "USERLONGITUDE")
        getAddressFromLatLon(pdblLatitude: self.str1 ?? "", withLongitude: self.str2 ?? "")
    }
    private var isConnectedToVpn: Bool {
        if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? Dictionary<String, Any>,
           let scopes = settings["__SCOPED__"] as? [String:Any] {
            for (key, _) in scopes {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") {
                    return true
                }
            }
        }
        return false
    }
    
    //newvresion alert
    func getNewVersionalertList() {
        var notificMessageList1: [String] = []
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "application_update_notification"
        let params:Parameters = ["lang": appLang,"device_type":"IOS"]
        print("paramsappupdateurl...login",url)
        print("paramsappupdate...login",params)
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
            
            let vc: WEBTEXTLOGINViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBTEXTLOGINViewController") as! WEBTEXTLOGINViewController
            vc.descArray = descArray
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            
            
            //            let popupone : WEBVIEWHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
            //            self.presentOnRoot(with: popupone, descArray: arrayFilter)
        }
    }
    //MARK: - APi Calls
    func getLoginFailedCount() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "login_failed_count"
        
        if ((self.defaults.string(forKey: "USERID")?.isEmpty) != nil)
        {
            self.userId = defaults.string(forKey: "USERID")
        }
        if ((self.defaults.string(forKey: "PASSW")?.isEmpty) != nil)
        {
            self.passw = defaults.string(forKey: "PASSW")
        }
        if ((self.defaults.string(forKey: "PIN")?.isEmpty) != nil)
        {
            self.pin = defaults.string(forKey: "PIN")
        }
        print("user idddd",self.userId!)
        let params:Parameters = ["id_no":self.userId!]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let count:Int = myresult!["count"].int!
                print("count",count)
                if(count >= 9)
                {
                    self.loginBtnTapped = false
                    self.lockStatus = "LOCK"
                }
                else{
                    self.lockStatus = ""
                }
                print("lock status",self.lockStatus)
                self.getToken()
                break
            case .failure:
                break
                
            }
        })
    }
    func getToken() {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        print("getToken url  \(url)")
        print("getToken headers  \(headers)")
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token1  ",self.userId)
                print("token2  ",self.passw)
                print("token3  ",self.pin)
                print("token4  ",token)
                
                self.callLogin(access_token: token)
                break
            case .failure:
                break
            }
        })
    }
    func callLogin(access_token:String) {
        print("address",self.addressString)
        print("lat",self.str1)
        print("lon",self.str2)
        self.addressString = self.addressString + "$" + self.str1 + "$" + self.str2
        
        let dateTime:String = getCurrentDateTime()
        
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        
        // checkLocation end
        
        let url = ge_api_url_new + "utilityservice/validatelogin"
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let appVersion = AppInfo.version
        print("appVersion",appVersion)
        
        
        
        
        
        
        //       //ind device
        //        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":userID,"source":"MOBILE","password":password,"mpin":pin,"loginGEOLocation": self.addressString + "$Port:"+" "+"$IMEI:" + self.udid ,"loginCountry":"Qatar","loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus,"loginDeviceType":"IOS","loginVersionName":appVersion]
        
        
        let password = "GULFEXCHANGE"
        let hashedPassword = md5(password)
        print("MD5 Hashed Password: \(hashedPassword)")
        
        
        if let text = idNumTextField.text, text.isEmpty && (passwTextField.text != nil), text.isEmpty
        {
            
            print("pin pass id text empty","")
            // myTextField is not empty here
        } else {
            // myTextField is Empty
            print("pin pass id text not empty","")
            UserDefaults.standard.removeObject(forKey: "biometricenabled")
        }
        
        
        
        
        
        if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
        {
            loginBtnTapped = false
            self.userId = defaults.string(forKey: "USERID")!
            self.passw = defaults.string(forKey: "PASSW")!
            self.pin = defaults.string(forKey: "PIN")!
            
        }
        
        else
        {
            self.userId = idNumTextField.text!
            self.passw = passwTextField.text!
            self.pin = ""
            
            
        }
        
        
        
         /* -
        //MARK: checkLocation
        // change in live
        if userId == "29278801221" /*|| userId == "12345678913"*/
        {
            self.str_country = "Qatar"
            
           
            
        }
        
        else
        {
            if  str_country == "Qatar" || str_country == "قطر" || str_country == "دولة قطر" || str_country == "क़तर"
            {
                print("loniii","")
                self.str_country = "Qatar"
                
            }
            else
            {
                
                //str_country == ""
                if checkLoginSecond == 0{
                    //                     self.view.makeToast("Fetching Location Data", duration: 3.0, position: .top)
                    checkLoginSecond = 1
                    if CLLocationManager.locationServicesEnabled() {
                        locationManager.delegate = self
                        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                        locationManager.startUpdatingLocation()
                    }
                    //                     return
                }else{
                    print("logincountrystr_country",str_country)
                    print("loniiinoooo","")
                    checkLoginSecond = 0
                    loginLocationCount += 1
                    if loginLocationCount > 1{
                        self.alertMessage(
                            title: NSLocalizedString("gulf_exchange", comment: ""),
                            msg: NSLocalizedString("qatar_login_only", comment: ""),
                            action: NSLocalizedString("ok", comment: ""),
                            completion: {
                                self.alertMessage(
                                    title: NSLocalizedString("gulf_exchange", comment: ""),
                                    msg: NSLocalizedString("If you're experiencing login issues, please close and reopen the app and try again.", comment: ""),
                                    action: NSLocalizedString("ok", comment: "")
                                )
                            }
                        )
                    }else{
                        
                    }
                    
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("qatar_login_only", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    
                    
                    //                      return
                }
                self.effectView.removeFromSuperview()
                return
            }
            
           
        }
        
         */
        
        
         //MARK: production params
//        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":self.userId,"source":"MOBILE","password":self.passw,"mpin":self.pin,"loginGEOLocation": self.addressString/* + "$Port:"+" "+"$IMEI:" + self.udid*/ ,"loginCountry":str_country,"loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus,"loginDeviceType":"IOS","loginVersionName":appVersion,"loginSessionID": self.udid]
       
        
        //MARK: uat params
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":self.userId,"source":"MOBILE","password":self.passw,"mpin":self.pin,"loginGEOLocation": self.addressString/* + "$Port:"+" "+"$IMEI:" + self.udid*/ ,"loginCountry":"Qatar","loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus,"loginDeviceType":"IOS","loginVersionName":appVersion,"loginSessionID": self.udid]
        
        print("loginurl",url)
        print("logininput",params)
        print("TOKEWN",access_token)
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        print("login inputs  ",params)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            print("respLogin",response)
            print("responseCoderesponseCoderesponseCode",responseCode)
            self.effectView.removeFromSuperview()
            
            //            let respcode = myResult!["responseCode"].stringValue
            //            let respMsg = myResult!["responseMessage"].stringValue
            //            self.alertMessage(title: respcode, msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            
            //
            //            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            
            if(responseCode == "S103")
            {
                let customerRegNo = myResult!["customerRegNo"]
                print("login reg1",customerRegNo.string!)
                self.defaults.set(customerRegNo.string!, forKey: "REGNO")
                self.defaults.set(self.userId, forKey: "USERID")
                self.defaults.set(self.passw, forKey: "PASSW")
                self.defaults.set(self.pin, forKey: "PIN")
                self.idNumTextField.text?.removeAll()
                self.passwTextField.text?.removeAll()
                if self.loginBtnTapped{
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainPinLoginVC") as! MainPinLoginVC
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                }else{
                    
                    UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                    UserDefaults.standard.set(true, forKey: "isLoggedIN")
                    
                    isLoggedIN = .yes
                    let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                    NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                    //                                    self?.navigationController?.popViewController(animated: true)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    //                    self.saveLoginHistory(responseCode: responseCode.string!)
                    
                }
                
            }
            else if (responseCode == "S104")
            {
                
                let customerRegNo = myResult!["customerRegNo"]
                print("login reg1",customerRegNo.string!)
                self.defaults.set(customerRegNo.string!, forKey: "REGNO")
                self.defaults.set(self.userId, forKey: "USERID")
                self.defaults.set(self.passw, forKey: "PASSW")
                self.defaults.set(self.pin, forKey: "PIN")
                self.idNumTextField.text?.removeAll()
                self.passwTextField.text?.removeAll()
                if self.loginBtnTapped{
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainPinLoginVC") as! MainPinLoginVC
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                }else{
                    
                    let msg = myResult!["responseMessage"]
                    let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: msg.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
                        APIManager.shared.fetchToken { token in
                            if let token = token {
                                // Call login session update
                                APIManager.shared.updateSession(sessionType: "0", accessToken: token) { responseCode in
                                    if responseCode == "S111"{
                                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                        UserDefaults.standard.set(true, forKey: "isLoggedIN")
                                        
                                        isLoggedIN = .yes
                                        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                                        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                                        //                                    self?.navigationController?.popViewController(animated: true)
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                                        self.navigationController?.pushViewController(nextViewController, animated: true)
                                        //                    self.saveLoginHistory(responseCode: responseCode.string!)
                                    }
                                    else {
                                        //                                    self.handleSessionError()
                                    }
                                }
                            } else {
                                print("Failed to fetch token")
                            }
                        }
                    }))
                    alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
                        print("No....")
                    }))
                    self.present(alert, animated: true)
                    // self.saveLoginHistory(responseCode: responseCode.string!)
                    
                    
                    
                    
                }
                
                
            }
            /*
             else if(responseCode == "E0000")
             {
             self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("wrong_login_info", comment: ""), action: NSLocalizedString("ok", comment: ""))
             //                self.saveLoginHistory(responseCode: responseCode.string!)
             }
             else if(responseCode == "E1003")
             {
             self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("wrong_login_info", comment: ""), action: NSLocalizedString("ok", comment: ""))
             //                self.saveLoginHistory(responseCode: responseCode.string!)
             }
             else if(responseCode == "E2222")
             {
             self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("wrong_login_info", comment: ""), action: NSLocalizedString("ok", comment: ""))
             //                self.saveLoginHistory(responseCode: responseCode.string!)
             }
             else if(responseCode == "E6666")
             {
             self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("multiple_login", comment: ""), action: NSLocalizedString("ok", comment: ""))
             }
             */
            else if(responseCode == "E5555")
            {
                // send mail
                // acc lock
                
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                //                self.saveLoginHistory(responseCode: responseCode.string!)
            }
            else if(responseCode == "E9999")
            {
                
                self.getNewVersionalertList()
            }
            
            
            else
            {
                
                
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                
                //                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("wrong_login_info", comment: ""), action: NSLocalizedString("ok", comment: ""))
                //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("wrong_login_info", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
        })
    }
    func saveLoginHistory(responseCode:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        print("udid111",self.udid!)
        print("userid111",self.userId!)
        
        let modelName = UIDevice.modelName
        print("model name111",modelName)
        print("latt111",self.str1)
        print("lon111",self.str2)
        print("response code",responseCode)
        let url = api_url + "login_history_listing"
        
        let params:Parameters = ["id_no":self.userId!,"mobile_no":"","email":"","imei_no":self.udid!,"device_id":self.udid!,"device_name":modelName,"device_type":"IOS","lattitude":self.str1,"longitude":self.str2,"response_code":responseCode]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let code = myResult!["code"]
                if(code == "1")
                {
                    
                    
                    
                    self.validateMultipleLogin()
                }
                else if(code == "2"){
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("wrong_login_info", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else if(code == "3"){
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("try_after_ten", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else if(code == "4"){
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("permanent_lock", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                
                break
            case .failure:
                break
            }
        })
    }
    func validateMultipleLogin() {
        
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = api_url + "login_session"
        let params:Parameters = ["id_no":self.userId!,"session_id":self.udid!]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let code = myresult!["scode"]
                
                if(code == 1)
                {
                    // self.timer.invalidate()
                    /*
                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeViewController
                     self.present(nextViewController, animated:true, completion:nil)
                     */
                    
                    //checkuserdefaultil store cheytu veka
                    //popup bocx alerrt yes no yes click 1 no 2
                    //popbox
                    
                    
                    //
                    //                    if ((self.defaults.string(forKey: "logoutbiometrc")?.isEmpty) != nil)
                    //                    {
                    //
                    //                    }
                    // else
                    //{
                    
                    if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
                    {
                        
                        
                    }
                    
                    else
                    {
                        let msg = "Do you want to enable Biometric authentication in this application "
                        let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: NSLocalizedString("doyouenablebiometric", comment: ""), preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
                            
                            
                            
                            self.defaults.set("biometricenabled", forKey: "biometricenabled")
                            
                            
                            print("typed","typedbtn")
                            //biometric
                            let context = LAContext()
                            var error:NSError? = nil
                            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error)
                            {
                                let reason = "Please Autherise With Touch Id"
                                //context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason), reply: weak<#T##(Bool, Error?) -> Void#>)
                                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                                    [weak self] success, error in
                                    DispatchQueue.main.async { [self] in
                                        guard success, error == nil else{
                                            
                                            
                                            //                                    let ac = UIAlertController(title: "Failed To Authentication", message: "Please Try Again!", preferredStyle: .alert)
                                            //                                                       ac.addAction(UIAlertAction(title: "OK", style: .default))
                                            //                                    self!.present(ac, animated: true)
                                            
                                            return
                                            
                                        }
                                        //                     let vc = LoginViewController()
                                        //                        vc.title = "Welcome"
                                        //                        vc.view.backgroundColor = .systemBlue
                                        //                        self?.present(UINavigationController(rootViewController: vc),animated: true,completion: nil)
                                        
                                        // self!.getLoginFailedCount()
                                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                        UserDefaults.standard.set(true, forKey: "isLoggedIN")
                                        
                                        isLoggedIN = .yes
                                        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                                        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                                        //                                    self?.navigationController?.popViewController(animated: true)
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                                        self?.navigationController?.pushViewController(nextViewController, animated: true)
                                        
                                        /*self!.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                         UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                         let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                                         self?.navigationController?.pushViewController(vc, animated: true)*/
                                        
                                        
                                        
                                    }
                                }
                            }
                            else
                            {
                                let ac = UIAlertController(title: "Unavailable", message: "You Cant Use This Feature!", preferredStyle: .alert)
                                ac.addAction(UIAlertAction(title: "OK", style: .default))
                                self.present(ac, animated: true)
                                
                            }
                            
                            
                            
                            
                            UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                            UserDefaults.standard.set(true, forKey: "isLoggedIN")
                            isLoggedIN = .yes
                            let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                            NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                            //                      self?.navigationController?.popViewController(animated: true)
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            /*
                             self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                             UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                             let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                             self.navigationController?.pushViewController(vc, animated: true)
                             */
                            
                        }))
                        alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
                            print("No....")
                            
                            self.defaults.set("biometricdisabled", forKey: "biometricdisabled")
                            //self.defaults.set("", forKey: "biometricenabled")
                            UserDefaults.standard.removeObject(forKey: "biometricenabled")
                            
                            //                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                            UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                            UserDefaults.standard.set(true, forKey: "isLoggedIN")
                            isLoggedIN = .yes
                            let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                            NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                            //                        self.navigationController?.popViewController(animated: true)
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            /*let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                             self.navigationController?.pushViewController(vc, animated: true)*/
                        }))
                        self.present(alert, animated: true)
                    }
                    
                    
                    
                    //}
                    
                    //                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                    UserDefaults.standard.set(true, forKey: "isLoggedIN")
                    isLoggedIN = .yes
                    let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                    NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    // biometricLogin 1
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    /*self.navigationController?.popViewController(animated: true)
                     let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                     self.navigationController?.pushViewController(vc, animated: true)*/
                    
                    
                    
                }
                else if(code == 2)
                {
                    self.callLogout()
                }
                else if(code == 3)
                {
                    let msg = myresult!["message"]
                    let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: msg.stringValue, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
                        self.loginNewDevice()
                    }))
                    alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
                        print("No....")
                    }))
                    self.present(alert, animated: true)
                }
                break
            case .failure:
                break
                
            }
        })
        
        
    }
    func loginNewDevice() {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = api_url + "login_session_update"
        let params:Parameters = ["id_no":self.userId,"session_id":udid]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let code = myresult!["scode"]
                
                if(code == 1)
                {
                    //self.timer.invalidate()
                    /*
                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeViewController
                     self.present(nextViewController, animated:true, completion:nil)
                     */
                    
                    // newwwwwwww
                    
                    if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
                    {
                        //                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                        UserDefaults.standard.set(true, forKey: "isLoggedIN")
                        isLoggedIN = .yes
                        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        //                        self.navigationController?.popViewController(animated: true)
                        /*
                         let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                         self.navigationController?.pushViewController(vc, animated: true)
                         */
                        
                    }
                    
                    
                    else
                    {
                        //alertadd yesno
                        let msg = "Do you want to enable Biometric authentication in this application "
                        let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: NSLocalizedString("doyouenablebiometric", comment: ""), preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
                            
                            
                            
                            self.defaults.set("biometricenabled", forKey: "biometricenabled")
                            
                            
                            
                            // if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
                            // {
                            
                            print("typed","typedbtn")
                            //biometric
                            let context = LAContext()
                            var error:NSError? = nil
                            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error)
                            {
                                let reason = "Please Autherise With Touch Id"
                                //context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason), reply: weak<#T##(Bool, Error?) -> Void#>)
                                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                                    [weak self] success, error in
                                    DispatchQueue.main.async { [self] in
                                        guard success, error == nil else{
                                            
                                            
                                            //                                        let ac = UIAlertController(title: "Failed To Authentication", message: "Please Try Again!", preferredStyle: .alert)
                                            //                                                           ac.addAction(UIAlertAction(title: "OK", style: .default))
                                            //                                        self!.present(ac, animated: true)
                                            
                                            return
                                            
                                        }
                                        //                     let vc = LoginViewController()
                                        //                        vc.title = "Welcome"
                                        //                        vc.view.backgroundColor = .systemBlue
                                        //                        self?.present(UINavigationController(rootViewController: vc),animated: true,completion: nil)
                                        
                                        // self!.getLoginFailedCount()
                                        
                                        //                                        self!.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                        UserDefaults.standard.set(true, forKey: "isLoggedIN")
                                        isLoggedIN = .yes
                                        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                                        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                                        self?.navigationController?.pushViewController(nextViewController, animated: true)
                                        /*
                                         let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                                         self?.navigationController?.pushViewController(vc, animated: true)
                                         */
                                        
                                        
                                    }
                                }
                            }
                            else
                            {
                                let ac = UIAlertController(title: "Unavailable", message: "You Cant Use This Feature!", preferredStyle: .alert)
                                ac.addAction(UIAlertAction(title: "OK", style: .default))
                                self.present(ac, animated: true)
                                
                            }
                            
                            //Write button action here
                            // }
                            
                            
                            //                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                            UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                            UserDefaults.standard.set(true, forKey: "isLoggedIN")
                            isLoggedIN = .yes
                            let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                            NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            /*
                             let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                             self.navigationController?.pushViewController(vc, animated: true)*/
                            
                            
                        }))
                        alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
                            print("No....")
                            
                            self.defaults.set("biometricdisabled", forKey: "biometricdisabled")
                            UserDefaults.standard.removeObject(forKey: "biometricenabled")
                            
                            //                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                            UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                            UserDefaults.standard.set(true, forKey: "isLoggedIN")
                            isLoggedIN = .yes
                            let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                            NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            //                        self.navigationController?.popViewController(animated: true)
                            /*
                             let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                             self.navigationController?.pushViewController(vc, animated: true)*/
                        }))
                        self.present(alert, animated: true)
                        
                        
                        
                        //                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        
                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                        
                        UserDefaults.standard.set(true, forKey: "isLoggedIN")
                        isLoggedIN = .yes
                        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
        nextViewController.shouldShowPopup = true
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        //                        self.navigationController?.popViewController(animated: true)
                        /*
                         let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                         self.navigationController?.pushViewController(vc, animated: true)*/
                        
                        
                    }
                    
                    // elseclose
                }
                
                
                
                break
            case .failure:
                break
                
            }
        })
    }
    func callLogout() {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = api_url + "login_session_delete"
        let params:Parameters = ["id_no":self.userId!,"session_id":udid!]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let code = myresult!["scode"]
                
                if(code == 1)
                {
                    
                }
                break
            case .failure:
                break
                
            }
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
    func activityIndicator(_ title: String) {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 35))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height+111, width: 160, height: 35)
        
        
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 35)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        print("latotp",lat)
        print("lonotp",lon)
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        //<+37.78583400,-122.40641700> +/- 0.00m (speed -1.00 mps / course -1.00) @ 7/29/20, 8:12:18 PM India Standard Time
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks //as! [CLPlacemark]
            
            if pm?.count ?? 0 > 0 {
                self.locationManager.stopUpdatingLocation()
                let pm = placemarks![0]
                print(pm.country)
                print(pm.locality)
                print(pm.subLocality)
                print(pm.thoroughfare)
                print(pm.postalCode)
                print(pm.subThoroughfare)
                self.addressString.removeAll()
                self.str_country = pm.country!
                if pm.subLocality != nil {
                    self.addressString = self.addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    self.addressString = self.addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    self.addressString = self.addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    self.addressString = self.addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    self.addressString = self.addressString + pm.postalCode! + " "
                }
                
                
                print(self.addressString)
                if self.checkLoginSecond == 1{
                    self.checkLoginSecond = 2
                    self.getToken()
                }
            }
            
        })
        
    }
    
}



extension MainLoginViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == passwTextField)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == idNumTextField)
        {
            let maxLength = 11
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return Bool()
    }
}
extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}
extension String {
    func removeExtraSpaces() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: "", options: .regularExpression, range: nil)
    }
}

/*
 ["loginGEOLocation": "Thuthiyur, Seaport Airport Road, Kochi, India, 682037 Thuthiyur, Seaport Airport Road, Kochi, India, 682037 Thuthiyur, Seaport Airport Road, Kochi, India, 682037 Thuthiyur, Seaport Airport Road, Kochi, India, 682037 $9.99463241980968$76.35179728667008$Port: $IMEI:FE7AC0BF-7F4B-4CA7-84CB-E3AB3E7446D6", "loginDeviceType": "IOS", "userID": Optional("12312312312"), "password": Optional("Abc123$#"), "loginSessionId": Optional("FE7AC0BF-7F4B-4CA7-84CB-E3AB3E7446D6"), "token": "1234567", "requestTime": "2024-12-23 12:47:40", "loginCountry": "Qatar", "lockStatusIn": nil, "loginDevice": "iPhone13,2", "source": "MOBILE", "partnerId": "GULFEXC123", "mpin": Optional("1234"), "ipAddress": "223.228.130.79", "loginVersionName": Optional("1.0")]
 respLogin success({
 customerEmailId = "chelakkan@gmail.com";
 customerMobile = 919496805669;
 customerRegNo = 94657367;
 lockStatusOut = "<null>";
 loginSessionIDOut = "<null>";
 messageDetail = "<null>";
 notificationMessage = "<null>";
 responseCode = S103;
 responseMessage = "User is logged in successfully";
 })
 updateSession params ["customerUserId": "12312312312", "sessionType": "1", "loginSessionId": "FE7AC0BF-7F4B-4CA7-84CB-E3AB3E7446D6", "partnerId": "GULFEXC123", "token": "1234567"]
 success({
 messageDetail = "<null>";
 responseCode = E222;
 responseMessage = "Session Expired.";
 })
 
 login inputs   ["loginDevice": "iPhone13,2", "source": "MOBILE", "loginDeviceType": "IOS", "password": Optional("Abc123$#"), "loginGEOLocation": "Thuthiyur, Seaport Airport Road, Kochi, India, 682037 $9.99463241980968$76.35179728667008$Port: $IMEI:FE7AC0BF-7F4B-4CA7-84CB-E3AB3E7446D6", "requestTime": "2024-12-23 12:56:41", "loginVersionName": Optional("1.0"), "userID": Optional("12312312312"), "loginCountry": "Qatar", "partnerId": "GULFEXC123", "loginSessionId": Optional("FE7AC0BF-7F4B-4CA7-84CB-E3AB3E7446D6"), "lockStatusIn": nil, "mpin": Optional("1234"), "token": "1234567", "ipAddress": "223.228.130.79"]
 respLogin success({
 customerEmailId = "chelakkan@gmail.com";
 customerMobile = 919496805669;
 customerRegNo = 94657367;
 lockStatusOut = "<null>";
 loginSessionIDOut = "<null>";
 messageDetail = "<null>";
 notificationMessage = "<null>";
 responseCode = S103;
 responseMessage = "User is logged in successfully";
 })
 responseCoderesponseCoderesponseCode S103
 updateSession params ["customerUserId": "12312312312", "token": "1234567", "sessionType": "1", "partnerId": "GULFEXC123", "loginSessionId": "FE7AC0BF-7F4B-4CA7-84CB-E3AB3E7446D6"]
 success({
 messageDetail = "<null>";
 responseCode = E222;
 responseMessage = "Session Expired.";
 })
 */
