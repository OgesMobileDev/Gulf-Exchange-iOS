//  RegisterSelfieVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 02/01/2025.
//  Copyright © 2025 Oges. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield

class RegisterSelfieVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var selfieLbl: UILabel!
    @IBOutlet weak var threeSecondLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    
    var referenceNo:String = ""
    var base64String:String = ""
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    var strBase64:String = ""
    var strBase641:String = ""
    var verificationType:VerificationFlow = .register
    
    var idImageFrontData: Data?
    var idImageBackData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        configureButton(button: cancelBtn, title: "Cancel", size: 16, font: .medium)
        configureButton(button: okBtn, title: "Ok", size: 16, font: .medium)
        
        titleLbl.text = NSLocalizedString("Take a selfie while holding your ID.", comment: "")
        threeSecondLbl.text = NSLocalizedString("Record a 3-second video of yourself blinking while holding your ID.", comment: "")
        
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
    
   
    
    @IBAction func okBtnTapped(_ sender: Any) {
//        redirectShuftiPro(referenceNo: referenceNo)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterVideo1VC") as! RegisterVideo1VC
        nextViewController.strBase64 = self.strBase64
        nextViewController.strBase641 = self.strBase641
        nextViewController.verificationType = self.verificationType
        nextViewController.idImageBackData = self.idImageBackData
        nextViewController.idImageFrontData = self.idImageFrontData
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
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
        if verificationType == .register{
            self.navigationItem.title = "ID Verification"
        }else{
            self.navigationItem.title = "Update Profile"
        }
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
    
    //MARK: - API calls
    
    func redirectShuftiPro(referenceNo:String){
        /*
         secret key - asyyQCtOpKUIj2LPgkmcv46n4v6L8wov
         client ID - bd9666ed913a4224a5df94a20364375cd5720553f8d3b48cf9f6c626e0a82c9a
         */
        let originalString = "bd9666ed913a4224a5df94a20364375cd5720553f8d3b48cf9f6c626e0a82c9a:asyyQCtOpKUIj2LPgkmcv46n4v6L8wov"
        if let data = originalString.data(using: .utf8) {
            let base64EncodedString = data.base64EncodedString()
            print("Base64 Encoded String: \(base64EncodedString)")
            self.base64String = base64EncodedString
        }
        if !base64String.isEmpty{
            self.getShuftiToken(referenceNo: referenceNo)
        }

    }
    
    func getShuftiToken(referenceNo:String){
        print("getShuftiToken referenceNo",referenceNo)
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = shuftiproApi + "get/access/token"
        let headers:HTTPHeaders = ["Authorization" : "Basic \(base64String )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let token:String = myresult!["access_token"].string!
                print("getShuftiToken",token)
                self.defaults.setValue(token, forKey: "shuftiToken1")
                self.defaults.setValue(referenceNo, forKey: "shuftiReference1")
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterVideo1VC") as! RegisterVideo1VC
                nextViewController.token = token
                nextViewController.referenceNo = referenceNo
                nextViewController.base64String = self.base64String
                self.navigationController?.pushViewController(nextViewController, animated: true)
               
                break
            case .failure:
                break
            }
            
            
        })
    }
}
