//
//  RegisterPasswordVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 02/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import ScreenShield

class RegisterPasswordVC: UIViewController, TermsPopupUIViewDelegate {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var passEyeImg: UIImageView!
    @IBOutlet weak var retypePassTF: UITextField!
    @IBOutlet weak var retypePassEyeImg: UIImageView!
    @IBOutlet weak var retypePassBtn: UIButton!
    
    @IBOutlet weak var pinTF: UITextField!
    @IBOutlet weak var pinEyeBtn: UIButton!
    @IBOutlet weak var pinEyeImg: UIImageView!
    
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
    @IBOutlet weak var iAgreeLbl: UILabel!
    @IBOutlet weak var agreeImg: UIImageView!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var iAgreeBtn: UIButton!
    @IBOutlet weak var createProfileBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var retypePassView: UIView!
    @IBOutlet weak var pinView: UIView!
    

    
    @IBOutlet var emptyBtns: [UIButton]!
    
    let popUpView2 = Bundle.main.loadNibNamed("TermsPopupUIView", owner: TransferPage1VC.self, options: nil)?.first as! TermsPopupUIView
   
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var temrsContent = ""
    var isTermsPopup:Bool = false
    var termsClick:Bool = false
    var passwordEye = true
    var retypePassEye = true
    var pinEye = true
    
    var str_passw:String = ""
    var str_mpin:String = ""
    
    var passCheck1 = false
    var passCheck2 = false
    var passCheck3 = false
    var passCheck4 = false
    let defaults = UserDefaults.standard
    var idImageFrontData: Data?
    var idImageBackData: Data?
    var idImageSelfieVideoData: Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        getTermsandConditions()
        passwordTF.isSecureTextEntry = true
        retypePassTF.isSecureTextEntry = true
        passwordTF.addTarget(self, action: #selector(ResetPasswordVC.textFieldDidChange(_:)), for: .editingChanged)
        pinTF.isSecureTextEntry = true
        pinTF.keyboardType = .numberPad
        self.passwordTF.delegate = self
        self.pinTF.delegate = self
        self.retypePassTF.delegate = self
        addNavbar()
        setView()
        popUpView2.delegate = self
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            passwordTF.textAlignment = .right
            retypePassTF.textAlignment = .right
            pinTF.textAlignment = .right
        } else {
            passwordTF.textAlignment = .left
            retypePassTF.textAlignment = .left
            pinTF.textAlignment = .left
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        ScreenShield.shared.protect(view: self.)
        ScreenShield.shared.protect(view: self.passwordTF)
        ScreenShield.shared.protect(view: self.retypePassTF)
        ScreenShield.shared.protect(view: self.pinTF)
        ScreenShield.shared.protectFromScreenRecording()
    }
    @IBAction func passEyeBtnTapped(_ sender: Any) {
        if passwordEye {
            passwordTF.isSecureTextEntry = false
            passEyeImg.image = UIImage(named: "show pswrd")
        } else {
            passwordTF.isSecureTextEntry = true
            passEyeImg.image = UIImage(named: "hide pswrd")
        }
        passwordEye.toggle()
    }
    @IBAction func retypePassEyeBtnTapped(_ sender: Any) {
        if retypePassEye {
            retypePassTF.isSecureTextEntry = false
            retypePassEyeImg.image = UIImage(named: "show pswrd")
        } else {
            retypePassTF.isSecureTextEntry = true
            retypePassEyeImg.image = UIImage(named: "hide pswrd")
        }
        retypePassEye.toggle()
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

    @IBAction func termsBtnTapped(_ sender: Any) {
        if !termsClick{
            popUpView2.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            popUpView2.alpha = 0.0
            if temrsContent != ""{
                popUpView2.setView(content: temrsContent)
            }else{
                popUpView2.setView(content: "")
            }
            isTermsPopup = true
            view.addSubview(popUpView2)
            UIView.animate(withDuration: 0.3, animations: {
                self.popUpView2.alpha = 1.0
            })
        }
    }
    
    @IBAction func iAgreeBtnTapped(_ sender: Any) {
        if !termsClick{
            popUpView2.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            popUpView2.alpha = 0.0
            if temrsContent != ""{
                popUpView2.setView(content: temrsContent)
            }else{
                popUpView2.setView(content: "")
            }
            isTermsPopup = true
            view.addSubview(popUpView2)
            UIView.animate(withDuration: 0.3, animations: {
                self.popUpView2.alpha = 1.0
            })
        }
    }
    
    @IBAction func createProfileBtnTapped(_ sender: Any) {
        validateFields()
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterReviewVC") as! RegisterReviewVC
//        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - popupDelegates
    func TermsPopupUIView(_ vc: TermsPopupUIView, action: Bool) {
        if action {
            isTermsPopup = false
            termsClick = true
            if #available(iOS 13.0, *) {
                agreeImg.image = UIImage(systemName: "checkmark.square.fill")
                agreeImg.tintColor = UIColor.rgba(198, 23, 30, 1)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    //MARK: - Functions
    
    func setView(){
        for btn in emptyBtns{
            btn.setTitle("", for: .normal)
        }
        configureButton(button: termsBtn, title: NSLocalizedString("terms_conditions1", comment: ""), size: 12, font: .regular)
        configureButton(button: createProfileBtn, title: NSLocalizedString("create_profile", comment: ""), size: 16, font: .medium)
        configureButton(button: cancelBtn, title: NSLocalizedString("cancel1", comment: ""), size: 16, font: .medium)
        
        subTitleLbl.text = NSLocalizedString("passwordmesssage", comment: "")
        
        passwordTF.placeholder = NSLocalizedString("NewPassword", comment: "")
        retypePassTF.placeholder = NSLocalizedString("retype_pass", comment: "")
        
        characterLbl.text = NSLocalizedString("characters", comment: "")
        upperCaseLbl.text = NSLocalizedString("uppercase", comment: "")
        lowerCaseLbl.text = NSLocalizedString("lowercase", comment: "")
        numberLbl.text = NSLocalizedString("num", comment: "")
        splCharLbl.text = NSLocalizedString("1Special Characters", comment: "")
        
        passRequireLbl.text = NSLocalizedString("Yourpasswordmustcontainatleast", comment: "")
        
        pinTF.placeholder = NSLocalizedString("Pin", comment: "")
        
        iAgreeLbl.text = NSLocalizedString("i_agree", comment: "")
        
    }
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "Set Your Password"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
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
    
    func validateFields(){
        
    //        if(secQuesBtn.titleLabel?.text == NSLocalizedString("security_question", comment: ""))
    //        {
    //            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_sec_que", comment: ""), action: NSLocalizedString("ok", comment: ""))
    //            return
    //        }
           // print("str_occupationn",str_occupation)
            
    //        var stranswer = answerTextField.text
    //        stranswer = stranswer!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    //        print(stranswer)
    //        // "this is the answer"
    //        print("stranswer",stranswer)
    //        answerTextField.text =  stranswer
    //        print("answerTextField.text",answerTextField.text)
    //
    //
    //        //extraspace remove
    //        let startingStringanswer = answerTextField.text!
    //        let processedStringanswer = startingStringanswer.removeExtraSpacesregister()
    //        print("processedStringanswer:\(processedStringanswer)")
    //        answerTextField.text = processedStringanswer
    //
    //        guard let answer = answerTextField.text,answerTextField.text?.count != 0 else
    //        {
    //            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_answer", comment: ""), action: NSLocalizedString("ok", comment: ""))
    //            return
    //        }
    //        //"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
    //        var charSetanswer = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
    //               var string2answer = answer
    //
    //               if let strvalue = string2answer.rangeOfCharacter(from: charSetanswer)
    //               {
    //                   print("true")
    //                   let alert = UIAlertController(title: "Alert", message: "Please enter valid answer", preferredStyle: UIAlertController.Style.alert)
    //                   alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
    //                   self.present(alert, animated: true, completion: nil)
    //                  // print("check name",self.fullNameEnTextField.text)
    //
    //               }
            
            
            //
            
            //new
            if passwordTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.passwordView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }
            }
            else
            {
            
                self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            guard let passw = passwordTF.text,passwordTF.text?.count != 0 else
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("enter_password", comment: ""), duration: 3.0, position: .center)
                

                return
            }
            if(passCheck1)
            {
                self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            else{
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_length", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.passwordView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }

                
                self.view.makeToast(NSLocalizedString("pass_length", comment: ""), duration: 3.0, position: .center)
                return
            }
            if(passCheck2)
            {
                self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            else{
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must1", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                self.passwordView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }

                
                self.view.makeToast(NSLocalizedString("pass_must1", comment: ""), duration: 3.0, position: .center)

                return
            }
            if(passCheck3)
            {
                self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            else{
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must2", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("pass_must2", comment: ""), duration: 3.0, position: .center)
                
                self.passwordView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }


                return
            }
            if(passCheck4)
            {
                self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            else{
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must3", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("pass_must3", comment: ""), duration: 3.0, position: .center)
                
                self.passwordView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }


                return
            }
            
            //new
            
            var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
            var string2addressspecial = passwordTF.text!

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
                    self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                               
                }
            else
            {
                //radio5specialcharbtn.setImage(UIImage(named: "radio_light"), for: .normal)
                //let alert = UIAlertController(title: "Alert", message: "Please enter one special charecter", preferredStyle: UIAlertController.Style.alert)
               // alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                //self.present(alert, animated: true, completion: nil)
                
                self.view.makeToast("Password must contain atleast one special character", duration: 3.0, position: .center)
                
                self.passwordView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.passwordView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }

    //
    //                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
            }

            
            //new
            if retypePassTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.retypePassView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                  self.retypePassView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }
            }
            else
            {
            
          self.retypePassView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            guard let retypwPassw = retypePassTF.text,retypePassTF.text?.count != 0 else
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("re_type_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("re_type_password", comment: ""), duration: 3.0, position: .center)

                return
            }
            if(!passw.elementsEqual(retypwPassw))
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("password_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.retypePassView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                  self.retypePassView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }

                
                self.view.makeToast(NSLocalizedString("password_mismatch", comment: ""), duration: 3.0, position: .center)
                return
            }
            else
            {
                self.retypePassView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

            }
            
            //new
            if pinTF.text?.isEmpty == true
            {
               // timer.invalidate()
                self.pinView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.pinView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }
            }
            else
            {
            
             
            self.pinView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            guard let pin = pinTF.text,pinTF.text?.count != 0 else
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)

                return
            }
            if(pin.count != 4)
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .center)
                
                self.pinView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.pinView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }

                return
            }
            else
            {
                 
                self.pinView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            ///
            
            var charSetpin = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
            var string2 = pin

            if let strvalue = string2.rangeOfCharacter(from: charSetpin)
            {
                print("true")


               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)

                return
            }
            if (!validate (value: self.pinTF.text!))
            {
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)

                return
                
            }

            
            if(!termsClick)
            {
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("read_terms", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                self.view.makeToast(NSLocalizedString("read_terms", comment: ""), duration: 3.0, position: .center)
                return
            }
            //self.str_q1 = secQuesBtn.titleLabel?.text as! String
           // self.str_a1 = answerTextField.text!
            self.str_passw = passwordTF.text!
            self.str_mpin = pinTF.text!
        
            defaults.set(str_passw, forKey: "passw")
            defaults.set(str_mpin, forKey: "pin")
            
           // print("str_occupationnmmmmm",str_occupation)
            //old orginal
            
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterReviewVC") as! RegisterReviewVC
        nextViewController.idImageFrontData = self.idImageFrontData
        nextViewController.idImageBackData = self.idImageBackData
        nextViewController.idImageSelfieVideoData = self.idImageSelfieVideoData
        self.navigationController?.pushViewController(nextViewController, animated: true)
     
            
            //newwww
    //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    //        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViedionewViewController") as! ViedionewViewController
    //        self.navigationController?.pushViewController(nextViewController, animated: true)
    //
    //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    //               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "reg1") as! RegisterPage1ViewController
    //               self.navigationController?.pushViewController(nextViewController, animated: true)
    //
    //
            
            //new viewdetails simulater
    //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //        let vc: REGReviewViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "REGReviewViewController") as! REGReviewViewController
    //        self.navigationController?.pushViewController(vc, animated: true)

        
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
    
    //MARK: - API Calls
    func getTermsandConditions() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "contents_listing"
        let params:Parameters = ["type":"8","lang":"en"]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["contents_listing"]
                for i in resultArray.arrayValue{
                    let content = i["contents_desc_en"].stringValue
                    self.temrsContent = content
                    
                }
              break
            case .failure:
                break
            }
          })
    }
}
extension RegisterPasswordVC: UITextFieldDelegate{
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField == passwordTF)
        {
            if(passwordTF.text!.count > 0)
            {
                let str = passwordTF.text!
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
                characterImg.image = UIImage(systemName: "circle")
                upperCaseImg.image = UIImage(systemName: "circle")
                lowerCaseIMg.image = UIImage(systemName: "circle")
                numberImg.image = UIImage(systemName: "circle")
//                numberImg.image = UIImage(named: "pass_check")
            }
            
            //new
            
            var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
            var string2addressspecial = passwordTF.text!

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
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        resetTimer()
        if textField == pinTF{
            let maxLength = 4
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
}
