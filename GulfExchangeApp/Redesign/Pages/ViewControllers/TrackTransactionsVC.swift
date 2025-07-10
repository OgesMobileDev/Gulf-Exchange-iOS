//
//  TrackTransactionsVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield

class TrackTransactionsVC: UIViewController {

    //MARK: - Variable Declarations
    
    @IBOutlet weak var trackIngBgView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var benfNameLbl: UILabel!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var transactionIDLbl1: UILabel!
    @IBOutlet weak var transactionIDLbl: UILabel!
    @IBOutlet weak var refNoLbl1: UILabel!
    @IBOutlet weak var refNoLbl: UILabel!
    @IBOutlet weak var amountLbl1: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var dateLbl1: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusLbl1: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var statusImgView1: UIImageView!
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var trackView1: UIView!
    @IBOutlet weak var trackView2: UIView!
    @IBOutlet weak var trackLbl1: UILabel!
    @IBOutlet weak var trackLbl2: UILabel!
    @IBOutlet weak var trackLbl3: UILabel!
    @IBOutlet weak var trackDateLbl1: UILabel!
    @IBOutlet weak var trackDateLbl2: UILabel!
    @IBOutlet weak var trackDateLbl3: UILabel!
    @IBOutlet weak var profileImgBgView: UIView!
    
    var transactionRefNo:String = ""
    var timer = Timer()
    var timerGesture = UITapGestureRecognizer()
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var udid:String!
    let defaults = UserDefaults.standard
    //test
    //var transactionRefNo:String = ""
    static let AlamoFireManager: Alamofire.Session = {
        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator(),
                                                      "ws.gulfexchange.com.qa": DisabledEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    //production
       // var transactionRefNo:String = ""
//          static let AlamoFireManager: Alamofire.Session = {
//        //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
//                let configuration = URLSessionConfiguration.af.default
//                return Session(configuration: configuration)
//        //        return Session(configuration: configuration, serverTrustManager: manager)
//            }()
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        addNavbar()
        trackIngBgView.isHidden = true
        countryFlag.isHidden = true
        statusImgView.isHidden = true
        self.trackView.backgroundColor = UIColor.rgba(69, 90, 100, 1)
        self.trackView1.backgroundColor = UIColor.rgba(0, 136, 62, 1)
        let check = isKeyPresentInUserDefaults(key: "trackFrom")
        if(check)
        {
            let from = defaults.string(forKey: "trackFrom")
            if(from != "")
            {
                self.transactionRefNo = defaults.string(forKey: "transactionRefNo")!
                print("transRefNo ",transactionRefNo)
                self.getToken()
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)
        
        setTxtToSpeech()
        
        amountLbl1.text = (NSLocalizedString("amount1_sm", comment: ""))
        dateLbl1.text = (NSLocalizedString("date1", comment: ""))
        
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        ScreenShield.shared.protect(view: self.profileImgView)
        ScreenShield.shared.protect(view: self.benfNameLbl)
        ScreenShield.shared.protect(view: self.countryFlag)
        ScreenShield.shared.protect(view: self.countryLbl)
        ScreenShield.shared.protect(view: self.transactionIDLbl1)
        ScreenShield.shared.protect(view: self.transactionIDLbl)
        ScreenShield.shared.protect(view: self.refNoLbl1)
        ScreenShield.shared.protect(view: self.refNoLbl)
        ScreenShield.shared.protect(view: self.amountLbl1)
        ScreenShield.shared.protect(view: self.amountLbl)
        ScreenShield.shared.protect(view: self.dateLbl1)
        ScreenShield.shared.protect(view: self.dateLbl)
        ScreenShield.shared.protect(view: self.statusLbl1)
        ScreenShield.shared.protect(view: self.statusLbl)
        ScreenShield.shared.protect(view: self.statusImgView)
        ScreenShield.shared.protect(view: self.statusImgView1)
        ScreenShield.shared.protect(view: self.trackView)
        ScreenShield.shared.protect(view: self.trackView1)
        ScreenShield.shared.protect(view: self.trackView2)
        ScreenShield.shared.protect(view: self.trackLbl1)
        ScreenShield.shared.protect(view: self.trackLbl2)
        ScreenShield.shared.protect(view: self.trackLbl3)
        ScreenShield.shared.protect(view: self.trackDateLbl1)
        ScreenShield.shared.protect(view: self.trackDateLbl2)
        ScreenShield.shared.protect(view: self.trackDateLbl3)
        ScreenShield.shared.protect(view: self.profileImgBgView)
        ScreenShield.shared.protectFromScreenRecording()
        
    }
    
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recentTitleoLblTapped(_:)))
        benfNameLbl.isUserInteractionEnabled = true
        benfNameLbl.addGestureRecognizer(tapGesture)
        
//        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(idDetailLblTapped(_:)))
//        idDetailLbl.isUserInteractionEnabled = true
//        idDetailLbl.addGestureRecognizer(tapGesture1)
//
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(mobileLblTapped(_:)))
//        mobileLbl1.isUserInteractionEnabled = true
//        mobileLbl1.addGestureRecognizer(tapGesture2)
//
//        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(emailLblTapped(_:)))
//        emailLbl1.isUserInteractionEnabled = true
//        emailLbl1.addGestureRecognizer(tapGesture3)
    }
    
    @objc func recentTitleoLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak(benfNameLbl.text!, languageCode: "en")
            }
        }
    }
    @objc func idDetailLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("identification details", languageCode: "en")
            }
        }
        
    }
    
    @objc func mobileLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("mobile number", languageCode: "en")
            }
        }
    }
    
    @objc func emailLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("email", languageCode: "en")
            }
        }
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
    
    //MARK: - functions
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("track_transactions", comment: "")
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
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
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
    
    //MARK: - API Calls
    func getToken() {
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
                    print("token  ",token)
                    self.getTransactionInfo(access_token: token)
                    break
                case .failure:
                    break
                }
                
            })
        }
    func getTransactionInfo(access_token:String) {
       
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "transaction/viewtransaction"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"transactionRefNo":self.transactionRefNo]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        print("getTransactionInfo url",url)
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                print("getTransactionInfo resp",response)
                let respCode = myResult!["responseCode"]
                self.defaults.set("", forKey: "trackFrom")
                if(respCode == "S114")
                {
                    self.trackIngBgView.isHidden = false
                    self.statusImgView.isHidden = false
                    let benAccNo = myResult!["beneficiaryAccountNo"].stringValue
                    if(benAccNo != nil || benAccNo != "")
                    {
                        self.refNoLbl.text = self.transactionRefNo
                    }
                    else{
                        self.refNoLbl.text = "----"
                    }
                   
                    let benName = myResult!["beneficiaryAccountName"].stringValue
                    if(benName != nil || benName != "")
                    {
                        self.profileImgView.isHidden = true
                        createAvatar(username: benName, view: self.profileImgBgView, font: 30)
                        self.benfNameLbl.text = benName
                    }
                    else{
                        self.profileImgView.isHidden = false
                        self.benfNameLbl.text = "----"
                    }
                    
                    let country = myResult!["beneficiaryBankCountry"].stringValue
                    if(country != nil || country != "")
                    {
                        self.countryLbl.text = country
                    }
                    else{
                        self.countryLbl.text = "----"
                    }
                    let payinCurrency = myResult!["payinCurrency"].stringValue
                    let payinAmount = myResult!["payinAmount"].stringValue
                    let payoutCurrency = myResult!["payoutCurrency"].stringValue
                    let payoutAmount = myResult!["payoutAmount"].stringValue
                    let paymentAmt = "\(payinCurrency) \(payinAmount) - \(payoutCurrency): \(payoutAmount)"
                    self.amountLbl.text = paymentAmt
                
                    
                    let date = myResult!["transactionDate"].stringValue
                    if(date != "")
                    {
                        if let formattedDate = formatDateToCustomFormat(apiDateString: date, formatIndex: 2) {
                            print("Formatted Date 1: \(formattedDate)")
                            self.dateLbl.text = formattedDate
                        }else{
                            self.dateLbl1.text = "----"
                        }
                    }else{
                        self.dateLbl1.text = "----"
                    }
                    
                    let txnInitiateTime = myResult!["txnInitiateTime"].stringValue
                    if(txnInitiateTime != "")
                    {
                        if let formattedDate = formatDateToCustomFormat(apiDateString: txnInitiateTime, formatIndex: 0) {
                            print("Formatted Date 2: \(formattedDate)")
                            self.trackDateLbl1.text = formattedDate
                        }else{
                            self.trackDateLbl1.text = "----"
                        }
                    }else{
                        self.trackDateLbl1.text = "----"
                    }
                    
                    let txnProcessingTime = myResult!["txnProcessingTime"].stringValue
                    if(txnProcessingTime != "")
                    {
                        if let formattedDate = formatDateToCustomFormat(apiDateString: txnProcessingTime, formatIndex: 0) {
                            print("Formatted Date 3: \(formattedDate)")
                            self.trackDateLbl2.text = formattedDate
                        }else{
                            self.trackDateLbl2.text = "----"
                        }
                    }else{
                        self.trackDateLbl2.text = "----"
                    }
                    
                    let txnFinalTime = myResult!["txnFinalTime"].stringValue
                    if(txnFinalTime != "")
                    {
                        if let formattedDate = formatDateToCustomFormat(apiDateString: txnFinalTime, formatIndex: 1) {
                            print("Formatted Date 4: \(formattedDate)")
                            self.trackDateLbl3.text = formattedDate
                        }else{
                            self.trackDateLbl3.text = "----"
                        }
                    }else{
                        self.trackDateLbl3.text = "----"
                    }
                    
                    
                    
    //                if(date != "")
    //                {
    //                    if let (formattedDate1, formattedDate2, formattedDate3) = formatDateToCustomFormats(from: date) {
    //                        self.dateLbl.text = formattedDate3
    //                        self.trackDateLbl1.text = formattedDate1
    //                        self.trackDateLbl2.text = formattedDate1
    //                        self.trackDateLbl3.text = formattedDate2
    //                    }else{
    //                        self.dateLbl1.text = date
    //                        self.trackDateLbl1.text = date
    //                        self.trackDateLbl2.text = date
    //                        self.trackDateLbl3.text = date
    //                    }
    //                }
    //
    //                "txnInitiateTime": "2024-12-19 10:41:58",
    //                    "txnProcessingTime": "2024-12-19 10:43:54.289829",
    //                    "txnFinalTime": "2024-12-19 10:43:54.288149",
    //                else
    //                {
    //                    self.dateLbl1.text = "----"
    //                    self.trackDateLbl1.text = "----"
    //                    self.trackDateLbl2.text = "----"
    //                    self.trackDateLbl3.text = "----"
    //
    //                }
                    
                    let statusStr2 = myResult!["paymentStatus"].stringValue
                    if(statusStr2 != "")
                    {
                        if statusStr2 == "PAYMENT PROCESSED SUCCESSFULLY" || statusStr2 == "SUCCESS"{
                            self.trackLbl2.text = "PAYMENT SUCCESS"
                            self.statusLbl.text = "PAYMENT SUCCESS"
                            self.statusLbl.textColor = UIColor.rgba(0, 136, 62, 1)
                            self.trackView2.backgroundColor = UIColor.rgba(0, 136, 62, 1)
                            self.statusImgView1.image = UIImage(named: "t_done")
                            self.statusImgView.image = UIImage(named: "t_done")
                        }else if (statusStr2 == "PAYMENT FAILED" || statusStr2 == "PAYMENT CANCELED"){
                            self.trackLbl2.text = statusStr2
                            self.statusLbl.text = statusStr2
                            self.statusLbl.textColor = UIColor.rgba(227, 5, 13, 1)
    //                        self.trackView.backgroundColor = UIColor.rgba(227, 5, 13, 1)
    //                        self.trackView1.backgroundColor = UIColor.rgba(227, 5, 13, 1)
                            self.trackView2.backgroundColor = UIColor.rgba(227, 5, 13, 1)
                            self.statusImgView1.image = UIImage(named: "t_failed")
                            self.statusImgView.image = UIImage(named: "t_failed")
                        }else if (statusStr2 == "INITIATED" ){
                            self.trackLbl2.text = statusStr2
                            self.statusLbl.text = statusStr2
                            self.statusLbl.textColor = UIColor.rgba(244, 133, 2, 1)
    //                        self.trackView.backgroundColor = UIColor.rgba(244, 133, 2, 1)
    //                        self.trackView1.backgroundColor = UIColor.rgba(244, 133, 2, 1)
                            self.trackView2.backgroundColor = UIColor.rgba(244, 133, 2, 1)
                            self.statusImgView1.image = UIImage(named: "t_pending")
                            self.statusImgView.image = UIImage(named: "t_pending")
                        }else{
                            self.trackLbl2.text = statusStr2
                            self.statusLbl.text = statusStr2
    //                        self.trackView.backgroundColor = UIColor.rgba(139, 139, 139, 1)
    //                        self.trackView1.backgroundColor = UIColor.rgba(139, 139, 139, 1)
                            self.trackView2.backgroundColor = UIColor.rgba(139, 139, 139, 1)
                            self.statusImgView1.image = UIImage(named: "")
                            self.statusImgView.image = UIImage(named: "")
                        }
                    }else{
                        self.trackLbl2.text = "----"
                        self.statusLbl.text = "----"
                        self.trackView.backgroundColor = UIColor.rgba(69, 90, 100, 1)
                        self.trackView1.backgroundColor = UIColor.rgba(69, 90, 100, 1)
                        self.trackView2.backgroundColor = UIColor.rgba(69, 90, 100, 1)
                        self.statusImgView1.image = UIImage(named: "")
                        self.statusImgView.image = UIImage(named: "")
                    }
                    
                    
                    
                    let statusStr3 = myResult!["txnStatus1"].stringValue
                    if(statusStr3 != "")
                    {
                        self.trackLbl3.text = statusStr3
                    }
                    else
                    {
                        self.trackLbl3.text = "----"
                    }
                    let refNo = myResult!["paymentGatewayTxnRefID"].stringValue
                    if(refNo != "")
                    {
                        self.transactionIDLbl.text = refNo
                    }
                    else
                    {
                        self.transactionIDLbl.text = "----"
                    }
                    
                }
                else
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg:NSLocalizedString("no_data_available", comment: "") , action: NSLocalizedString("ok", comment: ""))
                }
            case .failure:
                break
            }

           
        })
    }

    
    
    
    
}











extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
import Foundation

//func formatDateToCustomFormats(from apiDateString: String) -> (String, String, String)? {
//    // Step 1: Parse the API date string into a Date object
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Assuming API returns UTC
//    
//    guard let date = dateFormatter.date(from: apiDateString) else {
//        return nil
//    }
//    
//    // Step 2: Format to "Mon, 21st Sep 2023 | 2:25 PM"
//    let outputFormatter1 = DateFormatter()
//    outputFormatter1.dateFormat = "EEE, d MMM yyyy | h:mm a"
//    let formattedDate1 = outputFormatter1.string(from: date)
//    let dayWithOrdinal = addOrdinalSuffix(to: date)
//    let formattedDate1WithOrdinal = formattedDate1.replacingOccurrences(of: "\(Calendar.current.component(.day, from: date))", with: dayWithOrdinal)
//    
//    // Step 3: Format to "Fri, 25th Sep 2023"
//    let outputFormatter2 = DateFormatter()
//    outputFormatter2.dateFormat = "EEE, d MMM yyyy"
//    let formattedDate2 = outputFormatter2.string(from: date)
//    let formattedDate2WithOrdinal = formattedDate2.replacingOccurrences(of: "\(Calendar.current.component(.day, from: date))", with: dayWithOrdinal)
//    
//    // Step 4: Format to "2024-03-01 02:07 PM"
//    let outputFormatter3 = DateFormatter()
//    outputFormatter3.dateFormat = "yyyy-MM-dd hh:mm a"
//    let formattedDate3 = outputFormatter3.string(from: date)
//    
//    return (formattedDate1WithOrdinal, formattedDate2WithOrdinal, formattedDate3)
//}

// Helper function to add ordinal suffix to a day
func addOrdinalSuffix(to date: Date) -> String {
    let day = Calendar.current.component(.day, from: date)
    let suffix: String
    
    switch day {
    case 11, 12, 13:
        suffix = "th"
    default:
        switch day % 10 {
        case 1: suffix = "st"
        case 2: suffix = "nd"
        case 3: suffix = "rd"
        default: suffix = "th"
        }
    }
    
    return "\(day)\(suffix)"
}

// Example Usage
func formatDateToCustomFormat(apiDateString: String, formatIndex: Int) -> String? {
    // Step 1: Attempt to parse the date string using multiple formats
    let dateFormats = [
        "yyyy-MM-dd HH:mm:ss",         // Without milliseconds
        "yyyy-MM-dd HH:mm:ss.SSSSSS"  // With fractional seconds
    ]
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Assuming API returns UTC
    
    var date: Date? = nil
    for format in dateFormats {
        dateFormatter.dateFormat = format
        if let parsedDate = dateFormatter.date(from: apiDateString) {
            date = parsedDate
            break
        }
    }
    
    guard let validDate = date else {
        return nil // Return nil if parsing fails
    }
    
    // Step 2: Define the desired date formats for output
    let formats = [
        "EEE, d MMM yyyy | h:mm a",    // Format for index 0
        "EEE, d MMM yyyy",             // Format for index 1
        "yyyy-MM-dd hh:mm a"           // Format for index 2
    ]
    
    // Step 3: Ensure the format index is within bounds
    guard formatIndex >= 0 && formatIndex < formats.count else {
        return nil
    }
    
    // Step 4: Format the date
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = formats[formatIndex]
    let formattedDate = outputFormatter.string(from: validDate)
    
    // Add ordinal suffix if required for the first two formats
    if formatIndex == 0 || formatIndex == 1 {
        let dayWithOrdinal = addOrdinalSuffix(to: validDate)
        return formattedDate.replacingOccurrences(of: "\(Calendar.current.component(.day, from: validDate))", with: dayWithOrdinal)
    }
    
    return formattedDate
}
/*func formatDateToCustomFormat(apiDateString: String, formatIndex: Int) -> String? {
    // Step 1: Parse the API date string into a Date object
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Assuming API returns UTC
    
    guard let date = dateFormatter.date(from: apiDateString) else {
        return nil
    }
    
    // Step 2: Define the desired date formats
    let formats = [
        "EEE, d MMM yyyy | h:mm a",    // Format for index 0
        "EEE, d MMM yyyy",             // Format for index 1
        "yyyy-MM-dd hh:mm a"           // Format for index 2
    ]
    
    // Step 3: Ensure the format index is within bounds
    guard formatIndex >= 0 && formatIndex < formats.count else {
        return nil
    }
    
    // Step 4: Format the date
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = formats[formatIndex]
    let formattedDate = outputFormatter.string(from: date)
    
    // Add ordinal suffix if required for the first two formats
    if formatIndex == 0 || formatIndex == 1 {
        let dayWithOrdinal = addOrdinalSuffix(to: date)
        return formattedDate.replacingOccurrences(of: "\(Calendar.current.component(.day, from: date))", with: dayWithOrdinal)
    }
    
    return formattedDate
}*/

// Helper function to add ordinal suffix to day
//func addOrdinalSuffix(to date: Date) -> String {
//    let day = Calendar.current.component(.day, from: date)
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .ordinal
//    return formatter.string(from: NSNumber(value: day)) ?? "\(day)"
//}
