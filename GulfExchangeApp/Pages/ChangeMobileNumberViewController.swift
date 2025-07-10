//
//  ChangeMobileNumberViewController.swift
//  GulfExchangeApp
//
//  Created by test on 22/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChangeMobileNumberViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var oldMobileTextField: UITextField!
    @IBOutlet weak var newMobileTextField: UITextField!
    @IBOutlet weak var retypeNewMobileTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var saveDetailsBtn: UIButton!
    @IBOutlet weak var oldMobContainerView: UIView!
    @IBOutlet weak var retypeNewMobContainerView: UIView!
    @IBOutlet weak var pinEyeBtn: UIButton!
    @IBOutlet weak var newMobContainerView: UIView!
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var udid:String!
    
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
    
    
    var pinEyeClick = true
    var strOldMobile:String = ""
    var strNewMobile:String = ""
    var strEmail:String!
    var accessToken:String = ""
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            oldMobContainerView.semanticContentAttribute = .forceLeftToRight
            newMobContainerView.semanticContentAttribute = .forceLeftToRight
            retypeNewMobContainerView.semanticContentAttribute = .forceLeftToRight
           oldMobileTextField.textAlignment = .right
           newMobileTextField.textAlignment = .right
           retypeNewMobileTextField.textAlignment = .right
           pinTextField.textAlignment = .right
           emailTextField.textAlignment = .right
        } else {
            oldMobContainerView.semanticContentAttribute = .forceLeftToRight
            newMobContainerView.semanticContentAttribute = .forceLeftToRight
            retypeNewMobContainerView.semanticContentAttribute = .forceLeftToRight
           oldMobileTextField.textAlignment = .left
           newMobileTextField.textAlignment = .left
           retypeNewMobileTextField.textAlignment = .left
           pinTextField.textAlignment = .left
           emailTextField.textAlignment = .left
        }
        self.title = NSLocalizedString("change_mobile", comment: "")
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        saveDetailsBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        saveDetailsBtn.layer.cornerRadius = 15
        setFont()
        
        oldMobileTextField.delegate = self
        newMobileTextField.delegate = self
        retypeNewMobileTextField.delegate = self
        pinTextField.delegate = self
        
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
    @IBAction func saveDetailsBtn(_ sender: Any) {
        guard let oldMobile = oldMobileTextField.text,oldMobileTextField.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_old_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        var charSetMOBNoold = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                    var string2MOBNoold = oldMobile
                    
                    if let strvalue = string2MOBNoold.rangeOfCharacter(from: charSetMOBNoold)
                    {
                        print("true")
        //                let alert = UIAlertController(title: "Alert", message: "Please enter valid account number", preferredStyle: UIAlertController.Style.alert)
        //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        //                self.present(alert, animated: true, completion: nil)
        //                print("check name",self.accountNum.text)
                        
                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                        
                    }
        
        if (!validate (value: self.oldMobileTextField.text!))
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        
        
        
        guard let newMobile = newMobileTextField.text, newMobileTextField.text?.count != 0 else {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_new_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        var charSetMOBNonew = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                    var string2MOBNonew = newMobile
                    
                    if let strvalue = string2MOBNonew.rangeOfCharacter(from: charSetMOBNonew)
                    {
                        print("true")
        //                let alert = UIAlertController(title: "Alert", message: "Please enter valid account number", preferredStyle: UIAlertController.Style.alert)
        //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        //                self.present(alert, animated: true, completion: nil)
        //                print("check name",self.accountNum.text)
                        
                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                        
                    }
        
        if (!validate (value: self.newMobileTextField.text!))
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        
        
        
        guard let retypeMobile = retypeNewMobileTextField.text,retypeNewMobileTextField.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("retype_new_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(newMobile.elementsEqual(retypeMobile))
        {
            
        }
        else{
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("mobile_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        guard let pin = pinTextField.text, pinTextField.text?.count != 0 else {
            
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        guard let email = emailTextField.text, emailTextField.text?.count != 0 else{
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        let validateEmail = isValidEmail(email)
        if(validateEmail)
        {
            
        }
        else{
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        self.strOldMobile = "974" + oldMobile
        self.strNewMobile = "974" + newMobile
        
        self.strEmail = email
        self.getToken()
    }
    func setFont() {
        oldMobileTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        newMobileTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        retypeNewMobileTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        pinTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        emailTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        saveDetailsBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == oldMobileTextField || textField == newMobileTextField || textField == retypeNewMobileTextField)
        {
            let maxLength = 8
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == pinTextField)
        {
            let maxLength = 4
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return Bool()
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
        
        ChangeMobileNumberViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let token:String = myresult!["access_token"].string!
                print("token4  ",token)
                self.accessToken = token
                self.validateMobileNumber()
                break
            case .failure:
                break
            }
        })
    }
    func validateMobileNumber() {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        print("old",strOldMobile)
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":strOldMobile,"customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMERID_MOBILE","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        ChangeMobileNumberViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("validatemobile ",response)
            self.effectView.removeFromSuperview()
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            print("respCode1",respCode)
            
            if(respCode == "S9004")
            {
                self.validateEmail()
            }
            else
            {
                self.alertMessage(title: "Gulf Exchange", msg: NSLocalizedString("check_current_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
        
        })
    }
    func validateEmail() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":strEmail,"customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMERID_EMAIL","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        ChangeMobileNumberViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("validateemail ",response)
            self.effectView.removeFromSuperview()
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            print("respCode2",respCode)
            
            if(respCode == "S9002")
            {
                self.validateNewMobileNumber()
            }
            else
            {
                self.alertMessage(title: "Gulf Exchange", msg: NSLocalizedString("check_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
        
        })
    }
    func validateNewMobileNumber() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        print("new",strNewMobile)
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":strNewMobile,"customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMERID_MOBILE","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        ChangeMobileNumberViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("validatenew ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            print("respCode3",respCode)
            self.effectView.removeFromSuperview()
            if(respCode == "S9004")
            {
                self.alertMessage(title: "Gulf Exchange", msg: NSLocalizedString("mobile_already_registered", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
            else
            {
                self.changeMobileNumber()
            }
        
        })
    }
    func changeMobileNumber() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/resetmobile"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"email":strEmail,"currentMobileNo":strOldMobile,"newMobileNo":strNewMobile]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        ChangeMobileNumberViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            print("respCode4",respCode)
            self.effectView.removeFromSuperview()
            if(respCode == "S110")
            {
                self.alertMessage(title: "Gulf Exchange", msg: NSLocalizedString("mobile_reset_success", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.oldMobileTextField.text = ""
                self.newMobileTextField.text = ""
                self.retypeNewMobileTextField.text = ""
                self.pinTextField.text = ""
                self.emailTextField.text = ""
            }
            else
            {
                
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                
                
//                self.alertMessage(title: "Gulf Exchange", msg: NSLocalizedString("mobile_not_reset", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
