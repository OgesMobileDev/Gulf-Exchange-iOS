//
//  HomePageViewController.swift
//  GulfExchangeApp
//
//  Created by macbook on 07/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//
/*
 navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
 let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
 let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomePageVC") as! HomePageViewController
 self.navigationController?.pushViewController(nextViewController, animated: true)
 */

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Photos
import Toast_Swift
import ScreenShield
enum HomeValidationSelection{
    case bankTransfer
    case cashPickup
    case mobileWallet
    case benefDetails
    case none
}

var isLoggedIN:IsLoggedin = .no
class HomePageViewController: UIViewController, Home2TableViewCellDelegate, ErrorAlertPopupViewDelegate {
    
    
   
    @IBOutlet weak var screenshootView1: UIView!
    @IBOutlet weak var screenshootView2: UIView!
    @IBOutlet weak var rateRefreshBtn: UIButton!
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var rateCalculatorView: UIView!
    @IBOutlet weak var bankTransferBottomView: UIView!
    @IBOutlet weak var bankTransferBtn: UIButton!
    @IBOutlet weak var cashPickupBtn: UIButton!
    @IBOutlet weak var cashPickupBottomView: UIView!
    @IBOutlet weak var mobileWalletBtn: UIButton!
    @IBOutlet weak var mobileWalletBottomView: UIView!
    //    rate calculator
    @IBOutlet weak var rateCalculatorTitleLbl: UILabel!
    @IBOutlet weak var rateCalculatorContentView: UIView!
    @IBOutlet weak var sendingImgView: UIImageView!
    @IBOutlet weak var sendingLbl: UILabel!
    @IBOutlet weak var sendingTF: UITextField!
    @IBOutlet weak var recivingImgView: UIImageView!
    @IBOutlet weak var recivingDownImg: UIImageView!
    @IBOutlet weak var recivingLbl: UILabel!
    @IBOutlet weak var sendingAmntTitleLbl: UILabel!
    @IBOutlet weak var recivingAmntTitleLbl: UILabel!
    @IBOutlet weak var recivingBtn: UIButton!
    @IBOutlet weak var recivingTF: UITextField!
    @IBOutlet weak var exchangeBtn: UIButton!
    @IBOutlet weak var exchangeRateLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rateCountryTableView: UITableView!
    @IBOutlet weak var rateExpandingView: UIView!
    @IBOutlet weak var rateViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rateBaseView: UIView!
    
    
    @IBOutlet var exchangeratedesclabel: UILabel!
    
    var expandToggle = false
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var casmexCustomerCode:String = ""
    var casmexSessionId:String = ""
    var casmexToken:String = ""
    
    var fNamestr:String = ""
    var namestr:String = ""
    var emailstr:String = ""
    var phonestr:String = ""
    var userName:String = ""
    var selectedRateCalculator:RateCalculator = .bankTransfer
    var serviceType: String = ""
    var rateCountryList:[CasmexRateCalcCountry] = []
    let transparentView = UIView()
    var divCount = 0
    var viewHeight = 0
    var selectedRate:CasmexRateCalcCountry?
    var amountType:String = ""
    var amount:String = "0"
    var isRateSend:Bool = false
    var rateDetails:CasmexRateDetails?
    let defaults = UserDefaults.standard
    var transferSelection:HomeValidationSelection = .none
    var udid:String!
    var loggedIn = false
    var count:Int = 0
    var oncecheckpopupstr:String = ""
    
    let ErrorPopupView = Bundle.main.loadNibNamed("ErrorAlertPopupView", owner: HomePageViewController.self, options: nil)?.first as! ErrorAlertPopupView
    
    //test
    static let AlamoFireManager: Alamofire.Session = {
        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator(),
                                                      "ws.gulfexchange.com.qa": DisabledEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    //
//    production
//                  static let AlamoFireManager: Alamofire.Session = {
//                //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
//                        let configuration = URLSessionConfiguration.af.default
//                        return Session(configuration: configuration)
//                //        return Session(configuration: configuration, serverTrustManager: manager)
//                    }()
    
    
    func overrideHorizontalSizeClassIfNeeded() {
            if #available(iOS 18.0, *) {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    self.traitOverrides.horizontalSizeClass = .unspecified
                }
            }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideHorizontalSizeClassIfNeeded()
        
        rateExpandingView.layer.zPosition = 10
//        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginChange(_:)), name: loginChangedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleLanguageChange(_:)), name: languageChangedNotification, object: nil)
        
        self.topTableView?.register(UINib.init(nibName: "Home1TableViewCell", bundle: .main), forCellReuseIdentifier: "Home1TableCell")
        self.topTableView?.register(UINib.init(nibName: "Home2TableViewCell", bundle: .main), forCellReuseIdentifier: "Home2TableCell")
        self.rateCountryTableView?.register(UINib.init(nibName: "RateCountryListTableViewCell", bundle: .main), forCellReuseIdentifier: "RateCountryListTableViewCell")
        ErrorPopupView.delegate = self
        rateCountryTableView.delegate = self
        rateCountryTableView.dataSource = self
        topTableView.delegate = self
        topTableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = false
        setView()
        topTableView.reloadData()
        setTxtToSpeech()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginChange(_:)), name: loginChangedNotification, object: nil)
        print("willappear","willappear")
        /*
//        ScreenShield.shared.protect(view: rateRefreshBtn)
//        ScreenShield.shared.protect(view: bankTransferBtn)
//        ScreenShield.shared.protect(view: cashPickupBtn)
//        ScreenShield.shared.protect(view: mobileWalletBtn)
//        ScreenShield.shared.protect(view: sendingImgView)
        ScreenShield.shared.protect(view: sendingLbl)
        ScreenShield.shared.protect(view: sendingTF)
//        ScreenShield.shared.protect(view: recivingImgView)
//        ScreenShield.shared.protect(view: recivingDownImg)
        ScreenShield.shared.protect(view: recivingLbl)
        ScreenShield.shared.protect(view: sendingAmntTitleLbl)
        ScreenShield.shared.protect(view: recivingAmntTitleLbl)
//        ScreenShield.shared.protect(view: recivingBtn)
        ScreenShield.shared.protect(view: recivingTF)
//        ScreenShield.shared.protect(view: exchangeBtn)
        ScreenShield.shared.protect(view: exchangeRateLbl)
//        ScreenShield.shared.protect(view: rateRefreshBtn)
        ScreenShield.shared.protectFromScreenRecording()
         */
        if isLoggedIN == .yes{
            getToken(num: 2)
            
        }
        topTableView.reloadData()
    }
    
    
    @IBAction func rateRefreshBtnTapped(_ sender: Any) {
        print("rateRefreshBtnTapped")
        selectedRateCalculator = .bankTransfer
        changeRateCalclContent()
        rateCountryList.removeAll()
        recivingTF.text = ""
        sendingTF.text = ""
        recivingImgView.image = UIImage(named: "default_image")
        recivingLbl.text = "---"
        expandToggle = true
        setDropDownView()
    }
    @IBAction func bankTransferBtnTapped(_ sender: Any) {
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("bank Transfer", languageCode: "en")
        }
        selectedRateCalculator = .bankTransfer
        recivingTF.text = ""
        sendingTF.text = ""
        changeRateCalclContent()
    }
    @IBAction func cashPickupBtnTapped(_ sender: Any) {
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("cash Pickup", languageCode: "en")
        }
        selectedRateCalculator = .cashPickup
        recivingTF.text = ""
        sendingTF.text = ""
        changeRateCalclContent()
        
    }
    @IBAction func mobileWalletBtnTapped(_ sender: Any) {
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("mobile Wallet", languageCode: "en")
        }
        selectedRateCalculator = .mobileWallet
        recivingTF.text = ""
        sendingTF.text = ""
        changeRateCalclContent()
        
    }
    
    @IBAction func recivingCountryBtnTapped(_ sender: Any) {
        print("recivingCountryBtnTapped")
        setDropDownView()
    }
    @IBAction func exchangeBtnTapped(_ sender: Any) {
        print("exchangeBtnTapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("exchange", languageCode: "en")
        }
        expandToggle = true
        sendingTF.resignFirstResponder()
        recivingTF.resignFirstResponder()
        setDropDownView()
        getRateDetails()
    }
    //MARK: - Functions
    func navigateFromValidation(){
        switch transferSelection {
        case .bankTransfer:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
            vc.currentSelection = .bankTransfer
            self.navigationController?.pushViewController(vc, animated: true)
        case .cashPickup:
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
            vc.currentSelection = .cashPickup
            self.navigationController?.pushViewController(vc, animated: true)
        case .mobileWallet:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
            vc.currentSelection = .mobileWallet
            self.navigationController?.pushViewController(vc, animated: true)
        case .benefDetails:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: ManageBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageBeneficiaryVC") as! ManageBeneficiaryVC
            self.navigationController?.pushViewController(vc, animated: true)
        case .none:
            print("")
        }
    }
    
    func setTxtToSpeech(){
//        let voices = AVSpeechSynthesisVoice.speechVoices()
//        for voice in voices {
//            print("\(voice.language) - \(voice.name)")
//        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(rateCalculatorTitleLblTapped(_:)))
        rateCalculatorTitleLbl.isUserInteractionEnabled = true
        rateCalculatorTitleLbl.addGestureRecognizer(tapGesture)
        
    }
    @objc func rateCalculatorTitleLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("Rate calculator", languageCode: "en")
            }
        }
    }
    func setRateData(){
        
        loadCountryFlag(for: rateCountryList[0].countryCode, into: recivingImgView)
        recivingLbl.text = rateCountryList[0].currencyCode
        selectedRate = rateCountryList[0]
    }
    func addErrorPopup(msg:String,subMsg:String){
        ErrorPopupView.setView(msg: msg, subMsg: subMsg)
        ErrorPopupView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        ErrorPopupView.alpha = 0.0
        view.addSubview(ErrorPopupView)
        UIView.animate(withDuration: 0.3, animations: {
            self.ErrorPopupView.alpha = 1.0
        })
        
    }
    func ErrorAlertPopupView(_ vc: ErrorAlertPopupView, action: Bool) {
        if action{
            ErrorPopupView.removeFromSuperview()
        }
    }
    func setDropDownView(){
        exchangeRateLbl.isHidden = true
        expandToggle.toggle()
        rateCountryTableView.reloadData()
        if expandToggle{
            var viewHeight = 0
            divCount = rateCountryList.count
            if divCount > 4{
                viewHeight = 155
            }else{
                viewHeight = Int(divCount * 40 + 40)
            }
            rateBaseView.layer.cornerRadius = 4
            rateBaseView.layer.borderWidth = 1
            rateBaseView.layer.borderColor = UIColor.rgba(242, 242, 242, 1).cgColor
            
            rateExpandingView.isHidden = false
            recivingDownImg.isHidden = true
            rateViewHeight.constant = CGFloat(viewHeight)
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()
                addShadow(view: self.rateBaseView)
            }
        }else{
            rateViewHeight.constant = 40
            rateBaseView.layer.cornerRadius = 0
            rateBaseView.layer.borderWidth = 0
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.sendingTF.resignFirstResponder()
                self.recivingTF.resignFirstResponder()
                self.sendingTF.text?.removeAll()
                self.recivingTF.text?.removeAll()
                self.rateExpandingView.isHidden = true
                self.recivingDownImg.isHidden = false
                removeShadow(view: self.rateBaseView)
            }
        }
        
    }
    
    func setView(){
        rateViewHeight.constant = 40
        rateExpandingView.isHidden = true
        exchangeRateLbl.isHidden = true
//        recivingImgView.contentMode = .scaleAspectFit
        rateRefreshBtn.setTitle("", for: .normal) // Remove title
        rateRefreshBtn.setImage(UIImage(named: "reload_icon 1"), for: .normal) // Add image from assets
        rateRefreshBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rateRefreshBtn.imageView?.contentMode = .scaleAspectFit
        bankTransferBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("BankTransfer", comment: ""), size: 10, font: .semiBold), for: .normal)
        cashPickupBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("cash_pickup", comment: ""), size: 10, font: .semiBold), for: .normal)
       
        mobileWalletBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("Mobile Wallet", comment: ""), size: 10, font: .semiBold), for: .normal)
        
        //        rateRefreshBtn.tintColor = UIColor(named: "color_red")
        recivingBtn.setAttributedTitle(buttonTitleSet(title: "", size: 10, font: .semiBold), for: .normal)
        exchangeBtn.setAttributedTitle(buttonTitleSet(title: "", size: 10, font: .semiBold), for: .normal)
        rateCalculatorView.layer.cornerRadius = 10
        rateCalculatorView.layer.borderWidth = 1
        rateCalculatorView.layer.borderColor = UIColor.rgba(19, 56, 82, 0.1).cgColor
        rateCalculatorView.clipsToBounds = true
        sendingAmntTitleLbl.text = NSLocalizedString("sending_amount", comment: "")
        recivingAmntTitleLbl.text = NSLocalizedString("receiving_amount", comment: "")
        rateCalculatorTitleLbl.text = NSLocalizedString("Rate Calculater", comment: "")
        exchangeratedesclabel.text = NSLocalizedString("Exhange rates are indicatve and are subject to change", comment: "")
        
        mobileWalletBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("Mobile Wallet", comment: ""), size: 10, font: .semiBold), for: .normal)
        
      
        
       // self.bankTransferBtn.setTitle(NSLocalizedString("BankTransfer", comment: ""), for: .normal)
        
        
        
        changeRateCalclContent()
        addShadow(view: rateCalculatorView)
        
    }
    func changeRateCalclContent(){
        expandToggle = true
        setDropDownView()
        switch selectedRateCalculator {
        case .bankTransfer:
            serviceType = "CREDIT"
            bankTransferBottomView.isHidden = false
            mobileWalletBottomView.isHidden = true
            cashPickupBottomView.isHidden = true
            bankTransferBtn.tintColor = colorRed
            cashPickupBtn.tintColor = .black
            mobileWalletBtn.tintColor = .black
            
        case .cashPickup:
            serviceType = "CASH"
            bankTransferBottomView.isHidden = true
            mobileWalletBottomView.isHidden = true
            cashPickupBottomView.isHidden = false
            cashPickupBtn.tintColor = colorRed
            bankTransferBtn.tintColor = .black
            mobileWalletBtn.tintColor = .black
            
        case .mobileWallet:
            serviceType = "CASH_TO_MOBILE"
            bankTransferBottomView.isHidden = true
            mobileWalletBottomView.isHidden = false
            cashPickupBottomView.isHidden = true
            mobileWalletBtn.tintColor = colorRed
            bankTransferBtn.tintColor = .black
            cashPickupBtn.tintColor = .black
        }
        self.getRateCountries()
        
    }
    @objc func handleLoginChange(_ notification: Notification){
        if let data = notification.userInfo as? [String:Any] {
            isLoggedIN = data["isLoggedIN"] as! IsLoggedin
            if isLoggedIN == .yes{
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
            topTableView.reloadData()
        }
    }
    @objc func handleLanguageChange(_ notification: Notification){
        if let data = notification.userInfo as? [String:Any] {
            let lang = data["language"] as! Bool
            if lang{
                topTableView.reloadData()
            }else{
                topTableView.reloadData()
            }
        }
    }
    func getRateDetails(){
        if sendingTF.text == "" && recivingTF.text == ""{
            showAlert(title: "ERROR", message: "Please enter amount in one field")
        }else if sendingTF.text != "" && recivingTF.text != ""{
            showAlert(title: "ERROR", message: "Please fill in only one field with the amount")
        }else {
            if sendingTF.text == ""{
                isRateSend = false
                amountType = "F"
                amount = recivingTF.text ?? "0"
            }else{
                isRateSend = true
                amountType = "L"
                amount = sendingTF.text ?? "0"
            }
            getRates()
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
    
    func setRateDetails(){
        exchangeRateLbl.isHidden = false
        sendingTF.text = rateDetails?.lcyAmount
        recivingTF.text = rateDetails?.fcyAmount
        exchangeRateLbl.text = "1 QAR = \(rateDetails?.divRate ?? "") \(selectedRate?.currencyCode ?? "") "
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
    func showToast(message: String, font: UIFont) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let maxWidthPercentage: CGFloat = 0.8
        let maxTitleSize = CGSize(width: view.bounds.size.width * maxWidthPercentage, height: view.bounds.size.height * maxWidthPercentage)
        var titleSize = toastLabel.sizeThatFits(maxTitleSize)
        titleSize.width += 20
        titleSize.height += 10
        toastLabel.frame = CGRect(x: view.frame.size.width / 2 - titleSize.width / 2, y: view.frame.size.height - 50, width: titleSize.width, height: titleSize.height)
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
    //MARK: - API Calls
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        print("tokenurl",url)
        //        self.olduserchkstr = "0"
        
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
                if(num == 1)
                {
                    self.validateRemittanceStatus(check: 1, accessToken: token)
                }
                if(num == 2)
                {
                    self.getProfileInfo(access_token: token)
                }
                break
            case .failure:
                break
            }
            
        })
    }
    func getProfileInfo(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        print("getProfileInfo params - \(params)")
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let respCode = myResult!["responseCode"]
                if(respCode == "S104")
                {
                    self.userName = myResult!["workingAddress3"].stringValue
                    self.topTableView.reloadData()
                    self.defaults.removeObject(forKey: "GLEmail")
                    self.defaults.removeObject(forKey: "GLFirstName")
                    self.defaults.removeObject(forKey: "GLUserName")
                    self.defaults.removeObject(forKey: "GLPhone")
                    self.fNamestr =  myResult!["customerFirstName"].stringValue
                    self.namestr =  myResult!["workingAddress3"].stringValue
                    self.emailstr = myResult!["email"].stringValue
                    self.phonestr =  myResult!["customerMobile"].stringValue
                    print("self.namestr",self.namestr)
                    print("self.emailstr",self.emailstr)
                    print("self.phonestr",self.phonestr)
                    self.defaults.set(self.emailstr, forKey: "GLEmail")
                    self.defaults.set(self.fNamestr, forKey: "GLFirstName")
                    self.defaults.set(self.namestr, forKey: "GLUserName")
                    self.defaults.set(self.phonestr, forKey: "GLPhone")
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
        })
    }
    
    
    func getRateCountries(){
        rateCountryList.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "shiftservice/getRateCountries"
        let params:Parameters =  [
            "serviceType":serviceType
        ]
        
//        print("URL getRateCountries",url)
//        print("params getRateCountries",params)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data ?? Data())
//            print("getRateCountries resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                if let resultArray = myResult?["data"]{
                    for i in resultArray.arrayValue{
                        let rateList = CasmexRateCalcCountry(countryCode:  i["countryCode"].stringValue, countryName:  i["countryName"].stringValue, currencyCode:  i["currencyCode"].stringValue, currencyName:  i["currencyName"].stringValue)
                        self.rateCountryList.append(rateList)
                        self.setRateData()
                    }
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
            
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
        })
    }
    
    func getRates(){
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "shiftservice/getRates"
        let params:Parameters =  [
            "serviceType":serviceType,
            "amountType":amountType,
            "amount":amount,
            "currencyCode":selectedRate?.currencyCode,
            "countryCode":selectedRate?.countryCode
        ]
        
//        print("URL getRates",url)
//        print("params getRates",params)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
//            print("getRates resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                if let statusCode = myResult?["statusCode"]{
                    if statusCode == "200"{
                        let rate = CasmexRateDetails(statusCode: myResult?["statusCode"].rawValue as! String,
                                                     statusMessage: myResult?["statusMessage"].rawValue as! String,
                                                     fcyAmount: myResult?["fcyAmount"].rawValue as! String,
                                                     lcyAmount: myResult?["lcyAmount"].rawValue as! String,
                                                     mulRate: myResult?["mulRate"].rawValue as! String,
                                                     divRate: myResult?["divRate"].rawValue as! String,
                                                     charge: myResult?["charge"].rawValue as! String,
                                                     vat: myResult?["vat"].rawValue as! String)
                        self.rateDetails = rate
                        self.setRateDetails()
                    }else{
                        showAlert(title: "ERROR", message: "Error loading data \n Please try again")
                    }
                }
            case .failure:
                break
            }

          
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
        })
    }
    
    func validateRemittanceStatus(check:Int,accessToken:String) {
        self.defaults.removeObject(forKey: "casmexCustomerCode")
        self.defaults.removeObject(forKey: "casmexSessionId")
        self.defaults.removeObject(forKey: "casmexToken")
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        
        let appVersion = AppInfo.version
                     print("appVersion",appVersion)        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":appVersion,"customerPhone":"IOS","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"ISREMITALLOWED","isExistOrValid":"0"]
        
        print("paramsvalidationutility ",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["responseCode"]
                 print("respCoderespCoderespCode ",respCode)
                let respMsg = myResult!["responseMessage"].stringValue
                if(respCode == "S1111")
                {
                    
                    let CustomerCode = myResult!["casmexCustomerCode"].stringValue
                    self.casmexCustomerCode = CustomerCode
                    self.defaults.set(CustomerCode, forKey: "casmexCustomerCode")
                    
                    let sessionId = myResult!["casmexSessionId"].stringValue
                    self.casmexSessionId = sessionId
                    self.defaults.set(sessionId, forKey: "casmexSessionId")
                    
                    let token = myResult!["casmexToken"].stringValue
                    self.casmexToken = token
                    self.defaults.set(token, forKey: "casmexToken")
                    if(check == 1)
                    {
                        self.navigateFromValidation()
                    }
                    else if(check == 2)
                    {
                        
                    }
                    else if(check == 3)
                    {
                        
                    }
                }
                else if(respCode == "S2222")
                {
                    
                    
                    let CustomerCode = myResult!["casmexCustomerCode"].stringValue
//                    self.casmexCustomerCode = CustomerCode
                    self.defaults.set(CustomerCode, forKey: "casmexCustomerCode")
                    
                    let sessionId = myResult!["casmexSessionId"].stringValue
//                    self.casmexSessionId = sessionId
                    self.defaults.set(sessionId, forKey: "casmexSessionId")
                    
                    let token = myResult!["casmexToken"].stringValue
//                    self.casmexToken = token
                    self.defaults.set(token, forKey: "casmexToken")
                    
                    let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                    let okAction = UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                      
                        self.navigateFromValidation()
                                        
                    }
                            commonAlert.addAction(okAction)
                    self.present(commonAlert, animated: true, completion: nil)
                }
                else if(respCode == "E9999")
                {
                       // AlertView.instance.showAlert(msg: respMsg, action: .attention)
                       // self.getPopupNotificationList()
                        self.getNewVersionalertList()
                }
                else if(respCode == "E7112")
                {
                    self.addErrorPopup(msg: respMsg, subMsg: "")
                    //original
    //                AlertView.instance.showAlert(msg: respMsg, action: .attention)
                    
    //                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
    //                let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
    //
    //                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //                   // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //                    let vc: ActualOccupationViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActualOccupationViewController") as! ActualOccupationViewController
    //                    self.navigationController?.pushViewController(vc, animated: true)
    //
    //                }
    //                        commonAlert.addAction(okAction)
    //                self.present(commonAlert, animated: true, completion: nil)
                   
                }
                else if(respCode == "E7002")
                {
                    let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                    let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                      
                        if let navigationController = self.navigationController {
                            // Check if ProfileVC exists in the navigation stack
                            if let tabController = navigationController.viewControllers.first(where: { $0 is CustomTabController }) as? CustomTabController {
                                tabController.selectedIndex = 2
                                tabController.profileSelection = 2
                                tabController.setTabSelections(currentIndex: 2)
                                navigationController.popToViewController(tabController, animated: true)
                            } else {
                                // If not in stack, push ProfileVC
                                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                let storyboard = UIStoryboard(name: "Main10", bundle: nil)
                                if let nextViewController = storyboard.instantiateViewController(withIdentifier: "CustomTabController") as? CustomTabController {
                                    nextViewController.profileSelection = 2
                                    nextViewController.selectedIndex = 2
                                    nextViewController.setTabSelections(currentIndex: 2)
                                    navigationController.pushViewController(nextViewController, animated: true)
                                }
                            }
                        } else {
                            print("❌ Error: navigationController is nil. Ensure this view is inside a UINavigationController.")
                        }
                                        
                    }
                            commonAlert.addAction(okAction)
                    self.present(commonAlert, animated: true, completion: nil)
                }
                else if(respCode == "E7003")
                {
                    let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                    let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                      
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                       // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        let vc: ActualOccupationViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActualOccupationViewController") as! ActualOccupationViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                                        
                    }
                            commonAlert.addAction(okAction)
                    self.present(commonAlert, animated: true, completion: nil)
                }
                else
                {
                    self.addErrorPopup(msg: NSLocalizedString("u_r_not_allowed", comment: ""), subMsg: NSLocalizedString("contact_customer_care", comment: ""))
    //                AlertView.instance.showAlert(msg: NSLocalizedString("u_r_not_allowed", comment: "") + NSLocalizedString("contact_customer_care", comment: ""), action: .attention)
                }
                
            case .failure:
                break
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
    //newvresion alert
    func getNewVersionalertList() {
       var notificMessageList1: [String] = []
       let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
             let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               self.activityIndicator(NSLocalizedString("loading", comment: ""))
               let url = api_url + "application_update_notification"
        let params:Parameters = ["lang": appLang,"device_type":"IOS"]
                 AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                   print("NEWVERRESPONSE",response)
                    self.effectView.removeFromSuperview()
                   switch response.result{
                   case .success:
                       guard let responseData = response.data else {
                           return
                       }
                       guard let myResult = try? JSON(data: responseData) else {
                           return
                       }
                       let popupListing1 = myResult["application_update_notification"]
                       if(popupListing1.count > 0) {
                           for popupObject in popupListing1.arrayValue {
                               let currentItemKey = "app_notf_desc_" + appLang
                               let currentItemEn = "app_notf_desc_en"
                               let desc = popupObject[currentItemKey].stringValue
                               let desc2 = popupObject[currentItemEn].stringValue
                               if(desc != "") {
                               let descString = desc
                               notificMessageList1.append(descString)
                                    print("descprint",descString)
//                                self.showPopupAlert(desc: descString)
                               } else if(desc2 != "") {
                               let desc2String = desc
                               notificMessageList1.append(desc2String)
                                   print("descprint2",desc2String)
//                                self.showPopupAlert(desc: desc2String)
                           }
                       }
                           
//                           let a = ["", "", ""]
//                           let b = notificMessageList
//                        if a == b {
//                             print("Nullcontentpopup",notificMessageList)
//                        }
                          // else
                        //{
                        
                
//                        let vc: WEBVIEWHomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
//
//
//                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                        
                        
                        
                        ///
                           if notificMessageList1.count > 0 {
                           self.showPopupAlertone(descArray: notificMessageList1)
                                 print("contentpopupNEWVER",notificMessageList1)


                               //
//                               print("NullcontentpopupNEWVER",self.oncecheckpopupstr)
                           }
                        ////
                        
                        
                          // }
                        print("contentpopupNEWVERout",notificMessageList1)
                           
                           
                       }
                   break
                   case .failure:
                       break
                   
                   }
                 })
       }
    
   /* func getPopupNotificationList() {
       var notificMessageList: [String] = []
       let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
             let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               self.activityIndicator(NSLocalizedString("loading", comment: ""))
               let url = api_url + "popup_notification_listing"
           let params:Parameters = ["lang": appLang]
                 AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                   print("popup_notification_listing response",response)
                   switch response.result{
                   case .success:
                       guard let responseData = response.data else {
                           return
                       }
                       guard let myResult = try? JSON(data: responseData) else {
                           return
                       }
                       let popupListing = myResult["popup_notification_listing"]
                       if(popupListing.count > 0) {
                           for popupObject in popupListing.arrayValue {
                               let currentItemKey = "popup_notf_desc_" + appLang
                               let currentItemEn = "popup_notf_desc_en"
                               let desc = popupObject[currentItemKey].stringValue
                               let desc2 = popupObject[currentItemEn].stringValue
                               if(desc != "") {
                               let descString = desc
                               notificMessageList.append(descString)
                                    print("descprint",descString)
//                                self.showPopupAlert(desc: descString)
                               } else if(desc2 != "") {
                               let desc2String = desc
                               notificMessageList.append(desc2String)
                                   print("descprint2",desc2String)
//                                self.showPopupAlert(desc: desc2String)
                           }
                       }
                           
                           let a = ["", "", ""]
                           let b = notificMessageList
                        if a == b {
                             print("Nullcontentpopup",notificMessageList)
                        }
                           else
                        {
                           if notificMessageList.count > 0 {
                           self.showPopupAlert(descArray: notificMessageList)
                                 print("contentpopup",notificMessageList)
                               
                               self.oncecheckpopupstr = "1"
                               //
                               print("Nullcontentpopup",self.oncecheckpopupstr)
                           }
                           }
                           
                           
                           
                       }
                   break
                   case .failure:
                       break
                   
                   }
                 })
       }*/
    
    func showPopupAlert(descArray: [String]) {
        var arrayFilter = descArray
        if arrayFilter.count > 0 {
//        let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: arrayFilter[0], preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { action in
//            arrayFilter.remove(at: 0)
//            self.showPopupAlert(descArray: arrayFilter)
//        }))
//        self.present(alert, animated: true)
            
            //create view controller
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController")
//            //remove black screen in background
//            vc.modalPresentationStyle = .overCurrentContext
//            //add clear color background
//            vc.view.backgroundColor = UIColor.clear
//            //present modal
//            self.present(vc, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "IS_POPUP_SHOWN")
            let popup : PopupViewController = self.storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
            self.presentOnRoot(with: popup, descArray: arrayFilter)
        }
    }
    func showPopupAlertone(descArray: [String]) {
        var arrayFilter = descArray
        if arrayFilter.count > 0 {
//        let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: arrayFilter[0], preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { action in
//            arrayFilter.remove(at: 0)
//            self.showPopupAlert(descArray: arrayFilter)
//        }))
//        self.present(alert, animated: true)
            
            //create view controller
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController")
//            //remove black screen in background
//            vc.modalPresentationStyle = .overCurrentContext
//            //add clear color background
//            vc.view.backgroundColor = UIColor.clear
//            //present modal
//            self.present(vc, animated: true, completion: nil)
            
            
//            let vc: WEBVIEWHomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
//            vc.descArray = descArray
//
//            self.navigationController?.pushViewController(vc, animated: true)
            
            let vc: WEBTEXTVViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBTEXTVViewController") as! WEBTEXTVViewController
            vc.descArray = descArray
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            
    
//            let popupone : WEBVIEWHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
//            self.presentOnRoot(with: popupone, descArray: arrayFilter)
        }
    }
    
    
    
    
}
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == topTableView{
            return 1
        }else{
            return rateCountryList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == topTableView{
            switch isLoggedIN {
            case .yes:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Home2TableCell", for: indexPath) as! Home2TableViewCell
                //            cell.addData()
//                cell.setScreenshoot()
                
                cell.quickAccessLbl.text = NSLocalizedString("Quick Access", comment: "")
//                cell.seeAllBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("See All", comment: ""), size: 10, font: .semiBold), for: .normal)
                cell.seeAllBtn.addTarget(self, action: #selector(seeAllBtnTapped), for: .touchUpInside)
                cell.userNameLbl.text = userName
//                ScreenShield.shared.protect(view: cell.topView)
//                ScreenShield.shared.protect(view: cell.quickAccessLbl)
//                ScreenShield.shared.protect(view: cell.seeAllBtn)
                cell.startUpdatingTime()
                cell.delegate = self
                return cell
            case .no:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Home1TableCell", for: indexPath) as! Home1TableViewCell
                cell.setData()
                cell.quickAccessLbl.text = NSLocalizedString("Quick Access", comment: "")
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RateCountryListTableViewCell", for: indexPath) as! RateCountryListTableViewCell
            
            
            cell.countryLbl.text = rateCountryList[indexPath.row].currencyCode
            cell.setData(code: rateCountryList[indexPath.row].countryCode)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == topTableView{
            return 360
        }else{
            return 40
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            // Stop updating time when the cell is no longer visible
        if tableView == topTableView{
            if let timeCell = cell as? Home2TableViewCell {
                timeCell.stopUpdatingTime()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == rateCountryTableView{
            setDropDownView()
            selectedRate = rateCountryList[indexPath.row]
            recivingLbl.text = selectedRate?.currencyCode
            loadCountryFlag(for: selectedRate?.countryCode ?? "", into: recivingImgView)
        }
    }
    @objc func seeAllBtnTapped(sender: UIButton){
        
       
            if defaults.bool(forKey: "accessibilityenabled") {
                // Check if the button has a title label and speak its title
                if let buttonTitle = sender.titleLabel?.text {
                    SpeechHelper.shared.speak(buttonTitle, languageCode: "en")
                }
            }
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: AllServicesViewController = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "AllServicesViewController") as! AllServicesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func Home2TableViewCell(_ vc: Home2TableViewCell, index: Int) {
        
        switch index{
        case 0:
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("bank transfer", languageCode: "en")
            }
            transferSelection = .bankTransfer
            getToken(num: 1)
            print(" QuickAccess Tapped \(index)")
        case 1:
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("cash pickup", languageCode: "en")
            }
            transferSelection = .cashPickup
            getToken(num: 1)
            print(" QuickAccess Tapped \(index)")
        case 2:
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("mobile wallet transfer", languageCode: "en")
            }
            transferSelection = .mobileWallet
            getToken(num: 1)
            print(" QuickAccess Tapped \(index)")
        case 3:
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("beneficiaries", languageCode: "en")
            }
            transferSelection = .benefDetails
            getToken(num: 1)
//            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let vc: ManageBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageBeneficiaryVC") as! ManageBeneficiaryVC
//            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("track transaction", languageCode: "en")
            }
            print(" QuickAccess Tapped \(index)")
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: TransactionHistoryVC = UIStoryboard.init(name: "Main10", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransactionHistoryVC") as! TransactionHistoryVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("branches", languageCode: "en")
            }
//            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let vc: TransferReciptVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransferReciptVC") as! TransferReciptVC
//            self.navigationController?.pushViewController(vc, animated: true)
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: BranchListVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "BranchListVC") as! BranchListVC
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}













extension UIViewController {
    func setTitle1(_ title: String, andImage image: UIImage) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        //      let titleView = UIStackView(arrangedSubviews: [imageView, titleLbl])
        //        let titleView1 =
        //        titleView.axis = .horizontal
        //        titleView.spacing = 100.0
        navigationItem.titleView = imageView
    }
}





