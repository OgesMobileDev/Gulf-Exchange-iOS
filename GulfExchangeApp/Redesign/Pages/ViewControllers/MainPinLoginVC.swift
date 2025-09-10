//
//  MainPinLoginVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 03/12/2024.
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

class MainPinLoginVC: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var getStartedLbl: UILabel!
    @IBOutlet weak var signInLbl: UILabel!
    @IBOutlet weak var pinLbl: UILabel!
    @IBOutlet weak var forgotPinLbl: UILabel!
    @IBOutlet weak var resetPinBtn: UIButton!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var pinEyeBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var pinEyeImg: UIImageView!
    @IBOutlet weak var resetPinLbl: UILabel!
    @IBOutlet var emptyBts: [UIButton]!
    
    var timer = Timer()
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
    
    //test
       static let AlamoFireManager: Alamofire.Session = {
           let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator(),
                                                         "ws.gulfexchange.com.qa": DisabledEvaluator()])
           let configuration = URLSessionConfiguration.af.default
           return Session(configuration: configuration, serverTrustManager: manager)
       }()
       
       //production
//          static let AlamoFireManager: Alamofire.Session = {
//        //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
//                let configuration = URLSessionConfiguration.af.default
//                return Session(configuration: configuration)
//        //        return Session(configuration: configuration, serverTrustManager: manager)
//            }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavbar()
        setView()
        
        timer.invalidate()
        self.awakeFromNib()
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            pinTextField.textAlignment = .right
            forgotPinLbl.textAlignment = .left
            resetPinBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        } else {
            pinTextField.textAlignment = .left
            forgotPinLbl.textAlignment = .right
            resetPinBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        }
    self.udid = UIDevice.current.identifierForVendor!.uuidString
        self.pinTextField.delegate = self
    self.locationManager.requestWhenInUseAuthorization()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScreenShield.shared.protect(view: self.pinTextField)
        ScreenShield.shared.protect(view: self.getStartedLbl)
        ScreenShield.shared.protect(view: self.signInLbl)
        ScreenShield.shared.protect(view: self.forgotPinLbl)
        ScreenShield.shared.protect(view: self.resetPinLbl)
        ScreenShield.shared.protectFromScreenRecording()
    }
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "neworexistcuststr")
       // timer.invalidate()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        if CLLocationManager.locationServicesEnabled() {
                  locationManager.delegate = self
                  locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                  locationManager.startUpdatingLocation()
                 // getAddressFromLatLon(pdblLatitude: self.lats ?? "", withLongitude: self.longs ?? "")
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
    
    
    @IBAction func resetPinBtnTapped(_ sender: Any) {
        print("resetPinBtnTapped")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.isNavigationBarHidden = false
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main11", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPinPasswordViewController") as! ResetPinPasswordViewController
        nextViewController.currentPage = .pin
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // checking required
    @IBAction func loginBtnTapped(_ sender: Any) {
        print("loginBtnTapped")
         checkLogin()
    }
    @IBAction func pinEyeBtnTapped(_ sender: Any) {
        if pinEyeClick {
            pinTextField.isSecureTextEntry = false
            pinEyeImg.image = UIImage(named: "show pswrd")
        } else {
            pinTextField.isSecureTextEntry = true
            pinEyeImg.image = UIImage(named: "hide pswrd")
        }
        pinEyeClick = !pinEyeClick
    }
    
    //MARK: - Functions
    
    func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
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
        navigationController?.popViewController(animated: true)
    }
    func navigateToLogin(){
        navigationController?.popViewController(animated: true)
    }
    func setView(){
        pinTextField.keyboardType = .numberPad
        pinTextField.isSecureTextEntry = true
        for button in emptyBts{
            button.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        }
        loginBtn.setAttributedTitle(buttonTitleSet(title: "Login", size: 14, font: .semiBold), for: .normal)
        
        signInLbl.text = (NSLocalizedString("Sign in to continue", comment: ""))
            pinTextField.placeholder = (NSLocalizedString("Pin", comment: ""))
        
        
        
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
    
    func md5(_ string: String) -> String {
        let inputData = Data(string.utf8)
        let hashed = Insecure.MD5.hash(data: inputData)
        let hashString = hashed.map { String(format: "%02hhx", $0) }.joined()
        return hashString
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
                    if pinTextField.text?.isEmpty == true
                    {
                       // timer.invalidate()
                        self.pinTextField.layer.borderColor = UIColor.red.cgColor
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                            if #available(iOS 13.0, *) {
                                self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                            } else {
                                // Fallback on earlier versions
                            }

                        }
                    }
                    else
                    {
                    
                        if #available(iOS 13.0, *) {
                            self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                    }

                    
                    guard let pinCode = pinTextField.text,pinTextField.text?.count != 0 else
                    {
                        self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)
                        
                       // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                    }
                    if(pinCode.count != 4)
                    {
                        
                        self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .top)
                        
                        self.pinTextField.layer.borderColor = UIColor.red.cgColor
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                            if #available(iOS 13.0, *) {
                                self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                            } else {
                                // Fallback on earlier versions
                            }

                        }

                        
                        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                    }
                    else
                    {
                        if #available(iOS 13.0, *) {
                            self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                        } else {
                            // Fallback on earlier versions
                        }

                    }
                    
                    var charSetexpIn = CharacterSet.init(charactersIn: "@#$%+_&'()*,/:;<=>?[]^`{|}~)(")
                    var string2pin = pinCode

                        if let strvalue = string2pin.rangeOfCharacter(from: charSetexpIn)
                        {
                            self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .top)
                            
                            self.pinTextField.layer.borderColor = UIColor.red.cgColor
                            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                                if #available(iOS 13.0, *) {
                                    self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                                } else {
                                    // Fallback on earlier versions
                                }

                            }

                            
                            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                            return
                        }
                    else
                    {
                        if #available(iOS 13.0, *) {
                            self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    
                    if (!validate (value: self.pinTextField.text!))
                    {
                        self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .top)
                        
                        self.pinTextField.layer.borderColor = UIColor.red.cgColor
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                            if #available(iOS 13.0, *) {
                                self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                            } else {
                                // Fallback on earlier versions
                            }

                        }

                        
                        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                        
                    }
                    else
                    {
                        if #available(iOS 13.0, *) {
                            self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                        } else {
                            // Fallback on earlier versions
                        }

                    }
                    
                
                    if ((self.defaults.string(forKey: "USERID")?.isEmpty) != nil)
                    {
                        self.userId = defaults.string(forKey: "USERID")
                    }
                    if ((self.defaults.string(forKey: "PASSW")?.isEmpty) != nil)
                    {
                        self.passw = defaults.string(forKey: "PASSW")
                    }
                    self.pin = pinCode
                    if(isConnectedToVpn)
                    {
                        self.view.makeToast(NSLocalizedString("no_vpn_network", comment: ""), duration: 3.0, position: .top)
                        
                        //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("no_vpn_network", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
                
                let storedUserId = UserDefaults.standard.string(forKey: "USERID") ?? ""
                
                //MARK: test -
                if let userId = self.userId, let password = self.passw, let pin = self.pin {
                    self.callLogindirectappstore(userID: userId, password: password, pin: pin, access_token: token)
                }
                 
                /*
                //MARK: production -
                if storedUserId == "29278801221"{
                    print("Stored USERID is 29278801221")
                    
                    if let userId = self.userId, let password = self.passw, let pin = self.pin {
                        self.callLogindirectappstore(userID: userId, password: password, pin: pin, access_token: token)
                    }
                    
                } else {
                    print("Stored USERID is something else: \(storedUserId)")
                    
                    if let userId = self.userId, let password = self.passw, let pin = self.pin {
                        self.callLogin(userID: userId, password: password, pin: pin, access_token: token)
                    }
                }
                */
                break
            case .failure:
                break
            }
        })
    }
    func callLogin(userID:String,password:String,pin:String,access_token:String) {
        print("address",self.addressString)
        print("lat",self.str1)
        print("lon",self.str2)
        print("str_countrynormallogin.....",self.str_country)
        self.addressString = self.addressString + "$" + self.str1 + "$" + self.str2
        
        let dateTime:String = getCurrentDateTime()
        
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        
        if  str_country == "Qatar" || str_country == "قطر" || str_country == "دولة قطر" || str_country == "क़तर"
        {
          print("loniii","")
            self.str_country = "Qatar"
        }
     else
        {
         //str_country == ""
            print("logincountrystr_country",str_country)
          print("loniiinoooo","")
          self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("qatar_login_only", comment: ""), action: NSLocalizedString("ok", comment: ""))
        return
         }

        
        let url = ge_api_url_new + "utilityservice/validatelogin"
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let appVersion = AppInfo.version
              print("appVersion...",appVersion)
        
        
        
//        if let text = idNumTextField.text, text.isEmpty && (passwTextField.text != nil), text.isEmpty && (pinTextField.text != nil), text.isEmpty
//        {
//            
//            print("pin pass id text empty","")
//           // myTextField is not empty here
//        } else {
//           // myTextField is Empty
//            print("pin pass id text not empty","")
//            UserDefaults.standard.removeObject(forKey: "biometricenabled")
//        }
        
        
        
        
          
//        if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
//        {
//            
//            self.userId = defaults.string(forKey: "USERID")!
//            self.passw = defaults.string(forKey: "PASSW")!
//            self.pin = defaults.string(forKey: "PIN")!
//   
//        }
//        
//        else
//        {
//            self.userId = idNumTextField.text!
//            self.passw = passwTextField.text!
//            self.pin = pinTextField.text!
//            
//            
//        }
        
        self.userId = defaults.string(forKey: "USERID")!
        self.passw = defaults.string(forKey: "PASSW")!
        self.pin = pinTextField.text!
        
        
        //ind device
        let params:Parameters =  ["partnerId":partnerId,
                                  "token":token,
                                  "requestTime":dateTime,
                                  "userID":self.userId,
                                  "source":"MOBILE",
                                  "password":self.passw,
                                  "mpin":self.pin,
                                  "loginGEOLocation": self.addressString ,
                                  "loginCountry":self.str_country,
                                  "loginDevice":UIDevice.modelName,
                                  "ipAddress":"223.228.130.79",
                                  "lockStatusIn":self.lockStatus,
                                  "loginDeviceType":"IOS",
                                  "loginVersionName":appVersion,
                                  "loginSessionID":self.udid!,
                                  "imeino":self.udid!]
//
        
        //original biometric
//        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":userId,"source":"MOBILE","password":self.passw,"mpin":self.pin,"loginGEOLocation": self.addressString ,"loginCountry":str_country,"loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus,"loginDeviceType":"IOS","loginVersionName":appVersion,"loginSessionID":self.udid!,"imeino":self.udid!]

        
//    let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":userID,"source":"MOBILE","password":password,"mpin":pin,"loginGEOLocation": "INDIA" ,"loginCountry":"INDIA","loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus]
        
         print("loginurl",url)
        print("logininput",params)
        print("TOKEWN",access_token)
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
         print("login inputs  ",params)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
        
       // LoginViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
           // let myResult = try? JSON(data: response.data!)
            //let responseCode = myResult!["responseCode"]
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
                
                    print("Session Valid")
                    let customerRegNo = myResult!["customerRegNo"]
                    print("login reg1",customerRegNo.string!)
                    self.defaults.set(customerRegNo.string!, forKey: "REGNO")
                    self.defaults.set(self.userId, forKey: "USERID")
                    self.defaults.set(self.passw, forKey: "PASSW")
                    self.defaults.set(self.pin, forKey: "PIN")
                    
                    
                    let customerMobNo = myResult!["customerMobile"].stringValue
                    print("login customerMobNo1",customerMobNo)
                    
                    let customerEmailId  = myResult!["customerEmailId"].stringValue
                    print("login customerEmailId1",customerEmailId)
                    
                    
                    self.defaults.set(customerEmailId, forKey: "emaill")
                    self.defaults.set(customerMobNo, forKey: "mobilee")
                    
                    if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
                    {
                        
                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                        UserDefaults.standard.set(true, forKey: "isLoggedIN")
                        
                        isLoggedIN = .yes
                        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                //                                    self?.navigationController?.popViewController(animated: true)
                        
                        NotificationCenter.default.post(name: NSNotification.Name("ShowLoginPopup"), object: nil)
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
                            nextViewController.shouldShowPopup = true
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        
                        
                //                    if(self.isConnectedToVpn)
                //                    {
                //                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("no_vpn_network", comment: ""), action: NSLocalizedString("ok", comment: ""))
                //                        return
                //                    }

                //                    self.sendmailbiometric()
                        
                //                UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                //                let vc: HomeAEViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeAEViewController") as! HomeAEViewController
                //                self.navigationController?.pushViewController(vc, animated: true)

                        
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
                                        NotificationCenter.default.post(name: NSNotification.Name("ShowLoginPopup"), object: nil)
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
                            NotificationCenter.default.post(name: NSNotification.Name("ShowLoginPopup"), object: nil)
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
                            nextViewController.shouldShowPopup = true
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            /*let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                            self.navigationController?.pushViewController(vc, animated: true)*/
                        }))
                        self.present(alert, animated: true)
                    
                    //for otp direcxtbiometric
                //            self.sendOTP(msg: "")
                        
                //                    /UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                //                    UserDefaults.standard.set(true, forKey: "isLoggedIN")
                //
                //                    isLoggedIN = .yes
                //                    let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                //                    NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                ////                                    self?.navigationController?.popViewController(animated: true)
                //                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                //                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
//                            nextViewController.shouldShowPopup = true
//                            nextViewController.shouldShowPopup = true
                //                    self.navigationController?.pushViewController(nextViewController, animated: true)/

                        
                    }
                    
                    
                    

                
               
            }
            else if(responseCode == "S104")
            {
                
                let msg = myResult!["responseMessage"]
                let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: msg.stringValue, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
                   // self.loginNewDevice()
                    
                    APIManager.shared.fetchToken { token in
                        if let token = token {
                            // Call login session update
                            APIManager.shared.updateSession(sessionType: "0", accessToken: token) { responseCode in
                                if responseCode == "S111" {
                                    print("Session Valid")
                                    let customerRegNo = myResult!["customerRegNo"]
                                    print("login reg1",customerRegNo.string!)
                                    self.defaults.set(customerRegNo.string!, forKey: "REGNO")
                                    self.defaults.set(self.userId, forKey: "USERID")
                                    self.defaults.set(self.passw, forKey: "PASSW")
                                    self.defaults.set(self.pin, forKey: "PIN")
                                    
                                    
                                    let customerMobNo = myResult!["customerMobile"].stringValue
                                    print("login customerMobNo1",customerMobNo)
                                    
                                    let customerEmailId  = myResult!["customerEmailId"].stringValue
                                    print("login customerEmailId1",customerEmailId)
                                    
                                    
                                    self.defaults.set(customerEmailId, forKey: "emaill")
                                    self.defaults.set(customerMobNo, forKey: "mobilee")
                                    if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
                                    {
                                        
                                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                        UserDefaults.standard.set(true, forKey: "isLoggedIN")
                                        
                                        isLoggedIN = .yes
                                        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                                        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                                //                                    self?.navigationController?.popViewController(animated: true)
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
//                            nextViewController.shouldShowPopup = true
                            nextViewController.shouldShowPopup = true
                                        self.navigationController?.pushViewController(nextViewController, animated: true)

                                        
                                //                    if(self.isConnectedToVpn)
                                //                    {
                                //                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("no_vpn_network", comment: ""), action: NSLocalizedString("ok", comment: ""))
                                //                        return
                                //                    }

                                //                    self.sendmailbiometric()
                                        
                                //                UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                //                let vc: HomeAEViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeAEViewController") as! HomeAEViewController
                                //                self.navigationController?.pushViewController(vc, animated: true)

                                        
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
//                            nextViewController.shouldShowPopup = true
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
                                    
                                    //for otp direcxtbiometric
                                //            self.sendOTP(msg: "")
                                        
                                //                    /UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                //                    UserDefaults.standard.set(true, forKey: "isLoggedIN")
                                //
                                //                    isLoggedIN = .yes
                                //                    let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                                //                    NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                                ////                                    self?.navigationController?.popViewController(animated: true)
                                //                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                                //                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
//                            nextViewController.shouldShowPopup = true
                                //                    self.navigationController?.pushViewController(nextViewController, animated: true)/

                                        
                                    }
                                } else {
//                                    self.handleSessionError()
                                }
                            }
                        } else {
                            print("Failed to fetch token")
                        }
                    }
                   

                    
//                    self.getTokennewae(num: 1)
                }))
                alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
                    print("No....")
                }))
                self.present(alert, animated: true)
               // self.saveLoginHistory(responseCode: responseCode.string!)
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
    
    
    //direct login appstore
    func callLogindirectappstore(userID:String,password:String,pin:String,access_token:String) {
        print("address",self.addressString)
        print("lat",self.str1)
        print("lon",self.str2)
        print("str_countrynormallogin.....",self.str_country)
        self.addressString = self.addressString + "$" + self.str1 + "$" + self.str2
        
        let dateTime:String = getCurrentDateTime()
        
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        
//        if  str_country == "Qatar" || str_country == "قطر" || str_country == "دولة قطر" || str_country == "क़तर"
//        {
//          print("loniii","")
//            self.str_country = "Qatar"
//        }
//     else
//        {
//         //str_country == ""
//            print("logincountrystr_country",str_country)
//          print("loniiinoooo","")
//          self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("qatar_login_only", comment: ""), action: NSLocalizedString("ok", comment: ""))
//        return
//         }

        
        let url = ge_api_url_new + "utilityservice/validatelogin"
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let appVersion = AppInfo.version
              print("appVersion...appstoredirct",appVersion)
        
        
        
//        if let text = idNumTextField.text, text.isEmpty && (passwTextField.text != nil), text.isEmpty && (pinTextField.text != nil), text.isEmpty
//        {
//
//            print("pin pass id text empty","")
//           // myTextField is not empty here
//        } else {
//           // myTextField is Empty
//            print("pin pass id text not empty","")
//            UserDefaults.standard.removeObject(forKey: "biometricenabled")
//        }
        
        
        
        
          
//        if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
//        {
//
//            self.userId = defaults.string(forKey: "USERID")!
//            self.passw = defaults.string(forKey: "PASSW")!
//            self.pin = defaults.string(forKey: "PIN")!
//
//        }
//
//        else
//        {
//            self.userId = idNumTextField.text!
//            self.passw = passwTextField.text!
//            self.pin = pinTextField.text!
//
//
//        }
        
        self.userId = defaults.string(forKey: "USERID")!
        self.passw = defaults.string(forKey: "PASSW")!
        self.pin = pinTextField.text!
        
        
        //ind device
        let params:Parameters =  ["partnerId":partnerId,
                                  "token":token,
                                  "requestTime":dateTime,
                                  "userID":self.userId,
                                  "source":"MOBILE",
                                  "password":self.passw,
                                  "mpin":self.pin,
                                  "loginGEOLocation": self.addressString ,
                                  "loginCountry":"Qatar",
                                  "loginDevice":UIDevice.modelName,
                                  "ipAddress":"223.228.130.79",
                                  "lockStatusIn":self.lockStatus,
                                  "loginDeviceType":"IOS",
                                  "loginVersionName":appVersion,
                                  "loginSessionID":self.udid!,
                                  "imeino":self.udid!]
//
        
        //original biometric
//        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":userId,"source":"MOBILE","password":self.passw,"mpin":self.pin,"loginGEOLocation": self.addressString ,"loginCountry":str_country,"loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus,"loginDeviceType":"IOS","loginVersionName":appVersion,"loginSessionID":self.udid!,"imeino":self.udid!]

        
//    let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":userID,"source":"MOBILE","password":password,"mpin":pin,"loginGEOLocation": "INDIA" ,"loginCountry":"INDIA","loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus]
        
         print("loginurl",url)
        print("logininput",params)
        print("TOKEWN",access_token)
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
         print("login inputs  ",params)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
        
       // LoginViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
           // let myResult = try? JSON(data: response.data!)
            //let responseCode = myResult!["responseCode"]
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
                
                    print("Session Valid")
                    let customerRegNo = myResult!["customerRegNo"]
                    print("login reg1",customerRegNo.string!)
                    self.defaults.set(customerRegNo.string!, forKey: "REGNO")
                    self.defaults.set(self.userId, forKey: "USERID")
                    self.defaults.set(self.passw, forKey: "PASSW")
                    self.defaults.set(self.pin, forKey: "PIN")
                    
                    
                    let customerMobNo = myResult!["customerMobile"].stringValue
                    print("login customerMobNo1",customerMobNo)
                    
                    let customerEmailId  = myResult!["customerEmailId"].stringValue
                    print("login customerEmailId1",customerEmailId)
                    
                    
                    self.defaults.set(customerEmailId, forKey: "emaill")
                    self.defaults.set(customerMobNo, forKey: "mobilee")
                    
                    if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
                    {
                        
                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                        UserDefaults.standard.set(true, forKey: "isLoggedIN")
                        
                        isLoggedIN = .yes
                        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                //                                    self?.navigationController?.popViewController(animated: true)
                        
                        NotificationCenter.default.post(name: NSNotification.Name("ShowLoginPopup"), object: nil)
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
                            nextViewController.shouldShowPopup = true
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        
                        
                //                    if(self.isConnectedToVpn)
                //                    {
                //                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("no_vpn_network", comment: ""), action: NSLocalizedString("ok", comment: ""))
                //                        return
                //                    }

                //                    self.sendmailbiometric()
                        
                //                UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                //                let vc: HomeAEViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeAEViewController") as! HomeAEViewController
                //                self.navigationController?.pushViewController(vc, animated: true)

                        
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
                                        NotificationCenter.default.post(name: NSNotification.Name("ShowLoginPopup"), object: nil)
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
                            NotificationCenter.default.post(name: NSNotification.Name("ShowLoginPopup"), object: nil)
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
                            nextViewController.shouldShowPopup = true
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            /*let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                            self.navigationController?.pushViewController(vc, animated: true)*/
                        }))
                        self.present(alert, animated: true)
                    
                    //for otp direcxtbiometric
                //            self.sendOTP(msg: "")
                        
                //                    /UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                //                    UserDefaults.standard.set(true, forKey: "isLoggedIN")
                //
                //                    isLoggedIN = .yes
                //                    let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                //                    NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                ////                                    self?.navigationController?.popViewController(animated: true)
                //                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                //                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
//                            nextViewController.shouldShowPopup = true
//                            nextViewController.shouldShowPopup = true
                //                    self.navigationController?.pushViewController(nextViewController, animated: true)/

                        
                    }
                    
                    
                    

                
               
            }
            else if(responseCode == "S104")
            {
                
                let msg = myResult!["responseMessage"]
                let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: msg.stringValue, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
                   // self.loginNewDevice()
                    
                    APIManager.shared.fetchToken { token in
                        if let token = token {
                            // Call login session update
                            APIManager.shared.updateSession(sessionType: "0", accessToken: token) { responseCode in
                                if responseCode == "S111" {
                                    print("Session Valid")
                                    let customerRegNo = myResult!["customerRegNo"]
                                    print("login reg1",customerRegNo.string!)
                                    self.defaults.set(customerRegNo.string!, forKey: "REGNO")
                                    self.defaults.set(self.userId, forKey: "USERID")
                                    self.defaults.set(self.passw, forKey: "PASSW")
                                    self.defaults.set(self.pin, forKey: "PIN")
                                    
                                    
                                    let customerMobNo = myResult!["customerMobile"].stringValue
                                    print("login customerMobNo1",customerMobNo)
                                    
                                    let customerEmailId  = myResult!["customerEmailId"].stringValue
                                    print("login customerEmailId1",customerEmailId)
                                    
                                    
                                    self.defaults.set(customerEmailId, forKey: "emaill")
                                    self.defaults.set(customerMobNo, forKey: "mobilee")
                                    if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
                                    {
                                        
                                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                        UserDefaults.standard.set(true, forKey: "isLoggedIN")
                                        
                                        isLoggedIN = .yes
                                        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                                        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                                //                                    self?.navigationController?.popViewController(animated: true)
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
//                            nextViewController.shouldShowPopup = true
                            nextViewController.shouldShowPopup = true
                                        self.navigationController?.pushViewController(nextViewController, animated: true)

                                        
                                //                    if(self.isConnectedToVpn)
                                //                    {
                                //                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("no_vpn_network", comment: ""), action: NSLocalizedString("ok", comment: ""))
                                //                        return
                                //                    }

                                //                    self.sendmailbiometric()
                                        
                                //                UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                //                let vc: HomeAEViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeAEViewController") as! HomeAEViewController
                                //                self.navigationController?.pushViewController(vc, animated: true)

                                        
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
//                            nextViewController.shouldShowPopup = true
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
                                    
                                    //for otp direcxtbiometric
                                //            self.sendOTP(msg: "")
                                        
                                //                    /UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                //                    UserDefaults.standard.set(true, forKey: "isLoggedIN")
                                //
                                //                    isLoggedIN = .yes
                                //                    let data = ["isLoggedIN": isLoggedIN] as [String : Any]
                                //                    NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
                                ////                                    self?.navigationController?.popViewController(animated: true)
                                //                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                                //                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
//                            nextViewController.shouldShowPopup = true
                                //                    self.navigationController?.pushViewController(nextViewController, animated: true)/

                                        
                                    }
                                } else {
//                                    self.handleSessionError()
                                }
                            }
                        } else {
                            print("Failed to fetch token")
                        }
                    }
                   

                    
//                    self.getTokennewae(num: 1)
                }))
                alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
                    print("No....")
                }))
                self.present(alert, animated: true)
               // self.saveLoginHistory(responseCode: responseCode.string!)
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
    
    
    
    
//    func sendmailbiometric() {
//        self.activityIndicator(NSLocalizedString("loading", comment: ""))
//        
//        let udid = UIDevice.current.identifierForVendor!.uuidString
//        let url = api_url + "biometric_notification"
//       // let params:Parameters = ["id_no":self.str_id_no,"mobile_no":self.strMobile,"email":"","otp_no":otp,"imei_no":udid,"type":"1"]
//        
////        if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
////        {
////            
////            self.userId = defaults.string(forKey: "USERID")!
////        }
////        else
////        {
////            self.userId = idNumTextField.text!
////        }
//        
//        self.userId = defaults.string(forKey: "USERID")!
//        
//        let params:Parameters = ["id_no":userId,"mobile_no":defaults.string(forKey: "mobilee"),"email":defaults.string(forKey: "emaill"),"type":"10","device":"iOS"]
//        
//        print("urlverifyotpbadd",url)
//        print("inputverifyotpbadd",params)
//        
//        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//            self.effectView.removeFromSuperview()
//            print("resp",response)
//            let myResult = try? JSON(data: response.data!)
//            let respCode = myResult!["code"]
//            if(respCode == "1")
//            {
//                // self.getToken(num: 2)
//                print("qidapifrecallapicalling","apicallinggg")
//               // self.getTokenGECOQID(num: 2)
//                
//                
//                
//                //new
//                UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
//                UserDefaults.standard.set(true, forKey: "isLoggedIN")
//                
//                isLoggedIN = .yes
//                let data = ["isLoggedIN": isLoggedIN] as [String : Any]
//                NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
////                                    self?.navigationController?.popViewController(animated: true)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
//                            nextViewController.shouldShowPopup = true
//                self.navigationController?.pushViewController(nextViewController, animated: true)
//
//
//                
//                //homevc
////                UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
////                let vc: HomeAEViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeAEViewController") as! HomeAEViewController
////                self.navigationController?.pushViewController(vc, animated: true)
//                
//            }
//            else
//            {
//                UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
//                UserDefaults.standard.set(true, forKey: "isLoggedIN")
//                
//                isLoggedIN = .yes
//                let data = ["isLoggedIN": isLoggedIN] as [String : Any]
//                NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
////                                    self?.navigationController?.popViewController(animated: true)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
//                            nextViewController.shouldShowPopup = true
//                self.navigationController?.pushViewController(nextViewController, animated: true)
////                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("invalid_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            }
//        })
//    }

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
    func alertMessageRedirect(title: String, msg: String, action: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { _ in
            completion?() // Execute the completion handler if provided
        }))
        self.present(alert, animated: true)
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
                    self.alertMessageRedirect(
                        title: NSLocalizedString("gulf_exchange", comment: ""),
                        msg: NSLocalizedString("wrong_login_info", comment: ""),
                        action: NSLocalizedString("ok", comment: ""),
                        completion: {
                            self.navigateToLogin()
                        }
                    )

                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("wrong_login_info", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else if(code == "3"){
                    self.alertMessageRedirect(
                        title: NSLocalizedString("gulf_exchange", comment: ""),
                        msg: NSLocalizedString("try_after_ten", comment: ""),
                        action: NSLocalizedString("ok", comment: ""),
                        completion: {
                            self.navigateToLogin()
                        }
                    )

                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("try_after_ten", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else if(code == "4"){
                    self.alertMessageRedirect(
                        title: NSLocalizedString("gulf_exchange", comment: ""),
                        msg: NSLocalizedString("permanent_lock", comment: ""),
                        action: NSLocalizedString("ok", comment: ""),
                        completion: {
                            self.navigateToLogin()
                        }
                    )

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
    func getNewVersionalertList() {
       var notificMessageList1: [String] = []
       let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
             let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               self.activityIndicator(NSLocalizedString("loading", comment: ""))
               let url = api_url + "application_update_notification"
        let params:Parameters = ["lang": appLang,"device_type":"IOS"]
        print("paramsappupdateurl",params)
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
              }
        })

    }

}
extension MainPinLoginVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == pinTextField)
        {
            let maxLength = 4
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return Bool()
    }
}



