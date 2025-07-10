//
//  ResetPasswordVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 11/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import ScreenShield

// Golalita Password updation

class ResetPasswordVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passBaseView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var retypePassTF: UITextField!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var passEyeImg: UIImageView!
    @IBOutlet weak var rePassEyeBtn: UIButton!
    @IBOutlet weak var rePpassEyeImg: UIImageView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var upperCaseImg: UIImageView!
    @IBOutlet weak var lowerCaseIMg: UIImageView!
    @IBOutlet weak var numberImg: UIImageView!
    @IBOutlet weak var splCharImg: UIImageView!
    
    var timer = Timer()
    var timerGesture = UITapGestureRecognizer()
    var passw:String!
    var passEye = false
    var rePassEye = false
    var passCheck1 = false
    var passCheck2 = false
    var passCheck3 = false
    var passCheck4 = false
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
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
        addNavbar()
        passwordTF.isSecureTextEntry = true
        retypePassTF.isSecureTextEntry = true
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            passwordTF.textAlignment = .right
            retypePassTF.textAlignment = .right
        } else {
            passwordTF.textAlignment = .left
            retypePassTF.textAlignment = .left
        }
        submitBtn.setTitle("", for: .normal)
        passEyeBtn.setTitle("", for: .normal)
        rePassEyeBtn.setTitle("", for: .normal)
        self.passwordTF.delegate = self
        self.retypePassTF.delegate = self
        passwordTF.addTarget(self, action: #selector(ResetPasswordVC.textFieldDidChange(_:)), for: .editingChanged)
        
        timer.invalidate()
    }
    override func viewWillAppear(_ animated: Bool) {
//        ScreenShield.shared.protect(view: self.)
        ScreenShield.shared.protect(view: self.passwordTF)
        ScreenShield.shared.protect(view: self.retypePassTF)
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    @IBAction func passEyeBtnTapped(_ sender: Any) {
        passEye.toggle()
        if passEye {
            passwordTF.isSecureTextEntry = false
            passEyeImg.image = UIImage(named: "show pswrd")
        } else {
            passwordTF.isSecureTextEntry = true
            passEyeImg.image = UIImage(named: "hide pswrd")
        }
    }
    @IBAction func retypePassEyeBtnTapped(_ sender: Any) {
        rePassEye.toggle()
        if rePassEye {
            retypePassTF.isSecureTextEntry = false
            rePpassEyeImg.image = UIImage(named: "show pswrd")
        } else {
            retypePassTF.isSecureTextEntry = true
            rePpassEyeImg.image = UIImage(named: "hide pswrd")
        }
    }
    @IBAction func submitBtnTapped(_ sender: Any) {
        submitDetails()
        
    }
    //MARK: - Functions
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("reset_password", comment: "")
       
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }


    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField == passwordTF)
        {
            if(passwordTF.text!.count > 0)
            {
                let str = passwordTF.text!
                if(str.count >= 8)
                {
                    self.passCheck1 = true
                    characterImg.image = UIImage(named: "t_done")
                }
                else{
                    self.passCheck1 = false
                    characterImg.image = UIImage(named: "pass_check")
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
                    upperCaseImg.image = UIImage(named: "t_done")
                }
                else{
                    self.passCheck2 = false
                    upperCaseImg.image = UIImage(named: "pass_check")
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
                    lowerCaseIMg.image = UIImage(named: "t_done")
                }
                else{
                    self.passCheck3 = false
                    lowerCaseIMg.image = UIImage(named: "pass_check")
                }
                
                if (str.contains("1") || str.contains("2") || str.contains("3") || str.contains("4") || str.contains("5") || str.contains("6") || str.contains("7") || str.contains("8") ||
                    str.contains("9") ||
                    str.contains("0"))
                {
                    self.passCheck4 = true
                    numberImg.image = UIImage(named: "t_done")
                }
                else{
                    self.passCheck4 = false
                    numberImg.image = UIImage(named: "pass_check")
                }
                
            }
            else{
                characterImg.image = UIImage(named: "pass_check")
                upperCaseImg.image = UIImage(named: "pass_check")
                lowerCaseIMg.image = UIImage(named: "pass_check")
                numberImg.image = UIImage(named: "pass_check")
            }
            
            //new
            
            var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
            var string2addressspecial = passwordTF.text!

                if let strvalue = string2addressspecial.rangeOfCharacter(from: charSetaddressspecial)
                {
                    print("true")
                    splCharImg.image = UIImage(named: "t_done")
                    
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
                splCharImg.image = UIImage(named: "pass_check")
            }

        }
        
    }
    func submitDetails(){
            //new
            if passwordTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.passwordTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
                
            
                if #available(iOS 13.0, *) {
                    self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            
            guard let passw = passwordTF.text, passwordTF.text?.count != 0 else {
                
                self.view.makeToast(NSLocalizedString("enter_password", comment: ""), duration: 3.0, position: .center)
                return
            }
            if(passCheck1)
            {
                self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
            }
            else{
                
                self.view.makeToast(NSLocalizedString("pass_length", comment: ""), duration: 3.0, position: .center)
                
                self.passwordTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
                return
            }
            if(passCheck2)
            {
                if #available(iOS 13.0, *) {
                    self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else{
                
                self.view.makeToast(NSLocalizedString("pass_must1", comment: ""), duration: 3.0, position: .center)
                
                self.passwordTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
                return
            }
            if(passCheck3)
            {
                if #available(iOS 13.0, *) {
                    self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            else{
                
                self.view.makeToast(NSLocalizedString("pass_must2", comment: ""), duration: 3.0, position: .center)
                
                self.passwordTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
                return
            }
            if(passCheck4)
            {
                if #available(iOS 13.0, *) {
                    self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else{
                
                self.view.makeToast(NSLocalizedString("pass_must3", comment: ""), duration: 3.0, position: .center)
                
                self.passwordTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
                return
            }
            
            //new
            
            var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
            var string2addressspecial = passwordTF.text!

                if let strvalue = string2addressspecial.rangeOfCharacter(from: charSetaddressspecial)
                {
                    print("true")
                    if #available(iOS 13.0, *) {
                        self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    
                               
                }
            else
            {
                self.view.makeToast("Password must contain atleast one special character", duration: 3.0, position: .center)
                
                self.passwordTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.passwordTF.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
                        return
            }

            
            //new
            if retypePassTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.retypePassTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.retypePassTF.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.retypePassTF.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let retypePassw = retypePassTF.text, retypePassTF.text?.count != 0 else {
                
                self.view.makeToast(NSLocalizedString("re_type_password", comment: ""), duration: 3.0, position: .center)
                return
            }
            if(passw.elementsEqual(retypePassw))
            {
                if #available(iOS 13.0, *) {
                    self.retypePassTF.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            else{
                self.view.makeToast(NSLocalizedString("password_mismatch", comment: ""), duration: 3.0, position: .center)
                
                self.retypePassTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.retypePassTF.layer.borderColor = UIColor.systemGray4.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("password_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            self.getToken()
        
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
    


    
    //MARK: - API Calls
    
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
        let url = ge_api_url_new + "utilityservice/forgotpassword"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,
                                  "userID":defaults.string(forKey: "resetUserId")!,
                                  "emailID":defaults.string(forKey: "resetEmail")!,
                                  "newPassword":self.passwordTF.text!,
                                  "currentPassword":""]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            let respMsg = myResult!["responseMessage"].stringValue
            print("resp",respCode)
            self.effectView.removeFromSuperview()
           if(respCode == "S108")
           {
               self.passw = self.passwordTF.text!
               self.updateGolalitaPassword()
               UserDefaults.standard.removeObject(forKey: "PASSW")
               UserDefaults.standard.set(self.passw, forKey: "PASSW")
               
               print("passnewww",self.passw)
               
            
            let commonAlert = UIAlertController(title:"", message: respMsg, preferredStyle:.alert)
            let okAction = UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .cancel){ (action:UIAlertAction) in
                              
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
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
    func updateGolalitaPassword(){
        let url = "https://www.golalita.com/go/api/gulfexc/change_password"
        let liveKey = "e9e6b0138afe1c861d7c9d3af96e33d3"
        let params:Parameters = [
            "params": [
                "secret_key": liveKey,
                "login": defaults.string(forKey: "resetEmail")!,
//                "login": "safeermeppayur@gmail.com",
                "new_password": self.passwordTF.text!
            ]
        ]
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("Golalita response\(response)")
            switch response.result {
            case .success:
                print("Golalita Password Updated")
                break
            case .failure(let error):
                print("Golalita Password failed to Update")
                print("Error: \(error.localizedDescription)")
            }
        })
    }
}
