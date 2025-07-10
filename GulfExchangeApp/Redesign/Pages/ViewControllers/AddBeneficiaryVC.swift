//
//  AddBeneficiaryVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 20/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Photos
import Toast_Swift
import ScreenShield

enum AddBenfDropDownSelection{
    case country
    case currency
    case nationality
    case relation
    case service
    case bank
    case branch
    case source
    case purpose
    case bic
}
class AddBeneficiaryVC: UIViewController, GenderSelectionPopupViewDelegate, AddBenefPopupViewDelegate, TermsPopupUIViewDelegate, SetCalendar, OTPViewDelegate {
    
    
    
    
    
    
    func PutDate(dateVal: String) {
        //        dobTF.text = convertDateFormat(from: dateVal) ?? ""
        //        str_Dob = convertDateFormat(from: dateVal) ?? ""
        //        print("str_Dob\(str_Dob)")
        print("")
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectSource source: CasmexPurposeSource?) {
        print("Not REQUIRED")
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectPurpose purpose: CasmexPurposeSource?) {
        print("Not REQUIRED")
    }
    
    
    
    
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
    
    @IBOutlet var screenShootTFs: [UITextField]!
    @IBOutlet var screenShootLbls: [UILabel]!
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var middleNameLbl: UILabel!
    @IBOutlet weak var middleNameTF: UITextField!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencyTF: UITextField!
    @IBOutlet weak var currencyBtn: UIButton!
    @IBOutlet weak var natioalityLbl: UILabel!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var natioalityTF: UITextField!
    @IBOutlet weak var natioalityBtn: UIButton!
    @IBOutlet weak var relationLbl: UILabel!
    @IBOutlet weak var relationView: UIView!
    @IBOutlet weak var relationTF: UITextField!
    @IBOutlet weak var relationBtn: UIButton!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var dobBtn: UIButton!
    @IBOutlet weak var address1Lbl: UILabel!
    @IBOutlet weak var address1TF: UITextField!
    @IBOutlet weak var address2Lbl: UILabel!
    @IBOutlet weak var address2TF: UITextField!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var idNumLbl: UILabel!
    @IBOutlet weak var idNumTF: UITextField!
    @IBOutlet weak var serviceProviderLbl: UILabel!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var serviceProviderTF: UITextField!
    @IBOutlet weak var serviceProviderBtn: UIButton!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var bankNameTF: UITextField!
    @IBOutlet weak var branchNameLbl: UILabel!
    @IBOutlet weak var branchNameView: UIView!
    @IBOutlet weak var branchNameTF: UITextField!
    @IBOutlet weak var accNumLbl: UILabel!
    @IBOutlet weak var accNumTF: UITextField!
    @IBOutlet weak var confirmAccNumLbl: UILabel!
    @IBOutlet weak var confirmAccNumTF: UITextField!
    @IBOutlet weak var submitLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet var emptyBtns: [UIButton]!
    @IBOutlet weak var termsImgView: UIImageView!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var termsImgBtn: UIButton!
    @IBOutlet weak var serviceProviderView: UIView!
    @IBOutlet weak var bankNameView: UIView!
    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var accView: UIView!
    @IBOutlet weak var confirmAccView: UIView!
    @IBOutlet weak var bankBtn: UIButton!
    @IBOutlet weak var branchBtn: UIButton!
    @IBOutlet weak var bicView: UIView!
    @IBOutlet weak var bicTypeView: UIView!
    @IBOutlet weak var bicLbl: UILabel!
    @IBOutlet weak var bicTF: UITextField!
    @IBOutlet weak var bicBtn: UIButton!
    
    
    @IBOutlet weak var branchIcon: UIImageView!
    // constraints
    @IBOutlet weak var serviceProviderHeight: NSLayoutConstraint!
    @IBOutlet weak var bankHeight: NSLayoutConstraint!
    @IBOutlet weak var branchHeight: NSLayoutConstraint!
    @IBOutlet weak var accHeight: NSLayoutConstraint!
    @IBOutlet weak var confirmAccHeight: NSLayoutConstraint!
    @IBOutlet weak var baseVIewHeight: NSLayoutConstraint!
    @IBOutlet weak var bicHeight: NSLayoutConstraint!
    
    @IBOutlet weak var otpBgView: UIView!
    @IBOutlet weak var otpBaseView: UIView!
    
    
    @IBOutlet var iagreetolabel: UILabel!
    
    @IBOutlet var characterTextFields: [UITextField]!
    @IBOutlet var numberTextFields: [UITextField]!
    
    var BranchApiCalled = false
    
    let popUpView = Bundle.main.loadNibNamed("GenderSelectionPopupView", owner: AddBeneficiaryVC.self, options: nil)?.first as! GenderSelectionPopupView
    let popUpView1 = Bundle.main.loadNibNamed("AddBenefPopupView", owner: AddBeneficiaryVC.self, options: nil)?.first as! AddBenefPopupView
    let popUpView2 = Bundle.main.loadNibNamed("TermsPopupUIView", owner: AddBeneficiaryVC.self, options: nil)?.first as! TermsPopupUIView
    let popUpOtpView = Bundle.main.loadNibNamed("OTPView", owner: TransferPage1VC.self, options: nil)?.first as! OTPView
    
    var timer : Timer?
    var timerGesture = UITapGestureRecognizer()
    var counter = 20
    var isTimerRunning = false
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let datePicker = UIDatePicker()
    let objCustomCalendar :CustomCalendar = CustomCalendar()
    var dateField:Int = 0
    var fromDate:String = ""
    var fromDate1 = Date()
    
    
    let defaults = UserDefaults.standard
    var termsClick:Bool = false
    var temrsContent = ""
    var currentDropdownSelection:AddBenfDropDownSelection = .country
    var currentSelection:TransferSelection = .none
    
    var selectedNationality:CasmexNationality?
    var selectedCountry:CasmexCountry?
    var selectedCurrency:CasmexCurrency?
    var selectedBank:CasmexBank?
    var selectedBranch:CasmexBranch?
    var selectedRelation:CasmexRelation?
    var selectedServiceProvider:CasmexServiceProvider?
    var selectedBic:CasmexBICDetail?
    
    var nationalityArray:[CasmexNationality] = []
    var bankArray:[CasmexBank] = []
    var countryArray:[CasmexCountry] = []
    var currencyArray:[CasmexCurrency] = []
    var branchArray:[CasmexBranch] = []
    var relationArray:[CasmexRelation] = []
    var serviceProviderArray:[CasmexServiceProvider] = []
    var bicArray: [CasmexBICDetail] = []
    
    // otp
    var email:String = ""
    var mobile:String = ""
    var strOtp:String = ""
    
    var udid:String!
    var isOtpPopup:Bool = false
    
    var serviceType:String = ""
    var str_firstName:String = ""
    var str_middleName:String = ""
    var str_lastName:String = ""
    var str_country:String = ""
    var str_currency:String = ""
    var str_natioality:String = ""
    var str_relation:String = ""
    var str_gender:String = ""
    var str_serviceProvider :String = ""
    var str_address1:String = ""
    var str_address2:String = ""
    var str_mobile:String = ""
    var str_idNum:String = ""
    var str_bankName:String = ""
    var str_branchName:String = ""
    var str_accNum:String = ""
    var str_benificiaryserialnostr:String = ""
    var str_Dob:String = ""
    
    
    var bankTFArray:[UITextField] = []
    var cashTFArray:[UITextField] = []
    var dropDownTFArray:[UITextField] = []
    
    var branchSearchText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.udid = UIDevice.current.identifierForVendor?.uuidString
        addNavbar()
        bankTFArray = [firstNameTF, middleNameTF, lastNameTF, countryTF, currencyTF, natioalityTF, relationTF, genderTF, dobTF, address1TF, address2TF, mobileTF, idNumTF, bankNameTF, branchNameTF, accNumTF, confirmAccNumTF, serviceProviderTF]
        
        setSelection()
        
        setView()
        characterTextFields.forEach { $0.delegate = self }
        numberTextFields.forEach { $0.delegate = self }
        accNumTF.delegate = self
        confirmAccNumTF.delegate = self
        branchNameTF.delegate = self
        popUpView.delegate = self
        popUpView1.delegate = self
        popUpView2.delegate = self
        popUpOtpView.delegate = self
        otpBaseView.clipsToBounds = true
        otpBgView.isHidden = true
        otpBaseView.isHidden = true
        bicBtn.setTitle("", for: .normal)
        for btn in emptyBtns{
            btn.setTitle("", for: .normal)
        }
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            firstNameTF.textAlignment = .right
            middleNameTF.textAlignment = .right
            lastNameTF.textAlignment = .right
            countryTF.textAlignment = .right
            currencyTF.textAlignment = .right
            natioalityTF.textAlignment = .right
            relationTF.textAlignment = .right
            genderTF.textAlignment = .right
            dobTF.textAlignment = .right
            address1TF.textAlignment = .right
            address2TF.textAlignment = .right
            mobileTF.textAlignment = .right
            idNumTF.textAlignment = .right
            serviceProviderTF.textAlignment = .right
            bankNameTF.textAlignment = .right
            branchNameTF.textAlignment = .right
            accNumTF.textAlignment = .right
            confirmAccNumTF.textAlignment = .right
        } else {
            firstNameTF.textAlignment = .left
            middleNameTF.textAlignment = .left
            lastNameTF.textAlignment = .left
            countryTF.textAlignment = .left
            currencyTF.textAlignment = .left
            natioalityTF.textAlignment = .left
            relationTF.textAlignment = .left
            genderTF.textAlignment = .left
            dobTF.textAlignment = .left
            address1TF.textAlignment = .left
            address2TF.textAlignment = .left
            mobileTF.textAlignment = .left
            idNumTF.textAlignment = .left
            serviceProviderTF.textAlignment = .left
            bankNameTF.textAlignment = .left
            branchNameTF.textAlignment = .left
            accNumTF.textAlignment = .left
            confirmAccNumTF.textAlignment = .left
        }
        //        configureButton(button: submitBtn, title: "Submit", size: 16, font: .medium)
        //newlogout
        timer?.invalidate()
        // timer?.fire()
        timer = nil
        counter = 0
        if counter > 0 {
            print("\(counter) seconds to the end of the world")
            counter -= 15*60
            //counter = 0
        }
        print("\(counter) timer resetcountdw")
        
        
        self.fromDate = self.getCurrentDateTime4()
        objCustomCalendar.calendarDelegate = self
        
        getToken(num: 2)
        getNationality()
        getRelation()
        getTermsandConditions()
        setTF()
        
        setTxtToSpeech()
        
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
        //        ScreenShield.shared.protect(view: baseView)
        for labl in screenShootLbls{
            ScreenShield.shared.protect(view: labl)
        }
        for tf in screenShootTFs{
            ScreenShield.shared.protect(view: tf)
        }
        
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    func setView(){
        mobileTF.keyboardType = .phonePad
        idNumTF.keyboardType = .numberPad
        accNumTF.keyboardType = .numberPad
        confirmAccNumTF.keyboardType = .numberPad
        
        branchNameTF.placeholder = "Enter Branch Name"
        
        setLabelWithAsterisk(label: firstNameLbl, text: NSLocalizedString("firstname_sm", comment: ""))
        setLabelWithAsterisk(label: lastNameLbl, text: NSLocalizedString("lastname_sm", comment: ""))
        setLabelWithAsterisk(label: countryLbl, text: NSLocalizedString("countryT", comment: ""))
        setLabelWithAsterisk(label: currencyLbl, text: "Currency")
        //        setLabelWithAsterisk(label: currencyLbl, text: NSLocalizedString("about_us_title", comment: ""))
        setLabelWithAsterisk(label: natioalityLbl, text: NSLocalizedString("nationality", comment: ""))
        setLabelWithAsterisk(label: relationLbl, text: "Relationship With Beneficiary")
        //        setLabelWithAsterisk(label: relationLbl, text: NSLocalizedString("Relationship With Beneficiary", comment: ""))
        setLabelWithAsterisk(label: genderLbl, text: NSLocalizedString("gender", comment: ""))
        //setLabelWithAsterisk(label: dobLbl, text: NSLocalizedString("dob", comment: ""))
        dobLbl.text = "\(NSLocalizedString("dob", comment: "")) (Optional)"
        setLabelWithAsterisk(label: address1Lbl, text: NSLocalizedString("Address1", comment: ""))
        
        setLabelWithAsterisk(label: mobileLbl, text: NSLocalizedString("mobile_no", comment: ""))
        //        setLabelWithAsterisk(label: idNumLbl, text: NSLocalizedString("id_number", comment: ""))
        setLabelWithAsterisk(label: bankNameLbl, text: NSLocalizedString("bank_name1_sm", comment: ""))
        setLabelWithAsterisk(label: branchNameLbl, text: NSLocalizedString("branch_name1_sm", comment: ""))
        setLabelWithAsterisk(label: accNumLbl, text: NSLocalizedString("acc_no1", comment: ""))
        setLabelWithAsterisk(label: confirmAccNumLbl, text: "Confirm Account Number")
        //        setLabelWithAsterisk(label: confirmAccNumLbl, text: NSLocalizedString("acc_no1", comment: ""))
        setLabelWithAsterisk(label: serviceProviderLbl, text: NSLocalizedString("SERVICEPROVIDER", comment: ""))
        
        idNumLbl.text = "\(NSLocalizedString("id_number", comment: "")) (Optional)"
        address2Lbl.text = "\(NSLocalizedString("Address2", comment: "")) (Optional)"
        // submitLbl.text = NSLocalizedString("submit", comment: "")
        // Ensure the key exists in the Localizable.strings file
        //termsBtn.setTitle(NSLocalizedString("terms_conditions1", comment: ""), for: .normal)
        //self.termsBtn.setTitle(NSLocalizedString("terms_conditions1", comment: ""), for: .normal)
        
        //        self.termsBtn.isEnabled = true
        //        self.termsBtn.setTitle(NSLocalizedString("terms_conditions1", comment: ""), for: .normal)
        //        self.termsBtn.setTitle(NSLocalizedString("terms_conditions1", comment: ""), for: .highlighted)
        //        print(NSLocalizedString("terms_conditions1", comment: ""))
        
        iagreetolabel.text = NSLocalizedString("i_agree", comment: "")
        
        
        
        
    }
    
    
    //new
    
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(firstNameLblTapped(_:)))
        firstNameLbl.isUserInteractionEnabled = true
        firstNameLbl.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(middleNameLblTapped(_:)))
        middleNameLbl.isUserInteractionEnabled = true
        middleNameLbl.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(lastNameLblTapped(_:)))
        lastNameLbl.isUserInteractionEnabled = true
        lastNameLbl.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(countryLblTapped(_:)))
        countryLbl.isUserInteractionEnabled = true
        countryLbl.addGestureRecognizer(tapGesture3)
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(currencyLblTapped(_:)))
        currencyLbl.isUserInteractionEnabled = true
        currencyLbl.addGestureRecognizer(tapGesture4)
        
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(genderLblTapped(_:)))
        genderLbl.isUserInteractionEnabled = true
        genderLbl.addGestureRecognizer(tapGesture5)
        
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(natioalityLblTapped(_:)))
        natioalityLbl.isUserInteractionEnabled = true
        natioalityLbl.addGestureRecognizer(tapGesture6)
        
        let tapGesture7 = UITapGestureRecognizer(target: self, action: #selector(dobLblTapped(_:)))
        dobLbl.isUserInteractionEnabled = true
        dobLbl.addGestureRecognizer(tapGesture7)
        
        let tapGesture8 = UITapGestureRecognizer(target: self, action: #selector(addressLblTapped(_:)))
        address1Lbl.isUserInteractionEnabled = true
        address1Lbl.addGestureRecognizer(tapGesture8)
        
        let tapGesture9 = UITapGestureRecognizer(target: self, action: #selector(relationLblTapped(_:)))
        relationLbl.isUserInteractionEnabled = true
        relationLbl.addGestureRecognizer(tapGesture9)
        
        let tapGesture10 = UITapGestureRecognizer(target: self, action: #selector(address2LblTapped(_:)))
        address2Lbl.isUserInteractionEnabled = true
        address2Lbl.addGestureRecognizer(tapGesture10)
        
        let tapGesture11 = UITapGestureRecognizer(target: self, action: #selector(mobileLblTapped(_:)))
        mobileLbl.isUserInteractionEnabled = true
        mobileLbl.addGestureRecognizer(tapGesture11)
        
        let tapGesture12 = UITapGestureRecognizer(target: self, action: #selector(bankNameLblTapped(_:)))
        bankNameLbl.isUserInteractionEnabled = true
        bankNameLbl.addGestureRecognizer(tapGesture12)
        
        let tapGesture13 = UITapGestureRecognizer(target: self, action: #selector(branchNameLblTapped(_:)))
        branchNameLbl.isUserInteractionEnabled = true
        branchNameLbl.addGestureRecognizer(tapGesture13)
        
        let tapGesture14 = UITapGestureRecognizer(target: self, action: #selector(idnumberLblTapped(_:)))
        idNumLbl.isUserInteractionEnabled = true
        idNumLbl.addGestureRecognizer(tapGesture14)
        
        let tapGesture15 = UITapGestureRecognizer(target: self, action: #selector(accountnumberLblTapped(_:)))
        accNumLbl.isUserInteractionEnabled = true
        accNumLbl.addGestureRecognizer(tapGesture15)
        
        let tapGesture16 = UITapGestureRecognizer(target: self, action: #selector(confirmAccNumLblTapped(_:)))
        confirmAccNumLbl.isUserInteractionEnabled = true
        confirmAccNumLbl.addGestureRecognizer(tapGesture16)
        
        let tapGesture17 = UITapGestureRecognizer(target: self, action: #selector(serviceProviderLblTapped(_:)))
        serviceProviderLbl.isUserInteractionEnabled = true
        serviceProviderLbl.addGestureRecognizer(tapGesture17)
        
        let tapGesture18 = UITapGestureRecognizer(target: self, action: #selector(bicLblTapped(_:)))
        bicLbl.isUserInteractionEnabled = true
        bicLbl.addGestureRecognizer(tapGesture18)
        //
        //
        //        let tapGesture18 = UITapGestureRecognizer(target: self, action: #selector(idfrontLblTapped(_:)))
        //        idFrontLbl.isUserInteractionEnabled = true
        //        idFrontLbl.addGestureRecognizer(tapGesture18)
        //
        //        let tapGesture19 = UITapGestureRecognizer(target: self, action: #selector(idbackLblTapped(_:)))
        //        idBackLbl.isUserInteractionEnabled = true
        //        idBackLbl.addGestureRecognizer(tapGesture19)
        
    }
    @objc func firstNameLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("first name", languageCode: "en")
            }
        }
    }
    @objc func middleNameLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("middle name", languageCode: "en")
            }
        }
        
    }
    
    @objc func lastNameLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("last name", languageCode: "en")
            }
        }
    }
    
    @objc func countryLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("country", languageCode: "en")
            }
        }
    }
    
    @objc func currencyLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("currency", languageCode: "en")
            }
        }
    }
    
    @objc func genderLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("gender", languageCode: "en")
            }
        }
    }
    
    @objc func natioalityLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("natioality", languageCode: "en")
            }
        }
    }
    
    @objc func dobLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("date of birth", languageCode: "en")
            }
        }
    }
    
    @objc func addressLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("address 1", languageCode: "en")
            }
        }
    }
    
    @objc func relationLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("relationship with beneficiary", languageCode: "en")
            }
        }
    }
    
    @objc func address2LblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("address2", languageCode: "en")
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
    
    @objc func idnumberLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id number", languageCode: "en")
            }
        }
    }
    
    @objc func accountnumberLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("account number", languageCode: "en")
            }
        }
    }
    
    @objc func confirmAccNumLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("confirm Account number", languageCode: "en")
            }
        }
    }
    
    //
    @objc func serviceProviderLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("service Provider", languageCode: "en")
            }
        }
    }
    @objc func bicLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("B i c details", languageCode: "en")
            }
        }
    }
    //
    //    @objc func idfrontLblTapped(_ sender: UITapGestureRecognizer) {
    //        if defaults.bool(forKey: "accessibilityenabled"){
    //            if let label = sender.view as? UILabel {
    //                SpeechHelper.shared.speak("id front", languageCode: "en")
    //            }
    //        }
    //    }
    //
    //    @objc func idbackLblTapped(_ sender: UITapGestureRecognizer) {
    //        if defaults.bool(forKey: "accessibilityenabled"){
    //            if let label = sender.view as? UILabel {
    //                SpeechHelper.shared.speak("id back", languageCode: "en")
    //            }
    //        }
    //    }
    //
    
    
    
    
    
    
    
    
    ////
    
    
    
    
    
    
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
    
    @IBAction func countryBtnTapped(_ sender: Any) {
        currentDropdownSelection = .country
        if !countryArray.isEmpty{
            addPopUp()
        }else {
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Country available")
        }
    }
    @IBAction func currencyBtnTapped(_ sender: Any) {
        if selectedCountry == nil{
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Country")
        }else{
            currentDropdownSelection = .currency
            if !currencyArray.isEmpty{
                addPopUp()
            }else {
                showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Currency available")
            }
        }
    }
    @IBAction func serviceProviderBtnTapped(_ sender: Any) {
        if selectedCountry == nil{
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Country")
        }else  if selectedCurrency == nil{
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Currency")
        }else{
            currentDropdownSelection = .service
            if !serviceProviderArray.isEmpty{
                addPopUp()
            }else {
                showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Service Provider available")
            }
        }
    }
    @IBAction func natioalityBtnTapped(_ sender: Any) {
        currentDropdownSelection = .nationality
        if !nationalityArray.isEmpty{
            addPopUp()
        }else {
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Nationalities available")
        }
    }
    @IBAction func relationBtnTapped(_ sender: Any) {
        currentDropdownSelection = .relation
        if !relationArray.isEmpty{
            addPopUp()
        }else {
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Relations available")
        }
    }
    @IBAction func bankBtnTapped(_ sender: Any) {
        if selectedCountry == nil{
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Country")
        }else  if selectedCurrency == nil{
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Currency")
        }else  if selectedServiceProvider == nil{
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Service Provider")
        }else{
            currentDropdownSelection = .bank
            if !bankArray.isEmpty{
                addPopUp()
            }else {
                showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Banks available")
            }
        }
        
    }
    @IBAction func branchBtnTapped(_ sender: Any) {
        if selectedBank == nil{
            branchSearchText = ""
            branchNameTF.text = ""
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Bank")
        }else{
            if branchArray.isEmpty &&  BranchApiCalled == false{
                self.branchSearchText = branchNameTF.text!
                self.getToken(num: 6)
                /*if branchNameTF.text == "" || branchNameTF.text == nil{
                 showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please enter a Branch Name")
                 }else{
                 self.branchSearchText = branchNameTF.text!
                 self.BranchApiCalled = true
                 self.getToken(num: 6)
                 }*/
            }else{
                currentDropdownSelection = .branch
                if !branchArray.isEmpty{
                    addPopUp()
                }else {
                    showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Branches available")
                }
            }
            
        }
    }
    
    @IBAction func bicBtnTapped(_ sender: Any) {
        if selectedBranch == nil{
            showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Branch")
        }else{
            if bicArray.count == 1{
                
            }else{
                currentDropdownSelection = .bic
                if !bicArray.isEmpty{
                    addPopUp()
                }else {
                    showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No BIC Details available")
                }
            }
        }
    }
    
    
    @IBAction func genderBtnTapped(_ sender: Any) {
        showGenderPopup()
    }
    func GenderSelectionPopupView(_ vc: GenderSelectionPopupView, isMale: Bool) {
        if isMale{
            genderTF.text = "Male"
            self.str_gender = "Male"
        }else{
            self.str_gender = "Female"
            genderTF.text = "Female"
        }
    }
    @IBAction func dobBtnTapped(_ sender: Any) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.backgroundColor = UIColor.white
        }
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate))
        toolbar.setItems([done], animated: true)
        dobTF.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        //        let today = Date()
        // datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -89, to: today)!
        
        datePicker.maximumDate = Date()
        let calendar = Calendar.current
        let today = Date()
        //           var components = calendar.dateComponents([.year, .month], from: today)
        //           components.month = (components.month ?? 1) - 1
        //           components.day = 1
        //
        //           if let firstDayOfPreviousMonth = calendar.date(from: components) {
        //               datePicker.date = firstDayOfPreviousMonth
        //           }
        datePicker.date = fromDate1
        dobTF.inputView = datePicker
        dobTF.becomeFirstResponder()
        
    }
    @objc func showdate()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        let dateVal = dateFormat.string(from: datePicker.date)
        dobTF.text = convertDateFormat(from: dateVal) ?? ""
        str_Dob = convertDateFormat(from: dateVal) ?? ""
        print("str_Dob\(str_Dob)")
        print("")
        fromDate1 = datePicker.date
        view.endEditing(true)
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
        view.addSubview(popUpView2)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView2.alpha = 1.0
        })
    }
    
    @IBAction func termsImgBtnTapped(_ sender: Any) {
        if !termsClick{
            showAlert(title: "", message: "Please read the Terms And Conditions")
        }
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("submit", languageCode: "en")
        }
        
        validateFields()
    }
    
    
    //MARK: - Popup Delegate
    func TermsPopupUIView(_ vc: TermsPopupUIView, action: Bool) {
        if action {
            termsClick = true
            if #available(iOS 13.0, *) {
                termsImgView.image = UIImage(systemName: "checkmark.square.fill")
                termsImgView.tintColor = UIColor.rgba(198, 23, 30, 1)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    func AddBenefPopupView(_ vc: AddBenefPopupView, cdidSelectCountry country: CasmexCountry?) {
        print("cdidSelectCountry")
        BranchApiCalled = false
        selectedCountry = country
        countryTF.text = selectedCountry?.countryName
        if selectedCountry?.countryName ?? "" == "NEPAL" {
            accNumTF.keyboardType = .default
            confirmAccNumTF.keyboardType = .default
        }else{
            accNumTF.keyboardType = .numberPad
            confirmAccNumTF.keyboardType = .numberPad
        }
        currencyArray.removeAll()
        currencyTF.text?.removeAll()
        selectedCurrency = nil
        serviceProviderArray.removeAll()
        serviceProviderTF.text?.removeAll()
        selectedServiceProvider = nil
        bankArray.removeAll()
        bankNameTF.text?.removeAll()
        selectedBank = nil
        branchArray.removeAll()
        branchNameTF.text?.removeAll()
        selectedBranch = nil
        bicArray.removeAll()
        bicTF.text?.removeAll()
        selectedBic = nil
        branchSearchText = ""
        branchNameTF.text = ""
        getToken(num: 3)
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectCurrency currency: CasmexCurrency?) {
        print("didSelectCurrency")
        BranchApiCalled = false
        selectedCurrency = currency
        currencyTF.text = selectedCurrency?.currencyName
        serviceProviderArray.removeAll()
        serviceProviderTF.text?.removeAll()
        selectedServiceProvider = nil
        bankArray.removeAll()
        bankNameTF.text?.removeAll()
        selectedBank = nil
        branchArray.removeAll()
        branchNameTF.text?.removeAll()
        selectedBranch = nil
        bicArray.removeAll()
        bicTF.text?.removeAll()
        selectedBic = nil
        branchSearchText = ""
        branchNameTF.text = ""
        getToken(num: 4)
        //        if currentSelection == .bankTransfer{
        //            getToken(num: 5)
        //        }else{
        //            getToken(num: 4)
        //        }
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectNationality nationality: CasmexNationality?) {
        print("didSelectNationality")
        selectedNationality = nationality
        natioalityTF.text = selectedNationality?.description
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectrRelation relation: CasmexRelation?) {
        print("didSelectrRelation")
        selectedRelation = relation
        relationTF.text = selectedRelation?.description
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectService service: CasmexServiceProvider?) {
        BranchApiCalled = false
        selectedServiceProvider = service
        serviceProviderTF.text = selectedServiceProvider?.serviceProviderName
        bankArray.removeAll()
        bankNameTF.text?.removeAll()
        selectedBank = nil
        branchArray.removeAll()
        branchNameTF.text?.removeAll()
        selectedBranch = nil
        bicArray.removeAll()
        bicTF.text?.removeAll()
        selectedBic = nil
        branchSearchText = ""
        branchNameTF.text = ""
        switch currentSelection {
        case .bankTransfer:
            getToken(num: 5)
        case .cashPickup:
            break
        case .mobileWallet:
            getToken(num: 5)
        case .none:
            break
        }
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectBank bank: CasmexBank?) {
        BranchApiCalled = false
        print("didSelectBank")
        selectedBank = bank
        bankNameTF.text = selectedBank?.bankName
        branchArray.removeAll()
        branchNameTF.text?.removeAll()
        selectedBranch = nil
        bicArray.removeAll()
        bicTF.text?.removeAll()
        selectedBic = nil
        branchSearchText = ""
        branchNameTF.text = ""
        if currentSelection == .bankTransfer{
            //            getToken(num: 6)
            branchNameTF.isUserInteractionEnabled = true
            branchIcon.image = UIImage(named: "t_search")
        }
    }
    
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectBranch branch: CasmexBranch?) {
        print("didSelectBranch")
        selectedBranch = branch
        branchSearchText = selectedBranch?.branchName ?? ""
        branchNameTF.text = selectedBranch?.branchName
        self.bicArray = selectedBranch?.bicDetails ?? []
        if !(bicArray.isEmpty){
            baseVIewHeight.constant = baseVIewHeight.constant + 80
            bicView.isHidden = false
            bicHeight.constant = 80
            if bicArray.count == 1{
                selectedBic = bicArray[0]
                //                bicTF.text = "\(bicArray[0].bicType ) - \(bicArray[0].bicValue )"
                bicTF.text = "\(bicArray[0].bicValue )"
            }
        }else{
            if serviceProviderArray.count > 1{
                baseVIewHeight.constant = 1560
            }else{
                baseVIewHeight.constant = 1480
            }
            
            bicView.isHidden = true
            bicHeight.constant = 0
        }
        
    }
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectBic purpose: CasmexBICDetail?) {
        selectedBic = purpose
        bicTF.text = "\(selectedBic?.bicType ?? "") - \(selectedBic?.bicValue ?? "")"
    }
    
    //MARK: - Functions
    func setServiceProvider(){
        if !serviceProviderArray.isEmpty{
            if serviceProviderArray.count == 1{
                
                selectedServiceProvider = serviceProviderArray[0]
                serviceProviderTF.text = selectedServiceProvider?.serviceProviderName ?? ""
                serviceProviderView.isHidden = true
                serviceProviderHeight.constant = 0
                switch currentSelection {
                case .bankTransfer:
                    baseVIewHeight.constant = 1480
                    getToken(num: 5)
                case .cashPickup:
                    baseVIewHeight.constant = 1160
                    break
                case .mobileWallet:
                    baseVIewHeight.constant = 1240
                    getToken(num: 5)
                case .none:
                    break
                }
            }else{
                serviceProviderView.isHidden = false
                serviceProviderHeight.constant = 80
                switch currentSelection {
                case .bankTransfer:
                    baseVIewHeight.constant = 1560
                case .cashPickup:
                    baseVIewHeight.constant = 1240
                case .mobileWallet:
                    baseVIewHeight.constant = 1320
                case .none:
                    break
                }
            }
        }
    }
    
    func setTF(){
        
        firstNameTF.borderWidth = 1
        firstNameTF.borderColor = UIColor.rgba(232, 233, 233, 1)
        firstNameTF.layer.cornerRadius = 4
        middleNameTF.borderWidth = 1
        middleNameTF.borderColor = UIColor.rgba(232, 233, 233, 1)
        middleNameTF.layer.cornerRadius = 4
        lastNameTF.borderWidth = 1
        lastNameTF.borderColor = UIColor.rgba(232, 233, 233, 1)
        lastNameTF.layer.cornerRadius = 4
        countryView.borderWidth = 1
        countryView.borderColor = UIColor.rgba(232, 233, 233, 1)
        countryView.layer.cornerRadius = 4
        currencyView.borderWidth = 1
        currencyView.borderColor = UIColor.rgba(232, 233, 233, 1)
        currencyView.layer.cornerRadius = 4
        nationalityView.borderWidth = 1
        nationalityView.borderColor = UIColor.rgba(232, 233, 233, 1)
        nationalityView.layer.cornerRadius = 4
        relationView.borderWidth = 1
        relationView.borderColor = UIColor.rgba(232, 233, 233, 1)
        relationView.layer.cornerRadius = 4
        genderView.borderWidth = 1
        genderView.borderColor = UIColor.rgba(232, 233, 233, 1)
        genderView.layer.cornerRadius = 4
        serviceView.borderWidth = 1
        serviceView.borderColor = UIColor.rgba(232, 233, 233, 1)
        serviceView.layer.cornerRadius = 4
        address1TF.borderWidth = 1
        address1TF.borderColor = UIColor.rgba(232, 233, 233, 1)
        address1TF.layer.cornerRadius = 4
        address2TF.borderWidth = 1
        address2TF.borderColor = UIColor.rgba(232, 233, 233, 1)
        address2TF.layer.cornerRadius = 4
        mobileTF.borderWidth = 1
        mobileTF.borderColor = UIColor.rgba(232, 233, 233, 1)
        mobileTF.layer.cornerRadius = 4
        idNumTF.borderWidth = 1
        idNumTF.borderColor = UIColor.rgba(232, 233, 233, 1)
        idNumTF.layer.cornerRadius = 4
        bankView.borderWidth = 1
        bankView.borderColor = UIColor.rgba(232, 233, 233, 1)
        bankView.layer.cornerRadius = 4
        branchNameView.borderWidth = 1
        branchNameView.borderColor = UIColor.rgba(232, 233, 233, 1)
        branchNameView.layer.cornerRadius = 4
        bicTypeView.borderWidth = 1
        bicTypeView.borderColor = UIColor.rgba(232, 233, 233, 1)
        bicTypeView.layer.cornerRadius = 4
        accNumTF.borderWidth = 1
        accNumTF.borderColor = UIColor.rgba(232, 233, 233, 1)
        accNumTF.layer.cornerRadius = 4
        confirmAccNumTF.borderWidth = 1
        confirmAccNumTF.borderColor = UIColor.rgba(232, 233, 233, 1)
        confirmAccNumTF.layer.cornerRadius = 4
        dobTF.borderWidth = 1
        dobTF.borderColor = UIColor.rgba(232, 233, 233, 1)
        dobTF.layer.cornerRadius = 4
    }
    func getCurrentDateTime3() -> String {
        let calendar = Calendar.current
        // Get the date one month before
        guard let dateOneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date()) else { return "" }
        fromDate1 = dateOneMonthAgo
        let format = DateFormatter()
        format.dateFormat = "MM-yyyy"
        let formattedDate = "01-" + format.string(from: dateOneMonthAgo)
        print(formattedDate)
        return formattedDate
    }
    
    func getCurrentDateTime4() -> String {
        let calendar = Calendar.current
        // Get the date one month before
        guard let dateOneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date()) else { return "" }
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM"
        let formattedDate = format.string(from: dateOneMonthAgo) + "-01"
        print(formattedDate)
        return formattedDate
    }
    
    func showGenderPopup(){
        popUpView.setView()
        popUpView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpView.alpha = 0.0
        popUpView.isMale = true
        view.addSubview(popUpView)
        print("SendMoneyView")
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.alpha = 1.0
        })
    }
    func addPopUp(){
        
        popUpView1.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpView1.alpha = 0.0
        popUpView1.currentSelection = self.currentDropdownSelection
        popUpView1.searchTF.text?.removeAll()
        
        switch currentDropdownSelection {
        case .country:
            popUpView1.countryArray = countryArray
            popUpView1.searchCountry = countryArray
        case .currency:
            popUpView1.currencyArray = currencyArray
            popUpView1.searchCurrency = currencyArray
        case .nationality:
            popUpView1.nationalityArray = nationalityArray
            popUpView1.searchNationality = nationalityArray
        case .relation:
            popUpView1.relationArray = relationArray
            popUpView1.searchRelation = relationArray
        case .service:
            popUpView1.serviceProviderArray = serviceProviderArray
            popUpView1.searchService = serviceProviderArray
        case .bank:
            popUpView1.bankArray = bankArray
            popUpView1.searchBank = bankArray
        case .branch:
            popUpView1.branchArray = branchArray
            popUpView1.searchBranch = branchArray
        case .source:
            break
        case .purpose:
            break
        case .bic:
            popUpView1.bicArray = bicArray
            popUpView1.searchBic = bicArray
        }
        popUpView1.setupTableView()
        popUpView1.baseTableView.reloadData()
        view.addSubview(popUpView1)
        print("PopUpView")
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView1.alpha = 1.0
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
    func OTPView(_ vc: OTPView, otp: String) {
        print("OTP - \(otp)")
        self.strOtp = otp
        self.getToken(num: 10)
    }
    
    func OTPView(_ vc: OTPView, resend: Bool) {
        if resend{
            self.getToken(num: 9)
        }
    }
    func OTPView(_ vc: OTPView, close: Bool) {
        if close{
            self.removeOtpView()
        }
    }
    func setSelection(){
        switch currentSelection {
        case .bankTransfer:
            print("selected bankTransfer")
            serviceType = "CREDIT"
            setCreditView()
        case .cashPickup:
            print("selected cashPickup")
            serviceType = "CASH"
            setCashView()
        case .mobileWallet:
            print("selected mobileWallet")
            serviceType = "CASH_TO_MOBILE"
            //            setCashView()
            setWaletView()
        case .none:
            print("selected none")
            serviceType = ""
        }
        configureButton(button: termsBtn, title:  NSLocalizedString("terms_conditions1", comment: ""), size: 12, font: .regular)
    }
    
    func setCreditView(){
        //        baseVIewHeight.constant = 1480
        baseVIewHeight.constant = 1480
        serviceProviderView.isHidden = true
        bankNameView.isHidden = false
        branchView.isHidden = false
        accView.isHidden = false
        confirmAccView.isHidden = false
        bicView.isHidden = true
        bicHeight.constant = 0
        //        bicView.isHidden = false
        //        bicHeight.constant = 80
        serviceProviderHeight.constant = 0
        bankHeight.constant = 80
        branchHeight.constant = 80
        accHeight.constant = 80
        confirmAccHeight.constant = 80
    }
    func setCashView(){
        baseVIewHeight.constant = 1160
        serviceProviderView.isHidden = true
        bankNameView.isHidden = true
        branchView.isHidden = true
        accView.isHidden = true
        confirmAccView.isHidden = true
        bicView.isHidden = true
        bicHeight.constant = 0
        serviceProviderHeight.constant = 0
        bankHeight.constant = 0
        branchHeight.constant = 0
        accHeight.constant = 0
        confirmAccHeight.constant = 0
    }
    func setWaletView(){
        baseVIewHeight.constant = 1240
        serviceProviderView.isHidden = true
        bankNameView.isHidden = false
        branchView.isHidden = true
        accView.isHidden = true
        confirmAccView.isHidden = true
        bicView.isHidden = true
        bicHeight.constant = 0
        serviceProviderHeight.constant = 0
        bankHeight.constant = 80
        branchHeight.constant = 0
        accHeight.constant = 0
        confirmAccHeight.constant = 0
    }
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "Add New Beneficiary"
    }
    @objc func customBackButtonTapped() {
        if isOtpPopup{
            removeOtpView()
            isOtpPopup = false
        }else{
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
    func convertDateFormat(from inputDate: String) -> String? {
        // Define the input date format
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        
        // Convert the input string to a Date object
        guard let date = inputFormatter.date(from: inputDate) else {
            print("Invalid input date format")
            return nil
        }
        
        // Define the output date format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MMM/yyyy"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent month abbreviation
        
        // Convert the Date object to the desired output format
        return outputFormatter.string(from: date)
    }
    
    func validateFields(){
        
        var str = firstNameTF.text
        str = str!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        firstNameTF.text =  str
        print("firstNameTextField.text",firstNameTF.text)
        //extraspace remove
        let startingStringfname = firstNameTF.text!
        let processedStringfname = startingStringfname.removeExtraSpacesremac()
        print("processedString:\(processedStringfname)")
        firstNameTF.text = processedStringfname
        if firstNameTF.text?.isEmpty == true
        {
            // timer.invalidate()
            self.firstNameTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.firstNameTF.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else
        {
            self.firstNameTF.layer.borderWidth = 1
            
            if #available(iOS 13.0, *) {
                self.firstNameTF.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        guard let firstName = firstNameTF.text,firstNameTF.text?.count != 0 else
        {
            self.scrollView.setContentOffset(.zero, animated: true)
            self.view.makeToast(NSLocalizedString("enter_firstname", comment: ""), duration: 3.0, position: .center)
            // alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("enter_firstname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if (!validate(value: self.firstNameTF.text!))
        {
            
            //            self.firstNameTextField.layer.borderWidth = 0.8
            //            self.firstNameTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            
        }
        else
        
        {
            self.scrollView.setContentOffset(.zero, animated: true)
            
            //            self.firstNameTextField.layer.borderColor = UIColor.red.cgColor
            //            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { (Timer) in
            //                self.firstNameTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            //            }
            
            self.view.makeToast(NSLocalizedString("enter_firstname", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("enter_firstname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        var charSet = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2 = firstName
        
        if let strvalue = string2.rangeOfCharacter(from: charSet)
        {
            print("true")
            
            self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        
        var strlastname = lastNameTF.text
        strlastname = strlastname!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strlastname)
        // "this is the answer"
        print("strlastname",strlastname)
        lastNameTF.text =  strlastname
        print("lastNameTextField.text",lastNameTF.text)
        //extraspace remove
        let startingStringlname = lastNameTF.text!
        let processedStringlname = startingStringlname.removeExtraSpacesremac()
        print("processedString:\(processedStringlname)")
        lastNameTF.text = processedStringlname
        if lastNameTF.text?.isEmpty == true
        {
            // timer.invalidate()
            self.lastNameTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.lastNameTF.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else
        {
            self.lastNameTF.layer.borderWidth = 1
            
            if #available(iOS 13.0, *) {
                self.lastNameTF.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        guard let lastName = lastNameTF.text,lastNameTF.text?.count != 0 else
        {
            self.scrollView.setContentOffset(.zero, animated: true)
            self.view.makeToast(NSLocalizedString("enter_lastname", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_lastname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if (!validate(value: self.lastNameTF.text!))
        {
        }
        else
        {
            //
            self.scrollView.setContentOffset(.zero, animated: true)
            self.view.makeToast(NSLocalizedString("enter_lastname", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_lastname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        var charSetlastname = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2lastname = lastName
        
        if let strvalue = string2lastname.rangeOfCharacter(from: charSetlastname)
        {
            print("true")
            
            self.scrollView.setContentOffset(.zero, animated: true)
            self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        
        
        
        var strmiddlenamee = middleNameTF.text
        strmiddlenamee = strmiddlenamee!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strmiddlenamee)
        // "this is the answer"
        print("strlastname",strmiddlenamee)
        middleNameTF.text =  strmiddlenamee
        print("lastNameTextField.text",middleNameTF.text)
        //extraspace remove
        let startingStringmname = middleNameTF.text!
        let processedStringmname = startingStringmname.removeExtraSpacesremac()
        print("processedString:\(processedStringmname)")
        middleNameTF.text = processedStringmname
        /*
         let middlenamee = middleNameTF.text
         if middleNameTF.text?.isEmpty == true
         {
         // timer.invalidate()
         self.middleNameTF.layer.borderColor = UIColor.red.cgColor
         Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
         if #available(iOS 13.0, *) {
         self.middleNameTF.layer.borderColor = UIColor.systemGray5.cgColor
         } else {
         // Fallback on earlier versions
         }
         }
         }
         else
         {
         self.middleNameTF.layer.borderWidth = 1
         
         if #available(iOS 13.0, *) {
         self.middleNameTF.layer.borderColor = UIColor.systemGray5.cgColor
         } else {
         // Fallback on earlier versions
         }
         }
         guard let middlenamee = middleNameTF.text,middleNameTF.text?.count != 0 else
         {
         self.scrollView.setContentOffset(.zero, animated: true)
         self.view.makeToast(NSLocalizedString("entermiddlename", comment: ""), duration: 3.0, position: .center)
         //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("entermiddlename", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         }
         var charSetmiddlename = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
         var string2middlename = middlenamee
         if let strvalue = string2middlename.rangeOfCharacter(from: charSetmiddlename)
         {
         print("true")
         
         self.scrollView.setContentOffset(.zero, animated: true)
         self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
         // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         }
         */
        
        
        
        
        
        
        
        if(countryTF.text?.isEmpty == true)
        {
            self.scrollView.setContentOffset(.zero, animated: true)
            self.countryView.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.countryView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            self.view.makeToast(NSLocalizedString("sel_country", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.countryView.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        
        
        
        if(currencyTF.text?.isEmpty == true)
        {
            self.scrollView.setContentOffset(.zero, animated: true)
            self.currencyView.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.currencyView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            self.view.makeToast(NSLocalizedString("Please select currency", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.currencyView.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        
        
        if(natioalityTF.text?.isEmpty == true)
        {
            
            let bottomOffset = CGPoint(x: 0, y: 40)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("sel_nationality", comment: ""), duration: 3.0, position: .center)
            
            self.nationalityView.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.nationalityView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.nationalityView.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        
        
        
        
        
        if(relationTF.text?.isEmpty == true)
        {
            let bottomOffset = CGPoint(x: 0, y: 100)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("Please select relation", comment: ""), duration: 3.0, position: .center)
            self.relationView.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.relationView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.relationView.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        
        
        
        if(genderTF.text?.isEmpty == true)
        {
            let bottomOffset = CGPoint(x: 0, y: 150)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("sel_gender", comment: ""), duration: 3.0, position: .center)
            
            self.genderView.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.genderView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.genderView.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        // dob validation
        /*
         if(dobTF.text?.isEmpty == true)
         {
         let bottomOffset = CGPoint(x: 0, y: 150)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         self.view.makeToast(NSLocalizedString("enter_dob", comment: ""), duration: 3.0, position: .center)
         
         self.dobTF.layer.borderColor = UIColor.red.cgColor
         Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
         if #available(iOS 13.0, *) {
         self.dobTF.layer.borderColor = UIColor.systemGray5.cgColor
         } else {
         // Fallback on earlier versions
         }
         }
         
         //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         }
         else{
         if #available(iOS 13.0, *) {
         self.dobTF.layer.borderColor = UIColor.systemGray5.cgColor
         } else {
         // Fallback on earlier versions
         }
         }
         */
        
        var straddress = address1TF.text
        straddress = straddress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(straddress)
        // "this is the answer"
        print("straddress",straddress)
        address1TF.text =  straddress
        print("addresstxtfiled.text",address1TF.text)
        
        
        
        //extraspace remove
        let startingStringaddress = address1TF.text!
        let processedStringaddress = startingStringaddress.removeExtraSpacesremac()
        print("processedString:\(processedStringaddress)")
        address1TF.text = processedStringaddress
        
        
        
        
        
        if address1TF.text?.isEmpty == true
        {
            // timer.invalidate()
            self.address1TF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.address1TF.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else
        {
            
            self.address1TF.layer.borderWidth = 1
            
            if #available(iOS 13.0, *) {
                self.address1TF.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
            
        }
        
        
        guard let addr = address1TF.text,address1TF.text?.count != 0 else
        {
            let bottomOffset = CGPoint(x: 0, y: 300)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("enter_address", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_address", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        
        var charAddr = CharacterSet.init(charactersIn: "@#$%+_&'()*,/:;<=>?[]^`{|}~)(")
        var string2Addr = straddress
        
        if let strvalue = string2Addr!.rangeOfCharacter(from: charAddr)
        {
            print("true")
            //            let alert = UIAlertController(title: "Alert", message: "Please enter valid  address", preferredStyle: UIAlertController.Style.alert)
            //            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //            self.present(alert, animated: true, completion: nil)
            //            print("check name",self.address.text)
            
            let bottomOffset = CGPoint(x: 0, y: 300)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("Please enter valid  address", comment: ""), duration: 3.0, position: .center)
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid  address", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        /*
         var straddress2 = address2TF.text
         straddress2 = straddress2!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
         print(straddress2)
         // "this is the answer"
         print("straddress",straddress2)
         address2TF.text =  straddress2
         print("addresstxtfiled.text",address2TF.text)
         
         
         
         //extraspace remove
         let startingStringaddress2 = address2TF.text!
         let processedStringaddress2 = startingStringaddress2.removeExtraSpacesremac()
         print("processedString:\(processedStringaddress2)")
         address2TF.text = processedStringaddress2
         
         
         
         
         
         if address2TF.text?.isEmpty == true
         {
         // timer.invalidate()
         self.address2TF.layer.borderColor = UIColor.red.cgColor
         Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
         if #available(iOS 13.0, *) {
         self.address2TF.layer.borderColor = UIColor.systemGray5.cgColor
         } else {
         // Fallback on earlier versions
         }
         }
         }
         else
         {
         
         self.address2TF.layer.borderWidth = 1
         
         if #available(iOS 13.0, *) {
         self.address2TF.layer.borderColor = UIColor.systemGray5.cgColor
         } else {
         // Fallback on earlier versions
         }
         
         }
         
         
         guard let addr = address2TF.text,address2TF.text?.count != 0 else
         {
         let bottomOffset = CGPoint(x: 0, y: 350)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         self.view.makeToast(NSLocalizedString("enter_address", comment: ""), duration: 3.0, position: .center)
         //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_address", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         }
         
         
         
         var charAddr2 = CharacterSet.init(charactersIn: "@#$%+_&'()*,/:;<=>?[]^`{|}~)(")
         var string2Addr2 = straddress2
         
         if let strvalue = string2Addr2!.rangeOfCharacter(from: charAddr2)
         {
         print("true")
         //            let alert = UIAlertController(title: "Alert", message: "Please enter valid  address", preferredStyle: UIAlertController.Style.alert)
         //            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
         //            self.present(alert, animated: true, completion: nil)
         //            print("check name",self.address.text)
         
         let bottomOffset = CGPoint(x: 0, y: 350)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         self.view.makeToast(NSLocalizedString("Please enter valid  address", comment: ""), duration: 3.0, position: .center)
         // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid  address", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         
         }
         */
        
        
        
        if (!isValid(testStr: self.mobileTF.text!))
        {
            
        }
        else
        {
            
            let bottomOffset = CGPoint(x: 0, y: 400)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("enter_mobile", comment: ""), duration: 3.0, position: .center)
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        
        var strmobile = mobileTF.text
        strmobile = strmobile!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strmobile)
        // "this is the answer"
        print("strcity",strmobile)
        mobileTF.text =  strmobile
        print("addresstxtfiled.text",mobileTF.text)
        
        
        //extraspace remove
        let startingStringmobile = mobileTF.text!
        let processedStringmobile = startingStringmobile.removeExtraSpacesaccountnumber()
        print("processedStringmobie:\(processedStringmobile)")
        mobileTF.text = processedStringmobile
        
        if mobileTF.text?.isEmpty == true
        {
            // timer.invalidate()
            self.mobileTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.mobileTF.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else
        {
            
            self.mobileTF.layer.borderWidth = 1
            
            if #available(iOS 13.0, *) {
                self.mobileTF.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
            
        }
        
        guard let mobile = mobileTF.text,mobileTF.text?.count != 0 else
        {
            let bottomOffset = CGPoint(x: 0, y: 400)
            //OR
            //            let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.view.makeToast(NSLocalizedString("enter_mobile", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        //
        var charSetMOBNo = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2MOBNo = mobile
        
        if let strvalue = string2MOBNo.rangeOfCharacter(from: charSetMOBNo)
        {
            print("true")
            //                let alert = UIAlertController(title: "Alert", message: "Please enter valid account number", preferredStyle: UIAlertController.Style.alert)
            //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //                self.present(alert, animated: true, completion: nil)
            //                print("check name",self.accountNum.text)
            
            self.view.makeToast(NSLocalizedString("Please enter valid mobile number", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        if serviceProviderArray.count > 1{
            if(serviceProviderTF.text?.isEmpty == true)
            {
                let bottomOffset = CGPoint(x: 0, y: 160)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("Please Select a Service Provider", comment: ""), duration: 3.0, position: .center)
                
                self.serviceView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.serviceView.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                //  self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_bank", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.serviceView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        
        
        
        if currentSelection == .bankTransfer{
            
            if(bankNameTF.text?.isEmpty == true)
            {
                //                let bottomOffset = CGPoint(x: 0, y: 160)
                //OR
                let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("sel_bank", comment: ""), duration: 3.0, position: .center)
                
                self.bankView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.bankView.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                //  self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_bank", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.bankView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            
            
            
            
            if selectedBranch == nil || selectedBranch?.branchName != branchNameTF.text {
                let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("enter_branch_name", comment: ""), duration: 3.0, position: .center)
                
                self.branchNameView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.branchNameView.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_branch_name", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            if(branchNameTF.text?.isEmpty == true)
            {
                //                let bottomOffset = CGPoint(x: 0, y: 160)
                //OR
                let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("enter_branch_name", comment: ""), duration: 3.0, position: .center)
                
                self.branchNameView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.branchNameView.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_branch_name", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.branchNameView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
                
            }
            if !bicArray.isEmpty{
                if(bicTF.text?.isEmpty == true)
                {
                    //                let bottomOffset = CGPoint(x: 0, y: 160)
                    //OR
                    let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                    self.scrollView.setContentOffset(bottomOffset, animated: true)
                    self.view.makeToast("Select BIC Details", duration: 3.0, position: .center)
                    //                    self.view.makeToast(NSLocalizedString("enter_branch_name", comment: ""), duration: 3.0, position: .center)
                    
                    self.bicTypeView.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        if #available(iOS 13.0, *) {
                            self.bicTypeView.layer.borderColor = UIColor.systemGray5.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_branch_name", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                else
                {
                    if #available(iOS 13.0, *) {
                        self.bicTypeView.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }
            }
            
            
            
            
            
            
            
            var straccountnoindout = accNumTF.text
            straccountnoindout = straccountnoindout!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(straccountnoindout)
            // "this is the answer"
            print("straccountnoindout",straccountnoindout)
            accNumTF.text =  straccountnoindout
            print("accountNum.textindout",accNumTF.text)
            
            //extraspace remove
            let startingStringaccountnoindout = accNumTF.text!
            let processedStringaccountnoindout = startingStringaccountnoindout.removeExtraSpacesaccountnumber()
            print("processedStringhomeadress:\(processedStringaccountnoindout)")
            accNumTF.text = processedStringaccountnoindout
            
            if accNumTF.text?.isEmpty == true
            {
                // timer.invalidate()
                self.accNumTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.accNumTF.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            else
            {
                
                
                if #available(iOS 13.0, *) {
                    self.accNumTF.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
                
            }
            
            guard let accNo = accNumTF.text,accNumTF.text?.count != 0 else
            {
                //            let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("enter_account", comment: ""), duration: 3.0, position: .center)
                // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_account", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            var charSetaccNo = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
            var string2accNo = accNo
            
            if let strvalue = string2accNo.rangeOfCharacter(from: charSetaccNo)
            {
                print("true")
                //                let alert = UIAlertController(title: "Alert", message: "Please enter valid account number", preferredStyle: UIAlertController.Style.alert)
                //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                //                self.present(alert, animated: true, completion: nil)
                //                print("check name",self.accountNum.text)
                
                //            let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast(NSLocalizedString("enter_account", comment: ""), duration: 3.0, position: .center)
                // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid account number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
                
            }
            
            var straccountnoindout1 = confirmAccNumTF.text
            straccountnoindout1 = straccountnoindout1!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(straccountnoindout1)
            // "this is the answer"
            print("straccountnoindout",straccountnoindout1)
            confirmAccNumTF.text =  straccountnoindout1
            print("accountNum.textindout",confirmAccNumTF.text)
            
            //extraspace remove
            let startingStringaccountnoindout1 = confirmAccNumTF.text!
            let processedStringaccountnoindout1 = startingStringaccountnoindout1.removeExtraSpacesaccountnumber()
            print("processedStringhomeadress:\(processedStringaccountnoindout1)")
            confirmAccNumTF.text = processedStringaccountnoindout1
            
            if confirmAccNumTF.text?.isEmpty == true
            {
                // timer.invalidate()
                self.confirmAccNumTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.confirmAccNumTF.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            else
            {
                
                
                if #available(iOS 13.0, *) {
                    self.confirmAccNumTF.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
                
            }
            
            guard let accNo1 = confirmAccNumTF.text,confirmAccNumTF.text?.count != 0 else
            {
                //                let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("Please re enter Account Number", comment: ""), duration: 3.0, position: .center)
                // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_account", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            var charSetaccNo1 = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
            var string2accNo1 = accNo1
            
            if let strvalue = string2accNo1.rangeOfCharacter(from: charSetaccNo1)
            {
                print("true")
                //                let alert = UIAlertController(title: "Alert", message: "Please enter valid account number", preferredStyle: UIAlertController.Style.alert)
                //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                //                self.present(alert, animated: true, completion: nil)
                //                print("check name",self.accountNum.text)
                
                //                let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast(NSLocalizedString("Please enter valid account number", comment: ""), duration: 3.0, position: .center)
                // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid account number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
                
            }
            
            
            
            if(accNo.elementsEqual(accNo1))
            {
                if #available(iOS 13.0, *) {
                    self.accNumTF.layer.borderColor = UIColor.systemGray5.cgColor
                    self.confirmAccNumTF.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
                
            }
            else{
                let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("Account number mismatch", comment: ""), duration: 3.0, position: .center)
                self.accNumTF.layer.borderColor = UIColor.red.cgColor
                self.confirmAccNumTF.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.accNumTF.layer.borderColor = UIColor.systemGray5.cgColor
                        self.confirmAccNumTF.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
                return
            }
        }
        if currentSelection == .mobileWallet{
            if(bankNameTF.text?.isEmpty == true)
            {
                //                let bottomOffset = CGPoint(x: 0, y: 160)
                //OR
                let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("sel_bank", comment: ""), duration: 3.0, position: .center)
                
                self.bankView.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.bankView.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                //  self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_bank", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.bankView.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        
        
        /*
         if self.ibanglobstrcheckappearstr == "1"
         {
         if iban.text?.isEmpty ?? true {
         print("textField is empty")
         
         let bottomOffset = CGPoint(x: 0, y: 260)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         
         self.view.makeToast(NSLocalizedString("enter_iban", comment: ""), duration: 3.0, position: .center)
         // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_iban", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         
         } else {
         print("textField has some text")
         }
         
         
         let ibantext = iban.text
         
         
         
         var charSetibantext = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
         var string2ibantext = ibantext
         
         if let strvalue = string2ibantext!.rangeOfCharacter(from: charSetibantext)
         {
         print("true")
         
         let bottomOffset = CGPoint(x: 0, y: 260)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         self.view.makeToast(NSLocalizedString("enter_iban", comment: ""), duration: 3.0, position: .center)
         // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_iban", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         }
         
         
         
         
         
         
         
         }
         
         if  self.accountnoglobstrcheckappearstr == "1"
         {
         if accountNum.text?.isEmpty ?? true {
         print("textField is empty")
         
         let bottomOffset = CGPoint(x: 0, y: 240)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         
         self.view.makeToast(NSLocalizedString("enter_account", comment: ""), duration: 3.0, position: .center)
         // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_account", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         
         } else {
         print("textField has some text")
         }
         
         
         
         }*/
        
        //MARK: - acc no length check
        /*
         let rrcheckmob = alreadysvaedcustomerstr
         
         print("rrcheck",rrcheckmob)
         let x = rrcheckmob
         let y = "0"
         if x == y
         {
         if Accountnolengthstr == "0"||Accountnolengthstr.isEmpty || accountnoclickcheckstr == "0"
         {
         
         
         }
         else
         {
         if minAccountnolengthstr.isEmpty || minAccountnolengthstr == "0"
         {
         // accountNum.text!.count
         print("acnolengthprint",accountNum.text!.count)
         let myString1 = Accountnolengthstr
         let myInt1 = Int(myString1)
         
         if accountNum.text!.count == myInt1
         {
         print("5printno",accountNum.text!.count)
         }
         else
         {
         let bottomOffset = CGPoint(x: 0, y: 240)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         self.view.makeToast(NSLocalizedString("Please enter valid account number", comment: ""), duration: 3.0, position: .center)
         //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid account number", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         
         }
         
         
         }
         else
         {
         //new for minaccnocalc
         print("acnolengthprint",accountNum.text!.count)
         let myString1 = Accountnolengthstr
         let myInt1 = Int(myString1)
         
         let myString3 = minAccountnolengthstr
         let myInt3 = Int(myString3)
         
         
         
         let startNumber = myInt3!
         let endNumber = myInt1
         let numberRange = startNumber...endNumber!
         
         if numberRange.contains(accountNum.text!.count) {
         print("Number is inside the range")
         } else {
         print("Number is outside the range")
         
         let bottomOffset = CGPoint(x: 0, y: 240)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         self.view.makeToast(NSLocalizedString("Please enter valid account number", comment: ""), duration: 3.0, position: .center)
         
         //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid account number", comment: ""), action: NSLocalizedString("ok", comment: ""))
         return
         }
         
         
         //               if accountNum.text!.count == myInt1
         //               {
         //                 print("5printno",accountNum.text!.count)
         //               }
         //            else
         //             {
         //                 alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid account number", comment: ""), action: NSLocalizedString("ok", comment: ""))
         //                 return
         //
         //             }
         }
         
         }
         
         
         
         //ibannolenghthcheck
         
         if Accountnolengthstr == "0"||Accountnolengthstr.isEmpty || ibanclickcheckstr == "0"
         {
         
         
         }
         else
         {
         
         // iban.text!.count
         print("acnolengthprint",iban.text!.count)
         let myString1b = Accountnolengthstr
         let myInt1b = Int(myString1b)
         
         if iban.text!.count == myInt1b
         {
         print("5printnoiban",iban.text!.count)
         }
         else
         {
         let bottomOffset = CGPoint(x: 0, y: 260)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         
         self.view.makeToast("IBAN number must be  " + Accountnolengthstr + "  characters", duration: 3.0, position: .center)
         
         // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "IBAN number must be  " + Accountnolengthstr + "  characters", action: NSLocalizedString("ok", comment: ""))
         return
         }
         
         }
         
         
         }
         
         
         //new ifsc validation
         if ifscnolengthstr.isEmpty || ifscnolengthstr == "0"
         {
         
         }
         else
         {
         //ifscvalid
         // ifsc.text!.count
         print("ifsclengthprint",ifscCode.text!.count)
         let myString1c = ifscnolengthstr
         let myInt1c = Int(myString1c)
         
         if ifscCode.text!.count == myInt1c
         {
         print("5printifscno",ifscCode.text!.count)
         }
         else
         {
         let bottomOffset = CGPoint(x: 0, y: 260)
         //OR
         //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
         self.scrollView.setContentOffset(bottomOffset, animated: true)
         
         self.view.makeToast("IFSC code must be  " + ifscnolengthstr + "  characters", duration: 3.0, position: .center)
         
         // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "IFSC code must be  " + ifscnolengthstr + "  characters", action: NSLocalizedString("ok", comment: ""))
         return
         }
         
         }
         
         
         
         
         //ibancheck
         if iban.text == ""||iban.text!.isEmpty
         {
         self.ibanstrenterd = ""
         }
         else
         {
         self.ibanstrenterd = iban.text!
         }
         
         */
        
        //        if(!checkClick)
        //        {
        //            self.view.makeToast(NSLocalizedString("confirm_account", comment: ""), duration: 3.0, position: .center)
        //            // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("confirm_account", comment: ""), action: NSLocalizedString("ok", comment: ""))
        //            return
        //        }
        if(!termsClick)
        {
            self.view.makeToast(NSLocalizedString("pls_agree", comment: ""), duration: 3.0, position: .center)
            // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pls_agree", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        if middleNameTF.text?.isEmpty ?? true {
            print("middlenametextField is empty")
            self.str_middleName = ""
        } else {
            print("middletextField has some text")
            self.str_middleName = middleNameTF.text!
            print("middletextField has some text",str_middleName)
        }
        
        
        //middlename
        //        var strmiddlename = middleNameTF.text
        //        strmiddlename = strmiddlename!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        //        print(strmiddlename)
        //        // "this is the answer"
        //        print("strlastname",strmiddlename)
        //        middleNameTF.text =  strmiddlename
        //        print("middlenaetxtfd.text",middleNameTF.text)
        //
        //        //extraspace remove
        //        let startingStringmnamee = middleNameTF.text!
        //        let processedStringmnamee = startingStringmnamee.removeExtraSpacesremac()
        //        print("processedString:\(processedStringmnamee)")
        //        middleNameTF.text = processedStringmnamee
        
        
        
        
        self.str_firstName = firstNameTF.text!
        self.str_middleName = middleNameTF.text!
        self.str_lastName = lastNameTF.text!
        self.str_country = countryTF.text!
        self.str_natioality = natioalityTF.text!
        self.str_relation = relationTF.text!
        self.str_gender = genderTF.text!
        self.str_serviceProvider = serviceProviderTF.text!
        self.str_address1 = address1TF.text!
        self.str_address2 = address2TF.text!
        self.str_mobile = mobileTF.text!
        self.str_idNum = idNumTF.text!
        self.str_bankName = bankNameTF.text!
        self.str_branchName = branchNameTF.text!
        self.str_accNum = accNumTF.text!
        
        print("\n partnerId",partnerId)
        print("\n token",token)
        print("\n customerRegNo",defaults.string(forKey: "REGNO"))
        print("\n customerIDNo",defaults.string(forKey: "USERID"))
        print("\n beneficiaryAccountName",self.str_firstName + " " + self.str_lastName)
        print("\n beneficiaryNickName","")
        print("\n DOB",self.str_Dob)
        print("\n beneficiaryAccountNumber",self.str_accNum)
        print("\n beneficiaryBankName",self.selectedBank?.bankCode)
        print("\n beneficiaryBankBranchName",self.selectedBranch?.branchCode)
        print("\n beneficiaryAccountType","SAVINGS")
        print("\n beneficiaryBankCountryCode",self.str_country)
        print("\n beneficiaryMobile",self.str_mobile)
        print("\n beneficiaryAddress1",self.str_address1)
        print("\n beneficiaryAddress2",self.str_address2)
        print("\n beneficiaryFirstName",self.str_firstName)
        print("\n beneficiaryLastName",str_lastName)
        print("\n relationship",self.str_relation)
        
        UserDefaults.standard.removeObject(forKey: "servicetypestoresel")
        UserDefaults.standard.set(self.serviceType, forKey: "servicetypestoresel")
        
        
        
        
        
        
        //for otp
        self.getToken(num: 7)
        //        self.getTokenOld(num: 1)
        //for no otp
        //             self.getToken(num: 8)
        
        timer?.invalidate()
        
    }
    // MARK: - Validation :
    func validate(value: String) -> Bool {
        //let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let PHONE_REGEX = "^[0-9]{0,15}$"
        //let PHONE_REGEX = "[a-zA-z]"
        
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func isValid(testStr:String) -> Bool {
        guard testStr.count > 0, testStr.count < 48 else { return false }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
    func isValidInput(Input:String) -> Bool {
        let RegEx = "[a-zA-z]+([ '-][a-zA-Z]+)*$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
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
                    
                }
                else if(num == 2)
                {
                    self.getCountry(access_token: token)
                }
                else if(num == 3)
                {
                    self.getCurrency(access_token: token)
                }
                else if(num == 4)
                {
                    self.getServiceProvider(access_token: token)
                }
                else if(num == 5)
                {
                    self.getBank(access_token: token)
                }
                else if(num == 6)
                {
                    self.getBranch(access_token: token)
                }
                
                else if(num == 7)
                {
                    self.viewCustomer(access_token: token)
                }
                else if(num == 8)
                {
                    self.saveBeneficiary(access_token: token)
                }
                else if(num == 9)
                {
                    self.getOTP(access_token: token)
                }
                else if(num == 10)
                {
                    self.validateOTP(access_token: token)
                }
                else if(num == 11)
                {
                    
                }
                
                break
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
        })
    }
    func getNationality() {
        nationalityArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "casmex/getMasterDetails"
        let params:Parameters =  [
            "type":"nationality"
        ]
        
        print("urlbank",url)
        print("paramsbank",params)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            
            print("resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                if let resultArray = myResult?["data"]{
                    for i in resultArray.arrayValue{
                        
                        let nationality = CasmexNationality(id: i["id"].stringValue, description: i["description"].stringValue)
                        self.nationalityArray.append(nationality)
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
    
    func getCountry(access_token:String) {
        countryArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "shiftservice/getDestinationCountries"
        let params:Parameters =  [
            "serviceType":serviceType
        ]
        print("urlbank",url)
        print("paramsbank",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            switch response.result{
                
            case .success:
                if let responseData = response.data {
                    do {
                        let myResult = try JSON(data: responseData)
                        
                        
                        print("myResult - \(myResult)")
                        let resultArray = myResult[]
                        for i in resultArray.arrayValue{
                            let country = CasmexCountry(countryCode: i["countryCode"].stringValue, countryName: i["countryName"].stringValue)
                            self.countryArray.append(country)
                        }
                        print("Parsed Countries: \(self.countryArray)")
                    } catch {
                        print("Error parsing response data: \(error.localizedDescription)")
                    }
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
        })
    }
    func getCurrency(access_token:String) {
        currencyArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "shiftservice/showPayoutCurrencies"
        let params:Parameters =  [
            "serviceType":serviceType,
            "destinationCountryCode":selectedCountry?.countryCode ?? ""
        ]
        
        print("urlbank",url)
        print("paramsbank",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            switch response.result{
                
            case .success:
                let myResult = try? JSON(data: response.data!)
                print("resp",response)
                
                let resultArray = myResult![]
                for i in resultArray.arrayValue{
                    
                    let currency = CasmexCurrency(currencyCode: i["currencyCode"].stringValue, currencyName: i["currencyName"].stringValue)
                    self.currencyArray.append(currency)
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
            
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
        })
    }
    func getServiceProvider(access_token:String){
        serviceProviderArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "utilityservice/getServiceProvider"
        let params:Parameters =  [
            "receiveContry":selectedCountry?.countryCode ?? "",
            "serviceType":serviceType,
            "receiveCurrency":selectedCurrency?.currencyCode ?? "",
            "sendCountryCode":"QAR",
            "idNo":defaults.string(forKey: "USERID")!
        ]
        
        print("urlbank",url)
        print("paramsbank",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            switch response.result{
                
            case .success:
                let myResult = try? JSON(data: response.data!)
                print("resp",response)
                
                let resultArray = myResult!
                for i in resultArray.arrayValue{
                    
                    let serviceProvider = CasmexServiceProvider(serviceProviderCode: i["serviceProviderCode"].stringValue,
                                                                serviceProviderName: i["serviceProviderName"].stringValue,
                                                                serviceProviderType: i["serviceProviderType"].stringValue)
                    self.serviceProviderArray.append(serviceProvider)
                    self.setServiceProvider()
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
            
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
        })
    }
    func getBank(access_token:String) {
        bankArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "utilityservice/getbanks"
        let params:Parameters =  [
            "receiveContry":selectedCountry?.countryCode ?? "",
            "serviceType":serviceType,
            "receiveCurrency":selectedCurrency?.currencyCode ?? "",
            "sendCountryCode":"QAR",
            "serviceProviderCode":selectedServiceProvider?.serviceProviderCode ?? "",
            "idNo":defaults.string(forKey: "USERID")!
        ]
        
        print("urlbank",url)
        print("paramsbank",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            switch response.result{
                
            case .success:
                let myResult = try? JSON(data: response.data!)
                print("resp",response)
                let resultArray = myResult![]
                for i in resultArray.arrayValue{
                    
                    let bank = CasmexBank(bankCode: i["bankCode"].stringValue, bankName: i["bankName"].stringValue)
                    self.bankArray.append(bank)
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
            
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
        })
    }
    func getBranch(access_token:String) {
        branchArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "utilityservice/getbankbranches"
        var params:Parameters = ["bankCode":selectedBank?.bankCode ?? "",
                                 "serviceProviderCode":selectedServiceProvider?.serviceProviderCode ?? "",
                                 "searchText":branchSearchText,
                                 "idNo":defaults.string(forKey: "USERID")!
        ]
        /*if branchSearchText == ""{
         params =  [
         "bankCode":selectedBank?.bankCode ?? "",
         "serviceProviderCode":selectedServiceProvider?.serviceProviderCode ?? "",
         //                "searchText":branchSearchText,
         "searchText":"",
         "idNo":defaults.string(forKey: "USERID")!
         ]
         }else{
         params =  [
         "bankCode":selectedBank?.bankCode ?? "",
         "serviceProviderCode":selectedServiceProvider?.serviceProviderCode ?? "",
         "searchText":branchSearchText,
         //            "searchText":"",
         "idNo":defaults.string(forKey: "USERID")!
         ]
         }*/
        
        
        print("urlbank",url)
        print("paramsbank",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        self.view.endEditing(true)
        self.BranchApiCalled = false
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("getBranch Resposnse",response)
            self.effectView.removeFromSuperview()
            switch response.result{
                
            case .success:
                self.branchArray.removeAll()
                let myResult = try? JSON(data: response.data!)
                //            print("resp",response)
                
                let resultArray = myResult!
                for i in resultArray.arrayValue{
                    
                    let bicDetailsArray = i["bicDetails"].arrayValue.map { bic in
                        CasmexBICDetail(
                            bicType: bic["bicType"].stringValue,
                            bicValue: bic["bicValue"].stringValue
                        )
                    }
                    
                    let branch = CasmexBranch(branchCode: i["branchCode"].stringValue,
                                              branchName: i["branchName"].stringValue,
                                              address: i["address"].stringValue,
                                              email: i["email"].stringValue,
                                              phone: i["phone"].stringValue,
                                              bicDetails: bicDetailsArray)
                    self.branchArray.append(branch)
                    self.currentDropdownSelection = .branch
                    if !self.branchArray.isEmpty{
                        self.addPopUp()
                        self.branchIcon.image = UIImage(named: "t_search")
                        
                    }else {
                        showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "No Branches available")
                    }
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
            
            // if bicDetails
            /*
             self.effectView.removeFromSuperview()
             if let responseData = response.data {
             do {
             // Decode the JSON response into the `Branch` model
             let branches = try JSONDecoder().decode([CasmexBranch].self, from: responseData)
             
             self.branchArray = branches
             
             // Debug print
             print("Parsed Branches: \(self.branchArray)")
             } catch {
             // Handle parsing errors
             print("Error decoding JSON: \(error.localizedDescription)")
             }
             }
             */
            
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
        })
    }
    func getRelation() {
        relationArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "casmex/getMasterDetails"
        let params:Parameters =  [
            "type":"relationship"
        ]
        
        print("urlgetRelation",url)
        print("paramsgetRelation",params)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            switch response.result{
                
            case .success:
                let myResult = try? JSON(data: response.data!)
                print("respgetRelation",response)
                
                let resultArray = myResult!["data"]
                for i in resultArray.arrayValue{
                    let relation = CasmexRelation(id: i["id"].stringValue, description: i["description"].stringValue)
                    self.relationArray.append(relation)
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
        })
    }
    func saveBeneficiary(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let appVersion = AppInfo.version
        print("appVersion",appVersion)
        
        //        if str_middle_name != ""
        //        {
        //            fullnamestr = self.str_first_name + " " + str_middle_name + " "  + self.str_last_name
        //        }
        //        else
        //        {
        //            fullnamestr = self.str_first_name + " " + self.str_last_name
        //        }
        
        
        
        // if bankcitytypestr == "T"
        //{}
        var serviceProviderCode:String?
        var serviceProviderName:String?
        if selectedServiceProvider == nil{
            serviceProviderCode = ""
            serviceProviderName = ""
        }else{
            serviceProviderCode = selectedServiceProvider?.serviceProviderCode
            serviceProviderName = selectedServiceProvider?.serviceProviderName
        }
        
        let url = ge_api_url_new + "beneficiary/savebeneficiary"
        let params:Parameters = [
            "customerIDNo":defaults.string(forKey: "USERID") ?? "",
            "serviceType":serviceType,
            "beneficiaryFirstName":str_firstName,
            "beneficiaryMiddleName":str_middleName,
            "beneficiaryLastName":str_lastName,
            "beneficiaryMobile":str_mobile,
            "beneficiaryEmail":"",
            "beneficiaryGender":str_gender,
            "dob":str_Dob,
            "beneficiaryAddress":str_address1,
            "beneficiaryBankCountryCode":selectedCountry?.countryCode ?? "",
            "beneficiaryNationality":selectedNationality?.id ?? "",
            "relationship":selectedRelation?.id ?? "",
            "beneficiaryBankCode": selectedBank?.bankCode ?? "",
            "beneficiaryBankName": selectedBank?.bankName ?? "",
            "beneficiaryBankBranchCode":selectedBranch?.branchCode ?? "",
            "beneficiaryBankBranchName":selectedBranch?.branchName ?? "",
            "beneficiaryCurrency":selectedCurrency?.currencyCode ?? "",
            "beneficiaryAccountNumber":str_accNum,
            "beneficiaryAccountType":"",
            "bicType":selectedBic?.bicType ?? "",
            "bicValue":selectedBic?.bicValue ?? "",
            "serviceProviderCode":serviceProviderCode ?? "",
            "serviceProviderName":serviceProviderName ?? ""
        ]
        
        //,"serviceType":"CREDIT","beneficiaryMiddleName": "kl","beneficiaryGender": "male","beneficiaryNationality": "ZMB"
        print("urlbeneficiary/savebeneficiary",url)
        print("urlbeneficiary/savebeneficiaryparams",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("\nsavebeneficiary \(response)")
            switch response.result{
                
            case .success:
                let myResult = try? JSON(data: response.data!)
                
                let respCode = myResult!["statusCode"]
                print("resp",respCode)
                print("response svavebenif",response)
                self.effectView.removeFromSuperview()
                
                
                
                if respCode == "200"
                {
                    let respMsg = myResult!["statusMessage"].stringValue
                    self.alertMessage(title:  NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: "")) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
                else
                {
                    let respMsg = myResult!["statusMessage"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: "")){
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
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
            switch response.result{
                
            case .success:
                let myResult = try? JSON(data: response.data!)
                print("resp",response)
                self.effectView.removeFromSuperview()
                self.email = myResult!["email"].stringValue
                self.mobile = myResult!["customerMobile"].stringValue
                print("email",self.email)
                print("mobile",self.mobile)
                self.getOTP(access_token: access_token)
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
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
    func getOTP(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/generateOtp"
        let params:Parameters = ["idNo":defaults.string(forKey: "USERID")!,"email":self.email,"type":"5","mobileNo":self.mobile]
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
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
        })
    }
    func validateOTP(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/verifyOtp"
        let params:Parameters = ["idNo":defaults.string(forKey: "USERID")!,"email":self.email,"type":"5","otpNo":self.strOtp,"mobileNo":self.mobile]
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
                    print("saveapicalling","apicallinggg")
                    self.getToken(num: 8)
                }
                else
                {
                    self.removeOtpView()
                    let respMsg = myResult!["responseMessage"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                }
                
                break
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
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
    
    //    func alertMessage(title:String,msg:String,action:String){
    //        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    //        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
    //        }))
    //        self.present(alert, animated: true)
    //    }
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
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
        })
    }
    
}

extension AddBeneficiaryVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Allow backspace
        //        if string.isEmpty {
        //            return true
        //        }
        if textField == branchNameTF{
            //            if let char = string.cString(using: String.Encoding.utf8) {
            //                    let isBackSpace = strcmp(char, "\\b")
            //                    if (isBackSpace == -92) {
            //                        print("Backspace was pressed")
            //                    }
            //                }
            
            if string.isEmpty, range.length == 1 {
                print("Backspace detected")
                selectedBic = nil
                bicArray.removeAll()
                selectedBranch = nil
                bicTF.text?.removeAll()
                return true
            }
            
            if selectedBank == nil{
                showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Bank")
                return true
            }else{
                selectedBic = nil
                bicArray.removeAll()
                selectedBranch = nil
                bicTF.text?.removeAll()
                //            branchArray.removeAll()
                branchIcon.image = UIImage(named: "t_search")
                
                let currentText = textField.text ?? ""
                if let textRange = Range(range, in: currentText) {
                    let updatedText = currentText.replacingCharacters(in: textRange, with: string)
                    
                    // Clear array and reset icon
                    branchArray.removeAll()
                    
                    // Call API if more than 3 characters
                    if updatedText.count > 3 && BranchApiCalled == false{
                        self.branchSearchText = branchNameTF.text!
                        self.BranchApiCalled = true
                        self.getToken(num: 6)
                        self.view.endEditing(true)
                    }
                }
            }
            
            
            
        }
        else{
            if string.isEmpty {
                return true
            }
        }
        if textField == accNumTF || textField ==  confirmAccNumTF{
            if selectedBranch == nil {
                showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Please choose a Branch")
                return true
            }else{
                //                if selectedBranch?.bicDetails[0].bicType ?? "" == "IBAN CODE"{
                
                if selectedCountry?.countryName ?? "" == "NEPAL" {
                    accNumTF.keyboardType = .default
                    confirmAccNumTF.keyboardType = .default
                    
                    let allowedCharacters = CharacterSet.alphanumerics.union(.whitespaces)
                    return string.rangeOfCharacter(from: allowedCharacters.inverted) == nil
                } else {
                    accNumTF.keyboardType = .numberPad
                    confirmAccNumTF.keyboardType = .numberPad
                    
                    let allowedCharacters = CharacterSet.decimalDigits
                    return string.rangeOfCharacter(from: allowedCharacters.inverted) == nil
                }
                
                //                if selectedCountry?.countryName ?? "" == "NEPAL"{
                //                    let allowedCharacters = CharacterSet.letters.union(.whitespaces)
                //                    return string.rangeOfCharacter(from: allowedCharacters) != nil
                //                }else{
                //                    let allowedCharacters = CharacterSet.decimalDigits
                //                    return string.rangeOfCharacter(from: allowedCharacters) != nil
                //                }
            }
        }
        for tf in characterTextFields{
            if textField == tf {
                // Allow only letters and spaces (no numbers or special characters)
                let allowedCharacters = CharacterSet.letters.union(.whitespaces)
                return string.rangeOfCharacter(from: allowedCharacters) != nil
            }
        }
        
        for tf in numberTextFields{
            if textField == tf {
                // Allow only numbers (0-9)
                let allowedCharacters = CharacterSet.decimalDigits
                return string.rangeOfCharacter(from: allowedCharacters) != nil
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == branchNameTF {
            if branchNameTF.text != "" && branchNameTF.text != nil && BranchApiCalled == false{
                self.branchSearchText = branchNameTF.text!
                self.BranchApiCalled = true
                self.getToken(num: 6)
                self.view.endEditing(true)
            }else{
                branchArray.removeAll()
                branchIcon.image = UIImage(named: "t_search")
            }
        }
        if let currentIndex = bankTFArray.firstIndex(of: textField) {
            var nextIndex = currentIndex + 1
            
            // If next field is a dropdown (disabled), resign the keyboard
            if nextIndex < bankTFArray.count, bankTFArray[nextIndex].isUserInteractionEnabled == false {
                textField.resignFirstResponder()
                return true
            }
            
            // Move to the next available text field
            if nextIndex < bankTFArray.count {
                bankTFArray[nextIndex].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        return true
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == branchNameTF {
            if branchNameTF.text != "" && branchNameTF.text != nil && BranchApiCalled == false{
                self.branchSearchText = branchNameTF.text!
                self.BranchApiCalled = true
                self.getToken(num: 6)
                self.view.endEditing(true)
            }else{
                branchArray.removeAll()
                branchIcon.image = UIImage(named: "t_search")
            }
        }
    }
    
}

