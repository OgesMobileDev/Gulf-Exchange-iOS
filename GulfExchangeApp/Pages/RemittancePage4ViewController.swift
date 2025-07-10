//
//  RemittancePage4ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 24/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield
class RemittancePage4ViewController: UIViewController {
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var msgLbl1: UILabel!
    @IBOutlet weak var msgLbl2: UILabel!
    @IBOutlet weak var enterOtpLbl: UILabel!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var resendOtp: UIButton!
    
    var promocodee:String = ""
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var email:String = ""
    var mobile:String = ""
    var udid:String!
     var str_acc_no:String = ""
    
    var priceordercodestoredglob:String = ""
    var benficiaryseioalnostoredglob:String = ""
    var countrycodestoredglob:String = ""
    
    
    
    
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
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        
        
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                                                       let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                                                       if appLang == "ar" || appLang == "ur" {
                                                          otpTextField.textAlignment = .right
                                                       } else {
                                                          otpTextField.textAlignment = .left
                                                       }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("remittance", comment: "")
        super.viewDidLoad()
        confirmBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        confirmBtn.layer.cornerRadius = 15
        setFont()
        setFontSize()
        self.getToken(num: 1)
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        
        
       // resetTimer()
        
    }
    override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(true)
               
               // Protect ScreenShot
//                      ScreenShield.shared.protect(view: self.mainView)
                      
                      // Protect Screen-Recording
                      ScreenShield.shared.protectFromScreenRecording()
              
           }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
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


        timer.invalidate()
        
        return
     }

    @objc func resetTimer() {
        print("Reset")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }

    
    
    
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func confirmBtn(_ sender: Any) {
        self.getToken(num: 3)

        
        guard let otp = otpTextField.text, otpTextField.text?.count != 0 else {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
       // hided
        //self.verifyOTP(otp: otpTextField.text!)
    }
    @IBAction func resendBtn(_ sender: Any) {
        self.sendOTP(msg: NSLocalizedString("otp_resent", comment: ""))
    }
    func setFont() {
        msgLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        msgLbl2.font = UIFont(name: "OpenSans-Regular", size: 14)
        enterOtpLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        otpTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        confirmBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        resendOtp.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        msgLbl1.font = msgLbl1.font.withSize(14)
        msgLbl2.font = msgLbl2.font.withSize(14)
        enterOtpLbl.font = enterOtpLbl.font.withSize(14)
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        RemittancePage4ViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!

                print("token4  ",token)
                if(num == 1)
                {
                    self.viewCustomer(access_token: token)
                }
                else if(num == 2)
                {
                    self.validation(access_token: token)
                }
                else if(num == 3)
                {
                    self.createTransaction(access_token: token)
                }
                break
            case .failure:
                break
            }
        })
    }
    func viewCustomer(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        RemittancePage4ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            self.email = myResult!["email"].stringValue
            self.mobile = myResult!["customerMobile"].stringValue
            print("email",self.email)
            print("mobile",self.mobile)
            self.sendOTP(msg: "")
            
        })
    }
    func sendOTP(msg:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "otp_generate_listing"
        let params:Parameters = ["id_no":defaults.string(forKey: "USERID")!,"mobile_no":self.mobile,"email":self.email,"type":"4"]

        print("USER ID ",defaults.string(forKey: "USERID")!)
          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(msg != "")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: msg, action: NSLocalizedString("ok", comment: ""))
            }
            
          })
    }
    func verifyOTP(otp:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "otp_verification"
        let params:Parameters = ["id_no":defaults.string(forKey: "USERID")!,"mobile_no":self.mobile,"email":self.email,"otp_no":otp,"imei_no":udid!,"type":"4"]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["code"]
            if(respCode == "1")
            {
                self.getToken(num: 2)
            }
            else
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("invalid_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
          })
    }
    func validation(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
              print("appVersion",appVersion)
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":appVersion,"customerPhone":"IOS","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"ISREMITALLOWED","isExistOrValid":""]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        RemittancePage4ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            if(respCode == "S1111" || respCode == "S2222")
            {
                self.getToken(num: 3)
            } else{
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("remittance_not_allowed", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
        })
    }
    func createTransaction(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "transaction/createtransaction"
        
        
        //new promocode
        self.promocodee = defaults.string(forKey: "promocodee")!
        
        if defaults.string(forKey: "priceordercodestored")! == "null" || defaults.string(forKey: "priceordercodestored")!.isEmpty
        {
         priceordercodestoredglob = ""
        }
        else
        {
        priceordercodestoredglob = defaults.string(forKey: "priceordercodestored")!
           print("priceordercodestored:\(priceordercodestoredglob)")
        }
        
        if defaults.string(forKey: "benficiaryseioalnostored")!.isEmpty
        {
          benficiaryseioalnostoredglob = ""
        }
        else
        {
       benficiaryseioalnostoredglob = defaults.string(forKey: "benficiaryseioalnostored")!
        print("benficiaryseioalnostored:\(benficiaryseioalnostoredglob)")
        print("benficiaryseioalnostoredprint:\(benficiaryseioalnostoredglob)")
            
        }
        
      countrycodestoredglob = defaults.string(forKey: "countrycodestored")!
      print("countrycodestored:\(countrycodestoredglob)")
        
    let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
               print("servicetypestored:\(servicetypestored)")
        
        
     
    
        //Accountnull check
        let userdefaultACCNONIL = UserDefaults.standard
        if let savedValue = userdefaultACCNONIL.string(forKey: "acc_no"){
            print("Here you will get saved value")
   
                      
        } else {
            //DO
            self.str_acc_no = "NA"
            self.defaults.set(self.str_acc_no, forKey: "acc_no")
             //UserDefaults.standard.set(self.str_acc_no, forKey: "acc_no")
            
        print("No value in Userdefault,Either you can save value here or perform other operation")
        userdefaultACCNONIL.set("Here you can save value", forKey: "key")
        }
        
        self.str_acc_no = defaults.string(forKey: "acc_no")!
            if  self.str_acc_no == ""
            {
                 self.str_acc_no = "NA"
                 self.defaults.set(self.str_acc_no, forKey: "acc_no")
            }
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print("appVersion",appVersion)
        
        
        
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"sourceApplication":"MOBILE","customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"mobileNo":self.mobile,"transactionDate":dateTime,"payinCurrency":"QAR","payinAmount":defaults.string(forKey: "amount1")!,"payoutCurrency":defaults.string(forKey: "currency")!,"payoutAmount":defaults.string(forKey: "amount2")!,"exchangeRate":defaults.string(forKey: "exchangeRate")!,"commission":defaults.string(forKey: "commission")!,"charges":"0","tax":"0","totalPayinAmount":defaults.string(forKey: "totalAmount")!,"deliveryOption":servicetypestored,"beneficiaryAccountNo":defaults.string(forKey: "acc_no")!,"customerRelationship":defaults.string(forKey: "relation")!,"purposeOfTxn":defaults.string(forKey: "purpose")!,"sourceOfIncome":defaults.string(forKey: "source")!,"remittanceDevice":"IOS","versionName":appVersion,"priceOrderCode":priceordercodestoredglob,"beneficiarySerialNo":benficiaryseioalnostoredglob,"receiveCountry":countrycodestoredglob,"paymentMode":"ONLINE","paymentStatus":"-","paymentGatewayName":"QPAY","paymentGatewayTxnRefID":promocodee]
        
        //,"priceOrderCode":defaults.string(forKey: "priceordercodestored")!,"beneficiarySerialNo":defaults.string(forKey: "benficiaryseioalnostored")!,"remittanceDevice":"IOS","receiveCountry":defaults.string(forKey: "countrycodestored")!
        
        //deliveryOption servicetype dynamicstore
        
       // params2.put("priceOrderCode", priceOrderCode);  //newly added - feelookup api
       // params2.put("beneficiarySerialNo", beneficiarySerialNo);  //newly added -viewor list benfitiaryapi
       // params2.put("remittanceDevice", "ANDROID");  //newly added = //static ios
       // params2.put("receiveCountry", receiveCountry);  //newly added// rem1 recivercountry first country shw configoke
        print("urlCREATETRANSACTION",url)
        print("paramsCREATETRANSACTION",params)
        
        
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        RemittancePage4ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("Create trans",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            if(respCode == "S112")
            {
                //clear
                UserDefaults.standard.removeObject(forKey: "refNo")
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let refNo = myResult!["transactionRefNo"].stringValue
                self.defaults.set(refNo, forKey: "refNo")
                print("refNoCreate trans",refNo)
                
                self.timer.invalidate()
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem5") as! RemittancePage5ViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            else
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            }
        })
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
}
