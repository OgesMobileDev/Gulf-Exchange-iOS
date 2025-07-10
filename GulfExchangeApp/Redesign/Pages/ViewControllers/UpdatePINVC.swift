//
//  UpdatePasswordVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 08/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import ScreenShield


class UpdatePINVC: UIViewController, UITextFieldDelegate, OTPViewDelegate {
    
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var currentPinLbl: UILabel!
    @IBOutlet weak var currentPinTF: UITextField!
    @IBOutlet weak var currentPinEyeBtn: UIButton!
    @IBOutlet weak var currentEyeImg: UIImageView!
    @IBOutlet weak var newPinLbl: UILabel!
    @IBOutlet weak var newPinTF: UITextField!
    @IBOutlet weak var newPinEyeBtn: UIButton!
    @IBOutlet weak var newEyeImg: UIImageView!
    @IBOutlet weak var confirmPinLbl: UILabel!
    @IBOutlet weak var confirmPinTF: UITextField!
    @IBOutlet weak var confirmPinEyeBtn: UIButton!
    @IBOutlet weak var confirmEyeImg: UIImageView!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var currentPinView: UIView!
    @IBOutlet weak var newPinView: UIView!
    @IBOutlet weak var confirmPinView: UIView!
    @IBOutlet weak var otpBgView: UIView!
    @IBOutlet weak var otpBaseView: UIView!

    var currentEyeClick:Bool = false
    var newEyeClick:Bool = false
    var confirmEyeClick:Bool = false
    var isOtpPopup:Bool = false
    
    var timer = Timer()
    var timerGesture = UITapGestureRecognizer()
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var udid:String!
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
    
    let popUpOtpView = Bundle.main.loadNibNamed("OTPView", owner: UpdatePINVC.self, options: nil)?.first as! OTPView
    
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
                  currentPinTF.textAlignment = .right
                  newPinTF.textAlignment = .right
                  confirmPinTF.textAlignment = .right
               } else {
                   currentPinTF.textAlignment = .left
                   newPinTF.textAlignment = .left
                   confirmPinTF.textAlignment = .left
               }
        popUpOtpView.delegate = self
        currentPinTF.delegate = self
        newPinTF.delegate = self
        confirmPinTF.delegate = self
//        otpTextField.delegate = self
        
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
//        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
//            self.view.isUserInteractionEnabled = true
//            self.view.addGestureRecognizer(timerGesture)
        
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
        ScreenShield.shared.protect(view: self.currentPinView)
        ScreenShield.shared.protect(view: self.confirmPinView)
        ScreenShield.shared.protect(view: self.newPinView)
        ScreenShield.shared.protect(view: self.currentPinLbl)
        ScreenShield.shared.protect(view: self.confirmPinLbl)
        ScreenShield.shared.protect(view: self.newPinLbl)
//        ScreenShield.shared.protect(view: otpBaseView)
        ScreenShield.shared.protect(view: self.titleLbl)
        ScreenShield.shared.protect(view: self.subTitleLbl)
//        ScreenShield.shared.protect(view: self.submitBtn)
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(currentpinblTapped(_:)))
        currentPinLbl.isUserInteractionEnabled = true
        currentPinLbl.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(newpinLblTapped(_:)))
        newPinLbl.isUserInteractionEnabled = true
        newPinLbl.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(confirmpinlLblTapped(_:)))
        confirmPinLbl.isUserInteractionEnabled = true
        confirmPinLbl.addGestureRecognizer(tapGesture2)
        
        
        
      
    }
    
    @objc func currentpinblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("current pin", languageCode: "en")
            }
        }
    }
    @objc func newpinLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("new pin", languageCode: "en")
            }
        }
        
    }
    
    @objc func confirmpinlLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("confirm pin", languageCode: "en")
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
    
    
    @IBAction func currentPinEyeBtnTapped(_ sender: Any) {
        currentEyeClick.toggle()
        if currentEyeClick {
            currentPinTF.isSecureTextEntry = false
            currentEyeImg.image = UIImage(named: "show pswrd")
        } else {
            currentPinTF.isSecureTextEntry = true
            currentEyeImg.image = UIImage(named: "hide pswrd")
        }
        
        
    }
    @IBAction func newPinEyeBtnTapped(_ sender: Any) {
        newEyeClick.toggle()
        if newEyeClick {
            newPinTF.isSecureTextEntry = false
            newEyeImg.image = UIImage(named: "show pswrd")
        } else {
            newPinTF.isSecureTextEntry = true
            newEyeImg.image = UIImage(named: "hide pswrd")
        }

       
    }
    @IBAction func confirmPinEyeBtnTapped(_ sender: Any) {
        
        confirmEyeClick.toggle()
        
        if confirmEyeClick {
            confirmPinTF.isSecureTextEntry = false
            confirmEyeImg.image = UIImage(named: "show pswrd")
        } else {
            confirmPinTF.isSecureTextEntry = true
            confirmEyeImg.image = UIImage(named: "hide pswrd")
        }

       
    }
    @IBAction func submitBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("save details", languageCode: "en")
        }
        validateFields()
    }
    
    //MARK: OTP Functions
    func showOtpView(){
        popUpOtpView.resetView()
        
        otpBgView.isHidden = false
        otpBaseView.isHidden = false
        otpBgView.alpha = 0.0
        otpBaseView.alpha = 0.0
        popUpOtpView.mobNum = ""
        isOtpPopup = true
        popUpOtpView.frame = otpBaseView.bounds
        popUpOtpView.setView()
        popUpOtpView.closeBtn.isHidden = true
        popUpOtpView.closeImg.isHidden = true
        popUpOtpView.alpha = 0.0
        otpBaseView.addSubview(popUpOtpView)
        UIView.animate(withDuration: 0.3,  delay: 0, options: [.curveEaseOut]) {
            self.otpBgView.alpha = 1.0
            self.otpBaseView.alpha = 1.0
            self.popUpOtpView.alpha = 1.0
        }
    }
    func removeOtpView(){
        popUpOtpView.alpha = 1.0
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
            self.popUpOtpView.alpha = 0.0
            self.otpBgView.alpha = 0.0
            self.otpBaseView.alpha = 0.0
        } completion: { _ in
            self.popUpOtpView.resetView()
            self.popUpOtpView.removeFromSuperview()
            self.isOtpPopup = false
            self.otpBgView.isHidden = true
            self.otpBaseView.isHidden = true
        }
    }
    func OTPView(_ vc: OTPView, otp: String) {
        print("OTP - \(otp)")
        self.strOtp = otp
        self.getToken(num: 3)
    }
    
    func OTPView(_ vc: OTPView, resend: Bool) {
        if resend{
//            self.removeOtpView()
            self.getToken(num: 4)
        }
    }
    func OTPView(_ vc: OTPView, close: Bool) {
        if close{
            removeOtpView()
        }
    }
    //MARK: Functions
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        resetTimer()
        
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
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("change_pin", comment: "")
        
    }
    @objc func customBackButtonTapped() {
        if isOtpPopup{
            self.removeOtpView()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    func setView(){
        otpBgView.isHidden = true
        otpBaseView.isHidden = true
        currentPinEyeBtn.setTitle("", for: .normal)
        newPinEyeBtn.setTitle("", for: .normal)
        confirmPinEyeBtn.setTitle("", for: .normal)
        let attributedTitle = buttonTitleSetWithColor(title:"Save Details", size: 16, font: .medium, color: UIColor.white)
       // submitBtn.setAttributedTitle(attributedTitle, for: .normal)
        submitBtn.layer.cornerRadius = 5
        currentPinTF.isSecureTextEntry = true
        newPinTF.isSecureTextEntry = true
        confirmPinTF.isSecureTextEntry = true
        
        self.titleLbl.text = "Set a New PIN"
//        (NSLocalizedString("send_money", comment: ""))
        self.currentPinLbl.text = (NSLocalizedString("CurrentPin", comment: ""))
        self.newPinLbl.text = (NSLocalizedString("new_pin", comment: ""))
        self.confirmPinLbl.text = (NSLocalizedString("ConfirmPin", comment: ""))
        currentPinTF.placeholder = (NSLocalizedString("CurrentPin", comment: ""))
        newPinTF.placeholder = (NSLocalizedString("new_pin", comment: ""))
        confirmPinTF.placeholder = (NSLocalizedString("ConfirmPin", comment: ""))
        
        self.subTitleLbl.text = (NSLocalizedString("Create a new PIN ensure it differs from previous ones for security", comment: ""))
        self.titleLbl.text = (NSLocalizedString("SetaNewPIN", comment: ""))
        
        self.submitBtn.isEnabled = true
        self.submitBtn.setTitle(NSLocalizedString("SaveDetails", comment: ""), for: .normal)
        self.submitBtn.setTitle(NSLocalizedString("SaveDetails", comment: ""), for: .highlighted)
        print(NSLocalizedString("SaveDetails", comment: ""))
        

        //new
        self.currentPinView.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.currentPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.newPinView.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.newPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.confirmPinView.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.confirmPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
            if currentPinTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.currentPinView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.currentPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.currentPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
                guard let oldPin = currentPinTF.text, currentPinTF.text?.count != 0 else {
                    
                    self.view.makeToast(NSLocalizedString("type_old_pin", comment: ""), duration: 3.0, position: .center)
                    
                    //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_old_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                if(currentPinTF.text?.count != 4)
                {
                    
                    self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .center)
                    
                    self.currentPinView.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        if #available(iOS 13.0, *) {
                            self.currentPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
                    self.currentPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
            if(oldPin != self.defaults.string(forKey: "PIN")!)
            {
                self.view.makeToast(NSLocalizedString("pin_not_valid", comment: ""), duration: 3.0, position: .center)
                
                self.currentPinView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.currentPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
                    self.currentPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
            
            //new
            if newPinTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.newPinView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.newPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.newPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
                guard let newPin = newPinTF.text, newPinTF.text?.count != 0 else {
                    
                    self.view.makeToast(NSLocalizedString("type_new_pin", comment: ""), duration: 3.0, position: .center)

                    
                    //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_new_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                if(newPinTF.text?.count != 4)
                {
                    self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .center)

                    self.newPinView.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        if #available(iOS 13.0, *) {
                            self.newPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
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
                    self.newPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
            
            
            //new
            if confirmPinTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.confirmPinView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.confirmPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                if #available(iOS 13.0, *) {
                    self.confirmPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
                guard let retypePin = confirmPinTF.text, confirmPinTF.text?.count != 0 else
                {
                    self.view.makeToast(NSLocalizedString("retype_new_pin", comment: ""), duration: 3.0, position: .center)

                    
                    //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("retype_new_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                if(newPin != retypePin)
                {
                    self.view.makeToast(NSLocalizedString("pin_mismatch", comment: ""), duration: 3.0, position: .center)
                    
                    self.confirmPinView.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        if #available(iOS 13.0, *) {
                            self.confirmPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                        } else {
                            // Fallback on earlier versions
                        }

                    }


                    
                   // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
            else
            {
                if #available(iOS 13.0, *) {
                    self.confirmPinView.layer.borderColor = UIColor.rgba(203, 203, 203, 1).cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
                self.strOldPin = oldPin
                self.strNewPin = newPin
            self.getToken(num: 1)
        
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
                print("num",num)
                if(num == 1)
                {
                    self.getEmailId(access_token: token)
                }
                else if(num == 2)
                {
                    self.changePIN(access_token: token)
                }
                else if(num == 3)
                {
                    self.validateOTP(access_token: token)
                }
                else if(num == 4)
                {
                    self.getOTP(access_token: token)
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
        let url = ge_api_url_new + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":strOldPin]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(responseCode == "S104")
            {
                self.email = myResult!["email"].string!
                print(self.email)
                self.mobile = myResult!["customerMobile"].string!
                self.getOTP(access_token: access_token)
                
            }
            else{
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("error_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
            
        })
    }
    func getOTP(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/generateOtp"
        let params:Parameters = ["idNo":defaults.string(forKey: "USERID")!,"email":self.email,"type":"2","mobileNo":self.mobile]
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
                    if !self.isOtpPopup{
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
    /*func resendOTP(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/generateOtp"
        let params:Parameters = ["idNo":defaults.string(forKey: "USERID")!,"email":self.email,"type":"1","mobileNo":self.mobile]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("getresp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["responseCode"]
                if(respCode == "200")
                {
                    self.showOtpView()
                }
                else{
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("something_went_wrong_try_again", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                break
            case .failure:
                break
            }
          })
    }*/
    func validateOTP(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/verifyOtp"
        let params:Parameters = ["idNo":defaults.string(forKey: "USERID")!,"email":self.email,"type":"2","otpNo":self.strOtp,"mobileNo":self.mobile]
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
                    self.removeOtpView()
                    self.getToken(num: 2)
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
    func changePIN(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/resetmpin"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"currentMPIN":strOldPin,"newMPIN":strNewPin]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(responseCode == "S109")
            {
                self.timer.invalidate()
                
                
                self.pin = self.newPinTF.text!
                UserDefaults.standard.removeObject(forKey: "PIN")
                UserDefaults.standard.set(self.pin, forKey: "PIN")

                
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_reset_success", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.defaults.set(self.newPinTF.text, forKey: "PIN")
                self.currentPinTF.text = ""
                self.newPinTF.text = ""
                self.confirmPinTF.text = ""
//                self.otpTextField.text = ""
//                self.otpView.isHidden = true
//                self.resendOtpBtn.isHidden = true
//                self.img.isHidden = true
//                self.sendOtpBtn.isHidden = false
//                self.saveDetailsBtn.isHidden = true
                
                
            }
            else{
                
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                self.timer.invalidate()
//                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("error_in_otp_sent", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
            
        })
    }
}
