//
//  RegisterViewController.swift
//  GulfExchangeApp
//
//  Created by test on 26/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Toast_Swift
import ScreenShield
class RegisterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    var timer = Timer()
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    //newserch
    var occupationselsearchstr:String = ""
    var AllArray:[String] = Array()
    var AllArrayid:[String] = Array()
    var searchedArray:[String] = Array()
   var searchedArrayids:[String] = Array()
   var fruitsArray:[String] = Array()
    
    var checkarrayaoccustr  = Array<String>()
    var checkarrayaoccu  = Array<String>()
    var teststrcls : String = ""
    
    
    //nationalitysearch
    var natselserchstr:String = ""
    var checkarrayaoccunatstr  = Array<String>()
    var checkarrayaoccunat  = Array<String>()
    var teststrclsnat : String = ""
    var teststrclsnat1 : String = ""
    var searchedArraynat:[String] = Array()
    //new
    var checkarrayaoccunatflagcode  = Array<String>()
    var searchedArraynatflag:[String] = Array()
    
    var teststrclsnatflagstr : String = ""
    
    //zonesearch
    var zoneselserchstr:String = ""
    var checkarrayaoccuzonestr  = Array<String>()
    var checkarrayaoccuzone  = Array<String>()
    var teststrclszone : String = ""
    var searchedArrayzone:[String] = Array()
    
    


    
    var munsibtnnselstr:String = ""
    var occupationselstr:String = ""
    var actualoccupationselstr:String = ""
    
    
    var countrycodeQIDstr:String = ""
    var countrynameqidstr:String = ""
    var qidexpdatestr:String = ""
    var statusstrr:String = ""
    
    var backbtnstatusstrr:String = ""
    
    var backbtnstatusdismissstrr:String = ""
    
    @IBOutlet var actualoccutextfd: UITextField!
    
    
    @IBOutlet var buildingnotextfd: UITextField!
    
    @IBOutlet weak var identificationDetailsLbl: UILabel!
    @IBOutlet weak var identificationBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var securityBtn: UIButton!
    @IBOutlet weak var idTypeBtn: UIButton!
    @IBOutlet weak var tblIdType: UITableView!
    @IBOutlet weak var idIssuerBtn: UIButton!
    @IBOutlet weak var tblIdIssuer: UITableView!
    @IBOutlet weak var idNumTextField: UITextField!
    @IBOutlet weak var idExpDateTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var mobContainerView: UIView!

    
    @IBOutlet var radiospecialcharlbl: UILabel!
    
    @IBOutlet weak var personal_infoLbl: UILabel!
    @IBOutlet weak var fullNameEnTextField: UITextField!
    @IBOutlet weak var fullNameArTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var countryResiBtn: UIButton!
    @IBOutlet weak var municipalityBtn: UIButton!
    @IBOutlet weak var zoneBtn: UIButton!
    @IBOutlet weak var homeAddressTextField: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var countryCodeTextfield: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var employerTextField: UITextField!
    @IBOutlet weak var expIncomeTextField: UITextField!
    @IBOutlet weak var workAddressTextField: UITextField!
    @IBOutlet weak var occupationTextField: UITextField!
    @IBOutlet weak var registrationCodeTextField: UITextField!
    @IBOutlet weak var next1Btn: UIButton!
    
    
    
    @IBOutlet weak var secQuesBtn: UIButton!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var passwLbl: UILabel!
    @IBOutlet weak var passReqLbl: UILabel!
    @IBOutlet weak var req1Lbl: UILabel!
    @IBOutlet weak var req2Lbl: UILabel!
    @IBOutlet weak var req3Lbl: UILabel!
    @IBOutlet weak var req4Lbl: UILabel!
    @IBOutlet weak var passwTextField: UITextField!
    @IBOutlet weak var retypePasswTextField: UITextField!
    @IBOutlet weak var pinLbl: UILabel!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var iAgreeLbl: UILabel!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var createProfileBtn: UIButton!
    
    @IBOutlet weak var tab1View: UIView!
    @IBOutlet weak var tab2View: UIView!
    @IBOutlet weak var tab3View: UIView!
    
    @IBOutlet weak var nationalitySearchView: UIView!
    @IBOutlet weak var nationalityTextField: UITextField!
    @IBOutlet weak var tblNationality: UITableView!
    @IBOutlet weak var nationalityWhiteView: UIView!
    
    @IBOutlet weak var municipalitySearchView: UIView!
    @IBOutlet weak var municipalityWhiteView: UIView!
    @IBOutlet weak var municipalitySearchTextField: UITextField!
    @IBOutlet weak var tblMunicipality: UITableView!
    @IBOutlet weak var zoneSearchView: UIView!
    @IBOutlet weak var zoneWhiteView: UIView!
    @IBOutlet weak var zoneSearchTextField: UITextField!
    @IBOutlet weak var tblZone: UITableView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderWhiteView: UIView!
    @IBOutlet weak var maleCheckBtn: UIButton!
    @IBOutlet weak var femaleCheckBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tblsecQues: UITableView!
    @IBOutlet weak var secQuesView: UIView!
    @IBOutlet weak var secQuesWhiteView: UIView!
    @IBOutlet weak var passwEyeBtn: UIButton!
    @IBOutlet weak var retypePasswEyeBtn: UIButton!
    @IBOutlet weak var pinEyeBtn: UIButton!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var termsWhiteView: UIView!
    @IBOutlet weak var termsTextView: UITextView!
    @IBOutlet weak var acceptBtn: UIButton!
    
    @IBOutlet weak var radio1: UIButton!
    @IBOutlet weak var radio2: UIButton!
    @IBOutlet weak var radio3: UIButton!
    @IBOutlet weak var radio4: UIButton!
    
    @IBOutlet weak var dualNationalityBtn: UIButton!
    
    @IBOutlet var radio5specialcharbtn: UIButton!
    
    
    @IBAction func radio5specialcharbtnAct(_ sender: Any) {
    }
    
    
    var passCheck1 = false
    var passCheck2 = false
    var passCheck3 = false
    var passCheck4 = false
    let idTypeArray = ["QID"]
    let idIssuerArray = ["Ministry of Interior","Ministry of Foreign Affairs"]
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
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
    var str_occupationname:String = ""
    var str_actualoccupationname:String = ""
    
    var str_buildingno:String = ""
    
    var str_actualoccupation:String = ""
    var str_working_address:String = ""
    var str_income:String = ""
    var str_reg_no:String = ""
    var str_zone:String = ""
    var strMobile:String = ""
    var nationalityFlagPath:String = ""
    var municipality_id:String = ""
    
      var municipality_idoccupationid:String = ""
    
    
    
    var nationalitynamestr:String = ""
    var nationalitynamestr1:String = ""
    
    var nationalityArray:[CasmexNationality] = []
    var countryResArray:[CasmexNationality] = []
    var checkCountry:Int = 0
    var municipalityArray:[City] = []
    var zoneArray:[Zone] = []
    var secQuesArray:[SecurityQuestion] = []
    var checkGender:Int = 0
    
    var checkNationality:Int = 0
    var passwEyeClick = true
    var retypePasswEyeClick = true
    var pinEyeClick = true
    var termsClick = false
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var userAge:Double?
        //test
        static let AlamoFireManager: Alamofire.Session = {
            let manager = ServerTrustManager(evaluators: [
                "78.100.141.203": DisabledEvaluator(),
                "ws.gulfexchange.com.qa": DisabledEvaluator(),
                "gulfexchange.com.qa": DisabledEvaluator()])
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
    
    func isValid(testStr:String) -> Bool {
        guard testStr.count > 0, testStr.count < 18 else { return false }

            let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
            return predicateTest.evaluate(with: testStr)
        }
    
    func isValidInput(Input:String) -> Bool {
           let RegEx = "[a-zA-z]+([ '-][a-zA-Z]+)*$"
        //let RegEx = "^([a-z0-9]+[._])*[a-z0-9]+$"
        
           let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
           return Test.evaluate(with: Input)
       // let trimmedString = Input.trimmingCharacters(in: .whitespaces)
        
       }
    
    // MARK: phone no Validation :
    func validate(value: String) -> Bool {
        //let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let PHONE_REGEX = "^[0-9]{0,15}$"
        //let PHONE_REGEX = "[a-zA-z]"
        
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print("recognizedTextrecognizedText",UserDefaults.standard.string(forKey: "recognizedQidText"))
       
        
        
        
        //newQID
//        getTokenGECOQID()
        
       // self.genderBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        //newbackbtn
        let custmBackBtn = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .done, target: self, action: #selector(Backbtnaction))
        self.navigationItem.leftBarButtonItem  = custmBackBtn
      //  backbtnstatusstrr = "idpage"
       // backbtnstatusdismissstrr == ""
        
            //localize
            //p1
            self.identificationDetailsLbl.text = (NSLocalizedString("identification", comment: ""))
            
            self.idTypeBtn.setTitle(NSLocalizedString("id_type", comment: ""), for: .normal)
            self.idTypeBtn.setTitleColor(UIColor.lightGray, for: .normal)
            
            self.idIssuerBtn.setTitle(NSLocalizedString("id_issuer", comment: ""), for: .normal)
            self.idIssuerBtn.setTitleColor(UIColor.lightGray, for: .normal)
            
            self.idNumTextField.placeholder = (NSLocalizedString("id_number", comment: ""))
            self.idExpDateTextField.placeholder = (NSLocalizedString("id_exp_date", comment: ""))
            
            self.nextBtn.setTitle(NSLocalizedString("next", comment: ""), for: .normal)
            self.cancelBtn.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
            
            //p2
            self.personal_infoLbl.text = (NSLocalizedString("personal_info", comment: ""))
            
            self.fullNameEnTextField.placeholder = (NSLocalizedString("fullname_en", comment: ""))
            self.fullNameArTextField.placeholder = (NSLocalizedString("fullname_ar", comment: ""))
            self.emailTextField.placeholder = (NSLocalizedString("email", comment: ""))
            self.dobTextField.placeholder = (NSLocalizedString("dob", comment: ""))
            
            self.nationalityBtn.setTitle(NSLocalizedString("nationality", comment: ""), for: .normal)
            self.dualNationalityBtn.setTitle(NSLocalizedString("dualnationality", comment: ""), for: .normal)
            self.countryResiBtn.setTitle(NSLocalizedString("country_residence", comment: ""), for: .normal)
            self.municipalityBtn.setTitle(NSLocalizedString("municipality", comment: ""), for: .normal)
            //self.zoneBtn.setTitle(NSLocalizedString("zone", comment: ""), for: .normal)
       // self.zoneBtn.setTitle(NSLocalizedString("zone", comment: ""), for: .normal)
        zoneBtn.setTitle("Zone", for: .normal)
       // dualnationalitybtn.setTitle("Dual nationality(optional)", for: .normal)
            //self.homeAddressTextField.placeholder = (NSLocalizedString("home_addr", comment: ""))
        self.homeAddressTextField.placeholder = "Street"
        self.buildingnotextfd.placeholder = "Building Number"
        

        
            self.genderBtn.setTitle(NSLocalizedString("gender", comment: ""), for: .normal)
            self.mobileTextField.placeholder = (NSLocalizedString("mobile_no", comment: ""))
            self.employerTextField.placeholder = (NSLocalizedString("employer", comment: ""))
            self.expIncomeTextField.placeholder = (NSLocalizedString("exp_income", comment: ""))
            self.workAddressTextField.placeholder = (NSLocalizedString("work_address", comment: ""))
            self.occupationTextField.placeholder = (NSLocalizedString("occupation", comment: ""))
            self.registrationCodeTextField.placeholder = (NSLocalizedString("reg_code", comment: ""))
            
            self.nextBtn.setTitle(NSLocalizedString("next", comment: ""), for: .normal)
            
            
            //p3
            
            self.secQuesBtn.setTitle(NSLocalizedString("security_question", comment: ""), for: .normal)
            
            self.answerTextField.placeholder = (NSLocalizedString("answer", comment: ""))
            self.passwLbl.text = (NSLocalizedString("pass_cap", comment: ""))
            self.passReqLbl.text = (NSLocalizedString("pass_req", comment: ""))
            
            self.req1Lbl.text = (NSLocalizedString("characters", comment: ""))
            self.req2Lbl.text = (NSLocalizedString("uppercase", comment: ""))
            self.req3Lbl.text = (NSLocalizedString("lowercase", comment: ""))
            self.req4Lbl.text = (NSLocalizedString("num", comment: ""))
            
            self.passwTextField.placeholder = (NSLocalizedString("password", comment: ""))
            
            self.retypePasswTextField.placeholder = (NSLocalizedString("retype_pass", comment: ""))
            
            self.pinLbl.text = (NSLocalizedString("pin_num", comment: ""))
            self.pinTextField.placeholder = (NSLocalizedString("pin", comment: ""))
            
            self.iAgreeLbl.text = (NSLocalizedString("i_agree", comment: ""))
            
            
            self.createProfileBtn.setTitle(NSLocalizedString("create_profile", comment: ""), for: .normal)
            
        
        
        
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didRecognizeTapGesture(_:)))

       occupationTextField.addGestureRecognizer(tapGesture)
        
        
        
        
    let tapGestureone = UITapGestureRecognizer(target: self, action: #selector(didRecognizeTapGestureone(_:)))

       actualoccutextfd.addGestureRecognizer(tapGestureone)
        
        
        //idTypeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 300, bottom: 0, right: 0);
       // idIssuerBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 300, bottom: 0, right: 0);
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        var image = UIImage(named: "box")
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            image = UIImage(named: "boxArabic")
            emailTextField.textAlignment = .right
            fullNameEnTextField.textAlignment = .right
            fullNameArTextField.textAlignment = .right
            dobTextField.textAlignment = .right
            homeAddressTextField.textAlignment = .right
            mobileTextField.textAlignment = .right
            employerTextField.textAlignment = .right
            expIncomeTextField.textAlignment = .right
            workAddressTextField.textAlignment = .right
            occupationTextField.textAlignment = .right
            idNumTextField.textAlignment = .right
            idExpDateTextField.textAlignment = .right
            nationalityTextField.textAlignment = .right
            municipalitySearchTextField.textAlignment = .right
            zoneSearchTextField.textAlignment = .right
            registrationCodeTextField.textAlignment = .right
            answerTextField.textAlignment = .right
            passwTextField.textAlignment = .right
            retypePasswTextField.textAlignment = .right
            pinTextField.textAlignment = .right
            mobContainerView.semanticContentAttribute = .forceLeftToRight
            
            countryCodeTextfield.textAlignment = .right
            answerTextField.textAlignment = .right
                    
                    
            zoneBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            self.genderBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            nationalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            dualNationalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            municipalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            countryResiBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            idTypeBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            idIssuerBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            secQuesBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            
        } else {
            emailTextField.textAlignment = .left
            fullNameEnTextField.textAlignment = .left
            fullNameArTextField.textAlignment = .left
            dobTextField.textAlignment = .left
            homeAddressTextField.textAlignment = .left
            mobileTextField.textAlignment = .left
            employerTextField.textAlignment = .left
            expIncomeTextField.textAlignment = .left
            workAddressTextField.textAlignment = .left
            occupationTextField.textAlignment = .left
            idNumTextField.textAlignment = .left
            idExpDateTextField.textAlignment = .left
            nationalityTextField.textAlignment = .left
            municipalitySearchTextField.textAlignment = .left
            zoneSearchTextField.textAlignment = .left
            registrationCodeTextField.textAlignment = .left
            answerTextField.textAlignment = .left
            passwTextField.textAlignment = .left
            retypePasswTextField.textAlignment = .left
            pinTextField.textAlignment = .left
            mobContainerView.semanticContentAttribute = .forceLeftToRight
        }
        identificationBtn .setBackgroundImage(image, for: .normal)
        self.awakeFromNib()
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("register", comment: "")
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        nextBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        nextBtn.layer.cornerRadius = 15
        cancelBtn.backgroundColor = UIColor(red: 0.13, green: 0.16, blue: 0.20, alpha: 1.00)
        cancelBtn.layer.cornerRadius = 15
        next1Btn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        next1Btn.layer.cornerRadius = 15
        nationalityWhiteView.layer.cornerRadius = 10
        municipalityWhiteView.layer.cornerRadius = 10
        zoneWhiteView.layer.cornerRadius = 10
        genderWhiteView.layer.cornerRadius = 10
        secQuesWhiteView.layer.cornerRadius = 10
        termsWhiteView.layer.cornerRadius = 10
        createProfileBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        createProfileBtn.layer.cornerRadius = 15
        acceptBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        acceptBtn.layer.cornerRadius = 15
        
        idTypeBtn.layer.cornerRadius = 0
        idTypeBtn.layer.borderWidth = 1
        idTypeBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        idIssuerBtn.layer.cornerRadius = 0
        idIssuerBtn.layer.borderWidth = 0.8
        idIssuerBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        nationalityBtn.layer.cornerRadius = 0
        nationalityBtn.layer.borderWidth = 0.8
        nationalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        dualNationalityBtn.layer.cornerRadius = 0
        dualNationalityBtn.layer.borderWidth = 0.8
        dualNationalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        countryResiBtn.layer.cornerRadius = 0
        countryResiBtn.layer.borderWidth = 0.8
        countryResiBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        municipalityBtn.layer.cornerRadius = 0
        municipalityBtn.layer.borderWidth = 0.8
        municipalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        zoneBtn.layer.cornerRadius = 0
        zoneBtn.layer.borderWidth = 0.8
        zoneBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        genderBtn.layer.cornerRadius = 0
        genderBtn.layer.borderWidth = 0.8
        genderBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        secQuesBtn.layer.cornerRadius = 0
        secQuesBtn.layer.borderWidth = 0.8
        secQuesBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        setFont()
        setFontSize()
        createToolbar()
        createToolbar1()
        
        tblIdType.dataSource = self
        tblIdType.delegate = self
        
        tblIdIssuer.dataSource = self
        tblIdIssuer.delegate = self
        
        tblNationality.dataSource = self
        tblNationality.delegate = self
        
        tblMunicipality.dataSource = self
        tblMunicipality.delegate = self
        
        tblZone.dataSource = self
        tblZone.delegate = self
        
        tblsecQues.dataSource = self
        tblsecQues.delegate = self
        
        idNumTextField.delegate = self
        mobileTextField.delegate = self
        passwTextField.delegate = self
        retypePasswTextField.delegate = self
        pinTextField.delegate = self
    
        getSecQues()
        getTermsandConditions()
        
        nationalityTextField.delegate = self
        municipalitySearchTextField.delegate = self
        zoneSearchTextField.delegate = self
        passwTextField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange(_:)), for: .editingChanged)
        nationalityTextField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange(_:)), for: .editingChanged)
        municipalitySearchTextField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange(_:)), for: .editingChanged)
        zoneSearchTextField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        
        
        
        
        //new
       
        countryResiBtn.setTitle("Qatar", for: .normal)
        self.countryResiBtn.setTitleColor(UIColor.black, for: .normal)
       
        self.str_country = "QAT"
        
        self.str_idType = "QID"
        idTypeBtn.setTitle("QID", for: .normal)
        self.idTypeBtn.setTitleColor(UIColor.black, for: .normal)
        
        //self.idIssuerBtn.titleLabel?.text = "Ministry of Interior"
        self.idIssuerBtn.setTitle("\("Ministry of Interior")", for: .normal)
        self.idIssuerBtn.setTitleColor(.black, for: .normal)

        
        
        //new
        
        self.idTypeBtn.layer.borderWidth = 0.8
        self.idTypeBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        self.idNumTextField.layer.borderWidth = 0.8
        self.idNumTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        self.idIssuerBtn.layer.borderWidth = 0.8
        self.idIssuerBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        self.idExpDateTextField.layer.borderWidth = 0.8
        self.idExpDateTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        
        self.fullNameEnTextField.layer.borderWidth = 0.8
        self.fullNameEnTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.fullNameArTextField.layer.borderWidth = 0.8
        self.fullNameArTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.emailTextField.layer.borderWidth = 0.8
        self.emailTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.dobTextField.layer.borderWidth = 0.8
        self.dobTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.homeAddressTextField.layer.borderWidth = 0.8
        self.homeAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
//        self.buildingnotextfd.layer.borderWidth = 0.8
//        self.buildingnotextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        self.buildingnotextfd.layer.borderWidth = 0.8
        self.buildingnotextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

        
        
        self.mobileTextField.layer.borderWidth = 0.8
        self.mobileTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.countryCodeTextfield.layer.borderWidth = 0.8
        self.countryCodeTextfield.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.employerTextField.layer.borderWidth = 0.8
        self.employerTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        self.expIncomeTextField.layer.borderWidth = 0.8
        self.expIncomeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.workAddressTextField.layer.borderWidth = 0.8
        self.workAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        self.occupationTextField.layer.borderWidth = 0.8
        self.occupationTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.actualoccutextfd.layer.borderWidth = 0.8
        self.actualoccutextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.registrationCodeTextField.layer.borderWidth = 0.8
        self.registrationCodeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        self.passwTextField.layer.borderWidth = 0.8
        self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        self.retypePasswTextField.layer.borderWidth = 0.8
        self.retypePasswTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        self.pinTextField.layer.borderWidth = 0.8
        self.pinTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        //new
//        self.genderBtn.setTitleColor(.systemGray5, for: .normal)
//        self.nationalityBtn.setTitleColor(.systemGray5, for: .normal)
//        self.municipalityBtn.setTitleColor(.systemGray5, for: .normal)
//        self.zoneBtn.setTitleColor(.systemGray5, for: .normal)
        }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(true)
        
        let recognizedName = UserDefaults.standard.string(forKey: "recognizedName")
           let recognizedDOB = UserDefaults.standard.string(forKey: "recognizedDOB")
        let recognizedNationality = UserDefaults.standard.string(forKey: "recognizedNationality")
        let recognizedText = UserDefaults.standard.string(forKey: "recognizedQidText")
        let recognizedExpiryText = UserDefaults.standard.string(forKey: "recognizedExpiryText")
        print("recognizedName\(recognizedName)\n recognizedDOB\(recognizedDOB)\n recognizedNationality\(recognizedNationality)\n recognizedText\(recognizedText)\n recognizedExpiryText\(recognizedExpiryText)")
        
        
        
        if let recognizedName = UserDefaults.standard.string(forKey: "recognizedName"),
           let recognizedDOB = UserDefaults.standard.string(forKey: "recognizedDOB"),let recognizedText = UserDefaults.standard.string(forKey: "recognizedQidText"), let recognizedExpiryText = UserDefaults.standard.string(forKey: "recognizedExpiryText") {
//             nationality check removed since its not working every where
//            let recognizedNationality = UserDefaults.standard.string(forKey: "recognizedNationality"),
            print("recognizedText",recognizedText)
            print(nationalityBtn.isHidden)
           // alertMessage(title: recognizedName, msg: self.dobTextField.text!, action: NSLocalizedString("ok", comment: ""))
            
            self.fullNameEnTextField.text = recognizedName
            self.dobTextField.text = recognizedDOB
            DispatchQueue.main.async {
                   self.nationalityBtn.setTitle(recognizedNationality, for: .normal)
                self.nationalityBtn.setTitleColor(.black, for: .normal)
                
               }
            UserDefaults.standard.removeObject(forKey: "nationalitynamestr")
            UserDefaults.standard.setValue(recognizedNationality, forKey: "nationalitynamestr")
            self.idNumTextField.text = recognizedText
            self.idExpDateTextField.text = recognizedExpiryText
        }
       
           // Protect ScreenShot
//                  ScreenShield.shared.protect(view: self.fullNameEnTextField)
//        ScreenShield.shared.protect(view: personal_infoLbl)
                  
                  // Protect Screen-Recording
                  ScreenShield.shared.protectFromScreenRecording()
          
       }

    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           
          
       }
    
    
    @objc func Backbtnaction()
    {
        
        
        print("backbtnpressed---","55554")
        
        //new hide
        
        self.zoneSearchView.isHidden = true
        self.tab2View.isHidden = false
        
        nationalitySearchView.isHidden = true
        tab2View.isHidden = false
        
        //muns,occu,actualoccu
        municipalitySearchView.isHidden = true
        tab2View.isHidden = false
        
        //gender
        genderView.isHidden = true
        tab2View.isHidden = false
        
        if #available(iOS 13.0, *) {
            self.genderBtn.setTitleColor(.systemGray2, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        self.genderBtn.setTitle(NSLocalizedString("gender", comment: ""), for: .normal)

        
//      if  backbtnstatusstrr == "idpage"
//        {
//          tab1View.isHidden = false
//          tab2View.isHidden = true
//          tab3View.isHidden = true
//
//
//
//          //backbtnstatusdismissstrr = "close"
//
////          identificationBtn .setBackgroundImage(image, for: .normal)
////          profileBtn .setBackgroundImage(nil, for: .normal)
////          securityBtn .setBackgroundImage(nil, for: .normal)
////          profileBtn.backgroundColor = .none
////          identificationBtn.backgroundColor = .none
//
//
//      }
       if backbtnstatusstrr == "profilepage"
        {
          tab1View.isHidden = false
          tab2View.isHidden = true
          tab3View.isHidden = true
           backbtnstatusstrr = "close"
          // backbtnstatusstrr = "idpage"
           
           let bottomOffset = CGPoint(x: 0, y: 20)
           //OR
           //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
           scrollView.setContentOffset(bottomOffset, animated: true)

           
           return
       }
        
       if backbtnstatusstrr == "securitypage"
       {
          tab1View.isHidden = true
          tab2View.isHidden = false
          tab3View.isHidden = true
        backbtnstatusstrr = "profilepage"
           
       }
        if  backbtnstatusstrr == "close"
        {
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
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
//            //        self.navigationController?.pushViewController(nextViewController, animated: true)
//                    self.navigationController?.pushViewController(nextViewController, animated: true)
   
        }
       if backbtnstatusstrr == ""
        {
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
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
//            //        self.navigationController?.pushViewController(nextViewController, animated: true)
//                    self.navigationController?.pushViewController(nextViewController, animated: true)

    
        }
    }
    
    
    
    
    
    @objc private dynamic func didRecognizeTapGesture(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        
        
        occupationselstr = "occubtnselstr"
        munsibtnnselstr = ""
        actualoccupationselstr = ""
        print("benfi---","55554")
       //do
     tab2View.isHidden = true
        municipalitySearchView.isHidden = false
        scrollView.setContentOffset(.zero, animated: true)
        self.municipalitySearchTextField.text = ""
       // getMunicipality(searchText: "")
        self.getMunicipalityoccupation(searchText: "")
        self.municipalitySearchTextField.isHidden = false
        
        //self.getCountryoccupation(searchText: "")
        
        
        guard gesture.state == .ended, occupationTextField.frame.contains(point) else { return }

        //donomething()
        print("benfi---","55554")
    }
    
    
    
    
    @objc private dynamic func didRecognizeTapGestureone(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        
        
        occupationselstr = ""
        munsibtnnselstr = ""
        actualoccupationselstr = "actualoccupationselstr"
        print("benfi---","55554")
       //do
     tab2View.isHidden = true
        municipalitySearchView.isHidden = false
        scrollView.setContentOffset(.zero, animated: true)
        self.municipalitySearchTextField.text = ""
       // getMunicipality(searchText: "")
        self.getMunicipalityoccupation(searchText: "")
        self.municipalitySearchTextField.isHidden = false
        
        //self.getCountryoccupation(searchText: "")
        
        guard gesture.state == .ended, actualoccutextfd.frame.contains(point) else { return }

        //donomething()
        print("benfi---","55554")
    }
    
    
    
    
        @objc func textFieldDidChange(_ textField: UITextField) {
            if(textField == passwTextField)
            {
                if(passwTextField.text!.count > 0)
                {
                  let str = passwTextField.text!
                        if(str.count >= 8)
                        {
                            self.passCheck1 = true
                            radio1.setImage(UIImage(named: "radio_green"), for: .normal)
                        }
                        else{
                            self.passCheck1 = false
                            radio1.setImage(UIImage(named: "radio_light"), for: .normal)
                        }
                        if (str.contains("A") || str.contains("B") || str.contains("C") || str.contains("D") || str.contains("E") || str.contains("F") || str.contains("G") || str.contains("H") ||
                            str.contains("I") ||
                            str.contains("J") ||
                            str.contains("K") ||
                            str.contains("L") ||
                            str.contains("M") ||
                            str.contains("N") ||
                            str.contains("O") ||
                            str.contains("P") ||
                            str.contains("Q") ||
                            str.contains("R") ||
                            str.contains("S") ||
                            str.contains("T") ||
                            str.contains("U") ||
                            str.contains("V") ||
                            str.contains("W") ||
                            str.contains("X") ||
                            str.contains("Y") ||
                            str.contains("Z"))
                        {
                            self.passCheck2 = true
                            radio2.setImage(UIImage(named: "radio_green"), for: .normal)
                        }
                        else{
                            self.passCheck2 = false
                            radio2.setImage(UIImage(named: "radio_light"), for: .normal)
                        }
                        if (str.contains("a") || str.contains("b") || str.contains("c") || str.contains("d") || str.contains("e") || str.contains("f") || str.contains("g") || str.contains("h") ||
                            str.contains("i") ||
                            str.contains("j") ||
                            str.contains("k") ||
                            str.contains("l") ||
                            str.contains("m") ||
                            str.contains("n") ||
                            str.contains("o") ||
                            str.contains("p") ||
                            str.contains("q") ||
                            str.contains("r") ||
                            str.contains("s") ||
                            str.contains("t") ||
                            str.contains("u") ||
                            str.contains("v") ||
                            str.contains("w") ||
                            str.contains("x") ||
                            str.contains("y") ||
                            str.contains("z"))
                        {
                            self.passCheck3 = true
                            radio3.setImage(UIImage(named: "radio_green"), for: .normal)
                        }
                        else{
                            self.passCheck3 = false
                            radio3.setImage(UIImage(named: "radio_light"), for: .normal)
                        }
                        
                        if (str.contains("1") || str.contains("2") || str.contains("3") || str.contains("4") || str.contains("5") || str.contains("6") || str.contains("7") || str.contains("8") ||
                            str.contains("9") ||
                            str.contains("0"))
                        {
                            self.passCheck4 = true
                            radio4.setImage(UIImage(named: "radio_green"), for: .normal)
                        }
                        else{
                            self.passCheck4 = false
                            radio4.setImage(UIImage(named: "radio_light"), for: .normal)
                        }
                        
                    }
                    else{
                        radio1.setImage(UIImage(named: "radio_light"), for: .normal)
                        radio2.setImage(UIImage(named: "radio_light"), for: .normal)
                        radio3.setImage(UIImage(named: "radio_light"), for: .normal)
                        radio4.setImage(UIImage(named: "radio_light"), for: .normal)
                    }
                //new
                
                var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
                var string2addressspecial = passwTextField.text!

                    if let strvalue = string2addressspecial.rangeOfCharacter(from: charSetaddressspecial)
                    {
                        print("true")
                        radio5specialcharbtn.setImage(UIImage(named: "radio_green"), for: .normal)
                        
        //                let alert = UIAlertController(title: "Alert", message: "Please enter valid working address", preferredStyle: UIAlertController.Style.alert)
        //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        //                self.present(alert, animated: true, completion: nil)
//                        print("check name",self.workAddressTextField.text)
//
//                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                        return
                                   
                    }
                else
                {
                    radio5specialcharbtn.setImage(UIImage(named: "radio_light"), for: .normal)
                }
            }
            else if(textField == nationalityTextField)
            {
                
                if(nationalityTextField.text?.count == 0)
                {
                    view.endEditing(true)
                   // self.countrySearchFlag = 0
                    self.countryResArray.removeAll()
                    self.nationalityArray.removeAll()

                    self.natselserchstr = ""
                    self.getCountry(searchText: "")
                    
                }
                //newserch
                else
                {
                if(self.nationalityTextField.text?.count != 0)
                {
                    
                    self.natselserchstr = "searchcliked"
                    self.searchedArraynat.removeAll()
                    //self.searchedArraynatflag.removeAll()
                    
                    let fruitsArrayi = ["Orange","Litchi","PineApple","mango"]
                   // AllArray  = ["Orange","Litchi","PineApple","mango"]
                   // AllArrayid  = ["11","12","13","14"]
                    
                    let fruitsArrayiids = ["1","2","3","4"]
    //                    fruitsArray.append("Orange")
    //                    fruitsArray.append("Litchi")
    //                    fruitsArray.append("PineApple")
                    
                    
                    
                    
                    
                    
                     print("stringyyy---","sytringyuu")
    //        for str in checkarrayaoccunat {
    //        let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
    //        if range != nil {
    //        self.searchedArraynat.append(str)
    //        }
    //
    //
    //
    //    }
              
                    let searchTextnat  = textField.text!
                    if !searchTextnat.isEmpty {
                        //searching = true
                        searchedArraynat.removeAll()
                        for itemnat in checkarrayaoccunat {
                            if itemnat.lowercased().hasPrefix(searchTextnat.lowercased()) {
                                searchedArraynat.append(itemnat)
                            }
                        }
                        
                        
                       //new
                        
                    }

                    //newflagcode
//                    let searchTextnatflag  = textField.text!
//                    if !searchTextnatflag.isEmpty {
//                        //searching = true
//                        searchedArraynatflag.removeAll()
//                        for itemnat in checkarrayaoccunatflagcode {
//                            if itemnat.lowercased().hasPrefix(searchTextnatflag.lowercased()) {
//                                searchedArraynatflag.append(itemnat)
//                            }
//                        }
//
//
//                       //new
//
//                    }
                    
                
                    self.teststrclsnatflagstr = textField.text!
                    
                    
          print("serchedarrrr---",self.searchedArraynat)
        print("serchedarrrrflagcode---",self.searchedArraynatflag)
                    
                
                    
                    
                  self.tblNationality.reloadData()
                    
                }
            }

//                if(nationalityTextField.text?.count == 0)
//                {
//                    view.endEditing(true)
//                    getCountry(searchText: "")
//
//                }
            }
            else if(textField ==  municipalitySearchTextField)
            {
                if(municipalitySearchTextField.text?.count == 0)
                {
                    //getMunicipality(searchText: "")
                   // getMunicipality(searchText: "")
                    view.endEditing(true)
                self.occupationselsearchstr = ""
                self.municipalityArray.removeAll()
                self.getMunicipalityoccupation(searchText: "")

                }
                else
                {
              
                   //else
                    if(municipalitySearchTextField.text!.count > 0)
                    {
                        if munsibtnnselstr == "munsibtnnselstr"
                        {
                           //getMunicipality(searchText: "")
                            //self.getMunicipality(searchText: "")
                           // self.getMunicipality(searchText: self.municipalitySearchTextField.text!)
                          //  municipalitySearchView.isHidden = true
                           // tab2View.isHidden = false

                        }
                        else
                        {
                            
                            self.occupationselsearchstr = "searchcliked"
                            self.searchedArray.removeAll()
                            let fruitsArrayi = ["Orange","Litchi","PineApple","mango"]
                            AllArray  = ["Orange","Litchi","PineApple","mango"]
                            AllArrayid  = ["11","12","13","14"]
                            
                            let fruitsArrayiids = ["1","2","3","4"]
        //                    fruitsArray.append("Orange")
        //                    fruitsArray.append("Litchi")
        //                    fruitsArray.append("PineApple")
                            
                            
                            
                            
                            
                            
                             print("stringyyy---","sytringyuu")
//                    for str in checkarrayaoccu {
//                    let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
//                    if range != nil {
//                    self.searchedArray.append(str)
//                    }
//
//
//
//                }
                            //
                            let searchText  = textField.text!
                            if !searchText.isEmpty {
                                //searching = true
                                searchedArray.removeAll()
                                for item in checkarrayaoccu {
                                    if item.lowercased().hasPrefix(searchText.lowercased()) {
                                        searchedArray.append(item)
                                    }
                                }
                            }

                            
                
                            

//                let searchText  = textField.text!
//                if !searchText.isEmpty {
//                //searching = true
//                    searchedArray.removeAll()
//                for item in checkarrayaoccu {
//                 let range = item.lowercased().hasPrefix(searchText.lowercased())
//                    searchedArray.append(item)
//
//                            }
//                        }
                            //
                            
                  print("serchedarrrr---",self.searchedArray)
                          self.tblMunicipality.reloadData()
                            
                        }
                        
                       
                    }
                
            }
                

                ///
            }
            else if(textField == zoneSearchTextField)
            {
                
                
                if(zoneSearchTextField.text?.count == 0)
                    {
                    self.zoneselserchstr = ""
                    self.zoneArray.removeAll()
                    getZone(id: self.municipality_id, searchText: "")
                    
                    }

                
                //newserch
                else
                {
                if(self.zoneSearchTextField.text?.count != 0)
                {
                    
                    self.zoneselserchstr = "searchcliked"
                    self.searchedArrayzone.removeAll()
                    let fruitsArrayi = ["Orange","Litchi","PineApple","mango"]
                   // AllArray  = ["Orange","Litchi","PineApple","mango"]
                   // AllArrayid  = ["11","12","13","14"]
                    
                    let fruitsArrayiids = ["1","2","3","4"]
    //                    fruitsArray.append("Orange")
    //                    fruitsArray.append("Litchi")
    //                    fruitsArray.append("PineApple")
                    
                    
                    
                    
                    
                    
                     print("stringyyy---","sytringyuu")
    //        for str in checkarrayaoccunat {
    //        let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
    //        if range != nil {
    //        self.searchedArraynat.append(str)
    //        }
    //
    //
    //
    //    }
              
                    let searchTextnat  = textField.text!
                    if !searchTextnat.isEmpty {
                        //searching = true
                        searchedArrayzone.removeAll()
                        for itemnat in checkarrayaoccuzone {
                            if itemnat.lowercased().hasPrefix(searchTextnat.lowercased()) {
                                searchedArrayzone.append(itemnat)
                            }
                        }
                    }

                    
                    
          print("serchedarrrr---",self.searchedArrayzone)
                  self.tblZone.reloadData()
                    
                }
            }

//                if(zoneSearchTextField.text?.count == 0)
//                {
//                    getZone(id: self.municipality_id, searchText: "")
//                }
            }
        }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == nationalityTextField)
        {
//            if(nationalityTextField.text?.count != 0)
//            {
//                self.getCountry(searchText: self.nationalityTextField.text!)
//            }
        }
        else if(textField == municipalitySearchTextField)
        {
//            if(municipalitySearchTextField.text?.count != 0)
//            {
//                if munsibtnnselstr == "munsibtnnselstr"
//                {
//                   // self.getMunicipality(searchText: self.municipalitySearchTextField.text!)
//                  //  municipalitySearchView.isHidden = true
//                   // tab2View.isHidden = false
//
//                }
//                else
//                {
//
//                    self.occupationselsearchstr = "searchcliked"
//                    self.searchedArray.removeAll()
//                    let fruitsArrayi = ["Orange","Litchi","PineApple","mango"]
//                    AllArray  = ["Orange","Litchi","PineApple","mango"]
//                    AllArrayid  = ["11","12","13","14"]
//
//                    let fruitsArrayiids = ["1","2","3","4"]
////                    fruitsArray.append("Orange")
////                    fruitsArray.append("Litchi")
////                    fruitsArray.append("PineApple")
//
//
//
//
//
//
//                     print("stringyyy---","sytringyuu")
//            for str in checkarrayaoccu {
//            let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
//            if range != nil {
//            self.searchedArray.append(str)
//            }
//
//
//
//        }
//          print("serchedarrrr---",self.searchedArray)
//                  self.tblMunicipality.reloadData()
//
//                }
//
//
//            }
        }
        
        else if(textField == zoneSearchTextField)
        {
//            if(zoneSearchTextField.text?.count != 0)
//            {
//                self.getZone(id: self.municipality_id, searchText: self.zoneSearchTextField.text!)
//            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    @IBAction func identificationBtn(_ sender: Any) {
        
        //new hide
        
        self.zoneSearchView.isHidden = true
        self.tab2View.isHidden = false
        
        nationalitySearchView.isHidden = true
        tab2View.isHidden = false
        
        //muns,occu,actualoccu
        municipalitySearchView.isHidden = true
        tab2View.isHidden = false
        
        //gender
        genderView.isHidden = true
        tab2View.isHidden = false
        
        if #available(iOS 13.0, *) {
            self.genderBtn.setTitleColor(.systemGray2, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        self.genderBtn.setTitle(NSLocalizedString("gender", comment: ""), for: .normal)

        
        setTab(tabNo: 1)
        scrollView.setContentOffset(.zero, animated: true)
    }
    @IBAction func profileBtn(_ sender: Any) {
        
        //new hide
        
        self.zoneSearchView.isHidden = true
        self.tab2View.isHidden = false
        
        nationalitySearchView.isHidden = true
        tab2View.isHidden = false
        
        //muns,occu,actualoccu
        municipalitySearchView.isHidden = true
        tab2View.isHidden = false
        
        //gender
        genderView.isHidden = true
        tab2View.isHidden = false
        
        if #available(iOS 13.0, *) {
            self.genderBtn.setTitleColor(.systemGray2, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        self.genderBtn.setTitle(NSLocalizedString("gender", comment: ""), for: .normal)

        setTab(tabNo: 2)
        scrollView.setContentOffset(.zero, animated: true)
    }
    @IBAction func securityBtn(_ sender: Any) {
        
        //new hide
        
        self.zoneSearchView.isHidden = true
        self.tab2View.isHidden = false
        
        nationalitySearchView.isHidden = true
        tab2View.isHidden = false
        
        //muns,occu,actualoccu
        municipalitySearchView.isHidden = true
        tab2View.isHidden = false
        
        //gender
        genderView.isHidden = true
        tab2View.isHidden = false
        
        if #available(iOS 13.0, *) {
            self.genderBtn.setTitleColor(.systemGray2, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        self.genderBtn.setTitle(NSLocalizedString("gender", comment: ""), for: .normal)

        
        setTab(tabNo: 3)
        scrollView.setContentOffset(.zero, animated: true)
    }
    @IBAction func idTypeBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            if self.tblIdType.isHidden{
                self.animateIdType(toogle: true)
            }
            else{
                self.animateIdType(toogle: false)
            }
        }
    }
    @IBAction func idIssuerBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            if self.tblIdIssuer.isHidden{
                self.animateIdIssuer(toogle: true)
            }
            else{
                self.animateIdIssuer(toogle: false)
            }
        }
    }
    @IBAction func nextBtn(_ sender: Any) {
        setTab(tabNo: 2)
       // scrollView.setContentOffset(.zero, animated: true)
    }
    @IBAction func cancelBtn(_ sender: Any) {
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
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
//        //        self.navigationController?.pushViewController(nextViewController, animated: true)
//                self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func next1Btn(_ sender: Any) {
        setTab(tabNo: 3)
       // scrollView.setContentOffset(.zero, animated: true)
    }
    @IBAction func nationalityBtn(_ sender: Any) {
        self.checkCountry = 0
        checkNationality = 0
        self.tblNationality.reloadData()
        tab2View.isHidden = true
        nationalitySearchView.isHidden = false
        self.nationalityTextField.text = ""
        scrollView.setContentOffset(.zero, animated: true)
        self.getCountry(searchText: "")
    }
    @IBAction func dualNationalityBtn(_ sender: Any) {
        self.checkCountry = 0
        checkNationality = 1
        self.tblNationality.reloadData()
        tab2View.isHidden = true
        nationalitySearchView.isHidden = false
        self.nationalityTextField.text = ""
        scrollView.setContentOffset(.zero, animated: true)
        self.getCountry(searchText: "")
    }
    @IBAction func countryResiBtn(_ sender: Any) {
        self.checkCountry = 1
        self.tblNationality.reloadData()
        self.nationalityTextField.text = ""
        tab2View.isHidden = true
        nationalitySearchView.isHidden = false
        scrollView.setContentOffset(.zero, animated: true)
        getCountry(searchText: "")
    }
    @IBAction func municipalityBtn(_ sender: Any) {
        tab2View.isHidden = true
        municipalitySearchView.isHidden = false
        scrollView.setContentOffset(.zero, animated: true)
        self.municipalitySearchTextField.text = ""
        getMunicipality(searchText: "")
        
        self.occupationselstr = ""
        self.munsibtnnselstr = "munsibtnnselstr"
        self.actualoccupationselstr = ""
        
        
             self.municipalitySearchTextField.isHidden = false
        
    }
    @IBAction func zoneBtn(_ sender: Any) {
//        if(municipalityBtn.titleLabel?.text == "Municipality" || municipality_id == "")
//        {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_municipality", comment: ""), action: NSLocalizedString("ok", comment: ""))
//        }
       // else{
            tab2View.isHidden = true
            zoneSearchView.isHidden = false
            scrollView.setContentOffset(.zero, animated: true)
            self.zoneSearchTextField.text = ""
            getZone(id: self.municipality_id, searchText: "")
       // }
        
    }
    @IBAction func maleCheckBtn(_ sender: Any) {
        self.checkGender = 1
        maleCheckBtn.setImage(UIImage(named: "radio_green"), for: .normal)
        femaleCheckBtn.setImage(UIImage(named: "radio_light"), for: .normal)
    }
    @IBAction func femaleCheckBtn(_ sender: Any) {
        self.checkGender = 2
        femaleCheckBtn.setImage(UIImage(named: "radio_green"), for: .normal)
        maleCheckBtn.setImage(UIImage(named: "radio_light"), for: .normal)
    }
    @IBAction func okBtn(_ sender: Any) {
        if(checkGender == 0)
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else if(checkGender == 1)
        {
            //hided
                     let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                     var image = UIImage(named: "box")
                     let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                     if appLang == "ar" || appLang == "ur"
            {
            genderView.isHidden = true
            tab2View.isHidden = false
            self.genderBtn.setTitle("Male", for: .normal)
            self.genderBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            }
            else
            {
                genderView.isHidden = true
                tab2View.isHidden = false
                self.genderBtn.setTitle("Male", for: .normal)
            }
            
            let bottomOffset = CGPoint(x: 0, y: 420)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)

     
        }
        else
        {
            
            //hided
                     let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                     var image = UIImage(named: "box")
                     let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                     if appLang == "ar" || appLang == "ur"
            {
                genderView.isHidden = true
                tab2View.isHidden = false
                self.genderBtn.setTitle("Female", for: .normal)
                self.genderBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            }
            else
            {
                genderView.isHidden = true
                tab2View.isHidden = false
                self.genderBtn.setTitle("Female", for: .normal)
            }
                    
            let bottomOffset = CGPoint(x: 0, y: 420)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)

            
        }
    }
    @IBAction func genderBtn(_ sender: Any) {
        genderView.isHidden = false
        tab2View.isHidden = true
        self.genderBtn.setTitleColor(.black, for: .normal)
    }
    @IBAction func secQuesBtn(_ sender: Any) {
        tab3View.isHidden = true
        secQuesView.isHidden = false
        scrollView.setContentOffset(.zero, animated: true)
        
        backbtnstatusstrr = "securitypage"
    }
    @IBAction func passwEyeBtn(_ sender: Any) {
        if(passwEyeClick == true) {
            passwTextField.isSecureTextEntry = false
            passwEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            passwTextField.isSecureTextEntry = true
            passwEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        passwEyeClick = !passwEyeClick
    }
    @IBAction func retypePasswEyeBtn(_ sender: Any) {
        if(retypePasswEyeClick == true) {
            retypePasswTextField.isSecureTextEntry = false
            retypePasswEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            retypePasswTextField.isSecureTextEntry = true
            retypePasswEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        retypePasswEyeClick = !retypePasswEyeClick
    }
    @IBAction func pinEyeBtn(_ sender: Any) {
        if(pinEyeClick == true) {
            pinTextField.isSecureTextEntry = false
            pinEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            pinTextField.isSecureTextEntry = true
            pinEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        pinEyeClick = !pinEyeClick
    }
    @IBAction func createProfile(_ sender: Any) {
        
//        if(secQuesBtn.titleLabel?.text == NSLocalizedString("security_question", comment: ""))
//        {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_sec_que", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }
//       // print("str_occupationn",str_occupation)
//
//        var stranswer = answerTextField.text
//        stranswer = stranswer!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        print(stranswer)
//        // "this is the answer"
//        print("stranswer",stranswer)
//        answerTextField.text =  stranswer
//        print("answerTextField.text",answerTextField.text)
//
//
//        //extraspace remove
//        let startingStringanswer = answerTextField.text!
//        let processedStringanswer = startingStringanswer.removeExtraSpacesregister()
//        print("processedStringanswer:\(processedStringanswer)")
//        answerTextField.text = processedStringanswer
//
//        guard let answer = answerTextField.text,answerTextField.text?.count != 0 else
//        {
//            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_answer", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }
//        //"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
//        var charSetanswer = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
//               var string2answer = answer
//
//               if let strvalue = string2answer.rangeOfCharacter(from: charSetanswer)
//               {
//                   print("true")
//                   let alert = UIAlertController(title: "Alert", message: "Please enter valid answer", preferredStyle: UIAlertController.Style.alert)
//                   alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                   self.present(alert, animated: true, completion: nil)
//                  // print("check name",self.fullNameEnTextField.text)
//
//               }
        
        
        //
        print("dobbbtestfinal:", self.str_dob)
        
        //new
        if passwTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
        }
        else
        {
        
        self.passwTextField.layer.borderWidth = 0.8
        self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        }

        
        guard let passw = passwTextField.text,passwTextField.text?.count != 0 else
        {
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.view.makeToast(NSLocalizedString("enter_password", comment: ""), duration: 3.0, position: .center)

            return
        }
        if(passCheck1)
        {
            
            self.passwTextField.layer.borderWidth = 0.8
            self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

        }
        else{
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_length", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            self.view.makeToast(NSLocalizedString("pass_length", comment: ""), duration: 3.0, position: .center)
            return
        }
        if(passCheck2)
        {
            
            self.passwTextField.layer.borderWidth = 0.8
            self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

        }
        else{
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must1", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            self.view.makeToast(NSLocalizedString("pass_must1", comment: ""), duration: 3.0, position: .center)

            return
        }
        if(passCheck3)
        {
            
            self.passwTextField.layer.borderWidth = 0.8
            self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

        }
        else{
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must2", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            self.view.makeToast(NSLocalizedString("pass_must2", comment: ""), duration: 3.0, position: .center)

            return
        }
        if(passCheck4)
        {
            
            self.passwTextField.layer.borderWidth = 0.8
            self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

        }
        else{
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must3", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            self.view.makeToast(NSLocalizedString("pass_must3", comment: ""), duration: 3.0, position: .center)

            return
        }
        
        //new
        
        var charSetaddressspecial = CharacterSet.init(charactersIn: "@#$%+_&'()*,./:;<=>?[]^`{|}~)(")
        var string2addressspecial = passwTextField.text!

            if let strvalue = string2addressspecial.rangeOfCharacter(from: charSetaddressspecial)
            {
                print("true")
//                //radio5specialcharbtn.setImage(UIImage(named: "radio_green"), for: .normal)
//
//                let alert = UIAlertController(title: "Alert", message: "Please enter one special charecter", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                        //print("check name",self.workAddressTextField.text)
////
////                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                        return
                self.passwTextField.layer.borderWidth = 0.8
                self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                           
            }
        else
        {
            //radio5specialcharbtn.setImage(UIImage(named: "radio_light"), for: .normal)
            //let alert = UIAlertController(title: "Alert", message: "Please enter one special charecter", preferredStyle: UIAlertController.Style.alert)
           // alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //self.present(alert, animated: true, completion: nil)
                    print("check name",self.workAddressTextField.text)
            self.passwTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.passwTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            self.view.makeToast("Password must contain atleast one special character", duration: 3.0, position: .center)
//
//                        alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
        }

        
        //new
        if retypePasswTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.retypePasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.retypePasswTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
        }
        else
        {
        
        self.retypePasswTextField.layer.borderWidth = 0.8
        self.retypePasswTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        }

        
        guard let retypwPassw = retypePasswTextField.text,retypePasswTextField.text?.count != 0 else
        {
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("re_type_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.view.makeToast(NSLocalizedString("re_type_password", comment: ""), duration: 3.0, position: .center)

            return
        }
        if(!passw.elementsEqual(retypwPassw))
        {
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("password_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            self.retypePasswTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.retypePasswTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            self.view.makeToast(NSLocalizedString("password_mismatch", comment: ""), duration: 3.0, position: .center)
            return
        }
        else
        {
            self.retypePasswTextField.layer.borderWidth = 0.8
            self.retypePasswTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

        }
        
        //new
        if pinTextField.text?.isEmpty == true
        {
           // timer.invalidate()
            self.pinTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.pinTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
        }
        else
        {
        
        self.pinTextField.layer.borderWidth = 0.8
        self.pinTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        }

        
        guard let pin = pinTextField.text,pinTextField.text?.count != 0 else
        {
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            
            self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)

            return
        }
        if(pin.count != 4)
        {
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.pinTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.pinTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            self.view.makeToast(NSLocalizedString("pin_must", comment: ""), duration: 3.0, position: .center)

            return
        }
        else
        {
            self.pinTextField.layer.borderWidth = 0.8
            self.pinTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        }
        ///
        
        var charSetpin = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2 = pin

        if let strvalue = string2.rangeOfCharacter(from: charSetpin)
        {
            print("true")


           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)

            return
        }
        if (!validate (value: self.pinTextField.text!))
        {
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.pinTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.pinTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            self.view.makeToast(NSLocalizedString("enter_pin", comment: ""), duration: 3.0, position: .center)

            return
            
        }
        else
        {
            self.pinTextField.layer.borderWidth = 0.8
            self.pinTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        }
        
        
        
        if(!termsClick)
        {
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("read_terms", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            
            self.view.makeToast(NSLocalizedString("read_terms", comment: ""), duration: 3.0, position: .center)
            return
        }
        //self.str_q1 = secQuesBtn.titleLabel?.text as! String
        //self.str_a1 = answerTextField.text!
        self.str_passw = passwTextField.text!
        self.str_mpin = pinTextField.text!
        self.str_reg_no = registrationCodeTextField.text!
        
        self.str_buildingno = buildingnotextfd.text!
        
        
        defaults.set(str_idType, forKey: "id_type")
        defaults.set(str_id_issuer, forKey: "id_issuer")
        defaults.set(str_id_no, forKey: "id_no")
        defaults.set(str_id_exp_date, forKey: "id_exp_date")
        defaults.set(str_name_en, forKey: "name_en")
        defaults.set(str_name_ar, forKey: "name_ar")
        defaults.set(strEmail, forKey: "email")
        defaults.set(str_dob, forKey: "dob")
        defaults.set(str_nationality, forKey: "nationality")
        if let buttonText = nationalityBtn.title(for: .normal) {
                     defaults.set(buttonText, forKey: "nationalityname")
                  print("buttonTextE",buttonText)
                 }
        if let buttonText = dualNationalityBtn.title(for: .normal) {
                      defaults.set(buttonText, forKey: "dualnationalityname")
                   print("buttonTextE",buttonText)
                  }
        defaults.set(str_dualNationality, forKey: "dualNationality")
        defaults.set(str_dualNationality, forKey: "nationalitynamestr1")
        defaults.set(str_country, forKey: "country")
        defaults.set(str_city, forKey: "municipality")
        defaults.set(str_zone, forKey: "zone")
        defaults.set(str_address, forKey: "home_addr")
        defaults.set(str_gender, forKey: "gender")
        defaults.set(strMobile, forKey: "mobile")
        defaults.set(str_employer, forKey: "employer")
        defaults.set(str_income, forKey: "income")
        defaults.set(str_working_address, forKey: "work_addr")
        defaults.set(str_occupation, forKey: "occupation")
        defaults.set(str_actualoccupation, forKey: "str_actualoccupation")
        defaults.set(str_buildingno, forKey: "str_buildingno")
        
        defaults.set(str_reg_no, forKey: "reg_code")
       // defaults.set(str_q1, forKey: "q1")
        //defaults.set(str_a1, forKey: "a1")
        defaults.set(str_passw, forKey: "passw")
        defaults.set(str_mpin, forKey: "pin")
        
       // print("str_occupationnmmmmm",str_occupation)
        
        
        //newwww
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViedionewViewController") as! ViedionewViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
//        //old orginal
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "photo1") as! Photo1ViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)

//
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "reg1") as! RegisterPage1ViewController
//               self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
        //new viewdetails simulater
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let vc: REGReviewViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "REGReviewViewController") as! REGReviewViewController
//        self.navigationController?.pushViewController(vc, animated: true)

        
        self.automaticallyAdjustsScrollViewInsets = false;
        scrollView.contentInset = UIEdgeInsets.zero;
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero;
        scrollView.contentOffset = CGPoint(x: 0,y :0);
    }
    @IBAction func termsBtn(_ sender: Any) {
        termsView.isHidden = false
        tab3View.isHidden = true
        scrollView.setContentOffset(.zero, animated: true)
    }
    @IBAction func acceptBtn(_ sender: Any) {
        termsClick = true
        termsView.isHidden = true
        tab3View.isHidden = false
        checkBtn.setImage(UIImage(named: "radio_green"), for: .normal)
        termsClick = true
    }
    @IBAction func checkBtn(_ sender: Any) {
        if(!termsClick)
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("read_terms", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else{
            termsClick = false
            checkBtn.setImage(UIImage(named: "radio_light"), for: .normal)
        }
    }
    
    func functionOne () {
       print("hello")
    }
    
    func setTab(tabNo:Int) {
        var image = UIImage(named: "box")
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            image = UIImage(named: "boxArabic")
        }
        if(tabNo == 1)
        {
            tab1View.isHidden = false
            tab2View.isHidden = true
            tab3View.isHidden = true
            identificationBtn .setBackgroundImage(image, for: .normal)
            profileBtn .setBackgroundImage(nil, for: .normal)
            securityBtn .setBackgroundImage(nil, for: .normal)
            profileBtn.backgroundColor = .none
            identificationBtn.backgroundColor = .none
        }
        else if(tabNo == 2)
        {
//            if(idTypeBtn.titleLabel?.text == NSLocalizedString("id_type", comment: ""))
//            {
//                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_id_type", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            }
            if(idIssuerBtn.titleLabel?.text == NSLocalizedString("id_issuer", comment: ""))
            {
                //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_id_issuer", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("sel_id_issuer", comment: ""), duration: 3.0, position: .center)

            }
            else
            {
                
                //new
                if idNumTextField.text?.isEmpty == true
                {
                   // timer.invalidate()
                    self.idNumTextField.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        self.idNumTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                    }
                }
                else
                {
                
                self.idNumTextField.layer.borderWidth = 0.8
                self.idNumTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
                
                
                
                guard let idNum = idNumTextField.text,idNumTextField.text?.count != 0 else
                {
                    self.view.makeToast(NSLocalizedString("enter_id_number", comment: ""), duration: 3.0, position: .center)
                    
                    
                        
                        
                        
                    
                    
                    
                  //  alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                let count = idNumTextField.text?.count
                if(count != 11)
                {
                    
                    self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
                    
                    self.idNumTextField.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        self.idNumTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                    }

                    
                    
                   //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                else
                {
                    self.idNumTextField.layer.borderWidth = 0.8
                    self.idNumTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
                
                var charSetidNum = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                var string2 = idNum

                if let strvalue = string2.rangeOfCharacter(from: charSetidNum)
                {
                    print("true")
 
                    self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
      
                   // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                if (!validate (value: self.idNumTextField.text!))
                {
                    
                    self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
                    
                   // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                    
                }
                
                
                
                guard let idExp = idExpDateTextField.text,idExpDateTextField.text?.count != 0 else
                {
                    
                    
                    //new
                    if idExpDateTextField.text?.isEmpty == true
                    {
                       // timer.invalidate()
                        self.idExpDateTextField.layer.borderColor = UIColor.red.cgColor
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                            self.idExpDateTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                        }
                    }
                    else
                    {
                    
                    self.idExpDateTextField.layer.borderWidth = 0.8
                    self.idExpDateTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                        
                        
                    
                        
                        
                    }
                    
                    self.view.makeToast(NSLocalizedString("enter_id_exp_date", comment: ""), duration: 3.0, position: .center)
                    
                   // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_exp_date", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                
                
                if idExpDateTextField.text?.isEmpty == true
                {
                    
                }
                else
                {
                    
                    //newwocr
                    
                    // Hardcoded expiry date (for example)
                    let currentDate = Date()
                    let expiryDateString = idExpDateTextField.text // Format: "yyyy-MM-dd"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    let expiryDate = dateFormatter.date(from: expiryDateString!)!

                    // Compare dates
                    let calendar = Calendar.current
                    let comparison = calendar.compare(currentDate, to: expiryDate, toGranularity: .day)

                    // Check expiry status
                    if comparison == .orderedDescending {
                        self.view.makeToast(NSLocalizedString("Enter valid expiry date", comment: ""), duration: 3.0, position: .center)
                        return
                        print("The expiry date has passed.old")
                    } else if comparison == .orderedAscending {
                        print("The product is still valid.")
                    } else {
                        print("Today is the expiry date.")
                    }
                    
                }
                
                
                
                
                self.str_id_no = idNum
                self.str_idType = idTypeBtn.titleLabel?.text as! String
                if(idIssuerBtn.titleLabel?.text == "Ministry of Interior")
                {
                    self.str_id_issuer = "QATAR MOI"
                }
                else
                {
                    self.str_id_issuer = "QATAR MOFA"
                }
                self.str_id_exp_date = idExp
                
                //newQID
               // getTokenGECOQID()
                
                self.getToken(num: 1)
                self.backbtnstatusstrr = "profilepage"
            }
        }
        else if(tabNo == 3)
        {
            print("check gender",checkGender)
            
            //new
 
            

            var str = fullNameEnTextField.text
                    str = str!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    print(str)
                    // "this is the answer"
                    print("strii",str)
                    fullNameEnTextField.text =  str
                    print("striifullnameEnTextField.text",fullNameEnTextField.text)
                    
            
            
            
            //extraspace remove
            let startingString = fullNameEnTextField.text!
            let processedString = startingString.removeExtraSpacesregister()
            print("processedString:\(processedString)")
            fullNameEnTextField.text = processedString
            
            
            //new
            
            //new
            if fullNameEnTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.fullNameEnTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.fullNameEnTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.fullNameEnTextField.layer.borderWidth = 0.8
            self.fullNameEnTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            
            guard let nameEn = fullNameEnTextField.text,fullNameEnTextField.text?.count != 0 else
            {
                let bottomOffset = CGPoint(x: 0, y: 0)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast(NSLocalizedString("enter_fullname_en", comment: ""), duration: 3.0, position: .center)
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_fullname_en", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
       // var charSet = CharacterSet.init(charactersIn: "@#$%+_)(")
        var charSet = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2 = nameEn

        if let strvalue = string2.rangeOfCharacter(from: charSet)
        {
            print("true")
//            let alert = UIAlertController(title: "Alert", message: "Please enter valid name", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            print("check name",self.fullNameEnTextField.text)
            
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            
            
            self.fullNameEnTextField.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.fullNameEnTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }


            
            self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
            



//
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
            else
            {
                self.fullNameEnTextField.layer.borderWidth = 0.8
                self.fullNameEnTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }
          
            
            if (!validate (value: self.fullNameEnTextField.text!))
            {
                self.fullNameEnTextField.layer.borderWidth = 0.8
                self.fullNameEnTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

                
            }
            else
            {
//              let alert = UIAlertController(title: "Alert", message: "Please enter valid name", preferredStyle: UIAlertController.Style.alert)
//              alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//              self.present(alert, animated: true, completion: nil)
//              print("check name",self.fullNameEnTextField.text)
                
              //  alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
                let bottomOffset = CGPoint(x: 0, y: 0)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                
                self.fullNameEnTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.fullNameEnTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }


                
                self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
                
                
                
                return
            }
            
            
            
            
            
            //newww
//            let string = fullNameEnTextField.text
//            let result = string!.components(separatedBy: " ")
//
//            
//            if result.count == 1
//            {
//                let bottomOffset = CGPoint(x: 0, y: 0)
//                //OR
//                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
//                self.scrollView.setContentOffset(bottomOffset, animated: true)
//
//                self.view.makeToast("Please enter full name", duration: 3.0, position: .top)
//
//                self.fullNameEnTextField.layer.borderColor = UIColor.red.cgColor
//                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
//                    self.fullNameEnTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
//                }
//                return
//
//            }
//            else
//            {
//                self.fullNameEnTextField.layer.borderWidth = 0.8
//                self.fullNameEnTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
//
//            }

            
            //fullname arabic
            
            var strfullnamear = fullNameArTextField.text
            strfullnamear = strfullnamear!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(strfullnamear)
            // "this is the answer"
            print("strefullnamear",strfullnamear)
            fullNameArTextField.text =  strfullnamear
            
            //extraspace remove
            let startingStringnamear = fullNameArTextField.text!
            let processedStringnamear = startingStringnamear.removeExtraSpacesregister()
            print("processedString:\(processedStringnamear)")
            fullNameArTextField.text = processedStringnamear
            
            
            var stremail = emailTextField.text
            stremail = stremail!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(stremail)
            // "this is the answer"
            print("striistremail",stremail)
            emailTextField.text =  stremail
            print("emailTextField.text",emailTextField.text)

            
            
            //new
            if emailTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.emailTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.emailTextField.layer.borderWidth = 0.8
            self.emailTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            
            guard let email = emailTextField.text,emailTextField.text?.count != 0 else
            {
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 0)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.view.makeToast(NSLocalizedString("enter_email", comment: ""), duration: 3.0, position: .center)
                
                return
            }

            let validateEmail = isValidEmail(email)
            if(!validateEmail)
            {
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_email", comment: ""), action: NSLocalizedString("ok", comment: ""))
                let bottomOffset = CGPoint(x: 0, y: 0)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.view.makeToast(NSLocalizedString("enter_valid_email", comment: ""), duration: 3.0, position: .center)
                
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.emailTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                
                return
            }
            else
            {
                self.emailTextField.layer.borderWidth = 0.8
                self.emailTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }
            
            //new
            if dobTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.dobTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.dobTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.dobTextField.layer.borderWidth = 0.8
            self.dobTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            
            guard let dob = dobTextField.text,dobTextField.text?.count != 0 else
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_dob", comment: ""), action: NSLocalizedString("ok", comment: ""))
                let bottomOffset = CGPoint(x: 0, y: 0)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.view.makeToast(NSLocalizedString("enter_dob", comment: ""), duration: 3.0, position: .center)
                
                return
            }
            //new
            if self.statusstrr == "ACTIVE"
            {
                
                if dobTextField.text?.count != 0
                {
                   // self.dobTextField.text = self.str_dob
                    
                    self.showdate1()
                    //self.dobTextField.text = self.str_dob
                        
                        if self.userAge ?? 0.0 < 18.0{
                            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("invalid_dob", comment: ""), action: NSLocalizedString("ok", comment: ""))
                             let bottomOffset = CGPoint(x: 0, y: 0)
                             //OR
                             //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                             self.scrollView.setContentOffset(bottomOffset, animated: true)

                             
                             self.view.makeToast(NSLocalizedString("invalid_dob", comment: ""), duration: 3.0, position: .center)
                             
                             self.dobTextField.layer.borderColor = UIColor.red.cgColor
                             Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                                 self.dobTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                             }

                             
                             return
                         }
                    else
                    {
                        self.dobTextField.layer.borderWidth = 0.8
                        self.dobTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                    }
                    print("dobbbtestqid:", self.str_dob)
                   
                    
                }else
                {
                    
                }
                      
            }

          
          else
            {
              self.showdate1()
              if self.userAge ?? 0.0 < 18.0{
                 // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("invalid_dob", comment: ""), action: NSLocalizedString("ok", comment: ""))
                  let bottomOffset = CGPoint(x: 0, y: 0)
                  //OR
                  //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                  self.scrollView.setContentOffset(bottomOffset, animated: true)

                  
                  self.view.makeToast(NSLocalizedString("invalid_dob", comment: ""), duration: 3.0, position: .center)
                  
                  self.dobTextField.layer.borderColor = UIColor.red.cgColor
                  Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                      self.dobTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                  }

                  
                  return
              }
              else
              {
                  self.dobTextField.layer.borderWidth = 0.8
                  self.dobTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

              }
              print("dobbbtestnormal:", self.str_dob)
              
            }
            
            
            
            if(nationalityBtn.titleLabel?.text == "Nationality")
            {
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 30)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.view.makeToast(NSLocalizedString("sel_nationality", comment: ""), duration: 3.0, position: .center)

                self.nationalityBtn.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.nationalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                return
            }
            
            else
            {
                self.nationalityBtn.layer.borderWidth = 0.8
                self.nationalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }
            
//            if(dualNationalityBtn.titleLabel?.text == "Dual Nationality")
//            {
//               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                
//                let bottomOffset = CGPoint(x: 0, y: 30)
//                //OR
//                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
//                self.scrollView.setContentOffset(bottomOffset, animated: true)
//
//                
//                self.view.makeToast(NSLocalizedString("seldualnationality", comment: ""), duration: 3.0, position: .center)
//
//                self.dualNationalityBtn.layer.borderColor = UIColor.red.cgColor
//                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
//                    self.dualNationalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
//                }
//
//                
//                return
//            }
//            
//            else
//            {
//                self.dualNationalityBtn.layer.borderWidth = 0.8
//                self.dualNationalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
//
//            }
            
            
//            if(countryResiBtn.titleLabel?.text == NSLocalizedString("country_of_residence", comment: ""))
//            {
//                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                return
//            }
            //new chnages
            
            
   
            
            
            if(municipalityBtn.titleLabel?.text == NSLocalizedString("municipality", comment: ""))
            {
//                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_municipality", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                return
                self.str_city = "-"
                print("strr_cityy",str_city)
            }
            
            if(zoneBtn.titleLabel?.text == "Zone")
            {
                let bottomOffset = CGPoint(x: 0, y: 30)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.str_zone = "-"
                print("strr_zonee",str_zone)
                //self.view.makeToast(NSLocalizedString("enter_zone", comment: ""), duration: 3.0, position: .center)
                self.view.makeToast("Please select zone", duration: 3.0, position: .center)
                
                self.zoneBtn.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.zoneBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_zone", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
                self.zoneBtn.layer.borderWidth = 0.8
                self.zoneBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }


            
            
            
            
            
            var strhomeadress = homeAddressTextField.text
            strhomeadress = strhomeadress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(strhomeadress)
            // "this is the answer"
            print("strhomeadress",strhomeadress)
            homeAddressTextField.text =  strhomeadress
            print("homeAddressTextField.text",homeAddressTextField.text)
            
            
            //extraspace remove
            let startingStringhomeadress = homeAddressTextField.text!
            let processedStringhomeaddress = startingStringhomeadress.removeExtraSpacesregister()
            print("processedStringhomeadress:\(processedStringhomeaddress)")
            homeAddressTextField.text = processedStringhomeaddress
            
            
            //new
            if homeAddressTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.homeAddressTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.homeAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.homeAddressTextField.layer.borderWidth = 0.8
            self.homeAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            
            
            
            if ((homeAddressTextField.text ?? "").isEmpty)
            {
                // is empty
                str_address = ""
                print("strhomeadressempty",str_address)
            }

            guard let homeAddr = homeAddressTextField.text,homeAddressTextField.text?.count != 0 else
            {
                let bottomOffset = CGPoint(x: 0, y: 350)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.view.makeToast("Please enter Street", duration: 3.0, position: .center)
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_address", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
//
            var charSethomeAddr = CharacterSet.init(charactersIn: "@#$%+_&'()*,-/:;<=>?[]^`{|}~)(")
            var string2homeAddr = homeAddressTextField.text!

            if let strvalue = string2homeAddr.rangeOfCharacter(from: charSethomeAddr)
            {
                print("true")
//                let alert = UIAlertController(title: "Alert", message: "Please enter valid home adress", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                print("check name",self.fullNameEnTextField.text)
//

               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid home adress", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 350)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                //self.view.makeToast(NSLocalizedString("Please enter valid home adress", comment: ""), duration: 3.0, position: .center)
                self.view.makeToast("Please enter valid Street", duration: 3.0, position: .center)
                
                self.homeAddressTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.homeAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }


                              return

            }
            else
            {
                self.homeAddressTextField.layer.borderWidth = 0.8
                self.homeAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            if (!validate (value: self.homeAddressTextField.text!))
            {
                
                self.view.makeToast("Please enter valid Street", duration: 3.0, position: .center)
                
                let bottomOffset = CGPoint(x: 0, y: 350)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.homeAddressTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.homeAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
                
            }
            else
            {
                self.homeAddressTextField.layer.borderWidth = 0.8
                self.homeAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }

            
          

            
         
            if buildingnotextfd.text?.isEmpty == true
            {
                // is empty
                let bottomOffset = CGPoint(x: 0, y: 350)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast("Please enter building number", duration: 3.0, position: .center)
                
                self.buildingnotextfd.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.buildingnotextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                return
            }
            else
            {
                self.buildingnotextfd.layer.borderWidth = 0.8
                self.buildingnotextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            
            //
            var charSetbuildno = CharacterSet.init(charactersIn: "@#$%+_&'()*,-/:;<=>?[]^`{|}~)(")
            var string2buildno = buildingnotextfd.text!

            if let strvalue = string2buildno.rangeOfCharacter(from: charSetbuildno)
            {
                print("true")
//                let alert = UIAlertController(title: "Alert", message: "Please enter valid home adress", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                print("check name",self.fullNameEnTextField.text)
//

               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid home adress", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 350)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                //self.view.makeToast(NSLocalizedString("Please enter valid home adress", comment: ""), duration: 3.0, position: .center)
                self.view.makeToast("Please enter valid building number", duration: 3.0, position: .center)
                
                self.buildingnotextfd.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.buildingnotextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }


                              return

            }
         else
            {
             self.buildingnotextfd.layer.borderWidth = 0.8
             self.buildingnotextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

         }
            
            if (!validate (value: self.buildingnotextfd.text!))
            {
                
                let bottomOffset = CGPoint(x: 0, y: 350)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.view.makeToast("Please enter valid building number", duration: 3.0, position: .center)
                
                self.buildingnotextfd.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.buildingnotextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
                
            }
            else
            {
                self.buildingnotextfd.layer.borderWidth = 0.8
                self.buildingnotextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }
                
//
            
            
            
            
            if(checkGender == 0)
            {
                
                
                
                let bottomOffset = CGPoint(x: 0, y: 420)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("sel_gender", comment: ""), duration: 3.0, position: .center)

                
                self.genderBtn.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.genderBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                return
            }
            else
            {
                self.genderBtn.layer.borderWidth = 0.8
                self.genderBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }
            
        
            var strmobile = mobileTextField.text
            strmobile = strmobile!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(strmobile)
            // "this is the answer"
            print("strmobile",strmobile)
            mobileTextField.text =  strmobile
            print("mobileTextField.text",mobileTextField.text)
            
            //extra space trim
            //extraspace remove
            let startingStringmobile = mobileTextField.text!
            let processedStringmobile = startingStringmobile.removeExtraSpacesregisternumbernospace()
            print("processedStringmobile:\(processedStringmobile)")
            mobileTextField.text = processedStringmobile
            
            
            
            
            //new
            if mobileTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.mobileTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.mobileTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.mobileTextField.layer.borderWidth = 0.8
            self.mobileTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            guard let mobile = mobileTextField.text,mobileTextField.text?.count != 0 else
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 440)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.view.makeToast(NSLocalizedString("enter_mobile", comment: ""), duration: 3.0, position: .center)
                

                return
            }
            if(mobile.count != 8)
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_mob", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 440)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.mobileTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.mobileTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                self.view.makeToast(NSLocalizedString("enter_valid_mob", comment: ""), duration: 3.0, position: .center)

                
                return
            }
            else
            {
                self.mobileTextField.layer.borderWidth = 0.8
                self.mobileTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            var charSetMOBNo = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                        var string2MOBNo = mobile
                        
                        if let strvalue = string2MOBNo.rangeOfCharacter(from: charSetMOBNo)
                        {
                            print("true")
                            
                            
                            let bottomOffset = CGPoint(x: 0, y: 440)
                            //OR
                            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                            self.scrollView.setContentOffset(bottomOffset, animated: true)

                            
            //                let alert = UIAlertController(title: "Alert", message: "Please enter valid account number", preferredStyle: UIAlertController.Style.alert)
            //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //                self.present(alert, animated: true, completion: nil)
            //                print("check name",self.accountNum.text)
                            
                            self.mobileTextField.layer.borderColor = UIColor.red.cgColor
                            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                                self.mobileTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                            }

                            
                            self.view.makeToast(NSLocalizedString("Please enter valid mobile number", comment: ""), duration: 3.0, position: .center)
                            
                          //  alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                            return
                            
                        }
            else
            {
                self.mobileTextField.layer.borderWidth = 0.8
                self.mobileTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            if (!validate (value: self.mobileTextField.text!))
            {
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 440)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.mobileTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.mobileTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                
                self.view.makeToast(NSLocalizedString("Please enter valid mobile number", comment: ""), duration: 3.0, position: .center)

                return
                
            }
            else
            {
                self.mobileTextField.layer.borderWidth = 0.8
                self.mobileTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }
            
            
            var stremployername = employerTextField.text
            stremployername = stremployername!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(stremployername)
            // "this is the answer"
            print("stremployername",stremployername)
            employerTextField.text =  stremployername
            print("employerTextField.text",employerTextField.text)
            
            
            //extraspace remove
            let startingStringemployer = employerTextField.text!
            let processedStringemployer = startingStringemployer.removeExtraSpacesregister()
            print("processedStringemployer:\(processedStringemployer)")
            employerTextField.text = processedStringemployer
            
            
            //new
            if employerTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.employerTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.employerTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.employerTextField.layer.borderWidth = 0.8
            self.employerTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            
            
            guard let employer = employerTextField.text,employerTextField.text?.count != 0 else
            {
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_employer_name", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                
                let bottomOffset = CGPoint(x: 0, y: 460)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast(NSLocalizedString("enter_employer_name", comment: ""), duration: 3.0, position: .center)

                
                return
            }
            
            //(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
            var charSetemployer = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                var string2employerr = employer

                if let strvalue = string2employerr.rangeOfCharacter(from: charSetemployer)
                {
                    print("true")
//                    let alert = UIAlertController(title: "Alert", message: "Please enter valid employer", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                    print("check name",self.fullNameEnTextField.text)
//
                    
                    //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid employer", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    
                    let bottomOffset = CGPoint(x: 0, y: 460)
                    //OR
                    //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                    self.scrollView.setContentOffset(bottomOffset, animated: true)
                    
                    self.employerTextField.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        self.employerTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                    }

                    
                    self.view.makeToast(NSLocalizedString("Please enter valid employer", comment: ""), duration: 3.0, position: .center)

                    return
                    
                }
            else
            {
                self.employerTextField.layer.borderWidth = 0.8
                self.employerTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
            
            if (!validate (value: self.employerTextField.text!))
            {
                self.employerTextField.layer.borderWidth = 0.8
                self.employerTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                
            }
            else
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid employer", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 460)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                
                self.employerTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.employerTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                self.view.makeToast(NSLocalizedString("Please enter valid employer", comment: ""), duration: 3.0, position: .center)

                
                return
            }
            
            
            
            
            var strexpxetedincome = expIncomeTextField.text
            strexpxetedincome = strexpxetedincome!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(strexpxetedincome)
            // "this is the answer"
            print("strexpxetedincome",strexpxetedincome)
            expIncomeTextField.text =  strexpxetedincome
            print("expIncomeTextField.text",expIncomeTextField.text)
            
            
            //extraspace remove
            //extraspace remove
            let startingStringexpincome = expIncomeTextField.text!
            let processedStringexpincome = startingStringexpincome.removeExtraSpacesregisternumbernospace()
            print("processedStringexpincome:\(processedStringexpincome)")
            expIncomeTextField.text = processedStringexpincome
            
            
            
            //new
            if expIncomeTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.expIncomeTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.expIncomeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.expIncomeTextField.layer.borderWidth = 0.8
            self.expIncomeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            
            guard let expIncome = expIncomeTextField.text,expIncomeTextField.text?.count != 0 else
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: NSLocalizedString("ok", comment: ""))
                let bottomOffset = CGPoint(x: 0, y: 480)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                
                self.view.makeToast(NSLocalizedString("enter_exp_income", comment: ""), duration: 3.0, position: .center)

                
                return
            }
            
            
            //
            //(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var charSetexpIncome = CharacterSet.init(charactersIn: "@#$%+_&'()*,/:;<=>?[]^`{|}~)(")
        var string2expIncome = expIncome

            if let strvalue = string2expIncome.rangeOfCharacter(from: charSetexpIncome)
            {
                print("true")
//                let alert = UIAlertController(title: "Alert", message: "Please enter valid working address", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
              
                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 480)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.expIncomeTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.expIncomeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                self.view.makeToast(NSLocalizedString("enter_exp_income", comment: ""), duration: 3.0, position: .center)

                return
                           
            }
            else
            {
                self.expIncomeTextField.layer.borderWidth = 0.8
                self.expIncomeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }
            
            //
            if (!validate (value: self.expIncomeTextField.text!))
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 480)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.expIncomeTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.expIncomeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }

                
                self.view.makeToast(NSLocalizedString("enter_exp_income", comment: ""), duration: 3.0, position: .center)

                
                return
                
            }
            else
            {
                self.expIncomeTextField.layer.borderWidth = 0.8
                self.expIncomeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor

            }
        
            
            
            
            
            var strworkadress = workAddressTextField.text
            strworkadress = strworkadress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(strworkadress)
            // "this is the answer"
            print("strworkadress",strworkadress)
            workAddressTextField.text =  strworkadress
            print("workAddressTextField.text",workAddressTextField.text)
            
            
            
            //extraspace remove
            let startingStringworkaddress = workAddressTextField.text!
            let processedStringworkaddress = startingStringworkaddress.removeExtraSpacesregister()
            print("processedStringworkaddress:\(processedStringworkaddress)")
            workAddressTextField.text = processedStringworkaddress
            
            
            
            
            
            //new
            if workAddressTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.workAddressTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.workAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.workAddressTextField.layer.borderWidth = 0.8
            self.workAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            
            guard let workAddress = workAddressTextField.text,workAddressTextField.text?.count != 0 else
            {
                let bottomOffset = CGPoint(x: 0, y: 500)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_working_address", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view.makeToast(NSLocalizedString("enter_working_address", comment: ""), duration: 3.0, position: .center)

                
                return
            }
            
            //(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
            var charSetaddress = CharacterSet.init(charactersIn: "@#$%+_&'()*,-/:;<=>?[]^`{|}~)(")
        var string2address = strworkadress

            if let strvalue = string2address!.rangeOfCharacter(from: charSetaddress)
            {
                print("true")
//                let alert = UIAlertController(title: "Alert", message: "Please enter valid working address", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
                print("check name",self.workAddressTextField.text)
                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 500)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.workAddressTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.workAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }


                
                self.view.makeToast(NSLocalizedString("Please enter valid working address", comment: ""), duration: 3.0, position: .center)
                return
                           
            }
            else
            {
                self.workAddressTextField.layer.borderWidth = 0.8
                self.workAddressTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }
            
    
            var strregcode = registrationCodeTextField.text
            strregcode = strregcode!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(strregcode)
            // "this is the answer"
            print("strexpxetedincome",strregcode)
            registrationCodeTextField.text =  strregcode
            print("expIncomeTextField.text",registrationCodeTextField.text)
            
            
            //extraspace remove
            //extraspace remove
            let startingStringregcodee = registrationCodeTextField.text!
            let processedStringregcodee = startingStringregcodee.removeExtraSpacesregisternumbernospace()
            print("processedStringregcode:\(processedStringregcodee)")
            registrationCodeTextField.text = processedStringregcodee
            
            
            
            
            var stroccupation = occupationTextField.text
            stroccupation = stroccupation!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(stroccupation)
            // "this is the answer"
            print("stroccupation",stroccupation)
            occupationTextField.text =  stroccupation
            print("occupationTextField.text",occupationTextField.text)
            
            
            
            //new
            if occupationTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.occupationTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.occupationTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.occupationTextField.layer.borderWidth = 0.8
            self.occupationTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            guard let occupation = occupationTextField.text,occupationTextField.text?.count != 0 else
            {
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_occupation", comment: ""), action: NSLocalizedString("ok", comment: ""))
                let bottomOffset = CGPoint(x: 0, y: 540)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                self.view.makeToast("Please select occupation", duration: 3.0, position: .center)
               // self.view.makeToast(NSLocalizedString("enter_occupation", comment: ""), duration: 3.0, position: .center)
                
                return
            }
            
            
            
            //new
            if actualoccutextfd.text?.isEmpty == true
            {
               // timer.invalidate()
                self.actualoccutextfd.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.actualoccutextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                }
            }
            else
            {
            
            self.actualoccutextfd.layer.borderWidth = 0.8
            self.actualoccutextfd.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            guard let actualoccupation = actualoccutextfd.text,actualoccutextfd.text?.count != 0 else
            {
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Select Actual Occupation", action: NSLocalizedString("ok", comment: ""))
                
                
                let bottomOffset = CGPoint(x: 0, y: 560)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)

                
                self.view.makeToast(NSLocalizedString("Select Actual Occupation", comment: ""), duration: 3.0, position: .center)
                return
            }
            
            //new
            //(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
            var charSetregcode = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
            var string2regcode = registrationCodeTextField.text!

                if let strvalue = string2regcode.rangeOfCharacter(from: charSetregcode)
                {
                    print("true")
//                    let alert = UIAlertController(title: "Alert", message: "Please enter valid employer", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                    print("check name",self.fullNameEnTextField.text)
//
                    
                    //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid employer", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    
                    let bottomOffset = CGPoint(x: 0, y: 460)
                    //OR
                    //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                    self.scrollView.setContentOffset(bottomOffset, animated: true)
                    
                    self.registrationCodeTextField.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        self.registrationCodeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
                    }

                    self.view.makeToast("Please enter valid registration code", duration: 3.0, position: .center)
                    //self.view.makeToast(NSLocalizedString("Please enter valid employer", comment: ""), duration: 3.0, position: .center)

                    return
                    
                }
            else
            {
                self.registrationCodeTextField.layer.borderWidth = 0.8
                self.registrationCodeTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
            }

            
            
            
            
            
            self.str_name_en = nameEn
            self.str_name_ar = fullNameArTextField.text!
            self.strEmail = email
            self.str_dob = dob
            self.str_address = homeAddressTextField.text!
            
            if(municipalityBtn.titleLabel?.text == NSLocalizedString("municipality", comment: ""))
            {
                self.str_city = "-"
            }
            else
            {
            self.str_city = municipalityBtn.titleLabel?.text as! String
            }
            
            //self.str_city = municipalityBtn.titleLabel?.text as! String
            if(checkGender == 1)
            {
                self.str_gender = "Male"
            }
            else {
                self.str_gender = "Female"
            }
            self.strMobile = "974" + mobile
            self.str_employer = employerTextField.text!
            self.str_income = expIncomeTextField.text!
            self.str_working_address = workAddressTextField.text!
           // self.str_occupation = occupationTextField.text!
            getToken(num: 3)
            backbtnstatusstrr = "securitypage"
        }
        
    }
    func setFont() {
        
        identificationBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 10)
        profileBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        securityBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        identificationDetailsLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        idTypeBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        idIssuerBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        idNumTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        idExpDateTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        nextBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        personal_infoLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        fullNameEnTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        fullNameArTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        emailTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        dobTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        nationalityBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        dualNationalityBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        countryResiBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        municipalityBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        zoneBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        homeAddressTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        buildingnotextfd.font = UIFont(name: "OpenSans-Regular", size: 14)
        
        genderBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        countryCodeTextfield.font = UIFont(name: "OpenSans-Regular", size: 14)
        mobileTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        employerTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        expIncomeTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        workAddressTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        occupationTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        actualoccutextfd.font = UIFont(name: "OpenSans-Regular", size: 14)
        registrationCodeTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        next1Btn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        
        secQuesBtn.titleLabel?.font = UIFont(name: "OpenSans- Regular", size: 14)
        answerTextField.font = UIFont(name: "OpenSans- Regular", size: 14)
        passwLbl.font = UIFont(name: "OpenSans- Regular", size: 14)
        passReqLbl.font = UIFont(name: "OpenSans- Regular", size: 14)
        req1Lbl.font = UIFont(name: "OpenSans- Regular", size: 14)
        req2Lbl.font = UIFont(name: "OpenSans- Regular", size: 14)
        req3Lbl.font = UIFont(name: "OpenSans- Regular", size: 14)
        req4Lbl.font = UIFont(name: "OpenSans- Regular", size: 14)
        passwTextField.font = UIFont(name: "OpenSans- Regular", size: 14)
        retypePasswTextField.font = UIFont(name: "OpenSans- Regular", size: 14)
        pinLbl.font = UIFont(name: "OpenSans- Regular", size: 14)
        pinTextField.font = UIFont(name: "OpenSans- Regular", size: 14)
        iAgreeLbl.font = UIFont(name: "OpenSans- Regular", size: 14)
        termsBtn.titleLabel?.font = UIFont(name: "OpenSans- Regular", size: 14)
        createProfileBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        nextBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        cancelBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        acceptBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        
        radiospecialcharlbl.font = UIFont(name: "OpenSans-Regular", size: 14)
    }
    func setFontSize(){
        identificationBtn.titleLabel?.font = identificationBtn.titleLabel?.font.withSize(12)
        profileBtn.titleLabel?.font = profileBtn.titleLabel?.font.withSize(12)
        securityBtn.titleLabel?.font = securityBtn.titleLabel?.font.withSize(12)
        secQuesBtn.titleLabel?.font = secQuesBtn.titleLabel?.font.withSize(14)
        passwLbl.font = passwLbl.font.withSize(14)
        passReqLbl.font = passReqLbl.font.withSize(12)
        req1Lbl.font = req1Lbl.font.withSize(14)
        req2Lbl.font = req2Lbl.font.withSize(14)
        req3Lbl.font = req3Lbl.font.withSize(14)
        req4Lbl.font = req4Lbl.font.withSize(14)
        pinLbl.font = pinLbl.font.withSize(14)
        iAgreeLbl.font = iAgreeLbl.font.withSize(14)
        termsBtn.titleLabel?.font = termsBtn.titleLabel?.font.withSize(14)
        identificationDetailsLbl.font = identificationDetailsLbl.font.withSize(14)
        idTypeBtn.titleLabel?.font = idTypeBtn.titleLabel?.font.withSize(14)
        idIssuerBtn.titleLabel?.font = idIssuerBtn.titleLabel?.font.withSize(14)
        personal_infoLbl.font = personal_infoLbl.font.withSize(14)
        nationalityBtn.titleLabel?.font = nationalityBtn.titleLabel?.font.withSize(16)
        dualNationalityBtn.titleLabel?.font = dualNationalityBtn.titleLabel?.font.withSize(16)
        countryResiBtn.titleLabel?.font = countryResiBtn.titleLabel?.font.withSize(16)
        municipalityBtn.titleLabel?.font = municipalityBtn.titleLabel?.font.withSize(16)
        zoneBtn.titleLabel?.font = zoneBtn.titleLabel?.font.withSize(16)
        genderBtn.titleLabel?.font = genderBtn.titleLabel?.font.withSize(16)
        
        //new
      
            
        radiospecialcharlbl.font = req1Lbl.font.withSize(14)
        
        
    }
    func animateIdType(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.tblIdType.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.tblIdType.isHidden = true
            }
        }
    }
    func animateIdIssuer(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.tblIdIssuer.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.tblIdIssuer.isHidden = true
            }
        }
    }
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
           datePicker.preferredDatePickerStyle = .wheels
           datePicker.backgroundColor = UIColor.white
        }
        
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate))
        toolbar.setItems([done], animated: true)
        idExpDateTextField.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        let today = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -89, to: today)!
        idExpDateTextField.inputView = datePicker
    }
    func createToolbar1(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
           datePicker1.preferredDatePickerStyle = .wheels
           datePicker1.backgroundColor = UIColor.white
        }
        
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate1))
        toolbar.setItems([done], animated: true)
        dobTextField.inputAccessoryView = toolbar
        datePicker1.datePickerMode = .date
        datePicker1.maximumDate = Date()
        dobTextField.inputView = datePicker1
    }
    @objc func showdate()
    {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd-MM-yyyy"
            idExpDateTextField.text = dateFormat.string(from: datePicker.date)
             
    //        let dateFormat = DateFormatter()
    //        dateFormat.dateFormat = "yyyy-MM-dd"
    //        self.qidexpdatestr = dateFormat.string(from: datePicker.date)
    //
    //
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let showDate = inputFormatter.string(from: datePicker.date)
            self.qidexpdatestr = inputFormatter.string(from: datePicker.date)
            //inputFormatter.dateFormat = "yyyy-MM-dd"
           // let resultString = inputFormatter.string(from: showDate)
            print(self.qidexpdatestr)
            
            
            view.endEditing(true)
        }
    
    @objc func showdate1()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        
        if self.statusstrr == "ACTIVE"
        {
            if self.str_dob.isEmpty == true
            {
                dobTextField.text = dateFormat.string(from: datePicker1.date)
            }
            else
            {
            dobTextField.text = self.str_dob
                print("dobbbtestshowdate1:", self.str_dob)
            }
        }
        else
        {
            if dobTextField.text != "" {
                str_dob = dobTextField.text ?? ""
            }else{
                dobTextField.text = dateFormat.string(from: datePicker1.date)
                print(dobTextField.text)
            }
      
        }
    
//        let birthday = dateFormat.date(from:  dobTextField.text!)
//        let timeInterval = birthday?.timeIntervalSinceNow
//        let age = abs(Int(timeInterval! / 31556926.0))
//        self.userAge = age
//
//        if age < 18 {
//            // user is under 18
//        }else{
//            print("above 18")
//        }
        let components = NSCalendar.current.dateComponents([.day,.month,.year],from:dateFormat.date(from: dobTextField.text!)!)
             if let day = components.day, let month = components.month, let year = components.year {
                 let dayString = "\(day)"
                 let monthString = "\(month)"
                 let yearString = "\(year)"
        
                let myDOB = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
        
                let myAge = Calendar.current.dateComponents([.month], from: myDOB, to: Date()).month!
                let years = myAge / 12
                let months = myAge % 12
                print("Age : \(years).\(months)")
                self.userAge = Double("\(years)"+"."+"\(months)")
                print(self.userAge)
        }
        view.endEditing(true)
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
        
        RegisterViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("tokenResp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                if(num == 1)
                {
                    self.idValidation(access_token: token)
                }
                else if(num == 3)
                {
                    self.validateEmailMobile(accessToken: token)
                }
                break
            case .failure:
                break
            }
        })
    }
    func idValidation(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":str_id_no,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1999-01-01","validationMethod":"CUSTOMERIDNO","isExistOrValid":"1"]
        
        print("idvalidate validate",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RegisterViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("responseid validate",response)
            
            
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            
            
//            //new
//            if(respCode == "S9001")
//            {
//               // timer.invalidate()
//                self.idNumTextField.layer.borderColor = UIColor.red.cgColor
//                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (Timer) in
//                    self.idNumTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
//                }
//            }
//            else
//            {
//
//            self.idNumTextField.layer.borderWidth = 0.8
//            self.idNumTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
//            }

            
            if(respCode == "S9001")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("id_exists", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.backbtnstatusstrr = "idpage"
                return
            }
            
            if(respCode == "EC2300")
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                
                self.setTab(tabNo: 1)
               self.tab1View.isHidden = true
                self.tab2View.isHidden = false
                self.tab2View.isHidden = true
                self.tab3View.isHidden = true
                
                self.setTab(tabNo: 1)
                
                self.backbtnstatusstrr == ""
                
                
                
                self.scrollView.setContentOffset(.zero, animated: true)
                return
            }
            else{
                self.tab1View.isHidden = true
                self.tab2View.isHidden = false
                self.tab3View.isHidden = true
                var image = UIImage(named: "box")
                let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                if appLang == "ar" || appLang == "ur" {
                    image = UIImage(named: "boxArabic")
                }
                self.profileBtn .setBackgroundImage(image, for: .normal)
                self.identificationBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
                self.securityBtn.setBackgroundImage(nil, for: .normal)
                self.profileBtn.backgroundColor = .none
                
                
            }
        })
    }
    func validateEmailMobile(accessToken:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":"","customerPassword":"","mpin":"","customerEmail":self.strEmail,"customerMobile":self.strMobile,"customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"MOBILE_EMAIL","isExistOrValid":"0"]
        
        print("validationapiurl ",url)
        print("validationapiparams ",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        RegisterViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            if(respCode == "E9000")
            {
                let RespMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: RespMsg, action: NSLocalizedString("ok", comment: ""))
                //new
                self.tab3View.isHidden = true
                self.tab2View.isHidden = false
                self.tab1View.isHidden = true

            }
            else{
                self.tab3View.isHidden = false
                self.tab2View.isHidden = true
                self.tab1View.isHidden = true
                var image = UIImage(named: "box")
                let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                if appLang == "ar" || appLang == "ur" {
                    image = UIImage(named: "boxArabic")
                }
//                self.securityBtn .setBackgroundImage(image, for: .normal)
                self.securityBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
                self.identificationBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
                self.profileBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
                
                self.backbtnstatusstrr = "securitypage"
                
                self.scrollView.setContentOffset(.zero, animated: true)
            }
        
        })
    }
    func getCountry(searchText:String) {
        self.countryResArray.removeAll()
        self.nationalityArray.removeAll()
        
        //newserch
        self.checkarrayaoccunat.removeAll()
        self.checkarrayaoccunatstr.removeAll()
        self.checkarrayaoccunatflagcode.removeAll()

        
        self.tblNationality.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "casmex/getMasterDetails"
        let params:Parameters = ["type":"nationality"]
        print("urlcountry",url)
        print("paramscountry",params)

        RegisterViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["data"]
//                self.nationalityFlagPath = myResult!["file_path"].stringValue
                for i in resultArray.arrayValue{
                    let nationality = CasmexNationality(id: i["id"].stringValue, description: i["description"].stringValue)
                    self.nationalityArray.append(nationality)
                    if(nationality.description == "QATAR")
                    {
                        self.countryResArray.append(nationality)
                    }
                    //new
                    self.checkarrayaoccunat.append(i["description"].stringValue)
                    self.checkarrayaoccunatstr.append(i["description"].stringValue)
                    self.checkarrayaoccunatflagcode.append(i["description"].stringValue)

                }
                self.tblNationality.reloadData()
                break
            case .failure:
                break
            }
          })
    }
    /*
     func getCountry(searchText:String) {
         self.countryResArray.removeAll()
         self.nationalityArray.removeAll()
         
         //newserch
         self.checkarrayaoccunat.removeAll()
         self.checkarrayaoccunatstr.removeAll()
         self.checkarrayaoccunatflagcode.removeAll()

         
         self.tblNationality.reloadData()
         self.activityIndicator(NSLocalizedString("loading", comment: ""))
         let url = api_url + "nationalities_listing"
         let params:Parameters = ["lang":"en","keyword":searchText]
         print("urlcountry",url)
         print("paramscountry",params)

           AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
             print("history",response)
             self.effectView.removeFromSuperview()
             switch response.result{
             case .success:
                 let myResult = try? JSON(data: response.data!)
                 let resultArray = myResult!["nationalities_listing"]
                 self.nationalityFlagPath = myResult!["file_path"].stringValue
                 for i in resultArray.arrayValue{
                     let nationality = Country(id: i["id"].stringValue, num_code: i["num_code"].stringValue, alpha_2_code: i["alpha_2_code"].stringValue, alpha_3_code: i["alpha_3_code"].stringValue, en_short_name: i["en_short_name"].stringValue, nationality: i["nationality"].stringValue)
                     self.nationalityArray.append(nationality)
                     if(nationality.alpha_2_code == "QA")
                     {
                         self.countryResArray.append(nationality)
                     }
                     //new
                     self.checkarrayaoccunat.append(i["en_short_name"].stringValue)
                     self.checkarrayaoccunatstr.append(i["alpha_3_code"].stringValue)
                     self.checkarrayaoccunatflagcode.append(i["alpha_2_code"].stringValue)

                 }
                 self.tblNationality.reloadData()
                 break
             case .failure:
                 break
             }
           })
     }
     */
    func getMunicipality(searchText:String) {
        
        self.municipalityArray.removeAll()
        self.tblMunicipality.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "city_listing"
        let params:Parameters = ["lang":"en","keyword":searchText]
        
        print("urlmunsi",url)
        print("paramsmunsi",params)

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["city_listing"]
                for i in resultArray.arrayValue{
                    let municipality = City(ge_city_name: i["ge_city_name"].stringValue, id: i["id"].stringValue)
                    self.municipalityArray.append(municipality)
                }
                self.tblMunicipality.reloadData()
              break
            case .failure:
                break
            }
          })
    }
    
    func getMunicipalityoccupation(searchText:String) {
        
        self.municipalityArray.removeAll()
        
        
        self.checkarrayaoccu.removeAll()
        self.checkarrayaoccustr.removeAll()

        
        self.tblMunicipality.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "casmex/getMasterDetails"
        let params:Parameters =  [
            "type":"profession"
        ]
        
        print("urloccuand actualoccu",url)
        print("paramsoccuandactualoccu",params)

          RegisterViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
                     print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                //let resultArray = myResult!["city_listing"]
                 let resultArray = myResult!["data"]
                for i in resultArray.arrayValue{
                    let municipality = City(ge_city_name: i["description"].stringValue, id: i["id"].stringValue)
                    self.municipalityArray.append(municipality)
                    
                    self.checkarrayaoccu.append(i["description"].stringValue)
                    self.checkarrayaoccustr.append(i["id"].stringValue)
                }
                self.tblMunicipality.reloadData()
              break
            case .failure:
                break
            }
          })
    }
    /*old
     func getMunicipalityoccupation(searchText:String) {
        
        self.municipalityArray.removeAll()
        
        
        self.checkarrayaoccu.removeAll()
        self.checkarrayaoccustr.removeAll()

        
        self.tblMunicipality.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "shiftservice/showOccupation"
       let params:Parameters = ["":""]
        
        print("urloccuand actualoccu",url)
        print("paramsoccuandactualoccu",params)

          RegisterViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
                     print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                //let resultArray = myResult!["city_listing"]
                 let resultArray = myResult![]
                for i in resultArray.arrayValue{
                    let municipality = City(ge_city_name: i["occupationName"].stringValue, id: i["occupationCode"].stringValue)
                    self.municipalityArray.append(municipality)
                    
                    self.checkarrayaoccu.append(i["occupationName"].stringValue)
                    self.checkarrayaoccustr.append(i["occupationCode"].stringValue)
                }
                self.tblMunicipality.reloadData()
              break
            case .failure:
                break
            }
          })
    }*/
    
    
    
    func getZone(id:String,searchText:String) {
        self.zoneArray.removeAll()
        
        //newserch
        self.checkarrayaoccuzone.removeAll()
        self.checkarrayaoccuzonestr.removeAll()

        
        self.tblZone.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.zoneArray.removeAll()
        let url = api_url + "zone_listing"
        //let params:Parameters = ["municipality":id,"keyword":searchText]
        let params:Parameters = ["municipality":""]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["zone_listing"]
                for i in resultArray.arrayValue{
                    let zone = Zone(id: i["id"].stringValue, municipality: i["municipality"].stringValue, zone: i["zone"].stringValue)
                    self.zoneArray.append(zone)
                    
                    //new
                    self.checkarrayaoccuzone.append(i["zone"].stringValue)
                    self.checkarrayaoccuzonestr.append(i["zone"].stringValue)

                }
                self.tblZone.reloadData()
              break
            case .failure:
                break
            }
          })
    }
    func getSecQues() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "security_questions_listing"
        let params:Parameters = ["lang":"en"]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["security_questions_listing"]
                for i in resultArray.arrayValue{
                    let secQues = SecurityQuestion(id: i["id"].stringValue, security_question_en: i["security_question_en"].stringValue)
                    self.secQuesArray.append(secQues)
                }
                self.tblsecQues.reloadData()
              break
            case .failure:
                break
            }
          })
    }
    func getTermsandConditions() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "contents_listing"
        let params:Parameters = ["type":"8","lang":"en"]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["contents_listing"]
                for i in resultArray.arrayValue{
                    let content = i["contents_desc_en"].stringValue
                    self.termsTextView.attributedText = content.htmlToAttributedString
                    self.adjustUITextViewHeight(arg: self.termsTextView)
                    self.termsTextView.font = UIFont(name: "OpenSans-Regular", size: 18)
                    
                }
              break
            case .failure:
                break
            }
          })
    }
    
    /////qidintegration
    
    
       func getTokenGECOQID() {
//           self.activityIndicator(NSLocalizedString("loading", comment: ""))
           let url = geco_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
           let str_encode_val = auth_client_id + ":" + auth_client_secret
           let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
           let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
           
           print("tokenurlqid",url)
          // print("tokenResqidparam",response)
           
           RegisterViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
               print("tokenRespgecoqid",response)
               self.effectView.removeFromSuperview()
               switch response.result{
               case .success:
                   let myresult = try? JSON(data: response.data!)
                   
                   let token:String = myresult!["access_token"].string!
                   
                   self.QIDLISTAPI(access_token:token)
                   
   //                if(num == 1)
   //                {
   //                    self.idValidation(access_token: token)
   //                }
   //                else if(num == 3)
   //                {
   //                    self.validateEmailMobile(accessToken: token)
   //                }
                   break
               case .failure:
                   break
               }
           })
       }
       
       
       
       func QIDLISTAPI(access_token:String) {
           self.activityIndicator(NSLocalizedString("loading", comment: ""))
          // let dateTime:String = getCurrentDateTime()
           //orginal
//           let url = geco_api_url + "transaction/validateID"
           //test
           let url = geco_api_url + "transaction/validateIDOld"
           
           let params:Parameters =  ["qidNo":self.str_id_no,"qidExpDate":self.qidexpdatestr]
            print("urlQIDLIST",url)
           print("paramsQIDLIST",params)
           let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
           
           RegisterViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in               
               let myResult = try? JSON(data: response.data!)
               print("responseQIDLIST",response)
               self.effectView.removeFromSuperview()
               let respCode = myResult!["responseCode"]
                 print("responsecodeQID",respCode)
               
               
               if myResult!["status"].stringValue.isEmpty
               {
                   
               }
               else
               {
                 let statusstr:String = myResult!["status"].string!
                   self.statusstrr = myResult!["status"].string!
               }
               if self.statusstrr == "ACTIVE"
               {
                   if myResult!["name"].stringValue.isEmpty
                   {
                       
                   }
                   else
                   {
                       self.fullNameEnTextField.text =  myResult!["name"].stringValue
                   }
                   
                   if myResult!["namearabic"].stringValue.isEmpty
                   {
                       
                   }
                   else
                   {
                       self.fullNameArTextField.text =  myResult!["namearabic"].stringValue
                   }
                   
                   if myResult!["dob"].stringValue.isEmpty
                   {
                       
                   }
                   else
                   {
                       self.dobTextField.text =  myResult!["dob"].stringValue
                       self.str_dob  = myResult!["dob"].stringValue
                   }
                   
                   if myResult!["gender"].stringValue.isEmpty
                   {
                                   
                   }
                   else
                   {
                       
                   let genderstr:String = myResult!["gender"].string!
                     if genderstr == "1"
                     {
                       self.checkGender = 1
                       self.genderBtn.setTitle("Male", for: .normal)
                     }
                   if genderstr == "2"
                       {
                           self.checkGender = 2
                       self.genderBtn.setTitle("Female", for: .normal)
                       }
                   
                   
                   }
                   
                   
                   if myResult!["nationality"].stringValue.isEmpty
                   {
                       //new
                 //  self.countryResiBtn.setTitle("\(NSLocalizedString("country_of_residence", comment: ""))", for: .normal)
                   }
                   else
                   {
                       //new
                     //  self.countryResiBtn.setTitle("\(NSLocalizedString("country_of_residence", comment: ""))", for: .normal)
                       self.countrycodeQIDstr = myResult!["nationality"].stringValue
                       
                     //  self.str_country = self.countrycodeQIDstr
                       //print("str_country",self.str_country)
                       
                       self.getCountryregQID(searchText: "")
                       
                   }
                   
               }
               
               
               
               
               
               
               
               
               
           })
       }
   

    func getCountryregQID(searchText:String) {
//        self.countryResArray.removeAll()
//        self.nationalityArray.removeAll()
//        self.tblNationality.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "casmex/getMasterDetails"
        let params:Parameters = ["type":"nationality"]

        RegisterViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["nationalities_listing"]
                self.nationalityFlagPath = myResult!["file_path"].stringValue
                for i in resultArray.arrayValue{
                    let nationality = CasmexNationality(id: i["id"].stringValue, description: i["description"].stringValue)
                    self.nationalityArray.append(nationality)
                     if(nationality.description == self.countrycodeQIDstr )
                     {
                        self.countrynameqidstr = i["description"].stringValue
                        print("counntryqid",self.countrynameqidstr)
                        self.str_nationality = i["description"].stringValue
                         self.str_dualNationality = i["description"].stringValue
                        print("str_nationalitycode",self.str_nationality)
                         print("str_dualNationality",self.str_dualNationality)
                         
                    }
                   // self.nationalityArray.append(nationality)
//                    if(nationality.alpha_2_code == "QA")
//                    {
//                        self.countryResArray.append(nationality)
//                    }
                    
                    
                    
                }
                self.nationalityBtn.setTitleColor(.black, for: .normal)
                 self.nationalityBtn.setTitle(self.countrynameqidstr, for: .normal)
                self.dualNationalityBtn.setTitleColor(.black, for: .normal)
                 self.dualNationalityBtn.setTitle(self.countrynameqidstr, for: .normal)
               // self.tblNationality.reloadData()
                break
            case .failure:
                break
            }
          })
    }
      /* func getCountryregQID(searchText:String) {
   //        self.countryResArray.removeAll()
   //        self.nationalityArray.removeAll()
   //        self.tblNationality.reloadData()
           self.activityIndicator(NSLocalizedString("loading", comment: ""))
           let url = api_url + "nationalities_listing"
           let params:Parameters = ["lang":"en","keyword":searchText]

             AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
               print("history",response)
               self.effectView.removeFromSuperview()
               switch response.result{
               case .success:
                   let myResult = try? JSON(data: response.data!)
                   let resultArray = myResult!["nationalities_listing"]
                   self.nationalityFlagPath = myResult!["file_path"].stringValue
                   for i in resultArray.arrayValue{
                       let nationality = Country(id: i["id"].stringValue, num_code: i["num_code"].stringValue, alpha_2_code: i["alpha_2_code"].stringValue, alpha_3_code: i["alpha_3_code"].stringValue, en_short_name: i["en_short_name"].stringValue, nationality: i["nationality"].stringValue)
                        if(nationality.alpha_3_code == self.countrycodeQIDstr )
                        {
                           self.countrynameqidstr = i["en_short_name"].stringValue
                           print("counntryqid",self.countrynameqidstr)
                           self.str_nationality = i["alpha_3_code"].stringValue
                            self.str_dualNationality = i["alpha_3_code"].stringValue
                           print("str_nationalitycode",self.str_nationality)
                            print("str_dualNationality",self.str_dualNationality)
                            
                       }
                      // self.nationalityArray.append(nationality)
   //                    if(nationality.alpha_2_code == "QA")
   //                    {
   //                        self.countryResArray.append(nationality)
   //                    }
                       
                       
                       
                   }
                   self.nationalityBtn.setTitleColor(.black, for: .normal)
                    self.nationalityBtn.setTitle(self.countrynameqidstr, for: .normal)
                   self.dualNationalityBtn.setTitleColor(.black, for: .normal)
                    self.dualNationalityBtn.setTitle(self.countrynameqidstr, for: .normal)
                  // self.tblNationality.reloadData()
                   break
               case .failure:
                   break
               }
             })
       }*/
   
   
    
    
    
    
    
    
    /////
    
    
    
    
    
    
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidspecialchar(_ email: String) -> Bool {
         let specialcharRegEx = "!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢"

         let emailPredspecialchar = NSPredicate(format:"SELF MATCHES %@", specialcharRegEx)
         return emailPredspecialchar.evaluate(with: email)
     }
    
    
    func usernameTest(testStr:String) -> Bool {

        return testStr.range(of: "^[ !\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]+", options: .regularExpression) != nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblIdType)
        {
            return idTypeArray.count
        }
        else if(tableView == tblIdIssuer)
        {
            return idIssuerArray.count
        }
        else if(tableView == tblNationality)
        {
            if natselserchstr == "searchcliked"
            {
                return searchedArraynat.count
            }
            else
            {
            
            if(checkCountry == 0)
            {
                return nationalityArray.count
            }
            else
            {
                return countryResArray.count
            }
        }
        }
        else if(tableView == tblMunicipality)
        {
            
            if occupationselsearchstr == "searchcliked"
            {
              
            return searchedArray.count
            }
            
            else
            {
            return municipalityArray.count
            }
        }
        else if(tableView == tblZone)
        {
            if zoneselserchstr == "searchcliked"
            {
              
            return searchedArrayzone.count
            }
            
            else
            {
            return zoneArray.count
            }
           // return zoneArray.count
        }
        else if(tableView == tblsecQues)
        {
            return secQuesArray.count
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tblIdType)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IdTypeCell") as! idTypeTableViewCell
            cell.idTypeLbl.text = idTypeArray[indexPath.row]
            return cell
        }
        else if(tableView == tblIdIssuer)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "idIssuerCell") as! idIssuerTableViewCell
            cell.idIssuerLbl.text = idIssuerArray[indexPath.row]
            return cell
        }
        else if(tableView == tblNationality)
        {
            if natselserchstr == "searchcliked"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "nationalityCell") as! CountryTableViewCell
                
                //for code getting
                
           
                
//                teststrclsnatflagstr = searchedArraynatflag[indexPath.row]
//                guard let index = checkarrayaoccunatflagcode.firstIndex(of: teststrclsnat)else { return cell }
//                print("kitydaflagg:\(index)")
//
//
//                let codee:String = searchedArraynatflag[indexPath.row].lowercased()
                
                ////
               
                cell.countryLbl.text = searchedArraynat[indexPath.row]
                //let code:String = country.alpha_2_code.lowercased()
                let url = nationalityFlagPath + "code" + ".png"
                //let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                let imgResource = URL(string: url)
                cell.flagImg.kf.setImage(with: imgResource)
                return cell
                
                
            }
            else
            {

            
           if(checkCountry == 0)
           {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nationalityCell") as! CountryTableViewCell
                       let nationality = nationalityArray[indexPath.row]
                       cell.setCountry(country: nationality)
                       
               let code:String = nationality.description.lowercased()
                       let url = nationalityFlagPath + code + ".png"
                       //let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
               let imgResource = URL(string: url)
               cell.flagImg.kf.setImage(with: imgResource)
                       return cell
            }
           else{
               if checkNationality == 0 {
                   let cell = tableView.dequeueReusableCell(withIdentifier: "nationalityCell") as! CountryTableViewCell
                              let nationality = countryResArray[indexPath.row]
                              cell.setCountry(country: nationality)
                              
                              let code:String = nationality.description.lowercased()
                              let url = nationalityFlagPath + code + ".png"
                             // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                      let imgResource = URL(string: url)
                      cell.flagImg.kf.setImage(with: imgResource)
                              return cell
               }
               else {
                   let cell = tableView.dequeueReusableCell(withIdentifier: "nationalityCell") as! CountryTableViewCell
                              let nationality = countryResArray[indexPath.row]
                              cell.setCountry(country: nationality)
                              
                              let code:String = nationality.description.lowercased()
                              let url = nationalityFlagPath + code + ".png"
                             // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                      let imgResource = URL(string: url)
                      cell.flagImg.kf.setImage(with: imgResource)
                              return cell
               }
           
            }
        }
            
        }
        else if(tableView == tblMunicipality)
        {
            
            
                
                if occupationselsearchstr == "searchcliked"
                   {
                    
                    if searchedArray.isEmpty == true
                    {
                        
                    }
                    else
                    {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "municipalityCell") as! LabelTableViewCell
                    print("searchedArraycellfor",searchedArray)
                    //cell.label.text = searchedArray[indexPath.row]
                    cell.label.text = searchedArray[indexPath.row]
                     
                      return cell
                    }
                   }

                
              
            
            
            else
            {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "municipalityCell") as! LabelTableViewCell
            let municipality = municipalityArray[indexPath.row]
            cell.label.text = municipality.ge_city_name
            return cell
            }
        }
        else if(tableView == tblZone)
        {
            
            if zoneselserchstr == "searchcliked"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCell") as! LabelTableViewCell
//                let zone = zoneArray[indexPath.row]
//                cell.label.text = zone.zone
                cell.label.text = searchedArrayzone[indexPath.row]
                return cell
            }
            else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCell") as! LabelTableViewCell
            let zone = zoneArray[indexPath.row]
            cell.label.text = zone.zone
            return cell
         }
        }
        else if(tableView == tblsecQues)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "secQuesCell") as! LabelTableViewCell
            let secQues = secQuesArray[indexPath.row]
            cell.label.text = secQues.security_question_en
            return cell
        }
        return UITableViewCell()
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == tblIdType)
        {
            let cell: idTypeTableViewCell = self.tblIdType.cellForRow(at: indexPath) as! idTypeTableViewCell
            let str: String = cell.idTypeLbl.text!
            idTypeBtn.setTitle("\(str)", for: .normal)
            animateIdType(toogle: false)
            idTypeBtn.setTitleColor(.black, for: .normal)
        }
        else if(tableView == tblIdIssuer)
        {
            let cell: idIssuerTableViewCell = self.tblIdIssuer.cellForRow(at: indexPath) as! idIssuerTableViewCell
            let str: String = cell.idIssuerLbl.text!
            idIssuerBtn.setTitle("\(str)", for: .normal)
            animateIdIssuer(toogle: false)
            idIssuerBtn.setTitleColor(.black, for: .normal)
        }
        else if(tableView == tblNationality)
        {
            if(checkCountry == 0)
            {
                let cell: CountryTableViewCell = self.tblNationality.cellForRow(at: indexPath) as! CountryTableViewCell
                let str: String = cell.countryLbl.text!
                let nat = nationalityArray[indexPath.row]
                //hided
                
                if checkNationality == 0 {
                    let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                    var image = UIImage(named: "box")
                    let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                     if appLang == "ar" || appLang == "ur"
                     {
                        nationalityBtn.setTitle("\(str)", for: .normal)
                        nationalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                         self.nationalityBtn.setTitleColor(.black, for: .normal)
                         
                         
                    }
                    else
                     {
                        if natselserchstr == "searchcliked"
                        {
                            let cell: CountryTableViewCell = self.tblNationality.cellForRow(at: indexPath) as! CountryTableViewCell
                            
                            
                            teststrclsnat = searchedArraynat[indexPath.row]
                                            print("selectednamesearch",teststrclsnat)
                            
                            
                            UserDefaults.standard.removeObject(forKey: "str_nationalitynew")
                            UserDefaults.standard.removeObject(forKey: "nationalitynamestr")
                            
                           // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                            guard let index = checkarrayaoccunat.firstIndex(of: teststrclsnat) else { return }
                            print(index)
                             print("kityda:\(index)")
                            
                            var indexone = index
                           // let firstName = AllArrayid[indexone]
                            let firstName = checkarrayaoccunatstr[indexone]
                            print("id selkityada:\(firstName)")
                            str_nationality = firstName
                            //print("id selkityadastr_natid:\(str_country_2_code)")
                            
                            
                            
                            self.nationalityBtn.setTitle("\(teststrclsnat)", for: .normal)
                            self.nationalityBtn.setTitleColor(UIColor.black, for: .normal)
                            nationalitynamestr = teststrclsnat
                            
                          //last
                            natselserchstr = ""
                        }
                        else
                        {

                        nationalityBtn.setTitle("\(str)", for: .normal)
                        self.nationalityBtn.setTitleColor(.black, for: .normal)
                            UserDefaults.standard.removeObject(forKey: "nationalitynamestr")
                            UserDefaults.standard.setValue(nationalitynamestr, forKey: "nationalitynamestr")
                            nationalitynamestr = nat.description
                            self.str_nationality = nat.description
                        }
                    }
                    
                    
                   // self.str_nationality = nat.alpha_3_code
                    
                    //nationalitynamestr = nat.en_short_name
                    
                    
                    
                    UserDefaults.standard.set(self.nationalitynamestr, forKey: "nationalitynamestr")
                    
                    nationalitySearchView.isHidden = true
                    tab2View.isHidden = false
                }
                else {
                    let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                    var image = UIImage(named: "box")
                    let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                     if appLang == "ar" || appLang == "ur"
                     {
                        dualNationalityBtn.setTitle("\(str)", for: .normal)
                         dualNationalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                         self.dualNationalityBtn.setTitleColor(.black, for: .normal)
                         
                         
                    }
                    else
                     {
                        if natselserchstr == "searchcliked"
                        {
                            let cell: CountryTableViewCell = self.tblNationality.cellForRow(at: indexPath) as! CountryTableViewCell
                            
                            
                            teststrclsnat1 = searchedArraynat[indexPath.row]
                                            print("selectednamesearch",teststrclsnat1)
                            
                            
                            UserDefaults.standard.removeObject(forKey: "str_nationalitynew")
                            UserDefaults.standard.removeObject(forKey: "nationalitynamestr1")
                            
                           // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                            guard let index = checkarrayaoccunat.firstIndex(of: teststrclsnat1) else { return }
                            print(index)
                             print("kityda:\(index)")
                            
                            var indexone = index
                           // let firstName = AllArrayid[indexone]
                            let firstName = checkarrayaoccunatstr[indexone]
                            print("id selkityada:\(firstName)")
                            str_dualNationality = firstName
                            //print("id selkityadastr_natid:\(str_country_2_code)")
                            
                            
                            
                            self.dualNationalityBtn.setTitle("\(teststrclsnat1)", for: .normal)
                            self.dualNationalityBtn.setTitleColor(UIColor.black, for: .normal)
                            nationalitynamestr1 = teststrclsnat1
                            
                          //last
                            natselserchstr = ""
                        }
                        else
                        {

                            dualNationalityBtn.setTitle("\(str)", for: .normal)
                        self.dualNationalityBtn.setTitleColor(.black, for: .normal)
                            UserDefaults.standard.removeObject(forKey: "nationalitynamestr1")
                            nationalitynamestr1 = nat.description
                            self.str_dualNationality = nat.description
                        }
                    }
                    
                    
                   // self.str_nationality = nat.alpha_3_code
                    
                    //nationalitynamestr = nat.en_short_name
                    
                    
                    
                    UserDefaults.standard.set(self.nationalitynamestr1, forKey: "nationalitynamestr1")
                    
                    nationalitySearchView.isHidden = true
                    tab2View.isHidden = false
                }
//                let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
//                var image = UIImage(named: "box")
//                let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
//                 if appLang == "ar" || appLang == "ur"
//                 {
//                    nationalityBtn.setTitle("\(str)", for: .normal)
//                    nationalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
//                     self.nationalityBtn.setTitleColor(.black, for: .normal)
//                     
//                     
//                }
//                else
//                 {
//                    if natselserchstr == "searchcliked"
//                    {
//                        let cell: CountryTableViewCell = self.tblNationality.cellForRow(at: indexPath) as! CountryTableViewCell
//                        
//                        
//                        teststrclsnat = searchedArraynat[indexPath.row]
//                                        print("selectednamesearch",teststrclsnat)
//                        
//                        
//                        UserDefaults.standard.removeObject(forKey: "str_nationalitynew")
//                        UserDefaults.standard.removeObject(forKey: "nationalitynamestr")
//                        
//                       // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
//                        guard let index = checkarrayaoccunat.firstIndex(of: teststrclsnat) else { return }
//                        print(index)
//                         print("kityda:\(index)")
//                        
//                        var indexone = index
//                       // let firstName = AllArrayid[indexone]
//                        let firstName = checkarrayaoccunatstr[indexone]
//                        print("id selkityada:\(firstName)")
//                        str_nationality = firstName
//                        //print("id selkityadastr_natid:\(str_country_2_code)")
//                        
//                        
//                        
//                        self.nationalityBtn.setTitle("\(teststrclsnat)", for: .normal)
//                        self.nationalityBtn.setTitleColor(UIColor.black, for: .normal)
//                        nationalitynamestr = teststrclsnat
//                        
//                      //last
//                        natselserchstr = ""
//                    }
//                    else
//                    {
//
//                    nationalityBtn.setTitle("\(str)", for: .normal)
//                    self.nationalityBtn.setTitleColor(.black, for: .normal)
//                        UserDefaults.standard.removeObject(forKey: "nationalitynamestr")
//                        nationalitynamestr = nat.en_short_name
//                        self.str_nationality = nat.alpha_3_code
//                    }
//                }
//                
//                
//               // self.str_nationality = nat.alpha_3_code
//                
//                //nationalitynamestr = nat.en_short_name
//                
//                
//                
//                UserDefaults.standard.set(self.nationalitynamestr, forKey: "nationalitynamestr")
//                
//                nationalitySearchView.isHidden = true
//                tab2View.isHidden = false
            }
            else{
                let cell: CountryTableViewCell = self.tblNationality.cellForRow(at: indexPath) as! CountryTableViewCell
                let str: String = cell.countryLbl.text!
                let country = countryResArray[indexPath.row]
                self.str_country = country.description
                
//                nationalitynamestr = country.en_short_name
//
//                UserDefaults.standard.removeObject(forKey: "nationalitynamestr")
//
//                UserDefaults.standard.set(self.nationalitynamestr, forKey: "nationalitynamestr")

                
                //hided
                let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                var image = UIImage(named: "box")
                let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                 if appLang == "ar" || appLang == "ur"
                 {
                    countryResiBtn.setTitle("\(str)", for: .normal)
                     countryResiBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                     self.countryResiBtn.setTitleColor(.black, for: .normal)
                 }
                 else
                 {
                    countryResiBtn.setTitle("\(str)", for: .normal)
                     self.countryResiBtn.setTitleColor(.black, for: .normal)
                }
                
                
                
                nationalitySearchView.isHidden = true
                tab2View.isHidden = false
            }
            
            print("str_countrynationalityfinaly",str_nationality)
            print("str_countrynationality1finaly",str_dualNationality)
            
            let bottomOffset = CGPoint(x: 0, y: 180)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
        else if(tableView == tblMunicipality)
        {
            
            if munsibtnnselstr == "munsibtnnselstr"
          {
            
            
            let cell: LabelTableViewCell = self.tblMunicipality.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            
            //hided
            let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
            var image = UIImage(named: "box")
            let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
             if appLang == "ar" || appLang == "ur"
             {
                municipalityBtn.setTitle("\(str)", for: .normal)
                municipalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                 self.municipalityBtn.setTitleColor(.black, for: .normal)
            }
            else
             {
                municipalityBtn.setTitle("\(str)", for: .normal)
                self.municipalityBtn.setTitleColor(.black, for: .normal)
            }
            
            municipalitySearchView.isHidden = true
            tab2View.isHidden = false
            let municipality = municipalityArray[indexPath.row]
            self.municipality_id = municipality.id
            print("munsiidd",self.municipality_id)
           // self.zoneBtn.setTitle("Zone", for: .normal)
            self.zoneBtn.setTitle(NSLocalizedString("zone", comment: ""), for: .normal)
            self.zoneArray.removeAll()
            self.tblZone.reloadData()
            self.getZone(id: municipality.id, searchText: "")
            
            
                let bottomOffset = CGPoint(x: 0, y: 290)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                scrollView.setContentOffset(bottomOffset, animated: true)
            
            }
            
             if occupationselstr == "occubtnselstr"
             
             {
                 
                 if occupationselsearchstr == "searchcliked"
                 {
                     let cell: LabelTableViewCell = self.tblMunicipality.cellForRow(at: indexPath) as! LabelTableViewCell
                                       let str: String = cell.label.text!
                                       
                                       //hided
                                       let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                                       var image = UIImage(named: "box")
                                       let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                                        if appLang == "ar" || appLang == "ur"
                                        {
                                          // municipalityBtn.setTitle("\(str)", for: .normal)
                                          // municipalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                                       }
                                       else
                                        {
                                            //municipalityBtn.setTitle("\(str)", for: .normal)
                                            occupationTextField.text = str
                                            
                                    }
                                       
                                       municipalitySearchView.isHidden = true
                                       tab2View.isHidden = false
                                       let municipality = municipalityArray[indexPath.row]
                                       self.municipality_idoccupationid = municipality.id
                                         print("seloccupationiddsearch",self.municipality_idoccupationid)
                     teststrcls = searchedArray[indexPath.row]
                                     print("selectednamesearch",teststrcls)
                     
                     
                     
                     
                    // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                     guard let index = checkarrayaoccu.firstIndex(of: teststrcls) else { return }
                     print(index)
                      print("kityda:\(index)")
                     
                     var indexone = index
                    // let firstName = AllArrayid[indexone]
                     let firstName = checkarrayaoccustr[indexone]
                     print("id selkityada:\(firstName)")
                     str_occupation = firstName
                     print("id selkityadastr_occupation:\(str_occupation)")
                     
                     str_occupationname = teststrcls
                     
                     UserDefaults.standard.removeObject(forKey: "str_occupationname")
                     
                     UserDefaults.standard.set(self.str_occupationname, forKey: "str_occupationname")
                     
                     let bottomOffset = CGPoint(x: 0, y: 650)
                     //OR
                     //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                     scrollView.setContentOffset(bottomOffset, animated: true)

                                      // self.zoneBtn.setTitle("Zone", for: .normal)
                                       //self.zoneArray.removeAll()
                                       //self.tblZone.reloadData()
                                       //self.getZone(id: municipality.id, searchText: "")
                                    
                                         occupationselsearchstr = ""
                 
                   
             
                 }

                 
                 else
                 {
                
                   let cell: LabelTableViewCell = self.tblMunicipality.cellForRow(at: indexPath) as! LabelTableViewCell
                   let str: String = cell.label.text!
                   
                   //hided
                   let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                   var image = UIImage(named: "box")
                   let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                    if appLang == "ar" || appLang == "ur"
                    {
                      // municipalityBtn.setTitle("\(str)", for: .normal)
                      // municipalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                   }
                   else
                    {
                        //municipalityBtn.setTitle("\(str)", for: .normal)
                        occupationTextField.text = str
                        
                }
                   
                   municipalitySearchView.isHidden = true
                   tab2View.isHidden = false
                   let municipality = municipalityArray[indexPath.row]
                   self.municipality_idoccupationid = municipality.id
                     print("occupationidd",self.municipality_idoccupationid)
                
                     self.str_occupation = municipality.ge_city_name
                print("str_occupationmm",str_occupation)
                  // self.zoneBtn.setTitle("Zone", for: .normal)
                   //self.zoneArray.removeAll()
                   //self.tblZone.reloadData()
                   //self.getZone(id: municipality.id, searchText: "")
                 str_occupationname = municipality.ge_city_name
                 
                 UserDefaults.standard.removeObject(forKey: "str_occupationname")
                 
                 UserDefaults.standard.set(self.str_occupationname, forKey: "str_occupationname")
                 
                 let bottomOffset = CGPoint(x: 0, y: 650)
                 //OR
                 //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                 scrollView.setContentOffset(bottomOffset, animated: true)
            }
                 
             }
            
          if  actualoccupationselstr == "actualoccupationselstr"
          {
             
              
              if occupationselsearchstr == "searchcliked"
              {
                  let cell: LabelTableViewCell = self.tblMunicipality.cellForRow(at: indexPath) as! LabelTableViewCell
                                    let str: String = cell.label.text!
                                    
                                    //hided
                                    let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                                    var image = UIImage(named: "box")
                                    let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                                     if appLang == "ar" || appLang == "ur"
                                     {
                                       // municipalityBtn.setTitle("\(str)", for: .normal)
                                       // municipalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                                    }
                                    else
                                     {
                                         //municipalityBtn.setTitle("\(str)", for: .normal)
                                        actualoccutextfd.text = str
                                         
                                 }
                                    
                                    municipalitySearchView.isHidden = true
                                    tab2View.isHidden = false
                                    let municipality = municipalityArray[indexPath.row]
                  self.str_actualoccupation = municipality.ge_city_name
                                      print("selactualoccupationiddsearch",self.municipality_idoccupationid)
                  teststrcls = searchedArray[indexPath.row]
                                  print("selectednamesearch",teststrcls)
                  
                  
                  
                  
                 // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                  guard let index = checkarrayaoccu.firstIndex(of: teststrcls) else { return }
                  print(index)
                   print("kityda:\(index)")
                  
                  var indexone = index
                 // let firstName = AllArrayid[indexone]
                  let firstName = checkarrayaoccustr[indexone]
                  print("id selkityada:\(firstName)")
                  str_actualoccupation = firstName
                  print("id selkityadastr_actualoccupation:\(str_actualoccupation)")
                  str_actualoccupationname = teststrcls
                  
                  UserDefaults.standard.removeObject(forKey: "str_actualoccupationname")
                  
                  UserDefaults.standard.set(self.str_actualoccupationname, forKey: "str_actualoccupationname")
                  
                  let bottomOffset = CGPoint(x: 0, y: 670)
                  //OR
                  //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                  scrollView.setContentOffset(bottomOffset, animated: true)

                  
                                   // self.zoneBtn.setTitle("Zone", for: .normal)
                                    //self.zoneArray.removeAll()
                                    //self.tblZone.reloadData()
                                    //self.getZone(id: municipality.id, searchText: "")
                                 
                                      occupationselsearchstr = ""
              
                
          
              }

              else
              {
                let cell: LabelTableViewCell = self.tblMunicipality.cellForRow(at: indexPath) as! LabelTableViewCell
                let str: String = cell.label.text!
                
                //hided
                let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                var image = UIImage(named: "box")
                let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                 if appLang == "ar" || appLang == "ur"
                 {
                   // municipalityBtn.setTitle("\(str)", for: .normal)
                   // municipalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                }
                else
                 {
                     //municipalityBtn.setTitle("\(str)", for: .normal)
                     actualoccutextfd.text = str
                     
             }
                
                municipalitySearchView.isHidden = true
                tab2View.isHidden = false
                let municipality = municipalityArray[indexPath.row]
               // self.municipality_idoccupationid = municipality.id
                 // print("occupationidd",self.municipality_idoccupationid)
             
                  self.str_actualoccupation = municipality.ge_city_name
             print("str_actualoccupation",str_actualoccupation)
               // self.zoneBtn.setTitle("Zone", for: .normal)
                //self.zoneArray.removeAll()
                //self.tblZone.reloadData()
                //self.getZone(id: municipality.id, searchText: "")
              
              str_actualoccupationname = municipality.ge_city_name
              
              UserDefaults.standard.removeObject(forKey: "str_actualoccupationname")
              
              UserDefaults.standard.set(self.str_actualoccupationname, forKey: "str_actualoccupationname")
              
              let bottomOffset = CGPoint(x: 0, y: 670)
              //OR
              //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
              scrollView.setContentOffset(bottomOffset, animated: true)
              
          }
         }
            
            
        }
        else if(tableView == tblZone)
        {
          
            
            let cell: LabelTableViewCell = self.tblZone.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            let zone = zoneArray[indexPath.row]
            
            //hided
            let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
            var image = UIImage(named: "box")
            let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
            if appLang == "ar" || appLang == "ur"
            {
                zoneBtn.setTitle("\(str)", for: .normal)
                zoneBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                self.zoneBtn.setTitleColor(.black, for: .normal)
            }
            else
            {
                zoneBtn.setTitle("\(str)", for: .normal)
                self.zoneBtn.setTitleColor(.black, for: .normal)
            }
            //
            
            if zoneselserchstr == "searchcliked"
            {
                let cell: LabelTableViewCell = self.tblZone.cellForRow(at: indexPath) as! LabelTableViewCell
                
                
                teststrclszone = searchedArrayzone[indexPath.row]
                                print("selectednamesearch",teststrclsnat)
                
                
          
                
               // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                guard let index = checkarrayaoccuzone.firstIndex(of: teststrclszone) else { return }
                print(index)
                 print("kityda:\(index)")
                
                var indexone = index
               // let firstName = AllArrayid[indexone]
                let firstName = checkarrayaoccuzonestr[indexone]
                print("id selkityada:\(firstName)")
                str_zone = firstName
                //print("id selkityadastr_natid:\(str_country_2_code)")
                
                
                zoneBtn.setTitle("\(str)", for: .normal)
               // self.zoneBtn.setTitle("\(teststrclsnat)", for: .normal)
                self.zoneBtn.setTitleColor(UIColor.black, for: .normal)
                
                
              //last
                zoneselserchstr = ""
            }
            else
            {
                self.str_zone = zone.zone
                zoneBtn.setTitle("\(str)", for: .normal)
               // self.zoneBtn.setTitle("\(teststrclsnat)", for: .normal)
                self.zoneBtn.setTitleColor(UIColor.black, for: .normal)


            }
            
            //
            
            
            print("zonefinaly",str_zone)
            
            zoneSearchView.isHidden = true
            tab2View.isHidden = false
            
            let bottomOffset = CGPoint(x: 0, y: 300)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)

            
        }
        else if(tableView == tblsecQues)
        {
            let cell: LabelTableViewCell = self.tblsecQues.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            secQuesBtn.setTitle("\(str)", for: .normal)
            secQuesBtn.intrinsicContentSize
            secQuesView.isHidden = true
            tab3View.isHidden = false
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == idNumTextField)
        {
            let maxLength = 11
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == mobileTextField)
        {
            let maxLength = 8
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == pinTextField)
        {
            let maxLength = 4
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == passwTextField || textField == retypePasswTextField)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == nationalityTextField)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == municipalitySearchTextField)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == zoneSearchTextField)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
//        else if(textField == fullNameArTextField)
//        {
//            let maxLength = 50
//            let currentString: NSString = textField.text as! NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }
        
        return Bool()
    }
    func adjustUITextViewHeight(arg : UITextView)
        {
            arg.translatesAutoresizingMaskIntoConstraints = true
            arg.sizeToFit()
            arg.isScrollEnabled = false
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
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    func convertToAttributedString() -> NSAttributedString? {
        let modifiedFontString = "<span style=\"font-family: helvetica neue; font-size: 16;\">" + self + "</span>"
        return modifiedFontString.htmlToAttributedString // color: rgb(60, 60, 60)
    }
    
}
class ResizableButton: UIButton {
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)

        return desiredButtonSize
    }
}
extension String {

    func removeExtraSpacesregister() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }

}

extension String {

    func removeExtraSpacesregisternumbernospace() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: "", options: .regularExpression, range: nil)
    }

}

//
//switch response.result{
//case .success:
//    
//case .failure:
//    break
//}
