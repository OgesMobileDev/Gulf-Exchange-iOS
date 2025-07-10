//
//  IDShuftiproVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 08/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

/*

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import ScreenShield
class IDShuftiproVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    //    var webView: WKWebView!
    var token:String = ""
    var referenceNo:String = ""
    var shuftiProURL:String = ""
    let redirectURL = "https://info.ogesinfotech.com"
//    let redirectURL = "https://gulfexchange.com.qa/work_new/en/get_shift_pro_status"
    var base64String:String = ""
    var strBase64:String = ""
    var strBase641:String = ""
    var strBase64video:String = ""
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        setupWebView()
        getShuftiUrl(token: self.token)
        
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
        self.navigationItem.title = "ID Verification"
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
        self.defaults.removeObject(forKey: "strBase64")
        self.defaults.removeObject(forKey: "frontimage")
        self.defaults.removeObject(forKey: "strBase641")
        self.defaults.removeObject(forKey: "backimage")
        self.defaults.removeObject(forKey: "strBase64Selfie")
        self.defaults.removeObject(forKey: "selfieimage")
        let dob1 = convertDateFormat(from: self.dob)
        let expiryDate1 = convertDateFormat(from: self.expiryDate)
        self.defaults.set(dob1, forKey: "dob")
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
        self.defaults.set(self.nationality, forKey: "shufti_nationality")
        
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
        
        
        //        getShuftiIDdata(url: proof, token: accessToken)
        webView.removeFromSuperview()
        performSequentialRequests()
    }
    
    func performSequentialRequests() {
        
        let url1 = proof
        let url2 = additionalProof
        let url3 = faceProof
        let token = accessToken
        //        self.getShuftiIDdata(url: url3, token: token) {
        //
        //        }
        getShuftiIDdata(url: url1, token: token, id: 1) {
            self.getShuftiIDdata(url: url2, token: token, id: 2) {
                self.getShuftiIDdata(url: url3, token: token, id: 3) {
                    print("All requests completed")
                    self.navigate()
                }
            }
        }
    }
    
    func navigate(){
        let isRegisteredCust =  defaults.string(forKey: "neworexistcuststr") ?? ""
        if isRegisteredCust == "B"{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetailsOld1VC") as! RegisterIdDetailsOld1VC
            self.navigationController?.pushViewController(nextViewController, animated: true)

        }else if isRegisteredCust == "N"{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails1VC") as! RegisterIdDetails1VC
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    //MARK: - WebKit
    
    //"https://www.youtube.com/watch?v=bOpXK6pNY_Y"
    
    private func setupWebView() {
        let config = WKWebViewConfiguration()
        config.mediaTypesRequiringUserActionForPlayback = []
        config.preferences.javaScriptEnabled = true
        config.allowsInlineMediaPlayback = true
        
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
    }
    
    private func loadShuftiProURL(url1:String) {
        guard let url = URL(string: url1) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    //       // Optional: Handle navigation events
    //       func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    //           // Example: Restrict navigation to certain URLs
    //           if let url = navigationAction.request.url {
    //               print("Navigating to: \(url)")
    //           }
    //           decisionHandler(.allow)
    //       }
    
    //MARK: - API Calls
    
    func getShuftiUrl(token:String){
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = shuftiproApi
        
        let params:Parameters = [
            "reference": self.referenceNo,
            "country": "",
            "language": "en",
//            "redirect_url": "https://info.ogesinfotech.com",
            "email": "",
            "verification_mode": "any",
            "allow_persistentidv": "1",
            "show_feedback_form": "0",
            "face": [
                "proof": "",
                "check_duplicate_request": 0 // Pass 1 or 0, 1 for true and 0 for false.
            ],
            "document": [
                "proof": "",
                "additional_proof": "",
                "backside_proof_required": "1",
                "process_only_ocr": "1", // Uncommented
                "fetch_enhanced_data": "1", // Uncommented
                "verification_instructions": [ // Uncommented
                    "allow_screenshot": "1", // Uncommented
                    "allow_scanned": "1" // Uncommented
                ],
                "supported_types": ["id_card"], // Pass the type of cards need to validate.
                "document_number": "",
                "allow_offline": "0",
                "allow_online": "1",
                "age": "",
                "name": "",
                "dob": "",
                "issue_date": "",
                "expiry_date": "",
                "nationality": "",
                "arabic_name": "",
                "occupation": ""
            ]
            
        ]
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("getShuftiUrl",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let url:String = myresult!["verification_url"].stringValue
                self.loadShuftiProURL(url1: url)
                break
            case .failure:
                break
            }
            
            
        })
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url?.absoluteString {
            print("Navigating to URL: \(url)")
            if url.contains(redirectURL) {
                getShuftiToken() // Call your function
            }
        }
        decisionHandler(.allow)
    }
    
    // MARK: - Function to Call on Redirect
    func getShuftiToken(){
        //        print("getShuftiToken referenceNo",self.referenceNo)
        let url = shuftiproApi + "get/access/token"
        let headers:HTTPHeaders = ["Authorization" : "Basic \(base64String )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("resp",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let token:String = myresult!["access_token"].string!
                print("getShuftiToken",token)
                self.token = token
                self.checkStatus()
                break
            case .failure:
                break
            }
            
            
        })
    }
    func checkStatus() {
        let url = shuftiproApi + "status"
        let params:Parameters =  [
            "reference": self.referenceNo
        ]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(self.token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("checkStatus Response",response)
            //                self.effectView.removeFromSuperview()
            //                self.webView.removeFromSuperview()
            
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
                        self.nationality = nationality
                    }
                    self.saveData()
                }
                break
            case .failure:
                break
            }
            
            
        })
    }
    
    func getShuftiIDdata(url: String, token: String, id:Int, completion: @escaping () -> Void) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let params: Parameters = ["access_token": token]
        let headers: HTTPHeaders = [
            "Accept": "image/*"
        ] // Specify that you expect an image response
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData { response in
            self.effectView.removeFromSuperview()
            switch response.result {
                
            case .success(let data):
                // Convert the image data to a Base64 string
                let base64String = data.base64EncodedString()
                print("Base64 Encoded String: \(base64String)")
                
                if id == 1{
                    self.defaults.set(base64String, forKey: "strBase64")
                    if let image = UIImage(data: data) {
                        // Compress the image as JPEG with medium quality
                        if let imageData = image.jpegData(compressionQuality: 0.5) {
                            // Save to UserDefaults
                            UserDefaults.standard.set(imageData, forKey: "frontimage")
                            print("Image saved successfully to UserDefaults.")
                        } else {
                            print("Failed to convert image to JPEG.")
                        }
                    } else {
                        print("Failed to create UIImage from data.")
                    }
                }
                if id == 2{
                    self.defaults.set(base64String, forKey: "strBase641")
                    if let image = UIImage(data: data) {
                        // Compress the image as JPEG with medium quality
                        if let imageData = image.jpegData(compressionQuality: 0.5) {
                            // Save to UserDefaults
                            UserDefaults.standard.set(imageData, forKey: "backimage")
                            print("Image saved successfully to UserDefaults.")
                        } else {
                            print("Failed to convert image to JPEG.")
                        }
                    } else {
                        print("Failed to create UIImage from data.")
                    }
                }
                if id == 3{
                    
                    // selfie Img
                    self.defaults.set(base64String, forKey: "strBase64Selfie")
                    if let image = UIImage(data: data) {
                        // Compress the image as JPEG with medium quality
                        if let imageData = image.jpegData(compressionQuality: 0.5) {
                            // Save to UserDefaults
                            UserDefaults.standard.set(imageData, forKey: "selfieimage")
                            print("Image saved successfully to UserDefaults.")
                        } else {
                            print("Failed to convert image to JPEG.")
                        }
                    } else {
                        print("Failed to create UIImage from data.")
                    }
                }
            case .failure(let error):
                if let responseData = response.data, let errorMessage = String(data: responseData, encoding: .utf8) {
                    print("Raw Error Response: \(errorMessage)")
                }
                print("Error: \(error.localizedDescription)")
            }
            completion()
        }
    }
    
    
    //    func getShuftiIDdata(url:String,token:String){
    //
    //        let params:Parameters = ["access_token": token]
    //        let headers: HTTPHeaders = ["Accept": "image/*"]
    //        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
    //            print("getShuftiIDdata resp",response)
    //            switch response.result{
    //            case .success(let data):
    //                       // Convert the data to a Base64-encoded string
    //                let base64String = (data as AnyObject).base64EncodedString()
    //                       print("Base64 Encoded String: \(base64String)")
    //                break
    //            case .failure:
    //                break
    //            }
    //
    //
    //        })
    //    }
    
}
/*
 "reference": "WEB043122689",
 "proof": "https://ns.shuftipro.com/api/pea/af004aea3784d93f64803148087dea8d9a697200",
 "additional_proof": "https://ns.shuftipro.com/api/pea/d86d06497fa0858b732884fb24c6dddb94affaaa"
 "access_token": "ed740aee6cf12dc6bbae21afeb1d19af28191cd425d72c0d85b98a9fbfa56f32",
 "verification_video": "https://ns.shuftipro.com/api/pea/d3fd55826bbd0751b83513f6d7ae4d3305ebf18e",
 "verification_report": "https://ns.shuftipro.com/api/pea/a4c55f345b2ddea37b1782d925f3fa284df51b5f"
 "full_name": "IINCY GEORGE"
 "dob": "1988-05-11",
 "expiry_date": "2025-09-20",
 "document_number": "28835643367",
 "document_number": "28835643367",
 "dob": "1988-05-11",
 "expiry_date": "2025-09-20",
 "full_name": "IINCY GEORGE",
 "full_name_native": "جينسي  جورج",
 
 */
/*
 let responseData: [String: Any] = [
 "reference": "WEB043122689",
 "event": "verification.accepted",
 "country": NSNull(),
 "proofs": [
 "document": [
 "proof": "https://ns.shuftipro.com/api/pea/af004aea3784d93f64803148087dea8d9a697200",
 "additional_proof": "https://ns.shuftipro.com/api/pea/d86d06497fa0858b732884fb24c6dddb94affaaa"
 ],
 "access_token": "ed740aee6cf12dc6bbae21afeb1d19af28191cd425d72c0d85b98a9fbfa56f32",
 "verification_video": "https://ns.shuftipro.com/api/pea/d3fd55826bbd0751b83513f6d7ae4d3305ebf18e",
 "verification_report": "https://ns.shuftipro.com/api/pea/a4c55f345b2ddea37b1782d925f3fa284df51b5f"
 ],
 "verification_data": [
 "document": [
 "name": [
 "first_name": NSNull(),
 "middle_name": NSNull(),
 "last_name": NSNull(),
 "full_name": "IINCY GEORGE"
 ],
 "dob": "1988-05-11",
 "expiry_date": "2025-09-20",
 "issue_date": NSNull(),
 "document_number": "28835643367",
 "age": 36,
 "nationality": "in",
 "country": "QA",
 "selected_type": ["id_card"],
 "supported_types": ["id_card"]
 ]
 ],
 "verification_result": [
 "document": [
 "document": NSNull(),
 "document_visibility": NSNull(),
 "document_must_not_be_expired": NSNull(),
 "document_proof": NSNull(),
 "selected_type": NSNull(),
 "ocr_performed": NSNull()
 ]
 ],
 "info": [
 "agent": [
 "is_desktop": true,
 "is_phone": false,
 "useragent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
 "device_name": "Windows NT 10.0",
 "browser_name": "Chrome 131.0.0.0",
 "platform_name": "Windows 10"
 ],
 "geolocation": [
 "host": "117.254.6.167",
 "ip": "117.254.6.167",
 "rdns": "117.254.6.167",
 "asn": "9829",
 "isp": "National Internet Backbone",
 "country_name": "India",
 "country_code": "IN",
 "region_name": "Kerala",
 "region_code": "KL",
 "city": "Cochin",
 "postal_code": "682009",
 "continent_name": "Asia",
 "continent_code": "AS",
 "latitude": "9.9651002883911",
 "longitude": "76.265998840332",
 "metro_code": "",
 "timezone": "Asia/Kolkata",
 "ip_type": "ipv4",
 "capital": "New Delhi",
 "currency": "INR"
 ]
 ],
 "additional_data": [
 "document": [
 "proof": [
 "face": "757,168,943,370",
 "document_number": "28835643367",
 "dob": "1988-05-11",
 "expiry_date": "2025-09-20",
 "full_name": "IINCY GEORGE",
 "full_name_native": "جينسي  جورج",
 "nationality": "Indian",
 "nationality_native": "भारतीय",
 "document_country": "Qatar",
 "document_country_code": "QA",
 "document_official_name": "Qatar Residence Permit v1",
 "occupation": "ریة منزل",
 "country": "qatar",
 "country_code": "QA"
 ],
 "additional_proof": [
 "face": "784,291,968,476",
 "employer": "شیرین بوسي",
 "personal_number": "30828835643367",
 "signature": "485,290,687,369",
 "passport_number": "Y5021963",
 "passport_expiry_date": "2033-06-21",
 "document_country": "Qatar",
 "document_country_code": "QA",
 "document_official_name": "Qatar Residence Permit v2",
 "country": "qatar",
 "country_code": "QA"
 ]
 ]
 ]
 ]
 */

                                                           */*/*/
