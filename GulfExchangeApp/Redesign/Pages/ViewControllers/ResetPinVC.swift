//
//  ResetPinVC.swift
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

class ResetPinVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var newPinTF: UITextField!
    @IBOutlet weak var retypePinTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var newPinEyeBtn: UIButton!
    @IBOutlet weak var retypePinEyeBtn: UIButton!
    @IBOutlet weak var retypePinEyeImg: UIImageView!
    @IBOutlet weak var newPinEyeImg: UIImageView!
   
    var pinEye = false
    var rePinEye = false
    
    var timer = Timer()
    var timerGesture = UITapGestureRecognizer()
    var pin:String!
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
        retypePinTF.isSecureTextEntry = true
        newPinTF.isSecureTextEntry = true
        retypePinTF.delegate = self
        newPinTF.delegate = self
        newPinTF.keyboardType = .numberPad
        retypePinTF.keyboardType = .numberPad
        addNavbar()
        submitBtn.setTitle("", for: .normal)
        newPinEyeBtn.setTitle("", for: .normal)
        retypePinEyeBtn.setTitle("", for: .normal)
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
    override func viewWillAppear(_ animated: Bool) {
        
        ScreenShield.shared.protect(view: self.newPinTF)
        ScreenShield.shared.protect(view: self.retypePinTF)
        ScreenShield.shared.protectFromScreenRecording()
        
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        saveDetails()
    }
    @IBAction func newPinEyeBtnTapped(_ sender: Any) {
        pinEye.toggle()
        if pinEye {
            newPinTF.isSecureTextEntry = false
            newPinEyeImg.image = UIImage(named: "show pswrd")
        } else {
            newPinTF.isSecureTextEntry = true
            newPinEyeImg.image = UIImage(named: "hide pswrd")
        }
    }
    @IBAction func retypePinEyeBtnTapped(_ sender: Any) {
        rePinEye.toggle()
        if rePinEye {
            retypePinTF.isSecureTextEntry = false
            retypePinEyeImg.image = UIImage(named: "show pswrd")
        } else {
            retypePinTF.isSecureTextEntry = true
            retypePinEyeImg.image = UIImage(named: "hide pswrd")
        }
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
        self.navigationItem.title = NSLocalizedString("reset_pin", comment: "")
       
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
    
    
    func saveDetails(){
            if newPinTF.text?.isEmpty == true
            {
               // timer.invalidate()
//                self.newPinTF.layer.borderColor = UIColor.red.cgColor
//                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
//                    if #available(iOS 13.0, *) {
//                        self.newPinTF.layer.borderColor = UIColor.systemGray4.cgColor
//                    } else {
//                        // Fallback on earlier versions
//                    }
//
//                }
            }
            else
            {
            
//                if #available(iOS 13.0, *) {
//                    self.newPinTF.layer.borderColor = UIColor.systemGray4.cgColor
//                } else {
//                    // Fallback on earlier versions
//                }
            }

            
            guard let newPin = newPinTF.text, newPinTF.text?.count != 0 else {
                
                self.view.makeToast(NSLocalizedString("type_new_pin", comment: ""), duration: 3.0, position: .center)
                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("type_new_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(newPin.count != 4)
            {
                self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .center)
                
//                self.newPinTF.layer.borderColor = UIColor.red.cgColor
//                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
//                    if #available(iOS 13.0, *) {
//                        self.newPinTF.layer.borderColor = UIColor.systemGray4.cgColor
//                    } else {
//                        // Fallback on earlier versions
//                    }
//
//                }
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
//                if #available(iOS 13.0, *) {
//                    self.newPinTF.layer.borderColor = UIColor.systemGray4.cgColor
//                } else {
//                    // Fallback on earlier versions
//                }
            }
            
            
            //new
            if retypePinTF.text?.isEmpty == true
            {
//               // timer.invalidate()
//                self.retypePinTF.layer.borderColor = UIColor.red.cgColor
//                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
//                    if #available(iOS 13.0, *) {
//                        self.retypePinTF.layer.borderColor = UIColor.systemGray4.cgColor
//                    } else {
//                        // Fallback on earlier versions
//                    }
//
//                }
            }
            else
            {
            
//                if #available(iOS 13.0, *) {
//                    self.retypePinTF.layer.borderColor = UIColor.systemGray4.cgColor
//                } else {
//                    // Fallback on earlier versions
//                }
            }

            
            guard let retypePin = retypePinTF.text, retypePinTF.text?.count != 0 else {
                
                self.view.makeToast(NSLocalizedString("re_type_new_pin", comment: ""), duration: 3.0, position: .center)
                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("re_type_new_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(newPin.elementsEqual(retypePin))
            {
//                if #available(iOS 13.0, *) {
//                    self.retypePinTF.layer.borderColor = UIColor.systemGray4.cgColor
//                } else {
//                    // Fallback on earlier versions
//                }

            }
            else{
                self.view.makeToast(NSLocalizedString("pin_mismatch", comment: ""), duration: 3.0, position: .center)
//                self.retypePinTF.layer.borderColor = UIColor.red.cgColor
//                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
//                    if #available(iOS 13.0, *) {
//                        self.retypePinTF.layer.borderColor = UIColor.systemGray4.cgColor
//                    } else {
//                        // Fallback on earlier versions
//                    }
//
//                }

                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            resetTimer()
            
            self.getToken(num: 1)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        resetTimer()
        
        let maxLength = 4
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
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
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    
    //MARK: - API Calls
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        let encodedValue = "GulfExe:gulf".data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
        let url = ge_api_url_new + "utilityservice/resetmpin"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"userID":defaults.string(forKey: "resetUserId")!,"password":"","emailID":defaults.string(forKey: "resetEmail")!,"currentMPIN":"","newMPIN":self.newPinTF.text!]
        
        print("paramsresetmpin",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            let respMsg = myResult!["responseMessage"].stringValue
            print("resp",respCode)
            self.effectView.removeFromSuperview()
           if(respCode == "S109")
           {
               
               self.pin = self.newPinTF.text!
               UserDefaults.standard.removeObject(forKey: "PIN")
               UserDefaults.standard.set(self.pin, forKey: "PIN")
               
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
}
