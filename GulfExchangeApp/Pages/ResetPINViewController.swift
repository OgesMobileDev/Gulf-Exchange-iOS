//
//  ResetPINViewController.swift
//  GulfExchangeApp
//
//  Created by test on 24/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class ResetPINViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var newPinTextField: UITextField!
    @IBOutlet weak var retypeNewPinTextField: UITextField!
    @IBOutlet weak var saveDetailsBtn: UIButton!
    @IBOutlet weak var pinEyeBtn: UIButton!
    @IBOutlet weak var retypePinEyeBtn: UIButton!
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()
    
    var pin:String!

    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var pinEyeClick = true
    var reTypePinEyeClick = true
    
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
    
            let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //new
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

        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
           newPinTextField.textAlignment = .right
           retypeNewPinTextField.textAlignment = .right
        } else {
           newPinTextField.textAlignment = .left
           retypeNewPinTextField.textAlignment = .left
        }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("reset_pin", comment: "")
        saveDetailsBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        saveDetailsBtn.layer.cornerRadius = 15
        newPinTextField.delegate = self
        retypeNewPinTextField.delegate = self
        setFont()
        
//
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)
        
        timer.invalidate()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
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

    
    
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func saveDetailsBtn(_ sender: Any) {
        
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
            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_new_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(newPin.count != 4)
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
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString("ok", comment: ""))
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

        
        guard let retypePin = retypeNewPinTextField.text, retypeNewPinTextField.text?.count != 0 else {
            
            self.view.makeToast(NSLocalizedString("re_type_new_pin", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("re_type_new_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(newPin.elementsEqual(retypePin))
        {
            if #available(iOS 13.0, *) {
                self.retypeNewPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else{
            self.view.makeToast(NSLocalizedString("pin_mismatch", comment: ""), duration: 3.0, position: .center)
            self.retypeNewPinTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.retypeNewPinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        resetTimer()
        
        self.getToken(num: 1)
    }
    @IBAction func retypePinEyeBtn(_ sender: Any) {
        if(reTypePinEyeClick == true) {
            retypeNewPinTextField.isSecureTextEntry = false
            retypePinEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            retypeNewPinTextField.isSecureTextEntry = true
            retypePinEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        reTypePinEyeClick = !reTypePinEyeClick
    }
    @IBAction func pinEyeBtn(_ sender: Any) {
        if(pinEyeClick == true) {
            newPinTextField.isSecureTextEntry = false
            pinEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            newPinTextField.isSecureTextEntry = true
            pinEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        pinEyeClick = !pinEyeClick
    }
    func setFont() {
        newPinTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        retypeNewPinTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        saveDetailsBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        resetTimer()
        
        let maxLength = 4
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        let encodedValue = "GulfExe:gulf".data(using: .utf8)?.base64EncodedString()
        
        
        
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        ResetPINViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token  ",token)
                if(num == 1)
                {
                    self.resetPIN(access_token: token)
                }
                break
            case .failure:
                break
            }
            
        })
    }
    func resetPIN(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/resetmpin"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":defaults.string(forKey: "resetUserId")!,"password":"","emailID":defaults.string(forKey: "resetEmail")!,"currentMPIN":"","newMPIN":self.newPinTextField.text!]
        
        print("paramsresetmpin",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        ResetPINViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            let respMsg = myResult!["responseMessage"].stringValue
            print("resp",respCode)
            self.effectView.removeFromSuperview()
           if(respCode == "S109")
           {
               
               self.pin = self.newPinTextField.text!
               UserDefaults.standard.removeObject(forKey: "PIN")
               UserDefaults.standard.set(self.pin, forKey: "PIN")
               
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
}
