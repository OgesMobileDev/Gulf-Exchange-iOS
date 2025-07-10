//
//  ResetPasswordViewController.swift
//  GulfExchangeApp
//
//  Created by macbook on 15/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
import Alamofire
import SwiftyJSON
import Toast_Swift

enum CurrentResetOptions{
    case pin
    case password
}
class ResetPinPasswordViewController: UIViewController, UITextFieldDelegate, OTPViewDelegate {
    
    
    
    
    
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var mobNumTF: UITextField!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var sendOtpBtn: UIButton!
    @IBOutlet weak var countryDropDownBtn: UIButton!
    
    var currentPage:CurrentResetOptions = .password
    var isOtp:Bool = false
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var strEmail:String = ""
    var strUserId:String = ""
    var strMobile:String = ""
    var strOtp:String = ""
    var strPassw:String = ""
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
    
    let popUpOtpView = Bundle.main.loadNibNamed("OTPView", owner: self, options: nil)?.first as! OTPView
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        popUpOtpView.delegate = self
        countryDropDownBtn.setTitle("", for: .normal)
        idTF.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScreenShield.shared.protect(view: self.countryCodeTF)
        ScreenShield.shared.protect(view: self.mobNumTF)
        ScreenShield.shared.protect(view: self.idTF)
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    
    @IBAction func countryDropDownBtnTapped(_ sender: Any) {
    }
    @IBAction func sendBtnTapped(_ sender: Any) {
        print("sendBtnTapped")
       
        sendOtp()
//        showOtpView()
    }
    // MARK: - Functions
    func OTPView(_ vc: OTPView, otp: String) {
        print("OTP - \(otp)")
        self.strOtp = otp
        self.getToken(num: 2)
    }
    func OTPView(_ vc: OTPView, resend: Bool) {
        if resend{
            self.getToken(num: 1)
        }
    }
    func OTPView(_ vc: OTPView, close: Bool) {
        if close{
            self.removeOtpView()        }
    }
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        if currentPage == .password{
            self.navigationItem.title = "Forgot Password"
        }else{
            self.navigationItem.title = "Forgot PIN"
        }
       
    }
    @objc func customBackButtonTapped() {
        if isOtp{
            removeOtpView()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    func removeOtpView(){
        popUpOtpView.alpha = 1.0
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
            self.popUpOtpView.alpha = 0.0
        } completion: { _ in
            self.popUpOtpView.resetView()
            self.popUpOtpView.removeFromSuperview()
            self.isOtp = false
        }
    }
    func getMaskedPhoneNumber(countryCode: String, phoneNumber: String) -> String {
        // Combine country code and phone number
        let combinedNumber = countryCode + phoneNumber
        
        // Get the first 4 characters (country code part) and last 2 characters
        let prefix = combinedNumber.prefix(4)
        let suffix = combinedNumber.suffix(2)
        
        // Calculate the number of * symbols needed for the masked section
        let maskedCount = max(0, combinedNumber.count - 6)
        let maskedSection = String(repeating: "*", count: maskedCount)
        
        // Return the masked phone number
        return "\(prefix)\(maskedSection)\(suffix)"
    }
    func showOtpView(){
        let maskedPhoneNumber = getMaskedPhoneNumber(countryCode: countryCodeTF.text ?? "", phoneNumber: mobNumTF.text ?? "")
        popUpOtpView.mobNum = maskedPhoneNumber
        isOtp = true
        popUpOtpView.setView()
        popUpOtpView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpOtpView.alpha = 0.0
        popUpOtpView.closeBtn.isHidden = true
        popUpOtpView.closeImg.isHidden = true
        view.addSubview(popUpOtpView)
        UIView.animate(withDuration: 0.3,  delay: 0, options: [.curveEaseOut]) {
            self.popUpOtpView.alpha = 1.0
        }
    }
    func sendOtp(){
        //new
        if mobNumTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.mobNumTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.mobNumTF.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.mobNumTF.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }

        
        guard let email = mobNumTF.text,mobNumTF.text?.count != 0 else {
            
            self.view.makeToast(NSLocalizedString("enter_mobile", comment: ""), duration: 3.0, position: .center)
            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
//        let validateEmail = isValidEmail(email)
//        if(validateEmail){
//
//        }
//        else{
//            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }

        //new
        if idTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.idTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.idTF.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                idTF            } else {
                // Fallback on earlier versions
            }
        }

        
        guard let idNum = idTF.text, idTF.text?.count != 0 else {
            
            self.view.makeToast(NSLocalizedString("enter_id_number", comment: ""), duration: 3.0, position: .center)

           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_number", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        var charSetidNum = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2 = idNum

        if let strvalue = string2.rangeOfCharacter(from: charSetidNum)
        {
            print("true")


            self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
            
            self.idTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.idTF.layer.borderColor = UIColor.systemGray4.cgColor
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
                self.idTF.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        
        
        if (!validate (value: self.idTF.text!))
        {
            self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
            
            self.idTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.idTF.layer.borderColor = UIColor.systemGray4.cgColor
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
                self.idTF.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        
        
        
        
        self.strUserId = idNum
        self.strMobile = email
        self.getToken(num: 1)
       
        
    }
    func validate(value: String) -> Bool {
        //let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let PHONE_REGEX = "^[0-9]{0,15}$"
        //let PHONE_REGEX = "[a-zA-z]"
        
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
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
    
    // MARK: - API Calls
    
    func getToken(num:Int) {
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
                print("token4  ",token)
                if(num == 1)
                {
                    self.validateEmailMobile(accessToken: token, number: self.strMobile)
                }
                else if(num == 2)
                {
                    self.validateOTP(access_token: token)
                }
                
                break
            case .failure:
                break
            }
        })
    }
    func validateEmailMobile(accessToken:String,number:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":self.strUserId,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"974"+number,"customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMER_EMAILID","isExistOrValid":"0"]
        
        print("urluu ",url)
        print("paramsuu ",params)
        //"customerMobile":"97400000011",
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("validateemail ",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["responseCode"]
                if(respCode == "S9004")
                {
                    let resMsg:String = myResult!["responseMessage"].string!
                    if let range = resMsg.range(of: "@") {
                        let subString = resMsg[range.lowerBound...]
                        print("sub",subString) // prints "123.456.7891"
                        let mobile = resMsg.replacingOccurrences(of: subString, with: "")
                        print("mobile",mobile)
                       // self.strMobile = mobile
                         let emailstr:String = myResult!["responseMessage"].string!
                        self.strEmail = emailstr
                        print("sstrEmail",self.strEmail)
                        self.getOTP(access_token: accessToken)
                    }
                }
                else{
                   // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("check_current_email_customer_id", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    
                    let respMsg = myResult!["responseMessage"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                    
                }
            case .failure:
                break
            }
           
        
        })
    }
    func getOTP(access_token:String) {
        print(self.strUserId)
        print(self.strEmail)
        print(self.strMobile)
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/generateOtp"
        var type = "0"
        switch currentPage {
        case .pin:
            type = "2"
        case .password:
            type = "3"
        }
        let params:Parameters = ["idNo":self.strUserId,"email":self.strEmail,"type":type,"mobileNo":self.strMobile]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("getOTP resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["responseCode"]
                if(respCode == "200")
                {
                    if !self.isOtp{
                        self.showOtpView()
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
    /*func getOTP(msg:String) {
        print(self.strUserId)
        print(self.strEmail)
        print(self.strMobile)
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "otp_generate_listing"
        let params:Parameters = ["id_no":self.strUserId,"email":self.strEmail,"type":"2","mobile_no":self.strMobile]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getresp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["code"]
                if(respCode == "1")
                {
                    if !self.isOtp{
                        self.showOtpView()
                    }
                    
//                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: msg, action: NSLocalizedString("ok", comment: ""))
                }
                else{
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("something_went_wrong", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                break
            case .failure:
                break
            }
          })
    }*/
    
    func validateOTP(access_token:String) {
        print(self.strUserId)
        print(self.strEmail)
        print(self.strOtp)
        print(self.strMobile)
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/verifyOtp"
        var type = "0"
        switch currentPage {
        case .pin:
            type = "2"
        case .password:
            type = "3"
        }
        let params:Parameters = ["idNo":strUserId,"email":self.strEmail,"type":type,"otpNo":self.strOtp,"mobileNo":self.strMobile]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("respvalidate",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["responseCode"]
                
                if(respCode == "200")
                {
                    self.defaults.set(self.strUserId, forKey: "resetUserId")
                    self.defaults.set(self.strEmail, forKey: "resetEmail")
                    self.defaults.set(self.strMobile, forKey: "resetMobile")
                    self.defaults.set(self.strEmail, forKey: "userEmail")
                    self.defaults.set(self.strPassw, forKey: "resetPassw")
                    self.removeOtpView()
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    if self.currentPage == .password{
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }else {
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPinVC") as! ResetPinVC
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                }
                else
                {
                    self.removeOtpView()
                    let respMsg = myResult!["responseMessage"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                }
                
                break
            case .failure:
                break
            }
          })
    }
    
    /*func validateOTP() {
        print(self.strUserId)
        print(self.strEmail)
        print(self.strOtp)
        print(self.strMobile)
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
                    self.defaults.set(self.strUserId, forKey: "resetUserId")
                    self.defaults.set(self.strEmail, forKey: "resetEmail")
                    self.defaults.set(self.strMobile, forKey: "resetMobile")
                    self.defaults.set(self.strEmail, forKey: "userEmail")
                    self.defaults.set(self.strPassw, forKey: "resetPassw")
                    self.removeOtpView()
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    if self.currentPage == .password{
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }else {
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPinVC") as! ResetPinVC
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
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
    }*/
   
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == idTF)
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
