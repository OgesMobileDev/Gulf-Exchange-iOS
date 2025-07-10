//
//  RegisterLoadingVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 28/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import SwiftyJSON
import ScreenShield

class RegisterLoadingVC: UIViewController {
    
    @IBOutlet weak var animationBaseView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var failedBaseView: UIView!
    @IBOutlet weak var failedPopView: UIView!
    @IBOutlet weak var failedAnimationView: UIView!
    @IBOutlet weak var failedTitleLbl: UILabel!
    @IBOutlet weak var failedDescLbl: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    
    let defaults = UserDefaults.standard
    var base64String:String = ""
    var token:String = ""
    var referenceNo:String = ""
    
    // extracted data
    var reference:String = ""
    var proof:String = ""
    var additionalProof:String = ""
    var faceProof:String = ""
    var accessToken:String = ""
    var verificationVideo:String = ""
    var verificationReport:String = ""
    var fullName:String = ""
    var dob:String = ""
    var expiryDate:String = ""
    var documentNumber:String = ""
    var fullNameNative:String = ""
    var nationality:String = ""
    var nationalityCode:String = ""
    
    var strBase64:String = ""
    var strBase641:String = ""
    var strBase64Selfie:String = ""
    var verificationType:VerificationFlow = .register
    var idImageFrontData: Data?
    var idImageBackData: Data?
    var idImageSelfieVideoData: Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.isHidden = true
        checkData()
        addNavbar()
        setView()
        configureButton(button: okBtn, title: "OK", size: 16, font: .medium)
        getToken()
        animationBaseView.clipsToBounds = true
        startLottieAnimation()
        startTimedSequence()
//        noshufti() // change in live
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
    
    
    func noshufti(){
        self.defaults.removeObject(forKey: "shufti_reference")
        self.defaults.removeObject(forKey: "shufti_photo1")
        self.defaults.removeObject(forKey: "shufti_photo2")
        self.defaults.removeObject(forKey: "shufti_access_token")
        self.defaults.removeObject(forKey: "shufti_video")
        self.defaults.removeObject(forKey: "shufti_verification_report")
        self.defaults.removeObject(forKey: "name_en")
        self.defaults.removeObject(forKey: "shufti_dob")
        self.defaults.removeObject(forKey: "dob")
        self.defaults.removeObject(forKey: "shufti_id_exp_date")
        self.defaults.removeObject(forKey: "id_exp_date")
        self.defaults.removeObject(forKey: "id_no")
        self.defaults.removeObject(forKey: "name_ar")
        self.defaults.removeObject(forKey: "shufti_nationality")
        self.defaults.removeObject(forKey: "shufti_update_nationality")
        self.defaults.removeObject(forKey: "shufti_update_dob")
        self.defaults.removeObject(forKey: "shufti_update_name_en")
        self.defaults.removeObject(forKey: "shufti_update_name_ar")
        self.defaults.removeObject(forKey: "shufti_update_id_exp_date")
        self.defaults.removeObject(forKey: "shufti_update_id_no")
        if verificationType == .register {
            navigate()
        }else{
            navigateProfile()
        }
       
    }
    @IBAction func continueBtnTapped(_ sender: Any) {
    }
    @IBAction func okBtnTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is MainLoginViewController {
                    self.navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
        }else{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "ID Verification"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func checkData(){
        if strBase64.isEmpty || strBase64 == ""{
            self.strBase64 = defaults.string(forKey: "strBase64") ?? ""
        }
        if strBase641.isEmpty || strBase641 == ""{
            self.strBase641 = defaults.string(forKey: "strBase641") ?? ""
        }
        if strBase64Selfie.isEmpty || strBase64Selfie == ""{
            self.strBase64Selfie = defaults.string(forKey: "strBase64video") ?? ""
        }
        
        if strBase64.isEmpty || strBase64 == ""{
            print("strBase64 empty")
        }
        if strBase641.isEmpty || strBase641 == ""{
            print("strBase641 empty")
        }
        if strBase64Selfie.isEmpty || strBase64Selfie == ""{
            print("strBase64video empty")
        }
    }
    func setView(){
        failedBaseView.isHidden = true
        label1.isHidden = true
        image1.isHidden = true
        label2.isHidden = true
        image2.isHidden = true
        label2.alpha = 0.0
        image2.alpha = 0.0
        label1.alpha = 0.0
        image1.alpha = 0.0
        label2.isHidden = false
        image2.isHidden = false
        label1.isHidden = false
        image1.isHidden = false
        
    }
    func showFailedView(resp:String){
        startLottieAnimation2()
        animationBaseView.isHidden = true
        label1.isHidden = true
        image1.isHidden = true
        label2.isHidden = true
        image2.isHidden = true
        failedBaseView.alpha = 0.0
        failedBaseView.isHidden = false
        if resp == "" || resp == nil{
            failedDescLbl.text = "Error fetching data\n Please try again."
        }else{
            failedDescLbl.text = resp
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.failedBaseView.alpha = 1.0
        })
    }
    func startLottieAnimation(){
        // Create a Lottie animation view
        animationBaseView.isHidden = false
        let width = animationBaseView.frame.width - 60
        let animationView = LottieAnimationView(name: "RegisterLoading")
        // Set the frame or constraints
        animationView.frame = animationBaseView.bounds
        //        animationView.frame = CGRect(x: 0, y: 0, width: width, height: 150)
        //        animationView.center = animationBaseView.center // Center the animation on the view
        
        // Optionally, enable looping
        animationView.loopMode = .loop
        
        // Add the animation to your view
        animationBaseView.addSubview(animationView)
        
        // Play the animation
        animationView.play()
    }
    
    func startLottieAnimation2(){
        // Create a Lottie animation view
        let width = failedAnimationView.frame.width - 30
        let animationView = LottieAnimationView(name: "verification_fail")
        // Set the frame or constraints
        animationView.frame = failedAnimationView.bounds
        //        animationView.frame = CGRect(x: 0, y: 0, width: width, height: 150)
        //        animationView.center = animationBaseView.center // Center the animation on the view
        
        // Optionally, enable looping
        animationView.loopMode = .loop
        
        // Add the animation to your view
        failedAnimationView.addSubview(animationView)
        
        // Play the animation
        animationView.play()
    }
    
    func startTimedSequence() {
        var step = 0
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            step += 1
            
            switch step {
            case 1:
                print("case 1")
                UIView.animate(withDuration: 0.3, animations: {
                    self.label1.alpha = 1.0
                    self.image1.alpha = 1.0
                })
                //            case 10:
                //                self.showFailedView(resp: "")
            case 35:
                print("case 1")
                UIView.animate(withDuration: 0.3, animations: {
                    self.image1.image = UIImage(named: "pass_check")
                })
            case 37:
                UIView.animate(withDuration: 0.3, animations: {
                    self.label2.alpha = 1.0
                    self.image2.alpha = 1.0
                })
                
            case 40:
                //                self.showAlertHome(title: "Error", message: "BackToHome")
                //                UIView.animate(withDuration: 0.3, animations: {
                //                    self.image2.image = UIImage(named: "pass_check")
                //                })
                timer.invalidate()
            default:
                break
            }
        }
    }
    
    func convertDateFormat(from dateString: String) -> String? {
        let inputDateFormat = "yyyy-MM-dd"
        let outputDateFormat = "dd-MM-yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        dateFormatter.dateFormat = outputDateFormat
        return dateFormatter.string(from: date)
    }
    
    func saveData(){
        
        if verificationType == .register{
            self.defaults.removeObject(forKey: "shufti_reference")
            self.defaults.removeObject(forKey: "shufti_dob_conv")
            self.defaults.removeObject(forKey: "shufti_photo1")
            self.defaults.removeObject(forKey: "shufti_photo2")
            self.defaults.removeObject(forKey: "shufti_access_token")
            self.defaults.removeObject(forKey: "shufti_video")
            self.defaults.removeObject(forKey: "shufti_verification_report")
            self.defaults.removeObject(forKey: "name_en")
            self.defaults.removeObject(forKey: "shufti_dob")
            self.defaults.removeObject(forKey: "dob")
            self.defaults.removeObject(forKey: "shufti_id_exp_date")
            self.defaults.removeObject(forKey: "id_exp_date")
            self.defaults.removeObject(forKey: "id_no")
            self.defaults.removeObject(forKey: "name_ar")
            self.defaults.removeObject(forKey: "shufti_nationality")
            let dob1 = convertDateFormat(from: self.dob)
            
            
            
            
            
            let expiryDate1 = convertDateFormat(from: self.expiryDate)
            if !nationality.isEmpty{
                let nationality1 = nationality.uppercased()
                self.defaults.set(nationality1, forKey: "shufti_nationality")
            }
            
            self.defaults.set(dob1, forKey: "dob")
            self.defaults.set(dob1, forKey: "shufti_dob_conv")
            self.defaults.set(expiryDate1, forKey: "id_exp_date")
            self.defaults.set(self.reference, forKey: "shufti_reference")
            self.defaults.set(self.proof, forKey: "shufti_photo1")
            self.defaults.set(self.additionalProof, forKey: "shufti_photo2")
            self.defaults.set(self.accessToken, forKey: "shufti_access_token")
            self.defaults.set(self.verificationVideo, forKey: "shufti_video")
            self.defaults.set(self.verificationReport, forKey: "shufti_verification_report")
            self.defaults.set(self.fullName, forKey: "name_en")
            self.defaults.set(self.dob, forKey: "shufti_dob")
            self.defaults.set(self.expiryDate, forKey: "shufti_id_exp_date")
            self.defaults.set(self.documentNumber, forKey: "id_no")
            self.defaults.set(self.fullNameNative, forKey: "name_ar")
            
            
            print("reference",reference,"\n")
            print("proof",proof,"\n")
            print("additionalProof",additionalProof,"\n")
            print("accessToken",accessToken,"\n")
            print("verificationVideo",verificationVideo,"\n")
            print("verificationReport",verificationReport,"\n")
            print("fullName",fullName,"\n")
            print("dob",dob,"\n")
            print("expiryDate",expiryDate,"\n")
            print("documentNumber",documentNumber,"\n")
            print("fullNameNative",fullNameNative,"\n")
            print("nationality",nationality,"\n")
            navigate()
        }else{
            let idNum = defaults.string(forKey: "USERID")
            if idNum != documentNumber{
                showAlertProfile(title: "ID verification failed", message: "The scanned ID number does not match the existing record. Please check the details or contact support")
            }else{
                let dob1 = convertDateFormat(from: self.dob)
                let expiryDate1 = convertDateFormat(from: self.expiryDate)
                if !nationality.isEmpty{
                    let nationality1 = nationality.uppercased()
                    self.defaults.set(nationality1, forKey: "shufti_update_nationality")
                }
                self.defaults.removeObject(forKey: "shufti_update_nationality")
                self.defaults.removeObject(forKey: "shufti_update_dob")
                self.defaults.removeObject(forKey: "shufti_update_name_en")
                self.defaults.removeObject(forKey: "shufti_update_name_ar")
                self.defaults.removeObject(forKey: "shufti_update_id_exp_date")
                self.defaults.removeObject(forKey: "shufti_update_id_no")
                
                
                self.defaults.set(dob1, forKey: "shufti_update_dob")
                self.defaults.set(self.fullName, forKey: "shufti_update_name_en")
                self.defaults.set(self.fullNameNative, forKey: "shufti_update_name_ar")
                self.defaults.set(expiryDate1, forKey: "shufti_update_id_exp_date")
                self.defaults.set(self.documentNumber, forKey: "shufti_update_id_no")
                navigateProfile()
            }
            
        }
        
    }
    
    func checkDob(dob:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        //        "dd-MM-yyyy"
        guard let dob1 = dateFormatter.date(from: dob) else {
            self.view.makeToast("Invalid date format.", duration: 3.0, position: .center)
            return
        }
        let currentDate = Date()
        let calendar = Calendar.current
        guard let eighteenYearsAgo = calendar.date(byAdding: .year, value: -18, to: currentDate) else {
            return
        }
        if dob1 > eighteenYearsAgo {
            if self.verificationType == .register{
                self.showFailedView(resp: "User must be above 18 year old")
            }else{
                showAlertProfile(title: "Error", message: "User must be above 18 year old")
            }
        }
        else
        {
            self.getCountryName(code: self.nationalityCode)
        }
        
    }
    func navigateProfile(){
        let data = ["IdUpdated": true] as [String : Any]
        NotificationCenter.default.post(name: IdUpdateNotification, object: nil, userInfo: data)
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
//        self.navigationController?.pushViewController(nextViewController, animated: true)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                if let viewControllers = self.navigationController?.viewControllers {
                    for viewController1 in viewControllers {
                        if viewController1 is EditProfileVC {
                            if let editProfileVC = viewController1 as? EditProfileVC {
                                editProfileVC.isShuftiDone = true
                                        editProfileVC.setShuftiView()  // Call the function before
                                        self.navigationController?.popToViewController(editProfileVC, animated: true)
                                        break
                                    }
                        }
                    }
                }else{
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
                    nextViewController.isShuftiDone = true
                    nextViewController.setShuftiView()
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
    }
    func navigate(){
        let isRegisteredCust =  defaults.string(forKey: "neworexistcuststr") ?? ""
        if isRegisteredCust == "B"{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier:
                                                                            "RegisterIdDetailsOld1VC") as! RegisterIdDetailsOld1VC
            nextViewController.idImageBackData = self.idImageBackData
            nextViewController.idImageFrontData = self.idImageFrontData
            nextViewController.idImageSelfieVideoData = self.idImageSelfieVideoData
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }else if isRegisteredCust == "N"{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails1VC") as! RegisterIdDetails1VC
            nextViewController.idImageBackData = self.idImageBackData
            nextViewController.idImageFrontData = self.idImageFrontData
            nextViewController.idImageSelfieVideoData = self.idImageSelfieVideoData
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    func showAlertHome(title: String, message: String) {
        let commonAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            if let viewControllers = self.navigationController?.viewControllers {
                for viewController in viewControllers {
                    if viewController is MainLoginViewController {
                        self.navigationController?.popToViewController(viewController, animated: true)
                        break
                    }
                }
            }else{
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        
        commonAlert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(commonAlert, animated: true, completion: nil)
    }
    
    func showAlertProfile(title: String, message: String) {
        let commonAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            if let viewControllers = self.navigationController?.viewControllers {
                for viewController in viewControllers {
                    if viewController is ProfileVC {
                        self.navigationController?.popToViewController(viewController, animated: true)
                        break
                    }
                }
            }else{
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        
        commonAlert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(commonAlert, animated: true, completion: nil)
    }
    
    
    
    //MARK: - API Calls
    
    func getToken() {
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let token:String = myresult!["access_token"].string!
                print("token  ",token)
                self.getReferenceId(access_token: token)
                break
            case .failure:
                break
            }
            
        })
    }
    func getReferenceId(access_token:String) {
        let url = ge_api_url_new + "utilityservice/referenceGeneration"
        let params:Parameters =  ["device":"IOS"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("resp",response)
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let responseCode = myResult!["responseCode"].stringValue
                
                if(responseCode == "200")
                {
                    let referenceNo = myResult!["referenceNo"].stringValue
                    self.referenceNo = referenceNo
                    self.redirectShuftiPro(referenceNo: referenceNo)
                }
                else{
                }
                break
            case .failure:
                break
            }
            
            
        })
    }
    func redirectShuftiPro(referenceNo:String){
        /*
         test
         secret key - asyyQCtOpKUIj2LPgkmcv46n4v6L8wov
         client ID - bd9666ed913a4224a5df94a20364375cd5720553f8d3b48cf9f6c626e0a82c9a
         
         production
         Secret Key: rHVT624cJL4E4wVhGL0Wv2WViugyXIrR
         Client id: zZSyk14TG4lphRenUYey8IdmMB5oNOmtr5vxIG29ermk9cDfhi1736330553
         
         */
        let originalString = "zZSyk14TG4lphRenUYey8IdmMB5oNOmtr5vxIG29ermk9cDfhi1736330553:rHVT624cJL4E4wVhGL0Wv2WViugyXIrR"
        if let data = originalString.data(using: .utf8) {
            let base64EncodedString = data.base64EncodedString()
            print("Base64 Encoded String: \(base64EncodedString)")
            self.base64String = base64EncodedString
        }
        if !base64String.isEmpty{
            self.getShuftiToken(referenceNo: referenceNo, num: 1)
        }
    }
    
    func getShuftiToken(referenceNo:String, num: Int){
        print("getShuftiToken referenceNo",referenceNo)
        let url = shuftiproApi + "get/access/token"
        let headers:HTTPHeaders = ["Authorization" : "Basic \(base64String )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("getShuftiToken resp",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult?["access_token"].string ?? ""
                if token == "" || token.isEmpty{
                    self.showAlertHome(title: "Error", message: "Authorization failed. Please try again")
                }else{
                    print("getShuftiToken",token)
                    if num == 1{
                        self.navigateShufti(token: token, referenceNo: referenceNo)
                    }
                    if num == 2{
                        self.checkStatus(token: token, referenceNo: referenceNo)
                    }
                }
                break
            case .failure:
                break
            }
            
            
        })
    }
    
    func navigateShufti(token: String, referenceNo: String){
        
        
        let url = shuftiproApi
        
        let params:Parameters = [ // change in live - 1 & 0
            "reference": referenceNo,
            "country": "",
            "language": "en",
            "email": "",
            "verification_mode": "any",
            "allow_persistentidv": "0",
            "show_feedback_form": "0",
            "face": [
                "proof": strBase64Selfie,
                "check_duplicate_request": "0" // Pass 1 or 0, 1 for true and 0 for false.
            ],
            "document": [
                "proof": strBase64,
                "additional_proof": strBase641,
                "backside_proof_required": "1",
                "process_only_ocr": "0",//0 for build - 1 for testing
                "fetch_enhanced_data": "1", // 1 for build - 0 for testing
                "verification_instructions": [
                    "allow_screenshot": "0", //0 for build - 1 for testing
                    "allow_scanned": "0", //0 for build - 1 for testing
                    "allow_cropped": "0", //0 for build - 1 for testing
                    "allow_black_and_white": "0", //0 for build - 1 for testing
                    "allow_e_document": "0", //0 for build - 1 for testing
                    "allow_colorcopy": "0" //0 for build - 1 for testing
                        ],
                "supported_types": ["id_card"], // Pass the type of cards need to validate.
                "document_number": "",
            ]
            
        ]
        /*
         let parameters: [String: Any] = [
         "reference": referenceNumber, // Pass the Reference number randomly.
         "country": "",
         "show_feedback_form": "0",
         "language": "en", // Pass the language.
         "verification_mode": "any",
         "email": "",
         "allow_persistentidv": "1", // Pass 1 for true, 0 for false.
         "face": [
         "proof": prefManager.getVideoSelfie() ?? "", // Pass the selfie video of the user.
         "check_duplicate_request": "0" // Pass 1 for true, 0 for false.
         ],
         "document": [
         "proof": prefManager.getFrontImage() ?? "", // Pass the ID card front image of the user.
         "additional_proof": prefManager.getBackImage() ?? "", // Pass the ID card back image of the user.
         "backside_proof_required": "1",
         "process_only_ocr": "0",
         "fetch_enhanced_data": "0",
         "verification_instructions": [
         "allow_screenshot": "0",
         "allow_scanned": "0",
         "allow_cropped": "1"
         ],
         "supported_types": ["id_card"],
         "document_number": ""
         ]
         ]*/
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(token )"]
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("navigateShufti response",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let event:String = myresult!["event"].stringValue
                if event == "verification.accepted"{
                    UIView.animate(withDuration: 0.3, animations: {
                        self.image2.image = UIImage(named: "pass_check")
                    })
                    self.getShuftiToken(referenceNo: referenceNo, num: 2)
                } else {
                    let declined_reason = myresult?["declined_reason"].stringValue ?? ""
                    if declined_reason != "" || !declined_reason.isEmpty{
                        if self.verificationType == .register{
                            self.showFailedView(resp: "\(declined_reason)\n Try again.")
                        }else{
                            self.showAlertProfile(title: "Error", message: "\(declined_reason)\n Try again.")
                        }
                        //
                        
                    }else{
                        if self.verificationType == .register{
                            self.showFailedView(resp: "Error scanning data\n Please try again.")
                        }else{
                            self.showAlertProfile(title: "Error", message: "Error scanning data\n Please try again.")
                        }
                        //
                    }
                    
                }
                break
            case .failure:
                if self.verificationType == .register{
                    self.showFailedView(resp: "Error scanning data\n Please try again.")
                }else{
                    self.showAlertProfile(title: "Error", message: "Error scanning data\n Please try again.")
                }
                break
            }
        })
    }
    
    func checkStatus(token: String, referenceNo: String){
        let url = shuftiproApi + "status"
        let params:Parameters =  [
            "reference": referenceNo
        ]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("checkStatus Response",response)
            
            switch response.result{
            case .success(let value):
                // Safely parse the response as a dictionary
                if let json = value as? [String: Any] {
                    // Extract fields from the root level
                    let reference = json["reference"] as? String ?? ""
                    self.reference = reference
                    if let proofs = json["proofs"] as? [String: Any],
                       let document = proofs["document"] as? [String: Any]{
                        let proof = document["proof"] as? String ?? ""
                        self.proof = proof
                        let additional_proof = document["additional_proof"] as? String ?? ""
                        self.additionalProof = additional_proof
                    }
                    if let proofs = json["proofs"] as? [String: Any],
                       let face = proofs["face"] as? [String: Any]{
                        let faceProof = face["proof"] as? String ?? ""
                        self.faceProof = faceProof
                    }
                    if let proofs = json["proofs"] as? [String: Any]{
                        let access_token = proofs["access_token"] as? String ?? ""
                        self.accessToken = access_token
                        //                        let verification_video = proofs["verification_video"] as? String ?? ""
                        //                        self.verificationVideo = verification_video
                        let verification_report = proofs["verification_report"] as? String ?? ""
                        self.verificationReport = verification_report
                    }
                    
                    if let additional_data = json["additional_data"] as? [String: Any],
                       let document = additional_data["document"] as? [String: Any],
                       let proof = document["proof"] as? [String: Any]{
                        let document_number = proof["document_number"] as? String ?? ""
                        self.documentNumber = document_number
                        let dob = proof["dob"] as? String ?? ""
                        self.dob = dob
                        let expiry_date = proof["expiry_date"] as? String ?? ""
                        self.expiryDate = expiry_date
                        let full_name = proof["full_name"] as? String ?? ""
                        self.fullName = full_name
                        let full_name_native = proof["full_name_native"] as? String ?? ""
                        self.fullNameNative = full_name_native
                        let nationality = proof["nationality"] as? String ?? ""
                        self.nationalityCode = nationality
                        print("nationalityCode\(self.nationalityCode)")
                    }
                    let dob1 = self.convertDateFormat(from: self.dob)
                    self.checkDob(dob: dob1 ?? "")
                }
                break
            case .failure:
                break
            }
            
            
        })
    }
    
    func getCountryName(code:String){
        let url = api_url + "get_country_name_from_2lettercode"
        let params:Parameters = ["code":code]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getCountryName resp",response)
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                if let arrayResult  = myResult?["get_country"]{
                    if let firstResult = arrayResult.arrayValue.first {
                        // Assign nationality only once (take the first result)
                        self.nationality = firstResult["en_short_name"].stringValue
                    } else {
                        self.nationality.removeAll()
                    }
                } else {
                    self.nationality.removeAll()
                }
                //                    for i in arrayResult.arrayValue{
                //                        let nationality = i["en_short_name"].stringValue
                //                            self.nationality = i["en_short_name"].stringValue
                //                    }
                //                }else{
                //                    self.nationality = ""
                //                }
                self.saveData()
                break
            case .failure:
                self.saveData()
            }
            
        })
    }
}

