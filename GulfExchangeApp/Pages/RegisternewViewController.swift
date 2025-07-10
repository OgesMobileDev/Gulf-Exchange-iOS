//
//  RegisternewViewController.swift
//  GulfExchangeApp
//
//  Created by MacBook Pro on 9/2/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class RegisternewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var munsibtnnselstr:String = ""
    var occupationselstr:String = ""
    
    
    
    @IBOutlet var emptyview: UIView!
    
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

    
    
    @IBOutlet weak var personal_infoLbl: UILabel!
    @IBOutlet weak var fullNameEnTextField: UITextField!
    @IBOutlet weak var fullNameArTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var secondNationalityBtn: UIButton!
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
    var str_working_address:String = ""
    var str_income:String = ""
    var str_reg_no:String = ""
    var str_zone:String = ""
    var strMobile:String = ""
    var nationalityFlagPath:String = ""
    var municipality_id:String = ""
    
      var municipality_idoccupationid:String = ""
    
    var nationalityArray:[Country] = []
    var countryResArray:[Country] = []
    var checkCountry:Int = 0
    var checkNationality:Int = 0
    var municipalityArray:[City] = []
    var zoneArray:[Zone] = []
    var secQuesArray:[SecurityQuestion] = []
    var checkGender:Int = 0
    
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
        
        
        
        
        self.emptyview.isHidden = true
        
        
        
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
       // self.genderBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didRecognizeTapGesture(_:)))

       occupationTextField.addGestureRecognizer(tapGesture)
        
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
            secondNationalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
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
        
        idTypeBtn.layer.cornerRadius = 5
        idTypeBtn.layer.borderWidth = 1
        idTypeBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        idIssuerBtn.layer.cornerRadius = 5
        idIssuerBtn.layer.borderWidth = 0.8
        idIssuerBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        nationalityBtn.layer.cornerRadius = 5
        nationalityBtn.layer.borderWidth = 0.8
        nationalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        secondNationalityBtn.layer.cornerRadius = 5
        secondNationalityBtn.layer.borderWidth = 0.8
        secondNationalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        countryResiBtn.layer.cornerRadius = 5
        countryResiBtn.layer.borderWidth = 0.8
        countryResiBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        municipalityBtn.layer.cornerRadius = 5
        municipalityBtn.layer.borderWidth = 0.8
        municipalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        zoneBtn.layer.cornerRadius = 5
        zoneBtn.layer.borderWidth = 0.8
        zoneBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        genderBtn.layer.cornerRadius = 5
        genderBtn.layer.borderWidth = 0.8
        genderBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        secQuesBtn.layer.cornerRadius = 5
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
        }
    
    
    @objc private dynamic func didRecognizeTapGesture(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        
        
        occupationselstr = "occubtnselstr"
        munsibtnnselstr = ""
        print("benfi---","55554")
       //do
     tab2View.isHidden = true
        municipalitySearchView.isHidden = false
        scrollView.setContentOffset(.zero, animated: true)
        self.municipalitySearchTextField.text = ""
       // getMunicipality(searchText: "")
        self.getMunicipalityoccupation(searchText: "")
        self.municipalitySearchTextField.isHidden = true
        
        //self.getCountryoccupation(searchText: "")
        
        guard gesture.state == .ended, occupationTextField.frame.contains(point) else { return }

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
            }
            else if(textField == nationalityTextField)
            {
                if(nationalityTextField.text?.count == 0)
                {
                    view.endEditing(true)
                    getCountry(searchText: "")
                    
                }
            }
            else if(textField ==  municipalitySearchTextField)
            {
                if(municipalitySearchTextField.text?.count == 0)
                {
                    getMunicipality(searchText: "")
                }
            }
            else if(textField == zoneSearchTextField)
            {
                if(zoneSearchTextField.text?.count == 0)
                {
                    getZone(id: self.municipality_id, searchText: "")
                }
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
            if(nationalityTextField.text?.count != 0)
            {
                self.getCountry(searchText: self.nationalityTextField.text!)
            }
        }
        else if(textField == municipalitySearchTextField)
        {
            if(municipalitySearchTextField.text?.count != 0)
            {
                self.getMunicipality(searchText: self.municipalitySearchTextField.text!)
            }
        }
        else if(textField == zoneSearchTextField)
        {
            if(zoneSearchTextField.text?.count != 0)
            {
                self.getZone(id: self.municipality_id, searchText: self.zoneSearchTextField.text!)
            }
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
       //setTab(tabNo: 2)
        //scrollView.setContentOffset(.zero, animated: true)
        
        
        setTab(tabNo: 3)
        scrollView.setContentOffset(.zero, animated: true)
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
                self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func next1Btn(_ sender: Any) {
        setTab(tabNo: 3)
        scrollView.setContentOffset(.zero, animated: true)
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
    
    @IBAction func secondNationalityBtn(_ sender: Any) {
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
        
             self.municipalitySearchTextField.isHidden = false
        
    }
    @IBAction func zoneBtn(_ sender: Any) {
        if(municipalityBtn.titleLabel?.text == "Municipality" || municipality_id == "")
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_municipality", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            tab2View.isHidden = true
            zoneSearchView.isHidden = false
            scrollView.setContentOffset(.zero, animated: true)
            self.zoneSearchTextField.text = ""
            getZone(id: self.municipality_id, searchText: "")
        }
        
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
                    
            
            
        }
    }
    @IBAction func genderBtn(_ sender: Any) {
        genderView.isHidden = false
        tab2View.isHidden = true
    }
    @IBAction func secQuesBtn(_ sender: Any) {
        tab3View.isHidden = true
        secQuesView.isHidden = false
        scrollView.setContentOffset(.zero, animated: true)
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
////        let startingStringanswer = answerTextField.text!
////        let processedStringanswer = startingStringanswer.removeExtraSpacesregisternew()
////        print("processedStringanswer:\(processedStringanswer)")
////        answerTextField.text = processedStringanswer
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
//
//        //
//
        
        guard let passw = passwTextField.text,passwTextField.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck1)
        {}
        else{
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_length", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck2)
        {}
        else{
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must1", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck3)
        {}
        else{
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must2", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passCheck4)
        {}
        else{
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pass_must3", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        guard let retypwPassw = retypePasswTextField.text,retypePasswTextField.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("re_type_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(!passw.elementsEqual(retypwPassw))
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("password_mismatch", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        guard let pin = pinTextField.text,pinTextField.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(pin.count != 4)
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        ///
        
        var charSetpin = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2 = pin

        if let strvalue = string2.rangeOfCharacter(from: charSetpin)
        {
            print("true")


            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if (!validate (value: self.pinTextField.text!))
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        
        
        if(!termsClick)
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("read_terms", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        self.str_q1 = secQuesBtn.titleLabel?.text as! String
        self.str_a1 = answerTextField.text!
        self.str_passw = passwTextField.text!
        self.str_mpin = pinTextField.text!
        self.str_reg_no = registrationCodeTextField.text!
        
        
        defaults.set(str_idType, forKey: "id_type")
        defaults.set(str_id_issuer, forKey: "id_issuer")
        defaults.set(str_id_no, forKey: "id_no")
        defaults.set(str_id_exp_date, forKey: "id_exp_date")
        defaults.set(str_name_en, forKey: "name_en")
        defaults.set(str_name_ar, forKey: "name_ar")
        defaults.set(strEmail, forKey: "email")
        defaults.set(str_dob, forKey: "dob")
        defaults.set(str_nationality, forKey: "nationality")
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
        defaults.set(str_reg_no, forKey: "reg_code")
        defaults.set(str_q1, forKey: "q1")
        defaults.set(str_a1, forKey: "a1")
        defaults.set(str_passw, forKey: "passw")
        defaults.set(str_mpin, forKey: "pin")
        
       // print("str_occupationnmmmmm",str_occupation)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "photo1") as! Photo1ViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
//
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "reg1") as! RegisterPage1ViewController
//               self.navigationController?.pushViewController(nextViewController, animated: true)
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
//            else if(idIssuerBtn.titleLabel?.text == NSLocalizedString("id_issuer", comment: ""))
//            {
//                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_id_issuer", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            }
           // else
           // {
                guard let idNum = idNumTextField.text,idNumTextField.text?.count != 0 else
                {
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                let count = idNumTextField.text?.count
                if(count != 11)
                {
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                
                var charSetidNum = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                var string2 = idNum

                if let strvalue = string2.rangeOfCharacter(from: charSetidNum)
                {
                    print("true")
 
      
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                if (!validate (value: self.idNumTextField.text!))
                {
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                    
                }
                
                
                
                guard let idExp = idExpDateTextField.text,idExpDateTextField.text?.count != 0 else
                {
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_exp_date", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
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
                
                self.getToken(num: 1)
           // }
        }
        else if(tabNo == 3)
        {
//            if(idTypeBtn.titleLabel?.text == NSLocalizedString("id_type", comment: ""))
//            {
//                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_id_type", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            }
//            else if(idIssuerBtn.titleLabel?.text == NSLocalizedString("id_issuer", comment: ""))
//            {
//                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_id_issuer", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            }
           // else
           // {
                guard let idNum = idNumTextField.text,idNumTextField.text?.count != 0 else
                {
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                let count = idNumTextField.text?.count
                if(count != 11)
                {
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                
                var charSetidNum = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                var string2 = idNum

                if let strvalue = string2.rangeOfCharacter(from: charSetidNum)
                {
                    print("true")
 
      
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                if (!validate (value: self.idNumTextField.text!))
                {
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                    
                }
                
                
                
                guard let idExp = idExpDateTextField.text,idExpDateTextField.text?.count != 0 else
                {
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_exp_date", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
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
                
                self.getToken(num: 3)
           // }
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
        secondNationalityBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        countryResiBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        municipalityBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        zoneBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        homeAddressTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        genderBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        countryCodeTextfield.font = UIFont(name: "OpenSans-Regular", size: 14)
        mobileTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        employerTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        expIncomeTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        workAddressTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        occupationTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
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
        nationalityBtn.titleLabel?.font = nationalityBtn.titleLabel?.font.withSize(14)
        secondNationalityBtn.titleLabel?.font = secondNationalityBtn.titleLabel?.font.withSize(14)
        countryResiBtn.titleLabel?.font = countryResiBtn.titleLabel?.font.withSize(14)
        municipalityBtn.titleLabel?.font = municipalityBtn.titleLabel?.font.withSize(14)
        zoneBtn.titleLabel?.font = zoneBtn.titleLabel?.font.withSize(14)
        genderBtn.titleLabel?.font = genderBtn.titleLabel?.font.withSize(14)
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
        view.endEditing(true)
    }
    
    @objc func showdate1()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        dobTextField.text = dateFormat.string(from: datePicker1.date)
        print(dobTextField.text)
    
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
        
        RegisternewViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RegisternewViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("response",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            if(respCode == "S9001")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("id_exists", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        RegisternewViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            if(respCode == "E9000")
            {
                let RespMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: RespMsg, action: NSLocalizedString("ok", comment: ""))
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
            }
        
        })
    }
    func getCountry(searchText:String) {
        self.countryResArray.removeAll()
        self.nationalityArray.removeAll()
        self.tblNationality.reloadData()
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
                    self.nationalityArray.append(nationality)
                    if(nationality.alpha_2_code == "QA")
                    {
                        self.countryResArray.append(nationality)
                    }
                }
                self.tblNationality.reloadData()
                break
            case .failure:
                break
            }
          })
    }
    func getMunicipality(searchText:String) {
        
        self.municipalityArray.removeAll()
        self.tblMunicipality.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "city_listing"
        let params:Parameters = ["lang":"en","keyword":searchText]

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
        self.tblMunicipality.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "shiftservice/showOccupation"
       let params:Parameters = ["":""]

          RegisternewViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
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
                }
                self.tblMunicipality.reloadData()
              break
            case .failure:
                break
            }
          })
    }
    
    
    
    func getZone(id:String,searchText:String) {
        self.zoneArray.removeAll()
        self.tblZone.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.zoneArray.removeAll()
        let url = api_url + "zone_listing"
        let params:Parameters = ["municipality":id,"keyword":searchText]

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
            if(checkCountry == 0)
            {
                return nationalityArray.count
            }
            else
            {
                return countryResArray.count
            }
        }
        else if(tableView == tblMunicipality)
        {
            return municipalityArray.count
        }
        else if(tableView == tblZone)
        {
            return zoneArray.count
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
           if(checkCountry == 0)
           {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nationalityCell") as! CountryTableViewCell
                       let nationality = nationalityArray[indexPath.row]
//                       cell.setCountry(country: nationality)
                       
                       let code:String = nationality.alpha_2_code.lowercased()
                       let url = nationalityFlagPath + code + ".png"
                       //let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                        let imgResource = URL(string: url)
                       cell.flagImg.kf.setImage(with: imgResource)
                       return cell
            }
           else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "nationalityCell") as! CountryTableViewCell
                       let nationality = countryResArray[indexPath.row]
//                       cell.setCountry(country: nationality)
                       
                       let code:String = nationality.alpha_2_code.lowercased()
                       let url = nationalityFlagPath + code + ".png"
                       //let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
               let imgResource = URL(string: url)
               cell.flagImg.kf.setImage(with: imgResource)
                       return cell
            }
            
        }
        else if(tableView == tblMunicipality)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "municipalityCell") as! LabelTableViewCell
            let municipality = municipalityArray[indexPath.row]
            cell.label.text = municipality.ge_city_name
            return cell
        }
        else if(tableView == tblZone)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCell") as! LabelTableViewCell
            let zone = zoneArray[indexPath.row]
            cell.label.text = zone.zone
            return cell
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
                }
                else{
                    
                }
                let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                var image = UIImage(named: "box")
                let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                 if appLang == "ar" || appLang == "ur"
                 {
                    nationalityBtn.setTitle("\(str)", for: .normal)
                    nationalityBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                }
                else
                 {
                    nationalityBtn.setTitle("\(str)", for: .normal)
                }
                
                
                self.str_nationality = nat.alpha_3_code
                nationalitySearchView.isHidden = true
                tab2View.isHidden = false
            }
            else{
                let cell: CountryTableViewCell = self.tblNationality.cellForRow(at: indexPath) as! CountryTableViewCell
                let str: String = cell.countryLbl.text!
                let country = countryResArray[indexPath.row]
                self.str_country = country.alpha_3_code
                
                //hided
                let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                var image = UIImage(named: "box")
                let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                 if appLang == "ar" || appLang == "ur"
                 {
                    countryResiBtn.setTitle("\(str)", for: .normal)
                     countryResiBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                 }
                 else
                 {
                    countryResiBtn.setTitle("\(str)", for: .normal)
                }
                
                
                
                nationalitySearchView.isHidden = true
                tab2View.isHidden = false
            }
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
            }
            else
             {municipalityBtn.setTitle("\(str)", for: .normal)}
            
            municipalitySearchView.isHidden = true
            tab2View.isHidden = false
            let municipality = municipalityArray[indexPath.row]
            self.municipality_id = municipality.id
            print("munsiidd",self.municipality_id)
            self.zoneBtn.setTitle("Zone", for: .normal)
            self.zoneArray.removeAll()
            self.tblZone.reloadData()
            self.getZone(id: municipality.id, searchText: "")
            
            
            
            
            }
            
             if occupationselstr == "occubtnselstr"
             
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
            }
            
            
        }
        else if(tableView == tblZone)
        {
            let cell: LabelTableViewCell = self.tblZone.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            let zone = zoneArray[indexPath.row]
            self.str_zone = zone.zone
            
            //hided
            let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
            var image = UIImage(named: "box")
            let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
            if appLang == "ar" || appLang == "ur"
            {
                zoneBtn.setTitle("\(str)", for: .normal)
                zoneBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            }
            else
            {
                zoneBtn.setTitle("\(str)", for: .normal)
            }
            
            zoneSearchView.isHidden = true
            tab2View.isHidden = false
            
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
//
//extension String {
//    var htmlToAttributedStringnew: NSAttributedString? {
//        guard let data = data(using: .utf8) else { return NSAttributedString() }
//        do {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch {
//            return NSAttributedString()
//        }
//    }
//    var htmlToStringnew: String {
//        return htmlToAttributedString?.string ?? ""
//    }
//    func convertToAttributedStringnew() -> NSAttributedString? {
//        let modifiedFontString = "<span style=\"font-family: helvetica neue; font-size: 16;\">" + self + "</span>"
//        return modifiedFontString.htmlToAttributedString // color: rgb(60, 60, 60)
//    }
//
//}
//class ResizableButtonnew: UIButton {
//    override var intrinsicContentSize: CGSize {
//        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
//        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
//
//        return desiredButtonSize
//    }
//}
//extension String {
//
//    func removeExtraSpacesregisternew() -> String {
//        return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
//    }
//
//}
//
//extension String {
//
//    func removeExtraSpacesregisternumbernospacenew() -> String {
//        return self.replacingOccurrences(of: "[\\s\n]+", with: "", options: .regularExpression, range: nil)
//    }
//
//}
