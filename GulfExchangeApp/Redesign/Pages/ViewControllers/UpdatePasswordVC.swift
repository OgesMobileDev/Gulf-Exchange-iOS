//
//  UpdatePasswordVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 11/12/2024.
//  Copyright © 2024 Oges. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import ScreenShield

class UpdatePasswordVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    @IBOutlet weak var currentPassLbl: UILabel!
    @IBOutlet weak var currentPassTF: UITextField!
    @IBOutlet weak var currentPassEyeBtn: UIButton!
    @IBOutlet weak var currentPassEyeImg: UIImageView!
    
    @IBOutlet weak var newPassLbl: UILabel!
    @IBOutlet weak var newPassTF: UITextField!
    @IBOutlet weak var newPassEyeBtn: UIButton!
    @IBOutlet weak var newPassEyeImg: UIImageView!
    
    @IBOutlet weak var confirmPassLbl: UILabel!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var confirmPassEyeBtn: UIButton!
    @IBOutlet weak var confirmPassEyeImg: UIImageView!
    
    @IBOutlet weak var pinLbl: UILabel!
    @IBOutlet weak var pinTF: UITextField!
    @IBOutlet weak var pinEyeBtn: UIButton!
    @IBOutlet weak var pinEyeImg: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var upperCaseImg: UIImageView!
    @IBOutlet weak var lowerCaseIMg: UIImageView!
    @IBOutlet weak var numberImg: UIImageView!
    @IBOutlet weak var splCharImg: UIImageView!
    @IBOutlet weak var passRequireLbl: UILabel!
    
    @IBOutlet weak var characterLbl: UILabel!
    @IBOutlet weak var upperCaseLbl: UILabel!
    @IBOutlet weak var lowerCaseLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var splCharLbl: UILabel!
    
    @IBOutlet weak var currentPassView: UIView!
    @IBOutlet weak var newPassView: UIView!
    @IBOutlet weak var confirmPassView: UIView!
    @IBOutlet weak var pinView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet var emptyBtns: [UIButton]!
    
    var currentPassEye = true
    var newPassEye = true
    var confirmPassEye = true
    var pinEye = true
    var passCheck1 = false
    var passCheck2 = false
    var passCheck3 = false
    var passCheck4 = false
    var udid:String!
    let defaults = UserDefaults.standard
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var timer = Timer()
    var timerGesture = UITapGestureRecognizer()
    var passw:String!
    
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
        addNavbar()
        setView()
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                      let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                      if appLang == "ar" || appLang == "ur" {
                         currentPassTF.textAlignment = .right
                         newPassTF.textAlignment = .right
                         confirmPassTF.textAlignment = .right
                         pinTF.textAlignment = .right
                         emailTF.textAlignment = .right
                      } else {
                          currentPassTF.textAlignment = .left
                          newPassTF.textAlignment = .left
                          confirmPassTF.textAlignment = .left
                          pinTF.textAlignment = .left
                          emailTF.textAlignment = .left
                      }
        currentPassTF.delegate = self
        newPassTF.delegate = self
        confirmPassTF.delegate = self
        pinTF.delegate = self
//        currentPassTF.addTarget(self, action: #selector(UpdatePasswordVC.textFieldDidChange(_:)), for: .editingChanged)
        newPassTF.addTarget(self, action: #selector(UpdatePasswordVC.textFieldDidChange(_:)), for: .editingChanged)
        confirmPassTF.addTarget(self, action: #selector(UpdatePasswordVC.textFieldDidChange(_:)), for: .editingChanged)
//        pinTF.addTarget(self, action: #selector(UpdatePasswordVC.textFieldDidChange(_:)), for: .editingChanged)
//        emailTF.addTarget(self, action: #selector(UpdatePasswordVC.textFieldDidChange(_:)), for: .editingChanged)
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)
        
        
        setTxtToSpeech()
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
        ScreenShield.shared.protect(view: self.currentPassTF)
        ScreenShield.shared.protect(view: self.newPassTF)
        ScreenShield.shared.protect(view: self.confirmPassTF)
        ScreenShield.shared.protect(view: self.pinTF)
        ScreenShield.shared.protect(view: self.emailTF)
        ScreenShield.shared.protect(view: self.currentPassLbl)
        ScreenShield.shared.protect(view: self.newPassLbl)
        ScreenShield.shared.protect(view: self.confirmPassLbl)
        ScreenShield.shared.protect(view: self.pinLbl)
        ScreenShield.shared.protect(view: self.emailLbl)
        ScreenShield.shared.protectFromScreenRecording()
        self.udid = UIDevice.current.identifierForVendor!.uuidString
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(currentpasswordblTapped(_:)))
        currentPassLbl.isUserInteractionEnabled = true
        currentPassLbl.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(newpasswordLblTapped(_:)))
        newPassLbl.isUserInteractionEnabled = true
        newPassLbl.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(confirmpasswordlLblTapped(_:)))
        confirmPassLbl.isUserInteractionEnabled = true
        confirmPassLbl.addGestureRecognizer(tapGesture2)
        
        
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(pinLblTapped(_:)))
        pinLbl.isUserInteractionEnabled = true
        pinLbl.addGestureRecognizer(tapGesture3)
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(emailLblTapped(_:)))
        emailLbl.isUserInteractionEnabled = true
        emailLbl.addGestureRecognizer(tapGesture4)
    }
    
    @objc func currentpasswordblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("current password", languageCode: "en")
            }
        }
    }
    @objc func newpasswordLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("new password", languageCode: "en")
            }
        }
        
    }
    
    @objc func confirmpasswordlLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("confirm password", languageCode: "en")
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
    
    @objc func emailLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("email", languageCode: "en")
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
    @IBAction func submitBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("Save details", languageCode: "en")
        }
        
        self.validateFields()
    }
    @IBAction func currentPassEyeBtnTapped(_ sender: Any) {
        if currentPassEye {
            currentPassTF.isSecureTextEntry = false
            currentPassEyeImg.image = UIImage(named: "show pswrd")
        } else {
            currentPassTF.isSecureTextEntry = true
            currentPassEyeImg.image = UIImage(named: "hide pswrd")
        }
        currentPassEye.toggle()
    }
    @IBAction func newPassEyeBtnTapped(_ sender: Any) {
        if newPassEye {
            newPassTF.isSecureTextEntry = false
            newPassEyeImg.image = UIImage(named: "show pswrd")
        } else {
            newPassTF.isSecureTextEntry = true
            newPassEyeImg.image = UIImage(named: "hide pswrd")
        }
        newPassEye.toggle()
    }
    @IBAction func confirmPassEyeBtnTapped(_ sender: Any) {
        if confirmPassEye {
            confirmPassTF.isSecureTextEntry = false
            confirmPassEyeImg.image = UIImage(named: "show pswrd")
        } else {
            confirmPassTF.isSecureTextEntry = true
            confirmPassEyeImg.image = UIImage(named: "hide pswrd")
        }
        confirmPassEye.toggle()
    }
    @IBAction func pinEyeBtnTapped(_ sender: Any) {
        if pinEye {
            pinTF.isSecureTextEntry = false
            pinEyeImg.image = UIImage(named: "show pswrd")
        } else {
            pinTF.isSecureTextEntry = true
            pinEyeImg.image = UIImage(named: "hide pswrd")
        }
        pinEye.toggle()
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
        self.navigationItem.title = NSLocalizedString("change_password", comment: "")
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
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
    func setView(){
        currentPassTF.isSecureTextEntry = true
        newPassTF.isSecureTextEntry = true
        confirmPassTF.isSecureTextEntry = true
        pinTF.isSecureTextEntry = true
        
        currentPassLbl.text = NSLocalizedString("CurrentPassword", comment: "")
        newPassLbl.text = NSLocalizedString("NewPassword", comment: "")
        confirmPassLbl.text = NSLocalizedString("ConfirmPassword", comment: "")
        pinLbl.text = NSLocalizedString("Pin", comment: "")
        emailLbl.text = NSLocalizedString("Email", comment: "")
        
        characterLbl.text = NSLocalizedString("characters", comment: "")
        upperCaseLbl.text = NSLocalizedString("uppercase", comment: "")
        lowerCaseLbl.text = NSLocalizedString("lowercase", comment: "")
        numberLbl.text = NSLocalizedString("num", comment: "")
        splCharLbl.text = NSLocalizedString("1Special Characters", comment: "")
        
        
        
        pinTF.placeholder = NSLocalizedString("enter_pin", comment: "")
        emailTF.placeholder = NSLocalizedString("enter_email", comment: "")
        
        newPassTF.placeholder = NSLocalizedString("enternewpassword", comment: "")
        confirmPassTF.placeholder = NSLocalizedString("confirmnewpassword", comment: "")
        currentPassTF.placeholder = NSLocalizedString("Entercurrentpassword", comment: "")
        
        passRequireLbl.text = NSLocalizedString("Yourpasswordmustcontainatleast", comment: "")
        titleLbl.text = NSLocalizedString("SetaNewPassword", comment: "")
        subTitleLbl.text = NSLocalizedString("Create a new password ensure it differ", comment: "")
        
        
        configureButton(button: submitBtn, title: NSLocalizedString("save_details", comment: ""), size: 16, font: .medium)
        for btn in emptyBtns{
            btn.setTitle("", for: .normal)
        }
        submitBtn.layer.cornerRadius = 5
        //new
        self.currentPassView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.currentPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.newPassView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
        self.emailView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.emailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }
        
        //new
        self.confirmPassView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.confirmPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }

        
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        timer.invalidate()
        print("invalidated")
       
        if(newPassTF.text!.count > 0)
        {
            let str = newPassTF.text!
            if(str.count >= 8)
            {
                self.passCheck1 = true
                characterImg.image = UIImage(named: "pass_check")
            }
            else{
                self.passCheck1 = false
                characterImg.image = UIImage(systemName: "circle")
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
                upperCaseImg.image = UIImage(named: "pass_check")
            }
            else{
                self.passCheck2 = false
                upperCaseImg.image = UIImage(systemName: "circle")
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
                lowerCaseIMg.image = UIImage(named: "pass_check")
            }
            else{
                self.passCheck3 = false
                lowerCaseIMg.image = UIImage(systemName: "circle")
            }
            
            if (str.contains("1") || str.contains("2") || str.contains("3") || str.contains("4") || str.contains("5") || str.contains("6") || str.contains("7") || str.contains("8") ||
                str.contains("9") ||
                str.contains("0"))
            {
                self.passCheck4 = true
                numberImg.image = UIImage(named: "pass_check")
            }
            else{
                self.passCheck4 = false
                numberImg.image = UIImage(systemName: "circle")
            }
            
            
        }
        else{
            characterImg.backgroundColor = UIColor.rgba(198, 23, 30, 1)
            
            characterImg.image = UIImage(systemName: "circle")
            upperCaseImg.image = UIImage(systemName: "circle")
            lowerCaseIMg.image = UIImage(systemName: "circle")
            numberImg.image = UIImage(systemName: "circle")
        }
        
        //new
        
        var charSetaddressspecial = CharacterSet.init(charactersIn: "!@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
        var string2addressspecial = newPassTF.text!

            if let strvalue = string2addressspecial.rangeOfCharacter(from: charSetaddressspecial)
            {
                print("true")
                splCharImg.image = UIImage(named: "pass_check")
                
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
            splCharImg.image = UIImage(systemName: "circle")
        }
        
       

    }
    
    func validateFields(){
        
            
            //new
            if currentPassTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.currentPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.currentPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.currentPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let oldPassw = currentPassTF.text, currentPassTF.text?.count != 0 else {
                self.view.makeToast(NSLocalizedString("type_old_password", comment: ""), duration: 3.0, position: .center)
                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_old_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(oldPassw != self.defaults.string(forKey: "PASSW")!)
            {
                
                self.view.makeToast(NSLocalizedString("check_password", comment: ""), duration: 3.0, position: .center)
                
                self.currentPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.currentPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
                    self.currentPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
            //new
            if newPassTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.newPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.currentPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let newPassw = newPassTF.text, newPassTF.text?.count != 0 else {
                
                self.view.makeToast(NSLocalizedString("type_new_password", comment: ""), duration: 3.0, position: .center)

                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_new_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(passCheck1)
            {
                if #available(iOS 13.0, *) {
                    self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else{
                self.view.makeToast(NSLocalizedString("pass_length", comment: ""), duration: 3.0, position: .center)
                
                self.newPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
                    self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else{
                self.view.makeToast(NSLocalizedString("pass_must1", comment: ""), duration: 3.0, position: .center)
                
                self.newPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
                    self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else{
                self.view.makeToast(NSLocalizedString("pass_must2", comment: ""), duration: 3.0, position: .center)

                self.newPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
                    self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else{
                self.view.makeToast(NSLocalizedString("pass_must3", comment: ""), duration: 3.0, position: .center)
                
                self.newPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must3", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            //new
            
            var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
            var string2addressspecial = newPassTF.text!

                if let strvalue = string2addressspecial.rangeOfCharacter(from: charSetaddressspecial)
                {
                    print("true")
                    
                    if #available(iOS 13.0, *) {
                        self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
                
                self.newPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.newPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
            if confirmPassTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.confirmPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.confirmPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.confirmPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let retypeNewPassw = confirmPassTF.text, confirmPassTF.text?.count != 0 else {
                
                self.view.makeToast(NSLocalizedString("re_type_new_password", comment: ""), duration: 3.0, position: .center)

                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("re_type_new_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(newPassw.elementsEqual(retypeNewPassw))
            {
                if #available(iOS 13.0, *) {
                    self.confirmPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else
            {
                self.view.makeToast(NSLocalizedString("password_mismatch", comment: ""), duration: 3.0, position: .center)
                
                self.confirmPassView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.confirmPassView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("password_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
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

            
            guard let pin = pinTF.text, pinTF.text?.count != 0 else
            {
                self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)

                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(pin.count < 4)
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


                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
            if(pin != self.defaults.string(forKey: "PIN")!)
            {
                self.view.makeToast(NSLocalizedString("current_pin_invalid", comment: ""), duration: 3.0, position: .center)
                
                self.pinView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.pinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
                    self.pinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            //new
            if emailTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.emailView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.emailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.emailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
            guard let email = emailTF.text, emailTF.text?.count != 0 else
            {
                self.view.makeToast(NSLocalizedString("enter_email", comment: ""), duration: 3.0, position: .center)
                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            let validateEmail = isValidEmail(email)
            if(validateEmail)
            {
                if #available(iOS 13.0, *) {
                    self.emailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            else
            {
                self.view.makeToast(NSLocalizedString("enter_valid_email", comment: ""), duration: 3.0, position: .center)
                
                self.emailView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.emailView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }

                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            self.getToken(num: 1)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == currentPassTF)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == newPassTF)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == confirmPassTF)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == pinTF)
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
    func alertMessageAction(title: String, msg: String, action: String, onAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { _ in
            onAction?() // Call the closure when the action button is pressed
        }))
        self.present(alert, animated: true)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: - API Calls
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
        let url = ge_api_url_new + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":self.defaults.string(forKey: "USERID")!,"customerPassword":self.currentPassTF.text!,"mpin":"","customerEmail":"","customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMERID_PASSWORD","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
        let url = ge_api_url_new + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":self.defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":self.emailTF.text!,"customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"CUSTOMERID_EMAIL","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
        let url = ge_api_url_new + "utilityservice/forgotpassword"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":self.defaults.string(forKey: "USERID")!,
                                  "currentPassword":self.currentPassTF.text!,
                                  "newPassword":self.newPassTF.text!,
                                  "emailID":self.emailTF.text!]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(responseCode == "S109")
            {
                self.passw = self.newPassTF.text!
                self.updateGolalitaPassword()
                UserDefaults.standard.removeObject(forKey: "PASSW")
                UserDefaults.standard.set(self.passw, forKey: "PASSW")
                
                self.timer.invalidate()
                let respMsg = myResult!["responseMessage"].stringValue
                self.defaults.set(self.newPassTF.text!, forKey: "PASSW")
                self.currentPassTF.text = ""
                self.newPassTF.text = ""
                self.confirmPassTF.text = ""
                self.pinTF.text = ""
                self.emailTF.text = ""
                self.passCheck1 = false
                self.characterImg.image = UIImage(systemName: "circle")
                self.passCheck2 = false
                self.upperCaseImg.image = UIImage(systemName: "circle")
                self.passCheck3 = false
                self.lowerCaseIMg.image = UIImage(systemName: "circle")
                self.passCheck4 = false
                self.numberImg.image = UIImage(systemName: "circle")
                self.splCharImg.image = UIImage(systemName: "circle")
                self.alertMessageAction(
                    title:  NSLocalizedString("gulf_exchange", comment: ""),
                    msg: respMsg,
                    action: NSLocalizedString("ok", comment: ""),
                    onAction: {
                        self.navigationController?.popViewController(animated: true)
                    }
                )
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
    func updateGolalitaPassword(){
        let url = "https://www.golalita.com/go/api/gulfexc/change_password"
        let liveKey = "e9e6b0138afe1c861d7c9d3af96e33d3"
        let params:Parameters = [
            "params": [
                "secret_key": liveKey,
                "login": self.emailTF.text!,
                "new_password": self.newPassTF.text!
            ]
        ]
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
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
