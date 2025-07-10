//
//  RegisterOtpVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 03/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield

class RegisterOtpVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var otpTF: UITextField!
    @IBOutlet weak var otpBaseView: UIView!
    @IBOutlet weak var didntRecvOtpLbl: UILabel!
    @IBOutlet weak var resendOtpLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var verifyBtn: UIButton!
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let defaults = UserDefaults.standard
    var str_idType:String = ""
    var str_id_issuer:String = ""
    var str_id_issued_country = ""
    var str_id_no:String = ""
    var str_id_exp_date:String = ""
    var str_name_en:String = ""
    var str_name_ar:String = ""
    var strEmail:String = ""
    var str_dob:String = ""
    var str_nationality:String = ""
    var str_dualNationality:String = ""
    var str_address:String = ""
    var str_city:String = ""
    var str_country:String = ""
    var str_gender:String = ""
    var str_country_code:String = ""
    var str_q1:String = ""
    var str_a1:String = ""
    var str_passw:String = ""
    var str_mpin:String = ""
    var str_employer:String = ""
    var str_occupation:String = ""
    var str_actualoccupation:String = ""
    var str_buildingno:String = ""
    var neworexistcuststr:String = ""
    var str_working_address:String = ""
    var str_income:String = ""
    var str_reg_no:String = ""
    var str_zone:String = ""
    var strMobile:String = ""
    var testfirstnamestr:String = ""
    var testlastnamestr:String = ""
    var testmiddlenamestr:String = ""
    
    var strBase64:String!
    var strBase641:String!
    var strBase642:String!
    var strBase64Selfie:String!
    var strBase64video:String!
    
    var idImageFrontData: Data?
    var idImageBackData: Data?
    var idImageSelfieVideoData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        otpTF.keyboardType = .numberPad
        resendBtn.setTitle("", for: .normal)
        configureButton(button: verifyBtn, title: "Verify", size: 16, font: .medium)
        
        
        
        titleLbl.text = NSLocalizedString("You're almost there!", comment: "")
        subTitleLbl.text = NSLocalizedString("otpmesssage", comment: "")
        
        getValues()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ScreenShield.shared.protect(view: self.otpTF)
        ScreenShield.shared.protectFromScreenRecording()
        
        
    }
    @IBAction func verifyBtnTapped(_ sender: Any) {
        
        guard let otp = otpTF.text, otpTF.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("please_enter_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        print("otp",otp)
        self.getToken(num: 2, msg: otp)
        
    }
    @IBAction func resendBtnTapped(_ sender: Any) {
        self.getToken(num: 1, msg: NSLocalizedString("otp_resent", comment: ""))
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
        self.navigationItem.title = "OTP Verification"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    
    func getValues()  {
        str_idType = defaults.string( forKey: "id_type")!
        str_id_issuer =  defaults.string( forKey: "id_issuer")!
        str_id_no = defaults.string( forKey: "id_no")!
        str_id_exp_date =  defaults.string( forKey: "id_exp_date")!
        str_name_en = defaults.string( forKey: "name_en")!
        str_name_ar = defaults.string( forKey: "name_ar")!
        strEmail = defaults.string( forKey: "email")!
        str_dob = defaults.string( forKey: "dob")!
        str_nationality = defaults.string(forKey: "nationality")!
        str_dualNationality = defaults.string(forKey: "dualNationality")!
       // str_country = defaults.string( forKey: "country")!
        str_country = "QAT"

//        let v1 = defaults.string(forKey: "nationality")
//        let v2 = defaults.string(forKey: "nationalityname")
//        print(" nationality - \(v1) - \(v2)")
        str_city = defaults.string( forKey: "municipality")!
        str_zone = defaults.string( forKey: "zone")!
        str_address = defaults.string( forKey: "home_addr")!
        str_gender = defaults.string( forKey: "gender")!
        strMobile = defaults.string( forKey: "mobile")!
        str_employer = defaults.string( forKey: "employer")!
        str_income = defaults.string( forKey: "income")!
        str_working_address =  defaults.string( forKey: "work_addr")!
        str_occupation =  defaults.string( forKey: "occupation")!
        str_actualoccupation = defaults.string( forKey: "str_actualoccupation")!
        
        str_buildingno = defaults.string( forKey: "str_buildingno")!
        
        neworexistcuststr = defaults.string( forKey: "neworexistcuststr")!
        
        str_reg_no = defaults.string( forKey: "reg_code")!
       // str_q1 = defaults.string( forKey: "q1")!
       // str_a1 = defaults.string( forKey: "a1")!
        str_passw = defaults.string( forKey: "passw")!
        str_mpin = defaults.string( forKey: "pin")!
        
        self.getToken(num: 1, msg: "")
        print("1",str_idType)
        print("2",str_id_issuer)
        print("3",str_id_no)
        print("4",str_id_exp_date)
        print("5",str_name_en)
        print("6",str_name_ar)
        print("7",strEmail)
        print("8",str_dob)
        print("9",str_nationality)
        print("10",str_country)
        print("11",str_city)
        print("12",str_zone)
        print("13",str_address)
        print("14",str_gender)
        print("15",strMobile)
        print("16",str_employer)
        print("17",str_income)
        print("18",str_working_address)
        print("19",str_occupation)
        print("20",str_reg_no)
        print("21",str_q1)
        print("22",str_a1)
        print("23",str_passw)
        print("24",str_mpin)
        
//        let imageData = img1.image!.pngData() as NSData?
//        strBase64 = imageData!.base64EncodedString(options: .lineLength64Characters)
//        let imageData1 = img2.image!.pngData() as NSData?
//        strBase641 = imageData1!.base64EncodedString(options: .lineLength64Characters)
//        let imageData2 = img3.image!.pngData() as NSData?
//        strBase642 = imageData2!.base64EncodedString(options: .lineLength64Characters)
        strBase64 = defaults.string(forKey: "strBase64")
        strBase641 = defaults.string(forKey: "strBase641")
        strBase64Selfie = defaults.string(forKey: "strBase64Selfie")
//        strBase642 = defaults.string(forKey: "strBase642")
        
        strBase64video = defaults.string(forKey: "strBase64video") ?? ""
        
        
//        print("str1",strBase64)
//        print("str2",strBase641)
//        print("str3",strBase642)
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
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)

    }
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    func getCurrentDateTime1() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    //MARK: - API Calls
    
    func getToken(num:Int, msg:String) {
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
                    self.getOTP(access_token: token, msg: msg)
                }
                else if(num == 2)
                {
                    self.validateOTP(access_token: token, otp: msg)
                }
                break
            case .failure:
                break
            }
        })
    }
    
    func getOTP(access_token:String, msg:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/generateOtp"
        let params:Parameters = ["idNo":self.str_id_no,"email":self.strEmail,"type":"1","mobileNo":self.strMobile]
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
                    if(msg != "")
                    {
                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: msg, action: NSLocalizedString("ok", comment: ""))
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
    func validateOTP(access_token:String, otp:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/verifyOtp"
        let params:Parameters = ["idNo":str_id_no,"email":self.strEmail,"type":"1","otpNo":otp,"mobileNo":self.strMobile]
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
                    self.getToken()
                }
                else
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("invalid_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                
                break
            case .failure:
                break
            }
          })
    }
    //MARK: Customer Registration
    func getToken() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")", "Content-Type": "application/json; charset=utf-8"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
    
                print("token4  ",token)
                self.regCustomer(access_token: token)
                break
            case .failure:
                break
            }
        })
    }
    
    func regCustomer(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let dateTime1:String = getCurrentDateTime1()
        let url = ge_api_url_new + "customer/registercustomer"

    
        let appVersion = AppInfo.version
              print("appVersion",appVersion)
        
        
        let string = str_name_en
           let result = string.components(separatedBy: " ")
        
        
        if result.count == 0
            {
            //middle name ""
            testmiddlenamestr = ""
            testlastnamestr = ""
            testfirstnamestr = ""
            }
        
        
        if result.count == 10
              {
                testmiddlenamestr = result[1] as! String
    testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String + " " + result[5] as! String + " " + result[6] as! String + " " + result[7] as! String + " " + result[8] as! String + " " +  result[9] as! String
                print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
              }

        
        if result.count == 9
              {
                testmiddlenamestr = result[1] as! String
testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String + " " + result[5] as! String + " " + result[6] as! String + " " + result[7] as! String + " " + result[8] as! String
                print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
              }
        
        if result.count == 8
              {
                testmiddlenamestr = result[1] as! String
    testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String + " " + result[5] as! String + " " + result[6] as! String + " " + result[7] as! String
                print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
              }
        
        
        if result.count == 7
              {
                testmiddlenamestr = result[1] as! String
    testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String + " " +  result[5] as! String + " " + result[6] as! String
                print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
              }
        
        if result.count == 6
              {
                testmiddlenamestr = result[1] as! String
    testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String  + " " + result[5] as! String
                print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
              }

        
        if result.count == 5
              {
                testmiddlenamestr = result[1] as! String
    testlastnamestr = result[2] as! String + " " + result[3] as! String + " " + result[4] as! String
                print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
              }
        
        
        if result.count == 4
          {
            testmiddlenamestr = result[1] as! String
             testlastnamestr = result[2] as! String + " " + result[3] as! String
            print("total4testlastnamestr: \(testlastnamestr)")
            testfirstnamestr = result[0] as! String
          }
        
        
        if result.count == 3
        {
            print(result[0])
            print(result[1])
            print(result[2])
            print("total3: \(result.count)")
            testlastnamestr = result[2] as! String
             print("total3testnamestr: \(testlastnamestr)")
            testmiddlenamestr = result[1] as! String
            testfirstnamestr = result[0] as! String
        }
        
        if result.count == 2
           {
               //middle name ""
                testmiddlenamestr = ""
             testlastnamestr = result[1] as! String
            testfirstnamestr = result[0] as! String
           }
        
        if result.count == 1
        {
            //middle name "",last name ""
            testmiddlenamestr = ""
            testlastnamestr = ""
            testfirstnamestr = result[0] as! String
        }
        defaults.removeObject(forKey: testfirstnamestr)
        defaults.set(testfirstnamestr, forKey:"testfirstnamestr")
        
        
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":str_id_no,
                                  "customerFullName":str_name_en,
                                  "customerFirstName":testfirstnamestr,
                                  "customerMiddleName":testmiddlenamestr,
                                  "customerLastName":testlastnamestr,
                                  "customerFullNameArabic":str_name_ar,
                                  "customerAddress":str_address,
                                  "customerCity":str_city,
                                  "customerMobile":strMobile,
                                  "customerPhone":strMobile,
                                  "customerZipCode":"",
                                  "customerCountry":str_dualNationality,
                                  "customerDOB":self.convertDateFormater(self.str_dob),
                                  "customerCountryOfBirth":"VIDEOS", //selfie video
//                                  "customerCountryOfBirth":"-", //selfie img
                                  "customerBirthPlace":str_country,
                                  "gender":str_gender,
                                  "customerNationality":str_nationality,
                                  "occupation":str_occupation,
                                  "email":strEmail,
                                  "customerIDType":str_idType,
                                  "customerIDIssuedDate":dateTime1,
                                  "customerIDExpiryDate":self.convertDateFormater(self.str_id_exp_date),
                                  "customerIDIssuedBy":str_id_issuer,
                                  "customerIDIssuedCountry":"QAT",
                                  "visaNo":"",
                                  "visaIssuedBy":"",
                                  "visaIssuedDate":"",
                                  "visaExpiryDate":"",
                                  "visaType":"",
                                  "password":str_passw,
                                  "mpin":str_mpin,
                                  "securityQuestion1":"-",
                                  "securityQuestion2":"",
                                  "securityQuestion3":str_buildingno,
                                  "securityAnswer1":"",
                                  "securityAnswer2":neworexistcuststr,
                                  "securityAnswer3":"",
                                "idImageFront":self.strBase64 ?? "",
                               //   "idImageFront": "",
                                  "idImageBack":self.strBase641 ?? "",
                             //     "idImageBack": "",
                                "idImageSelfie":self.strBase64video ?? "",// selfie video
//                                "idImageSelfie":"",
                                  "idDocAdditional1":"",
                                  "idDocAdditional2":"",
                                  "employerName":str_employer,
                                  "workingAddress1":str_working_address,
                                  "workingAddress2":str_actualoccupation,
                                  "workingAddress3":"",
                                  "expectedIncome":str_income,
                                  "customerRegNo":str_reg_no,
                                  "deviceType":"IOS",
                                  "versionName":appVersion,
                                  "mZone":str_zone]
        
        print("regCustomer paramsREG",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            
            print("resp regCustomer",response)
            
           
            self.effectView.removeFromSuperview()
            switch response.result {
                    case .success(let data):
                let responseCode = myResult!["responseCode"]
                if(responseCode == "S101")
                {
                    
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterCompleteVC") as! RegisterCompleteVC
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                else
                {
                    let respMsg = myResult!["responseMessage"]
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg.stringValue, action: NSLocalizedString("ok", comment: ""))
                }
                    case .failure(let error):
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Error registering. Please try again", action: NSLocalizedString("ok", comment: ""))
                    }
            
            
        })
 }
    
    func uploadSPIFormData(
        accessToken: String,
        requestDict: Parameters,
        idImageFront: Data,
        idImageBack: Data,
        idImageSelfie: Data
    ) {
        let url = ge_api_url_new + "customer/registercustomer"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "multipart/form-data"
        ]

        AF.upload(multipartFormData: { multipartFormData in
            // 1. Add the JSON request string
            if let jsonData = try? JSONSerialization.data(withJSONObject: requestDict, options: []),
               let jsonString = String(data: jsonData, encoding: .utf8),
               let jsonRequestData = jsonString.data(using: .utf8) {
                multipartFormData.append(jsonRequestData, withName: "request", mimeType: "application/json")
            }

            // 2. Add image/video files
            multipartFormData.append(idImageFront, withName: "idImageFront", fileName: "front.jpg", mimeType: "image/jpeg")
            multipartFormData.append(idImageBack, withName: "idImageBack", fileName: "back.jpg", mimeType: "image/jpeg")
            multipartFormData.append(idImageSelfie, withName: "idImageSelfie", fileName: "selfie.mp4", mimeType: "video/mp4")

        }, to: url, method: .post, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .success(let json):
                print("Upload successful: \(json)")
            case .failure(let error):
                print("Upload failed: \(error)")
            }
        }
    }

}
// changeinlive
//disable text field functionality in register pages

