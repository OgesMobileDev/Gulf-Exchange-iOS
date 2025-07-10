//
//  ResetPasswordViewController.swift
//  GulfExchangeApp
//
//  Created by test on 01/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class ResetPasswordViewController: UIViewController,UITextFieldDelegate {
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()
    
    
    //let defaults = UserDefaults.standard
    var passw:String!
    
    @IBOutlet var specialcharbtn: UIButton!
    @IBOutlet var specialcharlabel: UILabel!
    
    @IBOutlet weak var passwReqLbl: UILabel!
    @IBOutlet weak var req1Lbl: UILabel!
    @IBOutlet weak var req2Lbl: UILabel!
    @IBOutlet weak var req3Lbl: UILabel!
    @IBOutlet weak var req4Lbl: UILabel!
    @IBOutlet weak var passwTextField: UITextField!
    @IBOutlet weak var retypeTextField: UITextField!
    @IBOutlet weak var saveDetailsBtn: UIButton!
    @IBOutlet weak var passwEyeBtn: UIButton!
    @IBOutlet weak var reTypePasswEyeBtn: UIButton!
    @IBOutlet weak var radio1: UIButton!
    @IBOutlet weak var radio2: UIButton!
    @IBOutlet weak var radio3: UIButton!
    @IBOutlet weak var radio4: UIButton!
    
    var passCheck1 = false
    var passCheck2 = false
    var passCheck3 = false
    var passCheck4 = false
    
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
    
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let defaults = UserDefaults.standard
    
    var passwEyeClick = true
    var reTypePasswEyeClick = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.passwTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.retypeTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.retypeTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }

        
        
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
           passwTextField.textAlignment = .right
           retypeTextField.textAlignment = .right
        } else {
           passwTextField.textAlignment = .left
           retypeTextField.textAlignment = .left
        }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("reset_password", comment: "")
        saveDetailsBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        saveDetailsBtn.layer.cornerRadius = 15
        setFont()
        setFontSize()
        
        self.passwTextField.delegate = self
        self.retypeTextField.delegate = self
        passwTextField.addTarget(self, action: #selector(ResetPasswordViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        timer.invalidate()
        
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField == passwTextField)
        {
            if(passwTextField.text!.count > 0)
            {
                let str = passwTextField.text!
                if(str.count >= 8)
                {
                    self.passCheck1 = true
                    radio1.setImage(UIImage(named: "radio_green"), for: .normal)
                }
                else{
                    self.passCheck1 = false
                    radio1.setImage(UIImage(named: "radio_light"), for: .normal)
                }
                if (str.contains("A") || str.contains("B") || str.contains("C") || str.contains("D") || str.contains("E") || str.contains("F") || str.contains("G") || str.contains("H") ||
                    str.contains("I") ||
                    str.contains("J") ||
                    str.contains("K") ||
                    str.contains("L") ||
                    str.contains("M") ||
                    str.contains("N") ||
                    str.contains("O") ||
                    str.contains("P") ||
                    str.contains("Q") ||
                    str.contains("R") ||
                    str.contains("S") ||
                    str.contains("T") ||
                    str.contains("U") ||
                    str.contains("V") ||
                    str.contains("W") ||
                    str.contains("X") ||
                    str.contains("Y") ||
                    str.contains("Z"))
                {
                    self.passCheck2 = true
                    radio2.setImage(UIImage(named: "radio_green"), for: .normal)
                }
                else{
                    self.passCheck2 = false
                    radio2.setImage(UIImage(named: "radio_light"), for: .normal)
                }
                if (str.contains("a") || str.contains("b") || str.contains("c") || str.contains("d") || str.contains("e") || str.contains("f") || str.contains("g") || str.contains("h") ||
                    str.contains("i") ||
                    str.contains("j") ||
                    str.contains("k") ||
                    str.contains("l") ||
                    str.contains("m") ||
                    str.contains("n") ||
                    str.contains("o") ||
                    str.contains("p") ||
                    str.contains("q") ||
                    str.contains("r") ||
                    str.contains("s") ||
                    str.contains("t") ||
                    str.contains("u") ||
                    str.contains("v") ||
                    str.contains("w") ||
                    str.contains("x") ||
                    str.contains("y") ||
                    str.contains("z"))
                {
                    self.passCheck3 = true
                    radio3.setImage(UIImage(named: "radio_green"), for: .normal)
                }
                else{
                    self.passCheck3 = false
                    radio3.setImage(UIImage(named: "radio_light"), for: .normal)
                }
                
                if (str.contains("1") || str.contains("2") || str.contains("3") || str.contains("4") || str.contains("5") || str.contains("6") || str.contains("7") || str.contains("8") ||
                    str.contains("9") ||
                    str.contains("0"))
                {
                    self.passCheck4 = true
                    radio4.setImage(UIImage(named: "radio_green"), for: .normal)
                }
                else{
                    self.passCheck4 = false
                    radio4.setImage(UIImage(named: "radio_light"), for: .normal)
                }
                
            }
            else{
                radio1.setImage(UIImage(named: "radio_light"), for: .normal)
                radio2.setImage(UIImage(named: "radio_light"), for: .normal)
                radio3.setImage(UIImage(named: "radio_light"), for: .normal)
                radio4.setImage(UIImage(named: "radio_light"), for: .normal)
            }
            
            //new
            
            var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
            var string2addressspecial = passwTextField.text!

                if let strvalue = string2addressspecial.rangeOfCharacter(from: charSetaddressspecial)
                {
                    print("true")
                    specialcharbtn.setImage(UIImage(named: "radio_green"), for: .normal)
                    
    //                let alert = UIAlertController(title: "Alert", message: "Please enter valid working address", preferredStyle: UIAlertController.Style.alert)
    //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
    //                self.present(alert, animated: true, completion: nil)
//                        print("check name",self.workAddressTextField.text)
//
//                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                        return
                               
                }
            else
            {
                specialcharbtn.setImage(UIImage(named: "radio_light"), for: .normal)
            }

        }
        
    }
    @IBAction func saveDetailsBtn(_ sender: Any) {
        
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

        
        
        guard let passw = passwTextField.text, passwTextField.text?.count != 0 else {
            
            self.view.makeToast(NSLocalizedString("enter_password", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck1)
        {
            if #available(iOS 13.0, *) {
                self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else{
            
            self.view.makeToast(NSLocalizedString("pass_length", comment: ""), duration: 3.0, position: .center)
            
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }


            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_length", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck2)
        {
            if #available(iOS 13.0, *) {
                self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else{
            
            self.view.makeToast(NSLocalizedString("pass_must1", comment: ""), duration: 3.0, position: .center)
            
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString(
                //"pass_must1", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck3)
        {
            if #available(iOS 13.0, *) {
                self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        else{
            
            self.view.makeToast(NSLocalizedString("pass_must2", comment: ""), duration: 3.0, position: .center)
            
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must2", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck4)
        {
            if #available(iOS 13.0, *) {
                self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else{
            
            self.view.makeToast(NSLocalizedString("pass_must3", comment: ""), duration: 3.0, position: .center)
            
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must3", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        //new
        
        var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
        var string2addressspecial = passwTextField.text!

            if let strvalue = string2addressspecial.rangeOfCharacter(from: charSetaddressspecial)
            {
                print("true")
//                //radio5specialcharbtn.setImage(UIImage(named: "radio_green"), for: .normal)
//
//                let alert = UIAlertController(title: "Alert", message: "Please enter one special charecter", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                        //print("check name",self.workAddressTextField.text)
////
////                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                        return
                if #available(iOS 13.0, *) {
                    self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }
                
                
                           
            }
        else
        {
            //radio5specialcharbtn.setImage(UIImage(named: "radio_light"), for: .normal)
            //let alert = UIAlertController(title: "Alert", message: "Please enter one special charecter", preferredStyle: UIAlertController.Style.alert)
           // alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //self.present(alert, animated: true, completion: nil)
                   
            
            self.view.makeToast("Password must contain atleast one special character", duration: 3.0, position: .center)
            
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.passwTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
//
                        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Password must contain atlease one special character", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
        }

        
        //new
        if retypeTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.retypeTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.retypeTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.retypeTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }

        
        guard let retypePassw = retypeTextField.text, retypeTextField.text?.count != 0 else {
            
            self.view.makeToast(NSLocalizedString("re_type_password", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("re_type_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passw.elementsEqual(retypePassw))
        {
            if #available(iOS 13.0, *) {
                self.retypeTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        else{
            self.view.makeToast(NSLocalizedString("password_mismatch", comment: ""), duration: 3.0, position: .center)
            
            self.retypeTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.retypeTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("password_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        self.getToken()
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
    @IBAction func reTypePasswEyeBtn(_ sender: Any) {
        if(reTypePasswEyeClick == true) {
            retypeTextField.isSecureTextEntry = false
            reTypePasswEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            retypeTextField.isSecureTextEntry = true
            reTypePasswEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        reTypePasswEyeClick = !reTypePasswEyeClick
    }
    func setFont() {
        passwReqLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        req1Lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        req2Lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        req3Lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        req4Lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        passwTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        retypeTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        saveDetailsBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        passwReqLbl.font = passwReqLbl.font.withSize(14)
        req1Lbl.font = req1Lbl.font.withSize(14)
        req2Lbl.font = req2Lbl.font.withSize(14)
        req3Lbl.font = req3Lbl.font.withSize(14)
        req4Lbl.font = req4Lbl.font.withSize(14)
        
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    func getToken() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        ForgotPasswordViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token4  ",token)
                self.resetPassword(access_token: token)
                break
            case .failure:
                break
            }
        })
    }
    func resetPassword(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/forgotpassword"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":defaults.string(forKey: "resetUserId")!,"emailID":defaults.string(forKey: "resetEmail")!,"newPassword":self.passwTextField.text!,"currentPasswor":""]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        ResetPasswordViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            let respMsg = myResult!["responseMessage"].stringValue
            print("resp",respCode)
            self.effectView.removeFromSuperview()
           if(respCode == "S108")
           {
               self.passw = self.passwTextField.text!
               UserDefaults.standard.removeObject(forKey: "PASSW")
               UserDefaults.standard.set(self.passw, forKey: "PASSW")
               
               print("passnewww",self.passw)
               
            
            let commonAlert = UIAlertController(title:"", message: respMsg, preferredStyle:.alert)
            let okAction = UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .cancel){ (action:UIAlertAction) in
                              
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                                
            }
                    commonAlert.addAction(okAction)
            self.present(commonAlert, animated: true, completion: nil)
            
            
            }
           else{
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
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
        let maxLength = 16
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func checkCapital( text : String) -> Bool{


        let capitalLetterRegEx  = ".*[A-Z]+.*"
        var texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        var capitalresult = texttest.evaluate(with: text)
        

//
//        let numberRegEx  = ".*[0-9]+.*"
//        var texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
//        var numberresult = texttest1.evaluate(with: text)
//
//
//
//        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
//        var texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
//
//        var specialresult = texttest2.evaluate(with: text)
//

        return capitalresult

    }
    func checkLowerCase( text : String) -> Bool{
        
    let capitalLetterRegEx  = ".*[a-z]+.*"
    var texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
    var lowercaseresult = texttest.evaluate(with: text)
        return lowercaseresult
    }
    func checkNumber( text : String) -> Bool{
        
    let capitalLetterRegEx  = ".*[0-9]+.*"
    var texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
    var numResult = texttest.evaluate(with: text)
        return numResult
    }
    
}
