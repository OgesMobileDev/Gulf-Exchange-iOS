//
//  UpdateEmailVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 12/12/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import ScreenShield


class UpdateEmailVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    @IBOutlet weak var currentEmailLbl: UILabel!
    @IBOutlet weak var currentEmailView: UIView!
    @IBOutlet weak var currentEmailTF: UITextField!
    
    @IBOutlet weak var newEmailLbl: UILabel!
    @IBOutlet weak var newEmailView: UIView!
    @IBOutlet weak var newEmailTF: UITextField!
    
    @IBOutlet weak var confirmEmailLbl: UILabel!
    @IBOutlet weak var confirmEmailView: UIView!
    @IBOutlet weak var confirmEmailTF: UITextField!
    
    @IBOutlet weak var pinLbl: UILabel!
    @IBOutlet weak var pinView: UIView!
    @IBOutlet weak var pinTF: UITextField!
    
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var pinEyeBtn: UIButton!
    @IBOutlet weak var pinEyeImg: UIImageView!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var passEyeImg: UIImageView!
    @IBOutlet var emptyBtns: [UIButton]!
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var pinEyeClick = true
    var passwEyeClick = true
    
    var strOldEmail:String!
    var strNewEmail:String!
    var accessToken:String = ""
    var strPassw:String!
    let defaults = UserDefaults.standard
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        setView()
        addNavbar()
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
               let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               if appLang == "ar" || appLang == "ur" {
                   currentEmailTF.textAlignment = .right
                   newEmailTF.textAlignment = .right
                   confirmEmailTF.textAlignment = .right
                   pinTF.textAlignment = .right
                   passwordTF.textAlignment = .right
               } else {
                   currentEmailTF.textAlignment = .left
                   newEmailTF.textAlignment = .left
                   confirmEmailTF.textAlignment = .left
                   pinTF.textAlignment = .left
                   passwordTF.textAlignment = .left
               }
        
        pinTF.delegate = self
        passwordTF.delegate = self
        
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        setTxtToSpeech()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.shared.fetchToken { token in
            if let token = token {
                // Call login session update
                APIManager.shared.updateSession(sessionType: "1", accessToken: token) { responseCode in
                    if responseCode == "S222" {
                        print("Session Valid")
                    } else {
                        self.handleSessionError()
                    }
                }
            } else {
                print("Failed to fetch token")
            }
        }
        ScreenShield.shared.protect(view: self.currentEmailTF)
        ScreenShield.shared.protect(view: self.newEmailTF)
        ScreenShield.shared.protect(view: self.confirmEmailTF)
        ScreenShield.shared.protect(view: self.pinTF)
        ScreenShield.shared.protect(view: self.passwordTF)
        ScreenShield.shared.protect(view: self.currentEmailLbl)
        ScreenShield.shared.protect(view: self.newEmailLbl)
        ScreenShield.shared.protect(view: self.confirmEmailLbl)
        ScreenShield.shared.protect(view: self.pinLbl)
        ScreenShield.shared.protect(view: self.passwordLbl)
        ScreenShield.shared.protectFromScreenRecording()
        self.udid = UIDevice.current.identifierForVendor!.uuidString
    }
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(currentemailLblTapped(_:)))
        currentEmailLbl.isUserInteractionEnabled = true
        currentEmailLbl.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(newemailLblTapped(_:)))
        newEmailLbl.isUserInteractionEnabled = true
        newEmailLbl.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(confirmnewemailLblTapped(_:)))
        confirmEmailLbl.isUserInteractionEnabled = true
        confirmEmailLbl.addGestureRecognizer(tapGesture2)
        
        
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(pinLblTapped(_:)))
        pinLbl.isUserInteractionEnabled = true
        pinLbl.addGestureRecognizer(tapGesture3)
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(passwordLblTapped(_:)))
        passwordLbl.isUserInteractionEnabled = true
        passwordLbl.addGestureRecognizer(tapGesture4)
    }
    
    @objc func currentemailLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("current email", languageCode: "en")
            }
        }
    }
    @objc func newemailLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("new email", languageCode: "en")
            }
        }
        
    }
    
    @objc func confirmnewemailLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("confirm new email", languageCode: "en")
            }
        }
        
    }
    
    @objc func pinLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("pin", languageCode: "en")
            }
        }
        
    }
    
    @objc func passwordLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("password", languageCode: "en")
            }
        }
        
    }
    
    
    
    func handleSessionError() {
        //        if !defaults.string(forKey: "biometricenabled") == "biometricenabled"{
        //
        //        }
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
        self.defaults.set("logoutbiometrc", forKey: "logoutbiometrc")
                UserDefaults.standard.set(false, forKey: "isLoggedIN")
        //        UserDefaults.standard.removeObject(forKey: "biometricenabled")
                
                if let navigationController = self.navigationController {
                    for controller in navigationController.viewControllers {
                        if let tabController = controller as? MainLoginViewController {
                            navigationController.popToViewController(tabController, animated: true)
                            return
                        }
                    }
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
    }
    
    
    @IBAction func pinEyeBtnTapped(_ sender: Any) {
        if pinEyeClick {
            pinTF.isSecureTextEntry = false
            pinEyeImg.image = UIImage(named: "show pswrd")
        } else {
            pinTF.isSecureTextEntry = true
            pinEyeImg.image = UIImage(named: "hide pswrd")
        }
        pinEyeClick.toggle()
    }
    @IBAction func passEyeBtnTapped(_ sender: Any) {
        if passwEyeClick {
            passwordTF.isSecureTextEntry = false
            passEyeImg.image = UIImage(named: "show pswrd")
        } else {
            passwordTF.isSecureTextEntry = true
            passEyeImg.image = UIImage(named: "hide pswrd")
        }
        passwEyeClick.toggle()
    }
    @IBAction func submitBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("save details", languageCode: "en")
        }
        
        self.validateFields()
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
        self.navigationItem.title = NSLocalizedString("change_email", comment: "")
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setView(){
        pinTF.isSecureTextEntry = true
        passwordTF.isSecureTextEntry = true
        
//        currentEmailTF.placeholder = NSLocalizedString(<#T##key: String##String#>, comment: "")
//        currentEmailLbl.text = NSLocalizedString(<#T##key: String##String#>, comment: "")
        
        currentEmailTF.placeholder = "Current Email"
        currentEmailLbl.text = "Current Email"
        confirmEmailTF.placeholder = "Confirm New Email"
        confirmEmailLbl.text = "Confirm New Email"
        newEmailTF.placeholder = "New Email"
        newEmailLbl.text = "New Email"
        
        
        self.pinLbl.text = (NSLocalizedString("pin", comment: ""))
        pinTF.placeholder = (NSLocalizedString("pin", comment: ""))
        
        self.passwordLbl.text = (NSLocalizedString("pass_cap", comment: ""))
        passwordTF.placeholder = (NSLocalizedString("pass_cap", comment: ""))
        
        self.currentEmailLbl.text = (NSLocalizedString("CurrentEmail", comment: ""))
        currentEmailTF.placeholder = (NSLocalizedString("CurrentEmail", comment: ""))
        
        self.newEmailLbl.text = (NSLocalizedString("NewEmail", comment: ""))
        newEmailTF.placeholder = (NSLocalizedString("NewEmail", comment: ""))
        
        self.confirmEmailLbl.text = (NSLocalizedString("ConfirmNewEmail", comment: ""))
        confirmEmailTF.placeholder = (NSLocalizedString("ConfirmNewEmail", comment: ""))
        
        self.titleLbl.text = (NSLocalizedString("Set a New Email", comment: ""))
        self.subTitleLbl.text = (NSLocalizedString("Create a new Email ensure it differs from previous ones for security", comment: ""))
        
        
        configureButton(button: submitBtn, title: NSLocalizedString("save_details", comment: ""), size: 16, font: .medium)
        for btn in emptyBtns{
            btn.setTitle("", for: .normal)
        }
        
        self.currentEmailView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.currentEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.newEmailView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.newEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.confirmEmailView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.confirmEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.pinView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.pinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.passwordView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.passwordView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }
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
        let nextViewController  = UIStoryboard(name: "Main10", bundle:nil).instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
                self.navigationController?.pushViewController(nextViewController, animated: true)


        return
        
     }

    @objc func resetTimer() {
        print("Reset")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }
    
    func validateFields(){
        
            
            
            //new
            if currentEmailTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.currentEmailView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.currentEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.currentEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let oldEmail = currentEmailTF.text,currentEmailTF.text?.count != 0 else
            {
                self.view.makeToast(NSLocalizedString("type_old_email", comment: ""), duration: 3.0, position: .center)

               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_old_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            let validateOldEmail = isValidEmail(oldEmail)
            
            if validateOldEmail
            {
                if #available(iOS 13.0, *) {
                    self.currentEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

                
            }
            else{
                self.view.makeToast(NSLocalizedString("enter_valid_email", comment: ""), duration: 3.0, position: .center)
                
                self.currentEmailView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.currentEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            //new
            if newEmailTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.newEmailView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.newEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.newEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let newEmail = newEmailTF.text,newEmailTF.text?.count != 0 else
            {
                self.view.makeToast(NSLocalizedString("type_new_email", comment: ""), duration: 3.0, position: .center)
                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_new_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            let validateNewEmail = isValidEmail(newEmail)
            if validateNewEmail
            {
                if #available(iOS 13.0, *) {
                    self.newEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else{
                self.view.makeToast(NSLocalizedString("enter_valid_email", comment: ""), duration: 3.0, position: .center)

                self.newEmailView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.newEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
              //  alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            //new
            if newEmailTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.confirmEmailView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.confirmEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                        } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.confirmEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let retypeEmail = newEmailTF.text,newEmailTF.text?.count != 0 else
            {
                self.view.makeToast(NSLocalizedString("re_type_new_email", comment: ""), duration: 3.0, position: .center)
                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("re_type_new_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            let validateretypeEmail = isValidEmail(retypeEmail)
            if validateretypeEmail
            {
                if #available(iOS 13.0, *) {
                    self.confirmEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else{
                self.view.makeToast(NSLocalizedString("enter_valid_email", comment: ""), duration: 3.0, position: .center)
                
                self.confirmEmailView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.confirmEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if newEmail.elementsEqual(retypeEmail)
            {
                if #available(iOS 13.0, *) {
                    self.confirmEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else
            {
                self.view.makeToast(NSLocalizedString("email_mismatch", comment: ""), duration: 3.0, position: .center)
                
                self.confirmEmailView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.confirmEmailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("email_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            //new
            if pinTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.pinView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.pinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.pinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let pin = pinTF.text,pinTF.text?.count != 0 else
            {
                self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)

                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            if(pinTF.text?.count != 4)
            {
                self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .center)
                
                self.pinView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.pinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

                //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString(
                    //"ok", comment: ""))
                return
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.pinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
            if(pin != defaults.string(forKey: "PIN")!)
            {
                self.view.makeToast(NSLocalizedString("pin_not_valid", comment: ""), duration: 3.0, position: .center)
                
                self.pinView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.pinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }


               // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_not_valid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.pinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
            
            //new
            if passwordTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.passwordView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.passwordView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.passwordView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let passw = passwordTF.text,passwordTF.text?.count != 0 else
            {
                self.view.makeToast(NSLocalizedString("enter_password", comment: ""), duration: 3.0, position: .center)
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(passw != defaults.string(forKey: "PASSW")!)
            {
                self.view.makeToast(NSLocalizedString("password_not_valid", comment: ""), duration: 3.0, position: .center)

                self.passwordView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.passwordView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("password_not_valid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.passwordView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
            
            strOldEmail = oldEmail
            strNewEmail = newEmail
            strPassw = passw
            getToken()
            
        
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == pinTF)
        {
            let maxLength = 4
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == passwordTF)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return Bool()
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
    
    //MARK: API Calls
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
                self.accessToken = token
                self.validateCurrentEmail(oldEmail: self.strOldEmail)
                break
            case .failure:
                break
            }
        })
    }
    
    func validateCurrentEmail(oldEmail:String) {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        print("old email",oldEmail)
        print("token5",accessToken)
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":oldEmail,"customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMERID_EMAIL","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            if(respCode == "S9002")
            {
                self.validateNewEmailExisting()
            }
            else{
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("check_current_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
        
        })
    }
    
    func validateNewEmailExisting() {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":strNewEmail,"customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMERID_EMAIL","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            if(respCode == "S9002")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("new_email_existing", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
            else{
                self.changeEmail()
            }
        
        })
    }
    
    func changeEmail() {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/resetemail"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":defaults.string(forKey: "USERID")!,"password":strPassw,"currentEmail":strOldEmail,"newEmail":strNewEmail]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            
            if(respCode == "S111")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("email_reset_success", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.currentEmailTF.text = ""
                self.newEmailTF.text = ""
                self.confirmEmailTF.text = ""
                self.pinTF.text = ""
                self.passwordTF.text = ""
                
            }
            else{
                let respMsg:String = myResult!["responseMessage"].string!
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: "Ok")
            }
        
        })
    }
    
  
    
}
