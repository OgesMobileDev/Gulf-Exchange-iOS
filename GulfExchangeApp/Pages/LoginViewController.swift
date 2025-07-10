//
//  LoginViewController.swift
//  GulfExchangeApp
//
//  Created by test on 24/07/20.
//  Copyright © 2020 Oges. All rights reserved.
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


class LoginViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var idNumTextField: UITextField!
    @IBOutlet weak var passwTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var forgotPasswBtn: UIButton!
    @IBOutlet weak var forgotPinBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var infotechBtn: UIButton!
    @IBOutlet weak var already_customerLbl: UILabel!
    @IBOutlet weak var forgotPasswLbl: UILabel!
    @IBOutlet weak var forgotPinLbl: UILabel!
    
    @IBOutlet weak var orLbl: UILabel!
    @IBOutlet weak var pleaseRegisterLbl: UILabel!
    @IBOutlet weak var poweredByLbl: UILabel!
    @IBOutlet weak var passwEyeBtn: UIButton!
    @IBOutlet weak var pinEyeBtn: UIButton!
    
    
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
    
    
     //test
        static let AlamoFireManager: Alamofire.Session = {
            let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
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
       // passwTextField.background = UIImage(named: "down_arrow1")
        
        super.viewDidLoad()
        
//        mainView.makeSecure()
        
        timer.invalidate()
        
        //new
        self.idNumTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.idNumTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        self.passwTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        self.pinTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //localize
        self.already_customerLbl.text = (NSLocalizedString("already_customer", comment: ""))
        self.idNumTextField.placeholder = (NSLocalizedString("id_number", comment: ""))
        self.passwTextField.placeholder = (NSLocalizedString("password", comment: ""))
        self.pinTextField.placeholder = (NSLocalizedString("pin", comment: ""))
        self.signInBtn.setTitle(NSLocalizedString("sign_in", comment: ""), for: .normal)
        
        self.forgotPasswLbl.text = (NSLocalizedString("forgot_pwd_click", comment: ""))
        self.forgotPinLbl.text = (NSLocalizedString("forgot_pin_click", comment: ""))
        self.orLbl.text = (NSLocalizedString("or", comment: ""))
        self.pleaseRegisterLbl.text = (NSLocalizedString("pls_register", comment: ""))
        self.registerBtn.setTitle(NSLocalizedString("register", comment: ""), for: .normal)
        self.poweredByLbl.text = (NSLocalizedString("powered_by", comment: ""))

        
        
        
        
        
        
        
        self.awakeFromNib()
        
        //logoutcheck
        
//        if ((self.defaults.string(forKey: "logoutbiometrc")?.isEmpty) != nil)
//        {
//
//        }
        //else
        //{
        
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
                        
                        
//                        let ac = UIAlertController(title: "Failed To Authentication", message: "Please Try Again!", preferredStyle: .alert)
//                                           ac.addAction(UIAlertAction(title: "OK", style: .default))
//                        self!.present(ac, animated: true)

                        return
                    
                    }
//                     let vc = LoginViewController()
//                        vc.title = "Welcome"
//                        vc.view.backgroundColor = .systemBlue
//                        self?.present(UINavigationController(rootViewController: vc),animated: true,completion: nil)
                        
                        self!.getLoginFailedCount()
                        
//                        self!.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
//                        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
//                        self?.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    
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
        }
            
            //logoutcheckend
        
     //   }
        
        
        
        
        
        
        
        
        if #available(iOS 13.0, *) {
           // overrideUserInterfaceStyle = .light
            self.idNumTextField.layer.borderColor = UIColor.lightGray.cgColor
            
            if( self.traitCollection.userInterfaceStyle == .dark ){
                 //is dark
                overrideUserInterfaceStyle = .light
                self.idNumTextField.layer.borderColor = UIColor.lightGray.cgColor
                self.passwTextField.layer.borderColor = UIColor.lightGray.cgColor
                self.pinTextField.layer.borderColor = UIColor.lightGray.cgColor
                
              }else{
                  //is light
                  if #available(iOS 13.0, *) {
                     // overrideUserInterfaceStyle = .light
                      self.idNumTextField.layer.borderColor = UIColor.systemGray4.cgColor
                      self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
                      self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                  }
              }
            
        } else {
            // Fallback on earlier versions
        }
        
        UINavigationBar.appearance().backgroundColor = .white
        //self.idNumTextField.keyboardType = .numberPad
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
             let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
             if appLang == "ar" || appLang == "ur" {
                idNumTextField.textAlignment = .right
                passwTextField.textAlignment = .right
                pinTextField.textAlignment = .right
                forgotPasswLbl.textAlignment = .left
                 forgotPasswBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
                forgotPinLbl.textAlignment = .left
                forgotPinBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
             } else {
                idNumTextField.textAlignment = .left
                passwTextField.textAlignment = .left
                pinTextField.textAlignment = .left
                forgotPasswLbl.textAlignment = .right
                 forgotPasswBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
                forgotPinLbl.textAlignment = .right
                forgotPinBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
             }
        // Do any additional setup after loading the view.
        signInBtn.backgroundColor = UIColor(red: 0.00, green: 0.52, blue: 0.26, alpha: 1.00)
        registerBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        signInBtn.layer.cornerRadius = 15
        registerBtn.layer.cornerRadius = 15
        pinTextField.delegate = self
        idNumTextField.delegate = self
        passwTextField.delegate = self
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        setFont()
        setFontSize()
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        
        self.locationManager.requestWhenInUseAuthorization()
//        var currentLoc: CLLocation!
//        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//        CLLocationManager.authorizationStatus() == .authorizedAlways) {
//           currentLoc = locationManager.location
//           print("latyyy : ",currentLoc.coordinate.latitude)
//           print("lonyyy : ",currentLoc.coordinate.longitude)
//
//            let str1 = String(currentLoc.coordinate.latitude)
//            let str2 = String(currentLoc.coordinate.longitude)
//
//            //getAddressFromLatLon(pdblLatitude: str1, withLongitude: str2)
////            AlertView.instance.showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "location: lat =" + str1  + " lon = " + str2, action: .success)
//        }
        
//        locationEnableAction()
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           // Protect ScreenShot
//                  ScreenShield.shared.protect(view: self.mainView)
//        ScreenShield.shared.protect(view: self.idNumTextField)
//        ScreenShield.shared.protect(view: self.pinTextField)
//        ScreenShield.shared.protect(view: self.passwTextField)
//                  
                  // Protect Screen-Recording
                  ScreenShield.shared.protectFromScreenRecording()
          
       }

    func md5(_ string: String) -> String {
        let inputData = Data(string.utf8)
        let hashed = Insecure.MD5.hash(data: inputData)
        let hashString = hashed.map { String(format: "%02hhx", $0) }.joined()
        return hashString
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
    @objc func heplVCAction(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
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

//    func locationEnableAction(){
//        self.locationManager.requestAlwaysAuthorization()
//        self.locationManager.requestWhenInUseAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            switch CLLocationManager.authorizationStatus() {
//                case .notDetermined, .restricted, .denied:
//                    print("No access")
//                case .authorizedAlways, .authorizedWhenInUse:
//                    print("Access")
//                    locationManager.delegate = self
//                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//                    locationManager.startUpdatingLocation()
//                  //  getAddressFromLatLon(pdblLatitude: self.str1 ?? "", withLongitude: self.str2 ?? "")
//                @unknown default:
//                break
//
//            }
//            } else {
//                print("Location services are not enabled")
//        }
//    }
    override func viewWillAppear(_ animated: Bool) {
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
        setTitle("", andImage: UIImage(named: "titleImg")!)
    }
    
  override func viewWillDisappear(_ animated: Bool) {
                      locationManager.stopUpdatingLocation()
     
  }
    @IBAction func signInBtn(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.isNavigationBarHidden = true
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomePageVC") as! HomePageViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
       // getNewVersionalertList()
        
       /* if CLLocationManager.locationServicesEnabled() {
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
                        
                       // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_no", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
                        return
                    }
                    
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
                    
                
                    self.userId = id_no
                    self.passw = password
                    self.pin = pinCode
                    if(isConnectedToVpn)
                    {
                        self.view.makeToast(NSLocalizedString("no_vpn_network", comment: ""), duration: 3.0, position: .top)
                        
                        //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("no_vpn_network", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                    }
                        
                        
                        
                        
                    else{
                       getLoginFailedCount()
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
//        }*/
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
    @IBAction func forgotPasswBtn(_ sender: Any) {
        
//        let s:[String] = []
//        let b = s[8]
//       
        
        let string = "350.677"
        let components = string.components(separatedBy: ".")
        let decimalPart = Int(components.last!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
        let double = Double("\(components.first ?? "0").\(decimalPart)")
        print(decimalPart,"double: \(double)")
        
        var str = "3777"
        var len = str.count
        print( "Length of str is \(len)" )
    if len == 2
        {
            print( "itis 2 " )
        }
        
        //working
//        var url:NSURL = NSURL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")!
//
//        var moviePlayer = MPMoviePlayerController(contentURL: url as URL)
//
//        moviePlayer?.view.frame = CGRect(x: 20, y: 100, width: 200, height: 150)
//        moviePlayer!.movieSourceType = MPMovieSourceType.file
//
//        self.view.addSubview((moviePlayer?.view)!)
//        moviePlayer!.prepareToPlay()
//        moviePlayer!.play()
//
  
        
        //////////////
        
//        var moviePlayer: MPMoviePlayerController?
//
//
//
//        let url = NSURL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")
//
//
//
//        moviePlayer = MPMoviePlayerController(contentURL: url as URL?)
//
//            if let player = moviePlayer {
//
//                player.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//                player.view.sizeToFit()
//                player.scalingMode = MPMovieScalingMode.none
//
//
//                player.movieSourceType = MPMovieSourceType.streaming
//                //player.repeatMode = MPMovieRepeatMode.One
//
//
//                player.play()
//
//                self.view.addSubview(player.view)
//
//                NotificationCenter.default.addObserver(
//                    self,
//                    selector: "metadataUpdated",
//                    name: NSNotification.Name.MPMoviePlayerTimedMetadataUpdated,
//                    object: nil)
//
//
//        //
//
//        }
        /////////
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "forgotPassw") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)  ///< Don't for get this BTW!
        var moviePlayer: MPMoviePlayerController?
        if let player = moviePlayer {
            player.stop()
        }
    }
    
    
    @IBAction func forgotPinBtn(_ sender: Any) {
//
//        let currentDate = Date()
//
//        // Hardcoded expiry date (for example)
//        let expiryDateString = "25-07-2024" // Format: "yyyy-MM-dd"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let expiryDate = dateFormatter.date(from: expiryDateString)!
//
//        // Compare dates
//        let calendar = Calendar.current
//        let comparison = calendar.compare(currentDate, to: expiryDate, toGranularity: .day)
//
//        // Check expiry status
//        if comparison == .orderedDescending {
//            print("The expiry date has passed.old")
//        } else if comparison == .orderedAscending {
//            print("The product is still valid.")
//        } else {
//            print("Today is the expiry date.")
//        }
        

//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViedionewViewController") as! ViedionewViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        
//
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "forgotPIN") as! ForgotPINViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func registerBtn(_ sender: Any) {
        
        /*let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "register") as! RegisterViewController
        self.present(nextViewController, animated:true, completion:nil)*/
        
        

        
        let alert = UIAlertController(title: "Register", message: "Are you an existing Gulf Exchange customer?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
            //self.loginNewDevice()
            
            self.neworexistcuststr = "B"
            UserDefaults.standard.removeObject(forKey: "neworexistcuststr")
            UserDefaults.standard.set(self.neworexistcuststr, forKey: "neworexistcuststr")
//            
//            print("neworexistcuststr",UserDefaults.standard.string(forKey: "neworexistcuststr"))
//            let vc: RegisternewenhViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisternewenhViewController") as! RegisternewenhViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            
            
            //originalllll
//            
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "photo1") as! Photo1ViewController
//            self.navigationController?.pushViewController(nextViewController, animated: true)

            
            //originalllllOCR
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: IDverificationRegisterVC = UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "IDverificationRegisterVC") as! IDverificationRegisterVC
            self.navigationController?.pushViewController(vc, animated: true)
            
     
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
            print("No....")
            
            self.neworexistcuststr = "N"
            
            UserDefaults.standard.removeObject(forKey: "neworexistcuststr")
            UserDefaults.standard.set(self.neworexistcuststr, forKey: "neworexistcuststr")
//
//            
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let vc: RegisterViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerr") as! RegisterViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            
            
            //original
            
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "photo1") as! Photo1ViewController
//            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            //originalllllOCR
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: IDverificationRegisterVC = UIStoryboard.init(name: "Main2", bundle: Bundle.main).instantiateViewController(withIdentifier: "IDverificationRegisterVC") as! IDverificationRegisterVC
            self.navigationController?.pushViewController(vc, animated: true)

        }))
        self.present(alert, animated: true)
        
        
 
    }
    @IBAction func infotechBtn(_ sender: Any) {
        guard let url = URL(string: "http://www.smartinfotec.com") else { return }
        UIApplication.shared.open(url)
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
    @IBAction func passwEyeBtn(_ sender: Any) {
        if(passwEyeClick == true) {
            passwTextField.isSecureTextEntry = false
            passwEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            passwTextField.isSecureTextEntry = true
            passwEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        passwEyeClick = !passwEyeClick
    }
    @IBAction func pinEyeBtn(_ sender: Any) {
        if(pinEyeClick == true) {
            pinTextField.isSecureTextEntry = false
            pinEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            pinTextField.isSecureTextEntry = true
            pinEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        pinEyeClick = !pinEyeClick
    }
    
    func setFont(){
        // set Font
        already_customerLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        idNumTextField.font = UIFont(name: "OpenSans-Regular", size: 12)
        pinTextField.font = UIFont(name: "OpenSans-Regular", size: 12)
        passwTextField.font = UIFont(name: "OpenSans-Regular", size: 12)
        signInBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        forgotPasswLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        forgotPasswBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        forgotPinLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        forgotPinBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        orLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        registerBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        idNumTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        passwTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        pinTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        
        
    }
    func setFontSize() {
        
        forgotPasswLbl.font = forgotPasswLbl.font.withSize(14)
        forgotPasswBtn.titleLabel?.font = forgotPasswBtn.titleLabel?.font.withSize(15)
        forgotPinLbl.font = forgotPinLbl.font.withSize(14)
        forgotPinBtn.titleLabel?.font = forgotPinBtn.titleLabel?.font.withSize(15)
        orLbl.font = orLbl.font.withSize(16)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == pinTextField)
        {
            let maxLength = 4
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == passwTextField)
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
       // defaults.string(forKey: "USERID")
       // defaults.string(forKey: "PASSW")
       // defaults.string(forKey: "PIN")
        
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
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        LoginViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
                
                self.callLogin(userID: self.userId!, password: self.passw!, pin: self.pin!, access_token: token)
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
//         return
//         }
        
        
        let url = ge_api_url + "utilityservice/validatelogin"
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
              print("appVersion",appVersion)
        
        
     
       
        
        
//       //ind device
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":userID,"source":"MOBILE","password":password,"mpin":pin,"loginGEOLocation": self.addressString + "$Port:"+" "+"$IMEI:" + self.udid ,"loginCountry":"Qatar","loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus,"loginDeviceType":"IOS","loginVersionName":appVersion]
        
        
        let password = "GULFEXCHANGE"
        let hashedPassword = md5(password)
        print("MD5 Hashed Password: \(hashedPassword)")
        
        
        if let text = idNumTextField.text, text.isEmpty && (passwTextField.text != nil), text.isEmpty && (pinTextField.text != nil), text.isEmpty
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
            
            self.userId = defaults.string(forKey: "USERID")!
            self.passw = defaults.string(forKey: "PASSW")!
            self.pin = defaults.string(forKey: "PIN")!
   
        }
        
        else
        {
            self.userId = idNumTextField.text!
            self.passw = passwTextField.text!
            self.pin = pinTextField.text!
            
            
        }
        //original disbled biometric hided for ind
//        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":self.userId,"source":"MOBILE","password":self.passw,"mpin":self.pin,"loginGEOLocation": self.addressString + "$Port:"+" "+"$IMEI:" + self.udid ,"loginCountry":str_country,"loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus,"loginDeviceType":"IOS","loginVersionName":"1.12"]

        
   // let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":userID,"source":"MOBILE","password":password,"mpin":pin,"loginGEOLocation": "INDIA" ,"loginCountry":"INDIA","loginDevice":UIDevice.modelName,"ipAddress":"223.228.130.79","lockStatusIn":self.lockStatus]
        
         print("loginurl",url)
        print("logininput",params)
        print("TOKEWN",access_token)
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
         print("login inputs  ",params)
        
        LoginViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
                self.saveLoginHistory(responseCode: responseCode.string!)
            }
            else if(responseCode == "E0000")
            {
                self.saveLoginHistory(responseCode: responseCode.string!)
            }
            else if(responseCode == "E1003")
            {
                self.saveLoginHistory(responseCode: responseCode.string!)
            }
            else if(responseCode == "E2222")
            {
                self.saveLoginHistory(responseCode: responseCode.string!)
            }
            else if(responseCode == "E5555")
            {
                self.saveLoginHistory(responseCode: responseCode.string!)
            }
            else if(responseCode == "E9999")
            {
                self.getNewVersionalertList()
            }
            else if(responseCode == "E6666")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("multiple_login", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
                                    
                                    self!.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                    UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                    let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                                    self?.navigationController?.pushViewController(vc, animated: true)
                                    
                                    
                                
                                }
                                }
                        }
                        else
                        {
                            let ac = UIAlertController(title: "Unavailable", message: "You Cant Use This Feature!", preferredStyle: .alert)
                                               ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                            
                        }
                        
                        
                        
                        
                        
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    }))
                    alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
                        print("No....")
                        
                        self.defaults.set("biometricdisabled", forKey: "biometricdisabled")
                        //self.defaults.set("", forKey: "biometricenabled")
                        UserDefaults.standard.removeObject(forKey: "biometricenabled")
                        
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }))
                    self.present(alert, animated: true)
                }
                        
                        
                        
                    //}
                    
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                    let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                    
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
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
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
                                        
                                        self!.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                                        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                                        self?.navigationController?.pushViewController(vc, animated: true)
                                        
                                        
                                    
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
                        
                        
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    }))
                    alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
                        print("No....")
                        
                        self.defaults.set("biometricdisabled", forKey: "biometricdisabled")
                        UserDefaults.standard.removeObject(forKey: "biometricenabled")
                        
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }))
                    self.present(alert, animated: true)
                    
                    
                    
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                    let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                        
                        
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

//extension Decimal {
//    var significantFractionalDecimalDigits: Int {
//        return max(-exponent, 0)
//    }
//}
//
//extension String {
//
//    func removeExtraSpaces() -> String {
//        return self.replacingOccurrences(of: "[\\s\n]+", with: "", options: .regularExpression, range: nil)
//    }
//
//}
