//
//  IDVerificationBaseVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 02/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield
enum VerificationFlow{
    case register
    case update
}
class IDVerificationBaseVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    
    @IBOutlet weak var idBgView: UIView!
    @IBOutlet weak var frontLbl: UILabel!
    @IBOutlet weak var backLbl: UILabel!
    @IBOutlet weak var frontBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var frontCheckImg: UIImageView!
    @IBOutlet weak var frontCheckLbl: UILabel!
    @IBOutlet weak var backCheckImg: UIImageView!
    @IBOutlet weak var backCheckLbl: UILabel!
    @IBOutlet weak var proceedBtn: UIButton!
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    var base64String:String = ""
    var verificationType:VerificationFlow = .register
    //test
    static let AlamoFireManager: Alamofire.Session = {
        let serverTrustPolicies: [String: ServerTrustEvaluating] = [
            "https://api.shuftipro.com/get/access/token": DisabledTrustEvaluator(), // Disable strict evaluation for this domain
            "https://78.100.141.203:8181/gecomobileapi/": DisabledTrustEvaluator(), // Disable strict evaluation for this domain
            "https://78.100.141.203:7171/gecomobileapicasmex": DisabledTrustEvaluator() // Disable strict evaluation for this domain
        ]
        
        let serverTrustManager = ServerTrustManager(evaluators: serverTrustPolicies)
        let manager = ServerTrustManager(evaluators: [
            "78.100.141.203": DisabledTrustEvaluator(),
            "ws.gulfexchange.com.qa": DisabledTrustEvaluator(),
            "api.shuftipro.com": DisabledTrustEvaluator(),
            "ns.shuftipro.com": DisabledTrustEvaluator(),
            "gulfexchange.com.qa": DisabledTrustEvaluator()
        ])
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 360 // Wait up to 3 minutes
        configuration.timeoutIntervalForResource = 360 // Resource timeout (same as request)
        
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
//    production
//                  static let AlamoFireManager: Alamofire.Session = {
//                //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
//                        let configuration = URLSessionConfiguration.af.default
//                        return Session(configuration: configuration)
//                //        return Session(configuration: configuration, serverTrustManager: manager)
//                    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        setView()
        frontBtn.setTitle("", for: .normal)
        backBtn.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        let udid = UIDevice.current.identifierForVendor!.uuidString
        if verificationType == .update{
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
        }
        ScreenShield.shared.protectFromScreenRecording()
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
    @IBAction func frontBtnTapped(_ sender: Any) {
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        
    }
    @IBAction func proceedBtnTapped(_ sender: Any) {
        //        getToken(num: 1)
        //        getToken()
        
        //original
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterImage1VC") as! RegisterImage1VC
        nextViewController.verificationType = self.verificationType
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //                    let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        //                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails2VC") as! RegisterIdDetails2VC
        //                    self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
        //        let isRegisteredCust =  defaults.string(forKey: "neworexistcuststr") ?? ""
        //        if isRegisteredCust == "B"{
        //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        //            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetailsOld1VC") as! RegisterIdDetailsOld1VC
        //            self.navigationController?.pushViewController(nextViewController, animated: true)
        //
        //        }else if isRegisteredCust == "N"{
        //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        //            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails1VC") as! RegisterIdDetails1VC
        //            self.navigationController?.pushViewController(nextViewController, animated: true)
        //        }
        
        
        //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        //        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterPasswordVC") as! RegisterPasswordVC
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    
    
    
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        
        if verificationType == .register{
            self.navigationItem.title = "Registration"
        }else{
            self.navigationItem.title = "Update Profile"
        }
        
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func setView(){
        // api shufti
        //        configureButton(button: proceedBtn, title: "Proceed", size: 16, font: .medium)
        // web shufti
        configureButton(button: proceedBtn, title:  NSLocalizedString("Scan ID", comment: ""), size: 16, font: .medium)
        // subtitleLbl.text = "Please click 'Scan ID' to scan your ID card."
        
        backCheckLbl.text = NSLocalizedString("The back of the card was scanned successfully.", comment: "")
        frontCheckLbl.text = NSLocalizedString("The front of the card was scanned successfully.", comment: "")
        
        subtitleLbl.text = NSLocalizedString("Please scan both sides of your Id card", comment: "")
        
        titleLbl.text = NSLocalizedString("Scan Your ID", comment: "")
        
        
        frontCheckImg.isHidden = true
        frontCheckLbl.isHidden = true
        backCheckImg.isHidden = true
        backCheckLbl.isHidden = true
        idBgView.isHidden = true
        defaults.removeObject(forKey: "id_type")
        defaults.removeObject(forKey: "id_issuer")
        defaults.removeObject(forKey: "id_no")
        defaults.removeObject(forKey: "id_exp_date")
        defaults.removeObject(forKey: "name_en")
        defaults.removeObject(forKey: "name_ar")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "dob")
        defaults.removeObject(forKey: "nationality")
        defaults.removeObject(forKey: "dualNationality")
        defaults.removeObject(forKey: "country")
        defaults.removeObject(forKey: "municipality")
        defaults.removeObject(forKey: "zone")
        defaults.removeObject(forKey: "home_addr")
        defaults.removeObject(forKey: "gender")
        defaults.removeObject(forKey: "mobile")
        defaults.removeObject(forKey: "employer")
        defaults.removeObject(forKey: "income")
        defaults.removeObject(forKey: "work_addr")
        defaults.removeObject(forKey: "occupation")
        defaults.removeObject(forKey: "str_actualoccupation")
        defaults.removeObject(forKey: "str_buildingno")
        defaults.removeObject(forKey: "reg_code")
        defaults.removeObject(forKey: "passw")
        defaults.removeObject(forKey: "pin")
        defaults.removeObject(forKey: "strBase641")
        defaults.removeObject(forKey: "backimage")
        defaults.removeObject(forKey: "strBase64")
        defaults.removeObject(forKey: "frontimage")
        defaults.removeObject(forKey: "strBase64video")
        
    }
}
