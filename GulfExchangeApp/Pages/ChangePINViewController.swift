//
//  ChangePINViewController.swift
//  GulfExchangeApp
//
//  Created by test on 22/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class ChangePINViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var oldPinTextField: UITextField!
    @IBOutlet weak var newPinTextField: UITextField!
    @IBOutlet weak var retypeNewPinTextField: UITextField!
    @IBOutlet weak var sendOtpBtn: UIButton!
    @IBOutlet weak var oldPinEyeBtn: UIButton!
    @IBOutlet weak var newPinEyeBtn: UIButton!
    @IBOutlet weak var retypePinEyeBtn: UIButton!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var saveDetailsBtn: UIButton!
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()

    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var udid:String!
    var oldPinEyeClick = true
    var newPinEyeClick = true
    var retypePinEyeClick = true
    
    var strOldPin:String = ""
    var strNewPin:String = ""
    var custRegNo:String = ""
    var userId:String = ""
    var passw:String = ""
    var pin:String = ""
    var email:String = ""
    var mobile:String = ""
    var strOtp:String = ""
    let defaults = UserDefaults.standard
    
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
        
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        //new
        self.oldPinTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.oldPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.newPinTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.newPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.retypeNewPinTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.retypeNewPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }

        self.otpTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.otpTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }



        
        
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
               let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               if appLang == "ar" || appLang == "ur" {
                  oldPinTextField.textAlignment = .right
                  newPinTextField.textAlignment = .right
                  retypeNewPinTextField.textAlignment = .right
               } else {
                  oldPinTextField.textAlignment = .left
                  newPinTextField.textAlignment = .left
                  retypeNewPinTextField.textAlignment = .left
               }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("change_pin", comment: "")
        sendOtpBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        sendOtpBtn.layer.cornerRadius = 15
        saveDetailsBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        saveDetailsBtn.layer.cornerRadius = 15
        setFont()
        
        oldPinTextField.delegate = self
        newPinTextField.delegate = self
        retypeNewPinTextField.delegate = self
        otpTextField.delegate = self
        
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        
    }
    @objc func userIsInactive() {
        // Alert user
//        let alert = UIAlertController(title: "You have been inactive for 5 minutes. We're going to log you off for security reasons.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
//        //Log user off
//        }))
//        present(alert, animated: true)

        timer.invalidate()
        
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

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
                self.navigationController?.pushViewController(nextViewController, animated: true)


        return
        
     }

    @objc func resetTimer() {
        print("Reset")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        self.validateMultipleLogin()
    }
    func validateMultipleLogin() {
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            
            let url = api_url + "login_session"
        let params:Parameters = ["id_no":self.defaults.string(forKey: "USERID")!,"session_id":self.udid!]

              AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                self.effectView.removeFromSuperview()
                print("resp1111",response)
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)
                    let code = myresult!["scode"]
                    if(code == 1)
                    {
                        
                    }
                    else if(code == 2)
                    {
                        self.callLogout()
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
        let params:Parameters = ["id_no":self.defaults.string(forKey: "USERID")!,"session_id":udid!]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp2222",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let code = myresult!["scode"]
                
                if(code == 1)
                {
                    self.defaults.set("", forKey: "USERID")
                    self.defaults.set("", forKey: "PASSW")
                    self.defaults.set("", forKey: "PIN")
                    self.defaults.set("", forKey: "REGNO")
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
                    //        self.navigationController?.pushViewController(nextViewController, animated: true)
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                break
            case .failure:
                break
            
            }
          })
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func oldPinEyeBtn(_ sender: Any) {
        if(oldPinEyeClick == true) {
            oldPinTextField.isSecureTextEntry = false
            oldPinEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            oldPinTextField.isSecureTextEntry = true
            oldPinEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        oldPinEyeClick = !oldPinEyeClick
    }
    @IBAction func newPinEyeBtn(_ sender: Any) {
        if(newPinEyeClick == true) {
            newPinTextField.isSecureTextEntry = false
            newPinEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            newPinTextField.isSecureTextEntry = true
            newPinEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        newPinEyeClick = !newPinEyeClick
    }
    @IBAction func retypePinEyeBtn(_ sender: Any) {
        if(retypePinEyeClick == true) {
            retypeNewPinTextField.isSecureTextEntry = false
            retypePinEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            retypeNewPinTextField.isSecureTextEntry = true
            retypePinEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        retypePinEyeClick = !retypePinEyeClick
    }
    @IBAction func sendOtpBtn(_ sender: Any) {
        
        //new
        if oldPinTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.oldPinTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.oldPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.oldPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }

        
            guard let oldPin = oldPinTextField.text, oldPinTextField.text?.count != 0 else {
                
                self.view.makeToast(NSLocalizedString("type_old_pin", comment: ""), duration: 3.0, position: .center)
                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_old_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(oldPinTextField.text?.count != 4)
            {
                
                self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .center)
                
                self.oldPinTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.oldPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
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
                self.oldPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        
        if(oldPin != self.defaults.string(forKey: "PIN")!)
        {
            self.view.makeToast(NSLocalizedString("pin_not_valid", comment: ""), duration: 3.0, position: .center)
            
            self.oldPinTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.oldPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_not_valid", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.oldPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        
        
        //new
        if newPinTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.newPinTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.newPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.newPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }

        
            guard let newPin = newPinTextField.text, newPinTextField.text?.count != 0 else {
                
                self.view.makeToast(NSLocalizedString("type_new_pin", comment: ""), duration: 3.0, position: .center)

                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_new_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(newPinTextField.text?.count != 4)
            {
                self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .center)

                self.newPinTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.newPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
        else
        {
            if #available(iOS 13.0, *) {
                self.newPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        
        
        
        //new
        if retypeNewPinTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.retypeNewPinTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.retypeNewPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.retypeNewPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }

        
            guard let retypePin = retypeNewPinTextField.text, retypeNewPinTextField.text?.count != 0 else
            {
                self.view.makeToast(NSLocalizedString("retype_new_pin", comment: ""), duration: 3.0, position: .center)

                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("retype_new_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(newPin != retypePin)
            {
                self.view.makeToast(NSLocalizedString("pin_mismatch", comment: ""), duration: 3.0, position: .center)
                
                self.retypeNewPinTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.retypeNewPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }


                
               // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
        else
        {
            if #available(iOS 13.0, *) {
                self.retypeNewPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        
            self.strOldPin = oldPin
            self.strNewPin = newPin
        self.getToken(num: 1)
        
        
    }
    @IBAction func saveDetailsBtn(_ sender: Any) {
        
        
        //new
        if otpTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.otpTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.otpTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.otpTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }


        
        guard let otp = otpTextField.text, otpTextField.text?.count != 0 else
        {
            self.view.makeToast(NSLocalizedString("enter_otp", comment: ""), duration: 3.0, position: .center)

            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        self.strOtp = otp
        self.validateOTP()
    }
    @IBAction func resendOTP(_ sender: Any) {
        self.resendOTP()
    }
    func setFont() {
        oldPinTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        newPinTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        retypeNewPinTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        sendOtpBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        saveDetailsBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        resetTimer()
        
        let maxLength = 4
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        ChangePINViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token4  ",token)
                print("num",num)
                if(num == 1)
                {
                    self.getEmailId(access_token: token)
                }
                else if(num == 2)
                {
                    self.changePIN(access_token: token)
                }
                break
            case .failure:
                break
            }
        })
    }
    func getEmailId(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":strOldPin]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        ChangePINViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(responseCode == "S104")
            {
                self.email = myResult!["email"].string!
                print(self.email)
                self.mobile = myResult!["customerMobile"].string!
                self.getOTP()
                
            }
            else{
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("error_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
            
        })
    }
    func getOTP() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "otp_generate_listing"
        let params:Parameters = ["id_no":defaults.string(forKey: "USERID")!,"email":self.email,"type":"2","mobile_no":self.mobile]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getresp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["code"]
                if(respCode == "1")
                {
                    self.otpView.isHidden = false
                    self.resendOtpBtn.isHidden = false
                    self.sendOtpBtn.isHidden = true
                    self.saveDetailsBtn.isHidden = false
                    
                }
                else{
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("something_went_wrong_try_again", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                break
            case .failure:
                break
            }
          })
    }
    func resendOTP() {
        self.img.isHidden = true
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "otp_generate_listing"
        let params:Parameters = ["id_no":defaults.string(forKey: "USERID")!,"email":self.email,"type":"2","mobile_no":self.mobile]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getresp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["code"]
                if(respCode == "1")
                {
                    self.otpView.isHidden = false
                    self.resendOtpBtn.isHidden = false
                    self.img.isHidden = false
                    self.sendOtpBtn.isHidden = true
                    self.saveDetailsBtn.isHidden = false
                    
                }
                else{
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("something_went_wrong_try_again", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                break
            case .failure:
                break
            }
          })
    }
    func validateOTP() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "otp_verification"
        let params:Parameters = ["id_no":defaults.string(forKey: "USERID")!,"email":self.email,"type":"2","otp_no":self.strOtp,"mobile_no":self.mobile]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("respvalidate",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["code"]
                
                if(respCode == "1")
                {
                    self.getToken(num: 2)
                }
                else if(respCode == "0")
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("otp_expired", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("something_went_wrong_try_again", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                
                break
            case .failure:
                break
            }
          })
    }
    func changePIN(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/resetmpin"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"currentMPIN":strOldPin,"newMPIN":strNewPin]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        ChangePINViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(responseCode == "S109")
            {
                self.timer.invalidate()
                
                
                self.pin = self.newPinTextField.text!
                UserDefaults.standard.removeObject(forKey: "PIN")
                UserDefaults.standard.set(self.pin, forKey: "PIN")

                
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_reset_success", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.defaults.set(self.newPinTextField.text, forKey: "PIN")
                self.oldPinTextField.text = ""
                self.newPinTextField.text = ""
                self.retypeNewPinTextField.text = ""
                self.otpTextField.text = ""
                self.otpView.isHidden = true
                self.resendOtpBtn.isHidden = true
                self.img.isHidden = true
                self.sendOtpBtn.isHidden = false
                self.saveDetailsBtn.isHidden = true
                
                
            }
            else{
                
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                self.timer.invalidate()
//                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("error_in_otp_sent", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
