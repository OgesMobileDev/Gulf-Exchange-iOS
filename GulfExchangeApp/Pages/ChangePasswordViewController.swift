//
//  ChangePasswordViewController.swift
//  GulfExchangeApp
//
//  Created by test on 22/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class ChangePasswordViewController: UIViewController,UITextFieldDelegate {
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()
    
    var passw:String!
    
    
    @IBOutlet var specialcharlabel: UILabel!
    
    @IBOutlet var specialcharbtn: UIButton!
    
    
    
    @IBOutlet weak var oldPasswTextField: UITextField!
    
    @IBOutlet weak var passwReqLbl: UILabel!
    @IBOutlet weak var req1Lbl: UILabel!
    @IBOutlet weak var req2Lbl: UILabel!
    @IBOutlet weak var req3Lbl: UILabel!
    @IBOutlet weak var req4Lbl: UILabel!
    @IBOutlet weak var newPasswTextField: UITextField!
    @IBOutlet weak var retypeNewPasswTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var saveDetailsBtn: UIButton!
    
    @IBOutlet weak var radio1: UIButton!
    @IBOutlet weak var radio2: UIButton!
    @IBOutlet weak var radio3: UIButton!
    @IBOutlet weak var radio4: UIButton!
    @IBOutlet weak var oldPassEyeBtn: UIButton!
    @IBOutlet weak var newPassEyeBtn: UIButton!
    @IBOutlet weak var retypePassEyeBtn: UIButton!
    @IBOutlet weak var pinEyeBtn: UIButton!
    
    
    var passCheck1 = false
    var passCheck2 = false
    var passCheck3 = false
    var passCheck4 = false
    var udid:String!
    var oldPassEyeClick = true
    var newPassEyeClick = true
    var retypePassEyeClick = true
    var pinEyeClick = true
    let defaults = UserDefaults.standard
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
        //test
        static let AlamoFireManager: Alamofire.Session = {
            let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator(),
                                                          "ws.gulfexchange.com.qa": DisabledEvaluator()])
            let configuration = URLSessionConfiguration.af.default
            return Session(configuration: configuration, serverTrustManager: manager)
        }()
    //
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
        self.oldPasswTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.oldPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.newPasswTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.pinTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        //new
        self.emailTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.retypeNewPasswTextField.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.retypeNewPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }



        
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                      let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                      if appLang == "ar" || appLang == "ur" {
                         oldPasswTextField.textAlignment = .right
                         newPasswTextField.textAlignment = .right
                         retypeNewPasswTextField.textAlignment = .right
                         pinTextField.textAlignment = .right
                         emailTextField.textAlignment = .right
                      } else {
                         oldPasswTextField.textAlignment = .left
                         newPasswTextField.textAlignment = .left
                         retypeNewPasswTextField.textAlignment = .left
                         pinTextField.textAlignment = .left
                         emailTextField.textAlignment = .left
                      }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("change_password", comment: "")
        saveDetailsBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        saveDetailsBtn.layer.cornerRadius = 15
        setFont()
        setFontSize()
        oldPasswTextField.delegate = self
        newPasswTextField.delegate = self
        retypeNewPasswTextField.delegate = self
        pinTextField.delegate = self
        newPasswTextField.addTarget(self, action: #selector(ChangePasswordViewController.textFieldDidChange(_:)), for: .editingChanged)
        oldPasswTextField.addTarget(self, action: #selector(ChangePasswordViewController.textFieldDidChange(_:)), for: .editingChanged)
        retypeNewPasswTextField.addTarget(self, action: #selector(ChangePasswordViewController.textFieldDidChange(_:)), for: .editingChanged)
        pinTextField.addTarget(self, action: #selector(ChangePasswordViewController.textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(ChangePasswordViewController.textFieldDidChange(_:)), for: .editingChanged)


        
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
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        timer.invalidate()
        print("invalidated")
        
        if(newPasswTextField.text!.count > 0)
        {
            let str = newPasswTextField.text!
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
        var string2addressspecial = newPasswTextField.text!

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
    @IBAction func oldPassEyeBtn(_ sender: Any) {
        if(oldPassEyeClick == true) {
            oldPasswTextField.isSecureTextEntry = false
            oldPassEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            oldPasswTextField.isSecureTextEntry = true
            oldPassEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        oldPassEyeClick = !oldPassEyeClick
    }
    @IBAction func newPassEyeBtn(_ sender: Any) {
        if(newPassEyeClick == true) {
            newPasswTextField.isSecureTextEntry = false
            newPassEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            newPasswTextField.isSecureTextEntry = true
            newPassEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        newPassEyeClick = !newPassEyeClick
    }
    @IBAction func retypePassEyeBtn(_ sender: Any) {
        if(retypePassEyeClick == true) {
            retypeNewPasswTextField.isSecureTextEntry = false
            retypePassEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            retypeNewPasswTextField.isSecureTextEntry = true
            retypePassEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        retypePassEyeClick = !retypePassEyeClick
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
        
        //new
        if oldPasswTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.oldPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.oldPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.oldPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }

        
        guard let oldPassw = oldPasswTextField.text, oldPasswTextField.text?.count != 0 else {
            self.view.makeToast(NSLocalizedString("type_old_password", comment: ""), duration: 3.0, position: .center)
            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_old_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(oldPassw != self.defaults.string(forKey: "PASSW")!)
        {
            
            self.view.makeToast(NSLocalizedString("check_password", comment: ""), duration: 3.0, position: .center)
            
            self.oldPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.oldPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }


            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("check_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.oldPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        
        //new
        if newPasswTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.newPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }

        
        guard let newPassw = newPasswTextField.text, newPasswTextField.text?.count != 0 else {
            
            self.view.makeToast(NSLocalizedString("type_new_password", comment: ""), duration: 3.0, position: .center)

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_new_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck1)
        {
            if #available(iOS 13.0, *) {
                self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else{
            self.view.makeToast(NSLocalizedString("pass_length", comment: ""), duration: 3.0, position: .center)
            
            self.newPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
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
                self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else{
            self.view.makeToast(NSLocalizedString("pass_must1", comment: ""), duration: 3.0, position: .center)
            
            self.newPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must1", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck3)
        {
            if #available(iOS 13.0, *) {
                self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else{
            self.view.makeToast(NSLocalizedString("pass_must2", comment: ""), duration: 3.0, position: .center)

            self.newPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
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
                self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else{
            self.view.makeToast(NSLocalizedString("pass_must3", comment: ""), duration: 3.0, position: .center)
            
            self.newPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must3", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        //new
        
        var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
        var string2addressspecial = newPasswTextField.text!

            if let strvalue = string2addressspecial.rangeOfCharacter(from: charSetaddressspecial)
            {
                print("true")
                
                if #available(iOS 13.0, *) {
                    self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

//                //radio5specialcharbtn.setImage(UIImage(named: "radio_green"), for: .normal)
//
//                let alert = UIAlertController(title: "Alert", message: "Please enter one special charecter", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                        //print("check name",self.workAddressTextField.text)
////
////                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                        return
                           
            }
        else
        {
            //radio5specialcharbtn.setImage(UIImage(named: "radio_light"), for: .normal)
            //let alert = UIAlertController(title: "Alert", message: "Please enter one special charecter", preferredStyle: UIAlertController.Style.alert)
           // alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //self.present(alert, animated: true, completion: nil)
                   
            
            self.view.makeToast("Password must contain atleast one special character", duration: 3.0, position: .center)
            
            self.newPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.newPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
            //self.view.makeToast(NSLocalizedString("pass_must3", comment: ""), duration: 3.0, position: .center)
//
                        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Password must contain atleaste one special character", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
        }

        //new
        if retypeNewPasswTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.retypeNewPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.retypeNewPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
        
            if #available(iOS 13.0, *) {
                self.retypeNewPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }
        }

        
        guard let retypeNewPassw = retypeNewPasswTextField.text, retypeNewPasswTextField.text?.count != 0 else {
            
            self.view.makeToast(NSLocalizedString("re_type_new_password", comment: ""), duration: 3.0, position: .center)

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("re_type_new_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(newPassw.elementsEqual(retypeNewPassw))
        {
            if #available(iOS 13.0, *) {
                self.retypeNewPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else
        {
            self.view.makeToast(NSLocalizedString("password_mismatch", comment: ""), duration: 3.0, position: .center)
            
            self.retypeNewPasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.retypeNewPasswTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("password_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
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

        
        guard let pin = pinTextField.text, pinTextField.text?.count != 0 else
        {
            self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)

            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(pin.count < 4)
        {
            self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .center)
            
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
        if(pin != self.defaults.string(forKey: "PIN")!)
        {
            self.view.makeToast(NSLocalizedString("current_pin_invalid", comment: ""), duration: 3.0, position: .center)
            
            self.pinTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.pinTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("current_pin_invalid", comment: ""), action: NSLocalizedString("ok", comment: ""))
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

        
        guard let email = emailTextField.text, emailTextField.text?.count != 0 else
        {
            self.view.makeToast(NSLocalizedString("enter_email", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        let validateEmail = isValidEmail(email)
        if(validateEmail)
        {
            if #available(iOS 13.0, *) {
                self.emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        else
        {
            self.view.makeToast(NSLocalizedString("enter_valid_email", comment: ""), duration: 3.0, position: .center)
            
            self.emailTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        self.getToken(num: 1)
    }
    func setFont() {
        oldPasswTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        passwReqLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        req1Lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        req2Lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        req3Lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        req4Lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        newPasswTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        retypeNewPasswTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        pinTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        emailTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        saveDetailsBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        passwReqLbl.font = passwReqLbl.font.withSize(14)
        req1Lbl.font = req1Lbl.font.withSize(13)
        req2Lbl.font = req2Lbl.font.withSize(13)
        req3Lbl.font = req3Lbl.font.withSize(13)
        req4Lbl.font = req4Lbl.font.withSize(13)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == oldPasswTextField)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == newPasswTextField)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == retypeNewPasswTextField)
        {
            let maxLength = 16
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
    func getToken(num:Int) {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        ChangePasswordViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                if(num == 1)
                {
                    self.validatePassword(access_token: token)
                }
                else if(num == 2)
                {
                    self.validateEmail(access_token: token)
                }
                else if(num == 3)
                {
                    self.changePassword(access_token: token)
                }
                break
            case .failure:
                break
            }
        })
    }
    func validatePassword(access_token:String) {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":self.defaults.string(forKey: "USERID")!,"customerPassword":self.oldPasswTextField.text!,"mpin":"","customerEmail":"","customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMERID_PASSWORD","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        ChangePasswordViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(responseCode == "S9006")
            {
                self.getToken(num: 2)
            }
            else{
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("check_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
        })
    }
    func validateEmail(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":self.defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":self.emailTextField.text!,"customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMERID_EMAIL","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        ChangePasswordViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(responseCode == "S9002")
            {
                self.getToken(num: 3)
            }
            else{
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("check_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
        })
    }
    func changePassword(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/forgotpassword"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":self.defaults.string(forKey: "USERID")!,"currentPassword":self.oldPasswTextField.text!,"newPassword":self.newPasswTextField.text!,"emailID":self.emailTextField.text!]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        ChangePasswordViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(responseCode == "S109")
            {
                self.passw = self.newPasswTextField.text!
                UserDefaults.standard.removeObject(forKey: "PASSW")
                UserDefaults.standard.set(self.passw, forKey: "PASSW")
                
                self.timer.invalidate()
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                self.defaults.set(self.newPasswTextField.text!, forKey: "PASSW")
                self.oldPasswTextField.text = ""
                self.newPasswTextField.text = ""
                self.retypeNewPasswTextField.text = ""
                self.pinTextField.text = ""
                self.emailTextField.text = ""
                self.passCheck1 = false
                self.radio1.setImage(UIImage(named: "radio_light"), for: .normal)
                self.passCheck2 = false
                self.radio2.setImage(UIImage(named: "radio_light"), for: .normal)
                self.passCheck3 = false
                self.radio3.setImage(UIImage(named: "radio_light"), for: .normal)
                self.passCheck4 = false
                self.radio4.setImage(UIImage(named: "radio_light"), for: .normal)
                self.specialcharbtn.setImage(UIImage(named: "radio_light"), for: .normal)
            }
            else{
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                self.timer.invalidate()
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
}
