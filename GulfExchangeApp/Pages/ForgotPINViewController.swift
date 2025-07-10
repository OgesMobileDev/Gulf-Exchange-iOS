//
//  ForgotPINViewController.swift
//  GulfExchangeApp
//
//  Created by test on 23/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class ForgotPINViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var idNumLbl: UILabel!
    @IBOutlet weak var idNumTextField: UITextField!
    
    
    @IBOutlet weak var passwLbl: UILabel!
    @IBOutlet weak var passwTextField: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    
    
    
    
    
    @IBOutlet var codem: UITextField!
    @IBOutlet var mobcodetxtfd: UITextField!
    
    @IBOutlet weak var sendOtpBtn: UIButton!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var resendOtp: UIButton!
    @IBOutlet weak var passwordEyeBtn: UIButton!
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var strPassw:String = ""
    var strEmail:String = ""
    var strMobile:String = ""
    var strUserId:String = ""
    var strOtp:String = ""
    let defaults = UserDefaults.standard
    var passwEyeClick = true
    
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
        
//        if #available(iOS 13.0, *) {
//            overrideUserInterfaceStyle = .light
//        } else {
//            // Fallback on earlier versions
//        }
        
        //new
        self.emailTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.idNumTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.idNumTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        
        self.otpTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.otpTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        
        
        if #available(iOS 13.0, *) {
           // overrideUserInterfaceStyle = .light
            self.idNumTextField.layer.borderColor = UIColor.lightGray.cgColor
            
            if( self.traitCollection.userInterfaceStyle == .dark ){
                 //is dark
                overrideUserInterfaceStyle = .light
                self.idNumTextField.layer.borderColor = UIColor.lightGray.cgColor
                self.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
                self.otpTextField.layer.borderColor = UIColor.lightGray.cgColor
                self.mobcodetxtfd.layer.borderColor = UIColor.lightGray.cgColor
                self.mobcodetxtfd.layer.borderWidth = 0.8
                
                
                
              }else{
                  //is light
                  if #available(iOS 13.0, *) {
                     // overrideUserInterfaceStyle = .light
                      self.idNumTextField.layer.borderColor = UIColor.lightGray.cgColor
                      self.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
                      self.otpTextField.layer.borderColor = UIColor.lightGray.cgColor
                      self.mobcodetxtfd.layer.borderColor = UIColor.lightGray.cgColor
                      self.mobcodetxtfd.layer.borderWidth = 0.8
                      
                  }
              }
            
        } else {
            // Fallback on earlier versions
        }


        
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                                   let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                                   if appLang == "ar" || appLang == "ur" {
                                      idNumTextField.textAlignment = .right
                                      passwTextField.textAlignment = .right
                                      emailTextField.textAlignment = .right
                                      otpTextField.textAlignment = .right
                                   } else {
                                      idNumTextField.textAlignment = .left
                                      passwTextField.textAlignment = .left
                                      emailTextField.textAlignment = .left
                                      otpTextField.textAlignment = .left
                                   }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("forgot_pin", comment: "")
        sendOtpBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        sendOtpBtn.layer.cornerRadius = 15
        confirmBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        confirmBtn.layer.cornerRadius = 15
        setFont()
        setFontSize()
        
        idNumTextField.delegate = self
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
    
    
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func passwordEyeBtn(_ sender: Any) {
        if(passwEyeClick == true) {
            passwTextField.isSecureTextEntry = false
            passwordEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            passwTextField.isSecureTextEntry = true
            passwordEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        passwEyeClick = !passwEyeClick
    }
    @IBAction func sendOTP(_ sender: Any) {
        
        //new
        if emailTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.emailTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        
        guard let email = emailTextField.text, emailTextField.text?.count != 0 else {
            
            self.view.makeToast(NSLocalizedString("enter_mobile", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
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
        
        guard let idNum = idNumTextField.text, idNumTextField.text?.count != 0 else
        {
            self.view.makeToast(NSLocalizedString("enter_id_no", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_no", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        var charSetidNum = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2 = idNum

        if let strvalue = string2.rangeOfCharacter(from: charSetidNum)
        {
            print("true")

            self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if (!validate (value: self.idNumTextField.text!))
        {
            self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
            
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
        
        
        
//
//        guard let passw = passwTextField.text, passwTextField.text?.count != 0 else {
//            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }
 
//        let validateEmail = isValidEmail(email)
//        if(validateEmail)
//        {
//
//        }
//        else{
//            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }
        self.strUserId = idNum
       // self.strPassw = passw
        self.strEmail = email
        
        print(strUserId)
        print(strPassw)
        print(strEmail)
        
        //self.getToken()
        self.getOTP(msg: "")
       // self.validateOTP()
        
    }
    @IBAction func confirmBtn(_ sender: Any) {
        
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

        
        guard let otp = otpTextField.text, otpTextField.text?.count != 0 else {
            
            self.view.makeToast(NSLocalizedString("please_enter_otp", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("please_enter_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        self.strOtp = otp
        self.validateOTP()
        
    }
    @IBAction func resendOtpBtn(_ sender: Any) {
        self.getOTP(msg: NSLocalizedString("otp_resent", comment: ""))
    }
    func setFont() {
        idNumLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        idNumTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        passwLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        passwTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        emailLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        emailTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        sendOtpBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        confirmBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        resendOtp.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        
    }
    func setFontSize() {
        idNumLbl.font = idNumLbl.font.withSize(14)
        passwLbl.font = passwLbl.font.withSize(14)
        emailLbl.font = emailLbl.font.withSize(14)
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func getToken() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        ForgotPINViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token4  ",token)
                self.validateEmailMobile(accessToken: token, passw: self.strPassw, email: self.strEmail)
                break
            case .failure:
                break
            }
        })
    }
    func validateEmailMobile(accessToken:String,passw:String,email:String) {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":self.strUserId,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"974"+email,"customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMER_EMAILID","isExistOrValid":"0"]
        
        print("paramsvalidation ",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        ForgotPINViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            if(respCode == "S9004")
            {
                let resMsg:String = myResult!["responseMessage"].string!
                if let range = resMsg.range(of: "@") {
                    let subString = resMsg[range.lowerBound...]
                    print("sub",subString) // prints "123.456.7891"
                    //old
//                    let mobile = resMsg.replacingOccurrences(of: subString, with: "")
//                    print("mobile",mobile)
//                    self.strMobile = mobile
                    
                    //new
                    let emailstr:String = myResult!["responseMessage"].string!
                   self.strEmail = emailstr
                   print("sstrEmail",self.strEmail)
                    
                    //old original
                    //self.getOTP(msg: "")
                    //
                    self.defaults.set(self.strUserId, forKey: "resetUserId")
                    self.defaults.set(self.strEmail, forKey: "resetEmail")
                    self.defaults.set(self.strMobile, forKey: "resetMobile")
                    self.defaults.set(self.strPassw, forKey: "resetPassw")
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                   self.defaults.set(self.strEmail, forKey: "userEmail")
                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "resetPIN") as! ResetPINViewController
                   self.navigationController?.pushViewController(nextViewController, animated: true)
                    //
                }
            }
            else{
               // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("check_cust_id_password_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            }
        
        })
    }
    func getOTP(msg:String) {
        print("message ",msg)
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "otp_generate_listing"
        let params:Parameters = ["id_no":self.strUserId,"email":self.strEmail,"type":"2","mobile_no":"974"+emailTextField.text!]
        
        print("paramssendotp",params)

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getresp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["code"]
                if(respCode == "1")
                {
                   if(msg == "")
                   {
                    self.otpView.isHidden = false
                    }
                   else{
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: msg, action: NSLocalizedString("ok", comment: ""))
                    }
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
        let params:Parameters = ["id_no":self.strUserId,"email":self.strEmail,"type":"2","otp_no":self.strOtp,"mobile_no":self.strMobile]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("respvalidate",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["code"]
                
                if(respCode == "1")
                {
                    self.getToken()
                    
//                    self.defaults.set(self.strUserId, forKey: "resetUserId")
//                    self.defaults.set(self.strEmail, forKey: "resetEmail")
//                    self.defaults.set(self.strMobile, forKey: "resetMobile")
//                    self.defaults.set(self.strPassw, forKey: "resetPassw")
//                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                   self.defaults.set(self.strEmail, forKey: "userEmail")
//                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "resetPIN") as! ResetPINViewController
//                   self.navigationController?.pushViewController(nextViewController, animated: true)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == idNumTextField)
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
