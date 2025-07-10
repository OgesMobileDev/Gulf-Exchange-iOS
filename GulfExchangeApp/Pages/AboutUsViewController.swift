//
//  AboutUsViewController.swift
//  GulfExchangeApp
//
//  Created by test on 25/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AboutUsViewController: UIViewController {
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var aboutTitle: UILabel!
    @IBOutlet weak var aboutContent: UITextView!
    @IBOutlet weak var aboutTitleView: UIView!
    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var msgTitleView: UIView!
    @IBOutlet weak var msgTitle: UILabel!
    @IBOutlet weak var msgContent: UITextView!
    @IBOutlet weak var missionBtn: UIButton!
    @IBOutlet weak var missionView: UIView!
    @IBOutlet weak var missionContent: UITextView!
    @IBOutlet weak var visionView: UIView!
    @IBOutlet weak var visionContent: UITextView!
    @IBOutlet weak var valuesView: UIView!
    @IBOutlet weak var valuesContent: UITextView!
    @IBOutlet weak var teamBtn: UIButton!
    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var amlBtn: UIButton!
    @IBOutlet weak var amlView: UIView!
    @IBOutlet weak var amlContent: UITextView!
    @IBOutlet weak var top1: NSLayoutConstraint!
    @IBOutlet weak var top2: NSLayoutConstraint!
    var udid:String!
    
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()
   
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("about_us_title", comment: "")
        
        top1.constant = 0
        top2.constant = 0
        aboutContent.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "about_us", comment: "")
        msgContent.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "message_from_ge", comment: "")
        adjustUITextViewHeight(arg: aboutContent)
        adjustUITextViewHeight(arg: msgContent)
        missionContent.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "mission_ge", comment: "")
        adjustUITextViewHeight(arg: missionContent)
        visionContent.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "vision_ge", comment: "")
        adjustUITextViewHeight(arg: visionContent)
        valuesContent.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "values_ge", comment: "")
        adjustUITextViewHeight(arg: valuesContent)
        amlContent.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "compliance", comment: "")
        adjustUITextViewHeight(arg: amlContent)
        
        
        
        //        //new logout
//        timer = Timer.scheduledTimer(timeInterval: 1*60, target: self, selector: #selector(HomeViewController.doStuff), userInfo: nil, repeats: true)
//        timerGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.resetTimer));
//                self.view.isUserInteractionEnabled = true
//                self.view.addGestureRecognizer(timerGesture)

        
//        timer.invalidate()

        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        //resetTimer()
        //timer.invalidate()
        //timer.fire()

    }
    
    @objc func doStuff() {
        // perform any action you wish to
        print("User inactive for more than 10 seconds .")
        
        timer.invalidate()
        
        self.defaults.set("", forKey: "USERID")
        self.defaults.set("", forKey: "PASSW")
        self.defaults.set("", forKey: "PIN")
        self.defaults.set("", forKey: "REGNO")

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
                self.navigationController?.pushViewController(nextViewController, animated: true)
        
        //callLogoutinactivestate()
        
       
     }
//     @objc func resetTimer() {
//        timer.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 1*60, target: self, selector: #selector(HomeViewController.doStuff), userInfo: nil, repeats: true)
//     }
    
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
    
//    @objc func resetTimer() {
//       timer.invalidate()
//       timer = Timer.scheduledTimer(timeInterval: 1*60, target: self, selector: #selector(HomeViewController.doStuff), userInfo: nil, repeats: true)
//    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        self.validateMultipleLogin()
        
        //timer.invalidate()
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
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
//        arg.isScrollEnabled = false
    }
    @IBAction func aboutBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            if self.aboutContent.isHidden{
                self.animateAbout(toogle: true)
            }
            else{
                self.animateAbout(toogle: false)
            }
        }
    }
    @IBAction func msgBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            if self.msgTitleView.isHidden{
                self.animateMessage(toogle: true)
            }
            else{
                self.animateMessage(toogle: false)
            }
        }
    }
    @IBAction func missionBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            if self.missionView.isHidden{
                self.animateMission(toogle: true)
            }
            else{
                self.animateMission(toogle: false)
            }
            if self.visionView.isHidden{
                self.animateVision(toogle: true)
            }
            else{
                self.animateVision(toogle: false)
            }
            if self.valuesView.isHidden{
                self.animateValues(toogle: true)
            }
            else{
                self.animateValues(toogle: false)
            }
        }
    }
    @IBAction func teamBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            if self.teamView.isHidden{
                self.animateTeam(toogle: true)
            }
            else{
                self.animateTeam(toogle: false)
            }
        }
    }
    @IBAction func amlBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            if self.amlView.isHidden{
                self.animateAml(toogle: true)
            }
            else{
                self.animateAml(toogle: false)
            }
        }
    }
    func animateAbout(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.aboutTitleView.isHidden = false
                self.aboutContent.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.aboutTitleView.isHidden = true
                self.aboutContent.isHidden = true
            }
        }
    }
    func animateAml(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.amlView.isHidden = false
                self.amlContent.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.amlView.isHidden = true
                self.amlContent.isHidden = true
            }
        }
    }
    
    func animateMessage(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.msgTitleView.isHidden = false
                self.msgContent.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.msgTitleView.isHidden = true
                self.msgContent.isHidden = true
            }
        }
    }
    
    
    func animateMission(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.missionView.isHidden = false
                self.missionContent.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.missionView.isHidden = true
                self.missionContent.isHidden = true
            }
        }
    }
    
    func animateVision(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.visionView.isHidden = false
                self.visionContent.isHidden = false
                self.top1.constant = 8
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.visionView.isHidden = true
                self.visionContent.isHidden = true
                self.top1.constant = 0
            }
        }
    }
    func animateValues(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.valuesView.isHidden = false
                self.valuesContent.isHidden = false
                self.top2.constant = 8
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.valuesView.isHidden = true
                self.valuesContent.isHidden = true
                self.top2.constant = 0
            }
        }
    }
    func animateTeam(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.teamView.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.teamView.isHidden = true
            }
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

}
