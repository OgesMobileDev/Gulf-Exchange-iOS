//
//  SettingsViewController.swift
//  GulfExchangeApp
//
//  Created by test on 23/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SettingsViewController: UIViewController {
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()

    
    
    @IBOutlet var biometriclabel: UILabel!
    
    
    @IBOutlet var sampleswitch: UISwitch!
    
    @IBOutlet weak var changeEmailBtn: UIButton!
    @IBOutlet weak var changepinBtn: UIButton!
    @IBOutlet weak var changePasswBtn: UIButton!
    @IBOutlet weak var changeSeqQusBtn: UIButton!
    @IBOutlet weak var changeMobileBtn: UIButton!
    @IBOutlet weak var changeLanguageBtn: UIButton!
    
    @IBOutlet weak var changeEmailLbl: UILabel!
    @IBOutlet weak var changePinLbl: UILabel!
    @IBOutlet weak var changePasswLbl: UILabel!
    @IBOutlet weak var changeSecQusLbl: UILabel!
    @IBOutlet weak var changeMobileLbl: UILabel!
    @IBOutlet weak var changeLanguageLbl: UILabel!
    var udid:String!
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    
    
    
    @IBAction func switchAction(_ sender: Any) 
    {
       
        if sampleswitch.isOn {
             print("ON")
            
            self.defaults.set("biometricenabled", forKey: "biometricenabled")
         }
         else {
             print ("OFF")
            
            UserDefaults.standard.removeObject(forKey: "biometricenabled")
         }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.biometriclabel.text = (NSLocalizedString("enablebiometric", comment: ""))
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
        {
            sampleswitch.isOn = true
            
        }
        
    else
        {
            sampleswitch.isOn = false
        }
        
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("settings", comment: "")
        setFont()
        setFontSize()
        
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

    @objc func heplVCAction(){
        
        timer.invalidate()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func changeEmailBtn(_ sender: Any) {
        
        timer.invalidate()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "changeEmail") as! ChangeEmailViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func changepinBtn(_ sender: Any) {
        
        timer.invalidate()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "changePin") as! ChangePINViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func changePasswBtn(_ sender: Any) {
        timer.invalidate()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "changePassw") as! ChangePasswordViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func changeSecQusBtn(_ sender: Any) {
        timer.invalidate()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "sec") as! ChangeSecurityQuestionViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func changeMobileBtn(_ sender: Any) {
        timer.invalidate()
        
        alertMessage(title: NSLocalizedString("", comment: ""), msg: "You are not allowed to change the registered Mobile No. Please visit GE Branch.", action: NSLocalizedString("ok", comment: ""))
        return
            
            
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "changeMobile") as! ChangeMobileNumberViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func changeLanguageBtn(_ sender: Any) {
        timer.invalidate()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Lang") as! SelectLanguageViewController
        nextViewController.isFromSettings = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    
    
    func setFont()  {
        changeEmailLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        changePinLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        changePasswLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        changeSecQusLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        changeMobileLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        changeLanguageLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
    }
    
    
    
    func setFontSize() {
        changeEmailLbl.font = changeEmailLbl.font.withSize(14)
        changePinLbl.font = changePinLbl.font.withSize(14)
        changePasswLbl.font = changePasswLbl.font.withSize(14)
        changeSecQusLbl.font = changeSecQusLbl.font.withSize(14)
        changeMobileLbl.font = changeMobileLbl.font.withSize(14)
        changeLanguageLbl.font = changeLanguageLbl.font.withSize(14)
    }
    
}
