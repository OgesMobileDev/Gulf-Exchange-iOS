//
//  TransferPage1VC.swift
//  GulfExchangeApp
//
//  Created by macbook on 30/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Photos
import Toast_Swift
import ScreenShield

class TransferPage1VC: UIViewController, AddBenefPopupViewDelegate, TermsPopupUIViewDelegate, ReviewTransactionPopupUIViewDelegate, OTPViewDelegate, TransactionResultPopupViewDelegate {
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectBic purpose: CasmexBICDetail?) {
        print("Not REQUIRED")
    }
    
    
    
   
    
    
   
    
    
    //Not REQUIRED
    func AddBenefPopupView(_ vc: AddBenefPopupView, cdidSelectCountry country: CasmexCountry?) {
        print("Not REQUIRED")
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectCurrency currency: CasmexCurrency?) {
        print("Not REQUIRED")
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectNationality nationality: CasmexNationality?) {
        print("Not REQUIRED")
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectrRelation relation: CasmexRelation?) {
        print("Not REQUIRED")
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectService service: CasmexServiceProvider?) {
        print("Not REQUIRED")
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectBank bank: CasmexBank?) {
        print("Not REQUIRED")
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectBranch branch: CasmexBranch?) {
        print("Not REQUIRED")
    }
    
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var screenshootView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var benfNameLbl: UILabel!
    @IBOutlet weak var benfProfileView: UIView!
    @IBOutlet weak var benfProfileImg: UIImageView!
    @IBOutlet weak var benfCountryImg: UIImageView!
    @IBOutlet weak var benfCountryName: UILabel!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var bankNameTF: UITextField!
    @IBOutlet weak var branchNameLbl: UILabel!
    @IBOutlet weak var branchNameTF: UITextField!
    @IBOutlet weak var serviceTypeLbl: UILabel!
    @IBOutlet weak var rateExchangeLbl: UILabel!
    @IBOutlet weak var exchangeBtn: UIButton!
    @IBOutlet weak var reciveCountryLbl: UILabel!
    @IBOutlet weak var sendAmntTF: UITextField!
    @IBOutlet weak var reciveAmntTF: UITextField!
    @IBOutlet weak var purposeLbl: UILabel!
    @IBOutlet weak var purposeTF: UITextField!
    @IBOutlet weak var purposeBgView: UIView!
    @IBOutlet weak var purposeBtn: UIButton!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var sourceTF: UITextField!
    @IBOutlet weak var sourceBgView: UIView!
    @IBOutlet weak var sourceBtn: UIButton!
    @IBOutlet weak var iAgreeLbl: UILabel!
    @IBOutlet weak var agreeImg: UIImageView!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var iAgreeBtn: UIButton!
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var proceedLbl: UILabel!
    @IBOutlet var emptyBtns: [UIButton]!
    @IBOutlet var textFiels: [UITextField]!
    @IBOutlet weak var serviceProviderConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var otpBgView: UIView!
    @IBOutlet weak var otpBaseView: UIView!
    
    @IBOutlet var qarlbl: UILabel!
    
    @IBOutlet var includingservicefrrlbl: UILabel!
    @IBOutlet weak var serviceFeeLbl: UILabel!
    
    
    let popUpView1 = Bundle.main.loadNibNamed("AddBenefPopupView", owner: TransferPage1VC.self, options: nil)?.first as! AddBenefPopupView
    let popUpView2 = Bundle.main.loadNibNamed("TermsPopupUIView", owner: TransferPage1VC.self, options: nil)?.first as! TermsPopupUIView
    let reviewPopup = Bundle.main.loadNibNamed("ReviewTransactionPopupUIView", owner: TransferPage1VC.self, options: nil)?.first as! ReviewTransactionPopupUIView
    let popUpOtpView = Bundle.main.loadNibNamed("OTPView", owner: TransferPage1VC.self, options: nil)?.first as! OTPView
    let resultPopupView = Bundle.main.loadNibNamed("TransactionResultPopupView", owner: TransferPage1VC.self, options: nil)?.first as! TransactionResultPopupView
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let defaults = UserDefaults.standard
    var termsClick:Bool = false
    var temrsContent = ""
    var currentDropdownSelection:AddBenfDropDownSelection = .purpose
    var currentSelection:TransferSelection = .none
    // otp
    var email:String = ""
    var mobile:String = ""
    var strOtp:String = ""
    var udid:String!
    var isOtpPopup:Bool = false
    var isTablePopup:Bool = false
    var isTermsPopup:Bool = false
    var isReviewPopup:Bool = false
    
    
    var sourceArray:[CasmexPurposeSource] = []
    var purposeArray:[CasmexPurposeSource] = []
    var selectedSource:CasmexPurposeSource?
    var selectedPurpose:CasmexPurposeSource?
    var serviceType:String = ""
    var deliveryOption:String = ""
    var benefDetails:CasmexListBeneficiary?
    var amountType:String = ""
    var sendAmount:String = ""
    var totalAmount:Double = 0.0
    var transferResponseRate:CasmexTransferRate?
    var promocodee:String = ""
    var sendTransactionDetails:MyTransactions?
    var isSendAgain:Bool = false
    
    var casmexCustomerCode:String = ""
    var casmexSessionId:String = ""
    var casmexToken:String = ""

    
    //test
    static let AlamoFireManager: Alamofire.Session = {
        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator(),
                                                      "ws.gulfexchange.com.qa": DisabledEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    //
    //production
    //              static let AlamoFireManager: Alamofire.Session = {
    //            //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
    //                    let configuration = URLSessionConfiguration.af.default
    //                    return Session(configuration: configuration)
    //            //        return Session(configuration: configuration, serverTrustManager: manager)
    //                }()
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTransactionChange(_:)), name: transactionChangeNotification, object: nil)
        addNavbar()
        setView()
        popUpView1.delegate = self
        popUpView2.delegate = self
        reviewPopup.delegate = self
        popUpOtpView.delegate = self
        resultPopupView.delegate = self
        sendAmntTF.delegate = self
        reciveAmntTF.delegate = self
        setTxtToSpeech()
        self.casmexToken = defaults.string(forKey: "casmexToken") ?? ""
        self.casmexSessionId = defaults.string(forKey: "casmexSessionId") ?? ""
        self.casmexCustomerCode = defaults.string(forKey: "casmexCustomerCode") ?? ""
    
        sendAmntTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        reciveAmntTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        fetchApis()
        getTermsandConditions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.udid = UIDevice.current.identifierForVendor?.uuidString
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
//        ScreenShield.shared.protect(view: bottomView)
        ScreenShield.shared.protect(view: titleLbl)
        ScreenShield.shared.protect(view: benfNameLbl)
//        ScreenShield.shared.protect(view: benfProfileView)
//        ScreenShield.shared.protect(view: benfProfileImg)
//        ScreenShield.shared.protect(view: benfCountryImg)
        ScreenShield.shared.protect(view: benfCountryName)
        ScreenShield.shared.protect(view: bankNameLbl)
        ScreenShield.shared.protect(view: bankNameTF)
        ScreenShield.shared.protect(view: branchNameLbl)
        ScreenShield.shared.protect(view: branchNameTF)
        ScreenShield.shared.protect(view: serviceTypeLbl)
        ScreenShield.shared.protect(view: rateExchangeLbl)
//        ScreenShield.shared.protect(view: exchangeBtn)
        ScreenShield.shared.protect(view: reciveCountryLbl)
        ScreenShield.shared.protect(view: sendAmntTF)
        ScreenShield.shared.protect(view: reciveAmntTF)
        ScreenShield.shared.protect(view: purposeLbl)
        ScreenShield.shared.protect(view: purposeTF)
//        ScreenShield.shared.protect(view: purposeBtn)
        ScreenShield.shared.protect(view: sourceLbl)
        ScreenShield.shared.protect(view: sourceTF)
//        ScreenShield.shared.protect(view: sourceBtn)
        ScreenShield.shared.protect(view: iAgreeLbl)
//        ScreenShield.shared.protect(view: agreeImg)
//        ScreenShield.shared.protect(view: termsBtn)
//        ScreenShield.shared.protect(view: iAgreeBtn)
        ScreenShield.shared.protect(view: serviceFeeLbl)
        ScreenShield.shared.protect(view: proceedLbl)
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLblLblTapped(_:)))
        titleLbl.isUserInteractionEnabled = true
        titleLbl.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(bankNameLblTapped(_:)))
        bankNameLbl.isUserInteractionEnabled = true
        bankNameLbl.addGestureRecognizer(tapGesture1)

        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(branchNameLblTapped(_:)))
        branchNameLbl.isUserInteractionEnabled = true
        branchNameLbl.addGestureRecognizer(tapGesture2)
//
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(banktransferLblTapped(_:)))
        serviceTypeLbl.isUserInteractionEnabled = true
        serviceTypeLbl.addGestureRecognizer(tapGesture3)
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(qarLblTapped(_:)))
        qarlbl.isUserInteractionEnabled = true
        qarlbl.addGestureRecognizer(tapGesture4)
        
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(reciveCountryLblTapped(_:)))
        reciveCountryLbl.isUserInteractionEnabled = true
        reciveCountryLbl.addGestureRecognizer(tapGesture5)
        
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(includingservicefeeLblTapped(_:)))
        includingservicefrrlbl.isUserInteractionEnabled = true
        includingservicefrrlbl.addGestureRecognizer(tapGesture6)
        
        let tapGesture7 = UITapGestureRecognizer(target: self, action: #selector(purposeLblTapped(_:)))
        purposeLbl.isUserInteractionEnabled = true
        purposeLbl.addGestureRecognizer(tapGesture7)
        
        let tapGesture8 = UITapGestureRecognizer(target: self, action: #selector(incomesourceLblTapped(_:)))
        sourceLbl.isUserInteractionEnabled = true
        sourceLbl.addGestureRecognizer(tapGesture8)
        
        
        let tapGesture9 = UITapGestureRecognizer(target: self, action: #selector(benfnameLblTapped(_:)))
        benfNameLbl.isUserInteractionEnabled = true
        benfNameLbl.addGestureRecognizer(tapGesture9)
        
        let tapGesture10 = UITapGestureRecognizer(target: self, action: #selector(benfcountryLblTapped(_:)))
        benfCountryName.isUserInteractionEnabled = true
        benfCountryName.addGestureRecognizer(tapGesture10)
    }
    
    @objc func titleLblLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("your sending to", languageCode: "en")
            }
        }
    }
    @objc func bankNameLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("bank Name", languageCode: "en")
            }
        }
        
    }
    
    @objc func branchNameLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("branch Name", languageCode: "en")
            }
        }
    }
    
    @objc func banktransferLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak(serviceTypeLbl.text!, languageCode: "en")
            }
        }
        
    }
    @objc func qarLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("qar", languageCode: "en")
            }
        }
    }
    
    @objc func reciveCountryLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak(reciveCountryLbl.text!, languageCode: "en")
            }
        }
        
    }
        
    @objc func includingservicefeeLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("including service fee", languageCode: "en")
            }
        }
    }
        
    @objc func purposeLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("purpose", languageCode: "en")
            }
        }
    }

    @objc func incomesourceLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("income source", languageCode: "en")
            }
        }
    }
    
    @objc func benfnameLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak(benfNameLbl.text!, languageCode: "en")
            }
        }
    }
    
    @objc func benfcountryLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak(benfCountryName.text!, languageCode: "en")
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
    
    @IBAction func exchangeBtnTapped(_ sender: Any) {
        sendAmntTF.resignFirstResponder()
        reciveAmntTF.resignFirstResponder()
        getTranferApiData()
    }
    @IBAction func purposeBtnTapped(_ sender: Any) {
        currentDropdownSelection = .purpose
        if !purposeArray.isEmpty{
            addPopUp()
        }else {
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Purposes available")
        }
    }
    @IBAction func sourceBtnTapped(_ sender: Any) {
        currentDropdownSelection = .source
        if !sourceArray.isEmpty{
            addPopUp()
        }else {
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Sources available")
        }
    }
    @IBAction func termsBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("terms and conditions", languageCode: "en")
        }
        
        popUpView2.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpView2.alpha = 0.0
        if temrsContent != ""{
            popUpView2.setView(content: temrsContent)
        }else{
            popUpView2.setView(content: "")
        }
        isTermsPopup = true
        view.addSubview(popUpView2)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView2.alpha = 1.0
        })
    }
    
    @IBAction func iAgreeBtnTapped(_ sender: Any) {
        if !termsClick{
            showAlert(title: "", message: "Please read the Terms And Conditions")
        }
    }
    @IBAction func proceedBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("proceed", languageCode: "en")
        }
        
        validateFields()
    }
    
    //MARK: - Functions
    
    func setView(){
        sendAmntTF.keyboardType = .numberPad
        reciveAmntTF.keyboardType = .numberPad
        otpBaseView.clipsToBounds = true
        otpBgView.isHidden = true
        otpBaseView.isHidden = true
        rateExchangeLbl.isHidden = true
        serviceFeeLbl.isHidden = true
        
        switch benefDetails?.serviceCategory {
        case "0002":
            print("selected bankTransfer")
            serviceType = "Bank Transfer"
            deliveryOption = "CREDIT"
            bankNameLbl.text = NSLocalizedString("bank_name1_sm", comment: "")
            branchNameTF.isHidden = false
            branchNameLbl.isHidden = false
            serviceProviderConstraint.constant = 110
            bankNameTF.text = "   \(benefDetails?.bankName ?? "----")"
            branchNameTF.text = "   \(benefDetails?.branchName ?? "----")"
        case "0001":
            print("selected cashPickup")
            serviceType = "Cash Pickup"
            deliveryOption = "CASH"
            bankNameLbl.text = NSLocalizedString("SERVICEPROVIDER", comment: "")
            branchNameTF.isHidden = true
            branchNameLbl.isHidden = true
            serviceProviderConstraint.constant = 15
            bankNameTF.text = "   \(benefDetails?.serviceProviderName ?? "----")"
            branchNameTF.text = "----"
        case "0003":
            print("selected mobileWallet")
            serviceType = "Mobile Wallet"
            deliveryOption = "CASH_TO_MOBILE"
            bankNameLbl.text = NSLocalizedString("SERVICEPROVIDER", comment: "")
            branchNameTF.isHidden = true
            branchNameLbl.isHidden = true
            serviceProviderConstraint.constant = 15
            bankNameTF.text = "   \(benefDetails?.serviceProviderName ?? "----")"
            branchNameTF.text = "----"
        default:
            print("selected unkown")
            serviceType = "Mobile Wallet"
            deliveryOption = "CASH_TO_MOBILE"
            bankNameLbl.text = NSLocalizedString("SERVICEPROVIDER", comment: "")
            branchNameTF.isHidden = true
            branchNameLbl.isHidden = true
            serviceProviderConstraint.constant = 15
            bankNameTF.text = "   \(benefDetails?.serviceProviderName ?? "----")"
            branchNameTF.text = "----"
        }
        
        reciveCountryLbl.text = benefDetails?.currency
        configureButton(button: termsBtn, title: NSLocalizedString("terms_conditions1", comment: ""), size: 12, font: .regular)
        for btn in emptyBtns{
            btn.setTitle("", for: .normal)
        }
        sourceTF.textColor = UIColor.rgba(139, 139, 139, 1)
        sourceTF.isUserInteractionEnabled = false
        purposeTF.textColor = UIColor.rgba(139, 139, 139, 1)
        purposeTF.isUserInteractionEnabled = false
        for tf in textFiels{
            tf.borderWidth = 1
            tf.borderColor = UIColor.rgba(232, 233, 233, 1)
            tf.layer.cornerRadius = 4
            tf.textColor = UIColor.rgba(139, 139, 139, 1)
            tf.isUserInteractionEnabled = false
        }
        benfProfileImg.isHidden = true
        createAvatar(username: benefDetails?.firstName ?? "-", view: benfProfileView, font: 30)
        benfNameLbl.text = "\(benefDetails?.firstName ?? "") \(benefDetails?.lastName ?? "")"
        loadCountryFlag(for: benefDetails?.country ?? "", into: benfCountryImg)
        benfCountryName.text = benefDetails?.currency ?? "---"
        serviceTypeLbl.text = serviceType
        print(sendTransactionDetails?.payinAmount)
        if isSendAgain{
            sendAmntTF.text = sendTransactionDetails?.payinAmount
        }
        
        
        
        branchNameLbl.text = NSLocalizedString("branch_name1_sm", comment: "")
        iAgreeLbl.text = NSLocalizedString("i_agree", comment: "")
        purposeLbl.text = NSLocalizedString("Purpose", comment: "")
        sourceLbl.text = NSLocalizedString("Income Source", comment: "")
        
            //self.termsBtn.setTitle(NSLocalizedString("terms_conditions1", comment: ""), for: .normal)
        
    }
    func getTranferApiData(){
        if sendAmntTF.text == "" && reciveAmntTF.text == ""{
            showAlert(title: "ERROR", message: "Please enter amount in one field")
        }else if sendAmntTF.text != "" && reciveAmntTF.text != ""{
            showAlert(title: "ERROR", message: "Please fill in only one field with the amount")
        }else {
            if sendAmntTF.text == ""{
                amountType = "F"
                sendAmount = reciveAmntTF.text ?? "0"
            }else{
                amountType = "L"
                sendAmount = sendAmntTF.text ?? "0"
            }
            getToken(num: 1)
        }
    }
    func setTranferApiData(){
        sendAmntTF.text = transferResponseRate?.localAmount ?? "00.00"
        reciveAmntTF.text = transferResponseRate?.receiveAmount ?? "00.00"
        rateExchangeLbl.isHidden = false
        serviceFeeLbl.isHidden = false
        /*let divRate = transferResponseRate?.divRate
        var trimmedDivRate:Double = 0.00
        if let divRateDouble = divRate {
           let  trimmedDivRateStr = String(format: "%.2f", divRateDouble)
            trimmedDivRate = Double(trimmedDivRateStr) ?? 00.00
        } else {
            print("Invalid number format")
        }
        let divRate = transferResponseRate?.divRate ?? "0"
        var trimmedDivRate:String = "0.00"
        if let divRateDouble = Double(divRate) {
            trimmedDivRate = String(format: "%.2f", divRateDouble)
        } else {
            print("Invalid number format")
        }*/
        rateExchangeLbl.text = "QAR 1 = \(benefDetails?.currency ?? "") \(transferResponseRate?.divRate ?? "0")"
        serviceFeeLbl.text = "Service Fee = QAR \(transferResponseRate?.charge ?? "0").00"
    }
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "Transfer"
    }
    @objc func customBackButtonTapped() {
        if isOtpPopup{
            removeOtpView()
            isOtpPopup = false
        }else
        /*if isTablePopup{
            popUpView1.removeFromSuperview()
            isTablePopup = false
        }else if isTermsPopup{
            popUpView2.removeFromSuperview()
            isTablePopup = false
        }else if isReviewPopup{
            reviewPopup.removeFromSuperview()
            isReviewPopup = false
        }else*/
        {
            self.navigationController?.popViewController(animated: true)
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
    
    func addPopUp(){
        popUpView1.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpView1.alpha = 0.0
        popUpView1.currentSelection = self.currentDropdownSelection
        popUpView1.searchTF.text?.removeAll()
        
        switch currentDropdownSelection {
        case .country:
            break
        case .currency:
            break
        case .nationality:
            break
        case .relation:
            break
        case .service:
            break
        case .bank:
            break
        case .branch:
            break
        case .bic:
            break
        case .source:
            popUpView1.sourceArray = sourceArray
            popUpView1.searchSource = sourceArray
        case .purpose:
            popUpView1.purposeArray = purposeArray
            popUpView1.searchPurpose = purposeArray
        }
        popUpView1.setupTableView()
        popUpView1.baseTableView.reloadData()
        isTablePopup = true
        view.addSubview(popUpView1)
        print("PopUpView")
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView1.alpha = 1.0
        })
    }
    func addReviewPopup(){
        reviewPopup.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        reviewPopup.alpha = 0.0
        if transferResponseRate != nil{
            reviewPopup.setView(data: transferResponseRate!, sendCurrency: benefDetails?.currency ?? "", total: totalAmount)
        }else{
            
        }
        isReviewPopup = true
        view.addSubview(reviewPopup)
        UIView.animate(withDuration: 0.3, animations: {
            self.reviewPopup.alpha = 1.0
        })
    }
    func showOtpView(){
        popUpOtpView.resetView()
        otpBgView.isHidden = false
        otpBaseView.isHidden = false
        otpBgView.alpha = 0.0
        otpBaseView.alpha = 0.0
        popUpOtpView.mobNum = "and email"
        isOtpPopup = true
        popUpOtpView.frame = otpBaseView.bounds
        popUpOtpView.setView()
        popUpOtpView.alpha = 0.0
        otpBaseView.addSubview(popUpOtpView)
        UIView.animate(withDuration: 0.3,  delay: 0, options: [.curveEaseOut]) {
            self.otpBgView.alpha = 1.0
            self.otpBaseView.alpha = 1.0
            self.popUpOtpView.alpha = 1.0
        }
    }
    func removeOtpView(){
        popUpOtpView.alpha = 1.0
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
            self.popUpOtpView.alpha = 0.0
            self.otpBgView.alpha = 0.0
            self.otpBaseView.alpha = 0.0
        } completion: { _ in
            self.popUpOtpView.resetView()
            self.popUpOtpView.removeFromSuperview()
            self.isOtpPopup = false
            self.otpBgView.isHidden = true
            self.otpBaseView.isHidden = true
        }
    }
    func addResultPopup(){
        resultPopupView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        resultPopupView.alpha = 0.0
        if transferResponseRate != nil{
            resultPopupView.paymentType = serviceType
            resultPopupView.setView()
        }else{
            
        }
//        isReviewPopup = true
        view.addSubview(resultPopupView)
        UIView.animate(withDuration: 0.3, animations: {
            self.resultPopupView.alpha = 1.0
        })
    }
    func TransactionResultPopupView(_ vc: TransactionResultPopupView, action: TransactionStatus) {
        switch action {
        case .failiure:
            if let navigationController = self.navigationController {
                for controller in navigationController.viewControllers {
                    if let tabController = controller as? CustomTabController {
                        navigationController.popToViewController(tabController, animated: true)
                        return
                    }
                }
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .success:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: TransferReciptVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransferReciptVC") as! TransferReciptVC
            self.navigationController?.pushViewController(vc, animated: true)
        case .none:
            if let navigationController = self.navigationController {
                for controller in navigationController.viewControllers {
                    if let tabController = controller as? CustomTabController {
                        navigationController.popToViewController(tabController, animated: true)
                        return
                    }
                }
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
    
    @objc func handleTransactionChange(_ notification: Notification){
        if let data = notification.userInfo as? [String:Any] {
            let check = data["transactionComplete"] as! Bool
            if check{
                // show result Pop up
                self.addResultPopup()
            }
        }
    }
    
    func validateFields(){
        
        if sendAmntTF.text == "" && reciveAmntTF.text == ""{
            self.view.makeToast("Please enter the amount", duration: 3.0, position: .center)
            return
        }
        if sendAmntTF.text == "" || reciveAmntTF.text == ""{
            self.view.makeToast("Please convert the amount", duration: 3.0, position: .center)
            return
        }
        
        if(purposeTF.text?.isEmpty == true)
        {
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.purposeBgView.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.purposeBgView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            self.view.makeToast(NSLocalizedString("sel_purpose", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.purposeBgView.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        
        if(sourceTF.text?.isEmpty == true)
        {
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.sourceBgView.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.sourceBgView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            self.view.makeToast(NSLocalizedString("sel_source", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.sourceBgView.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        
        if(!termsClick)
        {
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("pls_agree", comment: ""), duration: 3.0, position: .center)
           // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pls_agree", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        let amount1 = Double(transferResponseRate?.localAmount ?? "0") ?? 0.0
        let amount2 = Double(transferResponseRate?.charge ?? "0") ?? 0.0
        
        totalAmount = amount1 + amount2
        addReviewPopup()
    }
   
   
    //MARK: - Popup Delegate
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectSource source: CasmexPurposeSource?) {
        selectedSource = source
        sourceTF.text = "   \(selectedSource?.description ?? "----")"
        isTablePopup = false
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectPurpose purpose: CasmexPurposeSource?) {
        selectedPurpose = purpose
        purposeTF.text = "   \(selectedPurpose?.description ?? "----")"
        isTablePopup = false
    }
    func TermsPopupUIView(_ vc: TermsPopupUIView, action: Bool) {
        if action {
            isTermsPopup = false
            termsClick = true
            if #available(iOS 13.0, *) {
                agreeImg.image = UIImage(systemName: "checkmark.square.fill")
                agreeImg.tintColor = UIColor.rgba(198, 23, 30, 1)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    func ReviewTransactionPopupUIView(_ vc: ReviewTransactionPopupUIView, action: Bool) {
        if action{
            isReviewPopup = false
            self.getToken(num: 3)
        }
    }
    func OTPView(_ vc: OTPView, otp: String) {
        print("OTP - \(otp)")
        strOtp = otp
        self.getToken(num: 5)
    }
    
    func OTPView(_ vc: OTPView, resend: Bool) {
        if resend{
            self.getToken(num: 4)
        }
    }
    func OTPView(_ vc: OTPView, close: Bool) {
        if close{
            self.removeOtpView()
        }
    }
    
    
    //MARK: API Calls
    func fetchApis(){
        let mainGroup = DispatchGroup()
        
        mainGroup.enter()
        getPurpose{ [self] in
            mainGroup.leave()
            mainGroup.enter()
            getSource{
                mainGroup.leave()
            }
        }
    }
    
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
                    self.getAmounts(access_token: token)
                }
                else if(num == 2)
                {
                    self.createTransaction(access_token: token)
                }
                else if(num == 3)
                {
                    self.viewCustomer(access_token: token)
                }
                else if(num == 4)
                {
                    self.getOTP(access_token: token)
                }
                else if(num == 5)
                {
                    self.validateOTP(access_token: token)
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
        let url = ge_api_url_new + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!]
        
        print("urlviewcustomer",url)
        print("inputviewcustomer",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            self.email = myResult!["email"].stringValue
            self.mobile = myResult!["customerMobile"].stringValue
            print("email",self.email)
            print("mobile",self.mobile)
            self.getOTP(access_token: access_token)
            
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
    
    func getOTP(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/generateOtp"
        let params:Parameters = ["idNo":defaults.string(forKey: "USERID")!,"email":self.email,"type":"4","mobileNo":self.mobile]
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
                    if !self.isOtpPopup{
                        self.showOtpView()
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
    
    func validateOTP(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/verifyOtp"
        let params:Parameters = ["idNo":defaults.string(forKey: "USERID")!,"email":self.email,"type":"4","otpNo":self.strOtp,"mobileNo":self.mobile]
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
                    self.removeOtpView()
                    self.getToken(num: 2)
                }
                else
                {
                    self.removeOtpView()
                    let respMsg = myResult!["responseMessage"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                }
                
                break
            case .failure:
                break
            }
          })
    }
    
   
    
    func alertMessage(title: String, msg: String, action: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { _ in
            completion?() // Execute the completion handler if provided
        }))
        self.present(alert, animated: true)
    }
    
    func getPurpose(completion: @escaping () -> Void) {
        purposeArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "shiftservice/showDescription"
        let params:Parameters =  [
            "beneficiaryCode":benefDetails?.beneficiaryCode ?? "",
            "codeType":"PURPOSE",
            "idNo":defaults.string(forKey: "USERID")!,
            "casmexCustomerCode":self.casmexCustomerCode,
            "casmexSessionId":self.casmexSessionId,
            "casmexToken":self.casmexToken
        ]
        
        print("url getPurpose",url)
        print("params getPurpose",params)
//        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("getPurpose resp",response)
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            for i in resultArray.arrayValue{
                
                let purpose = CasmexPurposeSource(
                    responseCode: i["responseCode"].stringValue,
                    responseMessage: i["responseMessage"].stringValue,
                    messageDetail: i["messageDetail"].stringValue,
                    description: i["description"].stringValue,
                    id: i["id"].stringValue)
                self.purposeArray.append(purpose)
            }
            completion()
        })
    }
    func getSource(completion: @escaping () -> Void) {
        sourceArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "shiftservice/showDescription"
        let params:Parameters =  [
            "beneficiaryCode":benefDetails?.beneficiaryCode ?? "",
            "codeType":"SOURCE",
            "idNo":defaults.string(forKey: "USERID")!,
            "casmexCustomerCode":self.casmexCustomerCode,
            "casmexSessionId":self.casmexSessionId,
            "casmexToken":self.casmexToken
        ]
        
        print("url getSource",url)
        print("params getSource",params)
//        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("getSource resp",response)
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            for i in resultArray.arrayValue{
                
                let source = CasmexPurposeSource(
                    responseCode: i["responseCode"].stringValue,
                    responseMessage: i["responseMessage"].stringValue,
                    messageDetail: i["messageDetail"].stringValue,
                    description: i["description"].stringValue,
                    id: i["id"].stringValue)
                self.sourceArray.append(source)
            }
           
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
            completion()
        })
    }
    func getAmounts(access_token:String) {
        let appVersion = AppInfo.version
        print("appVersion",appVersion)
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/feelookup"
        let params:Parameters =  [
            "customerIDNo":defaults.string(forKey: "USERID")!,
            "amountType":amountType,
            "sendAmount":sendAmount,
            "receiveCurrency":benefDetails?.currency ?? "",
            "receiveCountry":benefDetails?.country ?? "",
            "deliveryOption":deliveryOption,
            "deviceType":"IOS",
            "VersionName":appVersion,
            "casmexCustomerCode":self.casmexCustomerCode,
            "casmexSessionId":self.casmexSessionId,
            "casmexToken":self.casmexToken
        ]
        
        print("url getSource",url)
        print("params getSource",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
           
            print("getAmounts Response - \(response) - \n")
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let userProfileResponse = try JSONDecoder().decode(CasmexTransferRate.self, from: data)
                        print(userProfileResponse)
                        self.transferResponseRate = userProfileResponse
                        self.setTranferApiData()
                    } catch {
                        print("Error decoding JSON: \(error.localizedDescription)")
                    }
                    self.effectView.removeFromSuperview()
                } else {
                    print("Error: No data in response")
                    self.effectView.removeFromSuperview()
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.effectView.removeFromSuperview()
            }
            
        })
    }
    
    func createTransaction(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "transaction/createtransaction"
        
        // saving data
        self.defaults.removeObject(forKey: "totalAmount")
        self.defaults.removeObject(forKey: "amount1")
        self.defaults.removeObject(forKey: "retailExchangeRate")
        self.defaults.removeObject(forKey: "first_name")
        self.defaults.removeObject(forKey: "last_name")
        self.defaults.removeObject(forKey: "address")
        self.defaults.removeObject(forKey: "mobile")
        self.defaults.removeObject(forKey: "country_name")
        self.defaults.removeObject(forKey: "country_code")
        self.defaults.removeObject(forKey: "currency")
        self.defaults.removeObject(forKey: "bank_code")
        self.defaults.removeObject(forKey: "branch_code")
        self.defaults.removeObject(forKey: "acc_no")
        self.defaults.removeObject(forKey: "purpose")
        self.defaults.removeObject(forKey: "source")
        self.defaults.removeObject(forKey: "relation")
        
        
        self.defaults.set(self.totalAmount, forKey: "totalAmount")
        self.defaults.set(self.transferResponseRate?.localAmount ?? "", forKey: "amount1")
        self.defaults.set(self.transferResponseRate?.divRate ?? "", forKey: "retailExchangeRate")
        self.defaults.set(self.benefDetails?.firstName ?? "", forKey: "first_name")
        self.defaults.set(self.benefDetails?.lastName ?? "", forKey: "last_name")
        self.defaults.set(self.benefDetails?.address ?? "", forKey: "address")
        self.defaults.set(self.benefDetails?.mobileNumber ?? "", forKey: "mobile")
        self.defaults.set(self.benefDetails?.receiveCountry ?? "", forKey: "country_name")
        self.defaults.set(self.benefDetails?.country ?? "", forKey: "country_code")
        self.defaults.set(self.benefDetails?.currency ?? "", forKey: "currency")
        self.defaults.set(self.benefDetails?.bankCode ?? "", forKey: "bank_code")
        self.defaults.set(self.benefDetails?.branchCode ?? "", forKey: "branch_code")
        self.defaults.set(self.benefDetails?.accountNumber ?? "", forKey: "acc_no")
        self.defaults.set(self.selectedPurpose?.id ?? "", forKey: "purpose")
        self.defaults.set(self.selectedSource?.id ?? "", forKey: "source")
        self.defaults.set(self.benefDetails?.relationship ?? "", forKey: "relation")
        
        //new promocode
        self.promocodee = defaults.string(forKey: "promocodee") ?? ""
        /*
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
        */
        
        let appVersion = AppInfo.version
        print("appVersion",appVersion)
        
       
        
        
        let params:Parameters =  [
            "partnerId":partnerId,
            "token":token,
            "requestTime":dateTime,
            "sourceApplication":"MOBILE",
            "customerRegNo":benefDetails?.customerCode ?? "",
            "customerIDNo":defaults.string(forKey: "USERID")!,
            "customerPassword":defaults.string(forKey: "PASSW")!,
            "mpin":defaults.string(forKey: "PIN")!,
            "mobileNo":self.mobile,
            "transactionDate":dateTime,
            "payinCurrency":"QAR",
            "payinAmount":transferResponseRate?.localAmount ?? "",
            "payoutCurrency":benefDetails?.currency ?? "",
            "payoutAmount":transferResponseRate?.receiveAmount ?? "",
            "exchangeRate":transferResponseRate?.divRate ?? "",
            "commission":0,
            "charges":transferResponseRate?.charge ?? "",
            "tax":"0",
            "totalPayinAmount":self.totalAmount,
            "deliveryOption":self.deliveryOption,
            "beneficiaryAccountNo":benefDetails?.accountNumber ?? "",
            "customerRelationship":benefDetails?.relationship ?? "",// nil
            "purposeOfTxn":selectedPurpose?.id ?? "",
            "sourceOfIncome":selectedSource?.id ?? "",
            "remittanceDevice":"IOS",
            "versionName":appVersion,
            "priceOrderCode":transferResponseRate?.priceOrderCode ?? "",
            "beneficiarySerialNo":benefDetails?.beneficiaryCode ?? "",
            "receiveCountry":benefDetails?.country ?? "",
            "paymentMode":"ONLINE",
            "paymentStatus":"-",
            "paymentGatewayName":"QPAY",
            "paymentGatewayTxnRefID":promocodee,
            "serviceProviderName":benefDetails?.serviceProviderName ?? "",
            "firstName":benefDetails?.firstName ?? "",
            "lastName":benefDetails?.lastName ?? "",
            "middleName":benefDetails?.middleName ?? "",
            "benfAddress":benefDetails?.address ?? "",
            "benfMobile":benefDetails?.mobileNumber ?? "",
            "benfCountry":benefDetails?.receiveCountry ?? "",
            "bankName":benefDetails?.bankName ?? "",
            "branchName":benefDetails?.branchName ?? "",
            "sourceDesc": selectedSource?.description ?? "",
            "purposeDesc": selectedPurpose?.description ?? "",
            "relationDesc":benefDetails?.relationshipDesc ?? ""
        ]
        
        //,"priceOrderCode":defaults.string(forKey: "priceordercodestored")!,"beneficiarySerialNo":defaults.string(forKey: "benficiaryseioalnostored")!,"remittanceDevice":"IOS","receiveCountry":defaults.string(forKey: "countrycodestored")!
        
        //deliveryOption servicetype dynamicstore
        
       // params2.put("priceOrderCode", priceOrderCode);  //newly added - feelookup api
       // params2.put("beneficiarySerialNo", beneficiarySerialNo);  //newly added -viewor list benfitiaryapi
       // params2.put("remittanceDevice", "ANDROID");  //newly added = //static ios
       // params2.put("receiveCountry", receiveCountry);  //newly added// rem1 recivercountry first country shw configoke
        print("urlCREATETRANSACTION",url)
        print("paramsCREATETRANSACTION",params)
        
        
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("Create trans response",response)
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
                
//                self.timer.invalidate()
                
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
    
    func getTermsandConditions() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "contents_listing"
        let params:Parameters = ["type":"9","lang":"en"]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("historytremsconditionapi",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["contents_listing"]
                for i in resultArray.arrayValue{
                    let content = i["contents_desc_en"].stringValue
                    self.temrsContent = content
                }
                break
            case .failure:
                break
            }
        })
    }
}
extension TransferPage1VC : UITextFieldDelegate{
    @objc func textFieldDidChange(_ textField: UITextField) {
            if textField.text?.isEmpty == true {
                if textField == sendAmntTF {
                    reciveAmntTF.text = ""
                } else if textField == reciveAmntTF {
                    sendAmntTF.text = ""
                }
            }
        }
}
