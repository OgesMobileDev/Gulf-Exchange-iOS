//
//  RegisterIdDetails2VC.swift
//  GulfExchangeApp
//
//  Created by macbook on 02/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import AVKit
import Alamofire
import SwiftyJSON
import Kingfisher
import AVFoundation
import Photos
import Toast_Swift
import ScreenShield



class RegisterIdDetails2VC: UIViewController, RegistrationPopupViewDelegate, GenderSelectionPopupViewDelegate {
    
    
    
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectIdIssuer issuer: String?) {
        print("nil")
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectIdType type: String?) {
        print("nil")
    }
    

//    @IBOutlet weak var screenShootView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var emptyBtns: [UIButton]!
    @IBOutlet weak var personalInfoLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var fullNameArLbl: UILabel!
    @IBOutlet weak var fullNameArTF: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var nationalityLbl: UILabel!
    @IBOutlet weak var nationalityTF: UITextField!
    @IBOutlet weak var secNationalityLbl: UILabel!
    @IBOutlet weak var secNationalityTF: UITextField!
    @IBOutlet weak var zoneLbl: UILabel!
    @IBOutlet weak var zoneTF: UITextField!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var buildingLbl: UILabel!
    @IBOutlet weak var buildingTF: UITextField!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var mobileCodeTF: UITextField!
    @IBOutlet weak var employerLbl: UILabel!
    @IBOutlet weak var employerTF: UITextField!
    @IBOutlet weak var expIncomeLbl: UILabel!
    @IBOutlet weak var expIncomeTF: UITextField!
    @IBOutlet weak var workAddressLbl: UILabel!
    @IBOutlet weak var workAddressTF: UITextField!
    @IBOutlet weak var occupationLbl: UILabel!
    @IBOutlet weak var occupationTF: UITextField!
    @IBOutlet weak var actualOccLbl: UILabel!
    @IBOutlet weak var actualOccTF: UITextField!
    @IBOutlet weak var regCodeLbl: UILabel!
    @IBOutlet weak var regCodeTF: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextLbl: UILabel!
    
    @IBOutlet weak var dobBtn: UIButton!
    @IBOutlet weak var dobBgView: UIView!
    
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var nationalityBgView: UIView!
    
    @IBOutlet weak var secondnationalityBtn: UIButton!
    @IBOutlet weak var secondNationalityBgView: UIView!
    
    @IBOutlet weak var zoneBtn: UIButton!
    @IBOutlet weak var zoneBgView: UIView!
    
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var genderBgView: UIView!
    
    @IBOutlet weak var occupationBtn: UIButton!
    @IBOutlet weak var occupationBgView: UIView!
    
    @IBOutlet weak var actOccupationBtn: UIButton!
    @IBOutlet weak var actOccupationBgView: UIView!
    
    @IBOutlet weak var mobileBaseView: UIView!
    @IBOutlet weak var mobileHeightConstraint: NSLayoutConstraint!
    
    var isRegisteredCust:String =  ""
    var currentDropdownSelection:RegistrationDropDownSelection = .QID
    let datePicker = UIDatePicker()
    let defaults = UserDefaults.standard
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
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
    var userAge:Double?
    var expdatestr:String = ""
    var checkstr:String = ""
    
    var str_actualoccupation:String = ""
    var str_buildingno:String = ""
    var str_working_address:String = ""
    var str_income:String = ""
    var str_reg_no:String = ""
    var str_zone:String = ""
    var strMobile:String = ""
    var nationalityFlagPath:String = ""
    var municipality_id:String = ""
    
    var municipality_idoccupationid:String = ""
    
    var nationalityArray:[CasmexNationality] = []
    var countryResArray:[CasmexNationality] = []
    var checkCountry:Int = 0
    var municipalityArray:[CasmexNationality] = []
    var zoneArray:[Zone] = []
    var secQuesArray:[SecurityQuestion] = []
    var checkGender:Int = 0
    var idImageFrontData: Data?
    var idImageBackData: Data?
    var idImageSelfieVideoData: Data?
    
    let popUpView = Bundle.main.loadNibNamed("GenderSelectionPopupView", owner: RegisterIdDetails2VC.self, options: nil)?.first as! GenderSelectionPopupView
    let popUpView1 = Bundle.main.loadNibNamed("RegistrationPopupView", owner: RegisterIdDetails2VC.self, options: nil)?.first as! RegistrationPopupView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.delegate = self
        popUpView1.delegate = self
        mobileTF.delegate = self
        addNavbar()
        setView()
        setRegView()
        nextBtn.setTitle("", for: .normal)
        configureLabel(label: nextLbl, text: (NSLocalizedString("next", comment: "")), size: 16, font: .medium)
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
               let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               if appLang == "ar" || appLang == "ur" {
                   fullNameTF.textAlignment = .right
                   fullNameArTF.textAlignment = .right
                   emailTF.textAlignment = .right
                   dobTF.textAlignment = .right
                   nationalityTF.textAlignment = .right
                   secNationalityTF.textAlignment = .right
                   zoneTF.textAlignment = .right
                   streetTF.textAlignment = .right
                   buildingTF.textAlignment = .right
                   genderTF.textAlignment = .right
                   mobileTF.textAlignment = .right
                   mobileCodeTF.textAlignment = .right
                   employerTF.textAlignment = .right
                   expIncomeTF.textAlignment = .right
                   workAddressTF.textAlignment = .right
                   occupationTF.textAlignment = .right
                   actualOccTF.textAlignment = .right
                   regCodeTF.textAlignment = .right
               } else {
                   fullNameTF.textAlignment = .left
                   fullNameArTF.textAlignment = .left
                   emailTF.textAlignment = .left
                   dobTF.textAlignment = .left
                   nationalityTF.textAlignment = .left
                   secNationalityTF.textAlignment = .left
                   zoneTF.textAlignment = .left
                   streetTF.textAlignment = .left
                   buildingTF.textAlignment = .left
                   genderTF.textAlignment = .left
                   mobileTF.textAlignment = .left
                   mobileCodeTF.textAlignment = .left
                   employerTF.textAlignment = .left
                   expIncomeTF.textAlignment = .left
                   workAddressTF.textAlignment = .left
                   occupationTF.textAlignment = .left
                   actualOccTF.textAlignment = .left
                   regCodeTF.textAlignment = .left
               }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        ScreenShield.shared.protect(view: screenShootView)
                ScreenShield.shared.protect(view: nextBtn)
                ScreenShield.shared.protect(view: nextLbl)
                
                ScreenShield.shared.protect(view: self.fullNameTF)
                ScreenShield.shared.protect(view: self.fullNameArTF)
                ScreenShield.shared.protect(view: self.mobileTF)
                ScreenShield.shared.protect(view: self.emailTF)
                ScreenShield.shared.protect(view: self.nationalityTF)
                ScreenShield.shared.protect(view: self.genderTF)
                ScreenShield.shared.protect(view: self.secNationalityTF)
                ScreenShield.shared.protect(view: self.dobTF)
                ScreenShield.shared.protect(view: self.zoneTF)
                ScreenShield.shared.protect(view: self.streetTF)
                ScreenShield.shared.protect(view: self.buildingTF)
                ScreenShield.shared.protect(view: self.occupationTF)
                ScreenShield.shared.protect(view: self.actualOccTF)
                ScreenShield.shared.protect(view: self.employerTF)
                ScreenShield.shared.protect(view: self.expIncomeTF)
                ScreenShield.shared.protect(view: self.workAddressTF)
                ScreenShield.shared.protect(view: self.regCodeTF)
                ScreenShield.shared.protect(view: self.mobileCodeTF)
                ScreenShield.shared.protectFromScreenRecording()
    }
    
    //MARK: - Button Functions
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        validateFields()
        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterPasswordVC") as! RegisterPasswordVC
//        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func nationalityBtnTapped(_ sender: Any) {
        currentDropdownSelection = .nationality
        if nationalityArray.isEmpty{
            self.getCountry()
        }else{
            addPopUp()
        }
    }
    @IBAction func secondnationalityBtnTapped(_ sender: Any) {
        currentDropdownSelection = .secondNationality
        if nationalityArray.isEmpty{
            self.getCountry()
        }else{
            addPopUp()
        }
    }
    @IBAction func zoneBtnTapped(_ sender: Any) {
        currentDropdownSelection = .zone
        if zoneArray.isEmpty{
            self.getZone()
        }else{
            addPopUp()
        }
    }
    @IBAction func genderBtnTapped(_ sender: Any) {
        showGenderPopup()
    }
    @IBAction func occupationBtnTapped(_ sender: Any) {
        currentDropdownSelection = .occupation
        if municipalityArray.isEmpty{
            self.getMunicipalityoccupation()
        }else{
            addPopUp()
        }
    }
    @IBAction func actOccupationBtnTapped(_ sender: Any) {
        currentDropdownSelection = .actualOcc
        if municipalityArray.isEmpty{
            self.getMunicipalityoccupation()
        }else{
            addPopUp()
        }
    }
    //MARK: - Popups
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
    
    func GenderSelectionPopupView(_ vc: GenderSelectionPopupView, isMale: Bool) {
        if isMale{
            genderTF.text = "Male"
            self.checkGender = 1
        }else{
            genderTF.text = "Female"
            self.checkGender = 2
        }
    }
    func addPopUp(){
        popUpView1.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpView1.alpha = 0.0
        popUpView1.currentSelection = self.currentDropdownSelection
        popUpView1.searchTF.text?.removeAll()
        switch currentDropdownSelection {
        case .QID:
            print("none")
        case .idIssuer:
            print("none")
        case .nationality:
            popUpView1.nationalityArray = self.nationalityArray
            popUpView1.searchCountry = self.nationalityArray
        case .secondNationality:
            popUpView1.secNationalityArray = self.nationalityArray
            popUpView1.searchCountry = self.nationalityArray
        case .zone:
            popUpView1.zoneArray = self.zoneArray
            popUpView1.searchZone = self.zoneArray
        case .occupation:
            popUpView1.occupationArray = self.municipalityArray
            popUpView1.searchOccupation = self.municipalityArray
        case .actualOcc:
            popUpView1.actualOccArray = self.municipalityArray
            popUpView1.searchOccupation = self.municipalityArray
        }
        popUpView1.setupTableView()
        popUpView1.baseTableView.reloadData()
        
        view.addSubview(popUpView1)
        print("PopUpView")
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView1.alpha = 1.0
        })
    }
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectCountry country: CasmexNationality?) {
        nationalityTF.text = country?.description
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectSecondCountry secondCountry: CasmexNationality?) {
        secNationalityTF.text = secondCountry?.description
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectZone zone: Zone?) {
        zoneTF.text = zone?.zone
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectOccupation occupation: CasmexNationality?) {
        occupationTF.text = occupation?.description
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectActualOccupation actualOccupation: CasmexNationality?) {
        actualOccTF.text = actualOccupation?.description
    }
    
    
    
    //MARK: - Functions
    
    func setView(){
        
        occupationTF.isUserInteractionEnabled = false
        actualOccTF.isUserInteractionEnabled = false
        zoneTF.isUserInteractionEnabled = false
        nationalityTF.isUserInteractionEnabled = false
        secNationalityTF.isUserInteractionEnabled = false
        mobileTF.keyboardType = .phonePad
        streetTF.keyboardType = .numberPad
        for btn in emptyBtns{
            btn.setTitle("", for: .normal)
        }
        self.nextBtn.setTitle(NSLocalizedString("next", comment: ""), for: .normal)
        nextLbl.text = NSLocalizedString("next", comment: "")
        personalInfoLbl.text = NSLocalizedString("personal_info", comment: "")
        nationalityTF.delegate = self
        secNationalityTF.delegate = self
        zoneTF.delegate = self
        occupationTF.delegate = self
        actualOccTF.delegate = self
        mobileCodeTF.isUserInteractionEnabled = false
        genderTF.isUserInteractionEnabled = false
        expIncomeTF.keyboardType = .numberPad
        buildingTF.keyboardType = .numberPad
        //rgba(232, 233, 233, 1)
        fullNameTF.layer.borderWidth = 0.8
        fullNameTF.layer.cornerRadius = 4
        fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        emailTF.layer.borderWidth = 0.8
        emailTF.layer.cornerRadius = 4
        emailTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        dobBgView.layer.borderWidth = 0.8
        dobBgView.layer.cornerRadius = 4
        dobBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        zoneBgView.layer.borderWidth = 0.8
        zoneBgView.layer.cornerRadius = 4
        zoneBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        nationalityBgView.layer.borderWidth = 0.8
        nationalityBgView.layer.cornerRadius = 4
        nationalityBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        secondNationalityBgView.layer.borderWidth = 0.8
        secondNationalityBgView.layer.cornerRadius = 4
        secondNationalityBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        streetTF.layer.borderWidth = 0.8
        streetTF.layer.cornerRadius = 4
        streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        buildingTF.layer.borderWidth = 0.8
        buildingTF.layer.cornerRadius = 4
        buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        genderBgView.layer.borderWidth = 0.8
        genderBgView.layer.cornerRadius = 4
        genderBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        employerTF.layer.borderWidth = 0.8
        employerTF.layer.cornerRadius = 4
        employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        expIncomeTF.layer.borderWidth = 0.8
        expIncomeTF.layer.cornerRadius = 4
        expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        workAddressTF.layer.borderWidth = 0.8
        workAddressTF.layer.cornerRadius = 4
        workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        occupationBgView.layer.borderWidth = 0.8
        occupationBgView.layer.cornerRadius = 4
        occupationBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        actOccupationBgView.layer.borderWidth = 0.8
        actOccupationBgView.layer.cornerRadius = 4
        actOccupationBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        fullNameArTF.layer.borderWidth = 0.8
        fullNameArTF.layer.cornerRadius = 4
        fullNameArTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        mobileTF.layer.borderWidth = 0.8
        mobileTF.layer.cornerRadius = 4
        mobileTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        mobileCodeTF.layer.borderWidth = 0.8
        mobileCodeTF.layer.cornerRadius = 4
        mobileCodeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        //localized
        setLabelWithAsterisk(label: self.nationalityLbl, text: NSLocalizedString("nationality", comment: ""))
        setLabelWithAsterisk(label: self.genderLbl, text: NSLocalizedString("gender", comment: ""))
        setLabelWithAsterisk(label: self.dobLbl, text: NSLocalizedString("dob", comment: ""))
        setLabelWithAsterisk(label: self.workAddressLbl, text: NSLocalizedString("working_add", comment: ""))
        setLabelWithAsterisk(label: self.occupationLbl, text: NSLocalizedString("occupation", comment: ""))
        setLabelWithAsterisk(label: self.actualOccLbl, text: NSLocalizedString("ActualOccupation", comment: ""))
        setLabelWithAsterisk(label: self.employerLbl, text: NSLocalizedString("employer", comment: ""))
        setLabelWithAsterisk(label: self.expIncomeLbl, text: NSLocalizedString("exp_income", comment: ""))
        setLabelWithAsterisk(label: self.fullNameLbl, text: NSLocalizedString("fullname_en", comment: ""))
        setLabelWithAsterisk(label: self.zoneLbl, text: NSLocalizedString("zone", comment: ""))
        setLabelWithAsterisk(label: self.streetLbl, text: NSLocalizedString("Street", comment: ""))
        setLabelWithAsterisk(label: self.buildingLbl, text: NSLocalizedString("BuildingNumber", comment: ""))
        setLabelWithAsterisk(label: self.emailLbl, text: NSLocalizedString("email", comment: ""))
        setLabelWithAsterisk(label: self.mobileLbl, text: NSLocalizedString("mobile_no", comment: ""))

        self.regCodeLbl.text = (NSLocalizedString("reg_code", comment: ""))
        self.fullNameArLbl.text = (NSLocalizedString("fullname_ar", comment: ""))
        self.secNationalityLbl.text = (NSLocalizedString("dualnationality", comment: ""))
    }
    
    func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "Identity Details"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func setRegView(){
        isRegisteredCust =  defaults.string(forKey: "neworexistcuststr") ?? ""
        if isRegisteredCust == "B"{
            mobileBaseView.isHidden = true
            mobileHeightConstraint.constant = 0
            
            if let name_en = defaults.value(forKey: "name_en") as? String{
                fullNameTF.text = name_en
            }
//            if let dob = defaults.value(forKey: "shufti_dob_conv") as? String{
//                dobTF.text = dob
                
            if let dob = defaults.value(forKey: "shufti_dob") as? String{
                let dob1 = convertDateFormat(from:  dob)
                dobTF.isUserInteractionEnabled = false
                dobBtn.isUserInteractionEnabled = false
                dobTF.text = dob1
            }
            if let name_ar = defaults.value(forKey: "name_ar") as? String{
                fullNameArTF.text = name_ar
            }
//            if let shufti_nationality = defaults.value(forKey: "shufti_nationality") as? String{
//                nationalityTF.text = shufti_nationality
//            }
            if let email = defaults.value(forKey: "email") as? String{
                emailTF.text = email
            }
            if let gender = defaults.value(forKey: "gender") as? String{
                if gender == "Male"{
                    genderTF.text = "Male"
                    self.checkGender = 1
                }else if gender == "Female"{
                    self.str_gender = "Female"
                    self.checkGender = 2
                }
            }
            if let nationality = defaults.value(forKey: "nationality") as? String{
                nationalityTF.text = nationality
                nationalityBtn.isUserInteractionEnabled = false
            }
            if let nationality = defaults.value(forKey: "shufti_nationality") as? String{
                nationalityTF.text = nationality
                nationalityBtn.isUserInteractionEnabled = false
            }
            if let dualNationality = defaults.value(forKey: "dualNationality") as? String{
                secNationalityTF.text = dualNationality
            }
            if let home_addr = defaults.value(forKey: "home_addr") as? String{
                streetTF.text = home_addr
            }
            if let employer = defaults.value(forKey: "employer") as? String{
                employerTF.text = employer
            }
            if let income = defaults.value(forKey: "income") as? String{
                expIncomeTF.text = income
            }
            if let work_addr = defaults.value(forKey: "work_addr") as? String{
                workAddressTF.text = work_addr
            }
            if let occupation = defaults.value(forKey: "occupation") as? String{
                occupationTF.text = occupation
            }
            if let str_actualoccupation = defaults.value(forKey: "str_actualoccupation") as? String{
                actualOccTF.text = str_actualoccupation
            }
            
        }else if isRegisteredCust == "N"{
            mobileBaseView.isHidden = false
            mobileHeightConstraint.constant = 80
            
            if let name_en = defaults.value(forKey: "name_en") as? String{
                fullNameTF.text = name_en
            }
            if let dob = defaults.value(forKey: "shufti_dob") as? String{
                let dob1 = convertDateFormat(from:  dob)
                dobTF.text = dob1
                dobTF.isUserInteractionEnabled = false
                dobBtn.isUserInteractionEnabled = false
            }
            if let name_ar = defaults.value(forKey: "name_ar") as? String{
                fullNameArTF.text = name_ar
            }
//            if let shufti_nationality = defaults.value(forKey: "shufti_nationality") as? String{
//                nationalityTF.text = shufti_nationality
//            }
            if let email = defaults.value(forKey: "email") as? String{
                emailTF.text = email
            }
            if let gender = defaults.value(forKey: "gender") as? String{
                if gender == "Male"{
                    genderTF.text = "Male"
                    self.checkGender = 1
                }else if gender == "Female"{
                    self.str_gender = "Female"
                    self.checkGender = 2
                }
            }
            if let nationality = defaults.value(forKey: "nationality") as? String{
                nationalityTF.text = nationality
                nationalityBtn.isUserInteractionEnabled = false
            }
            if let nationality = defaults.value(forKey: "shufti_nationality") as? String{
                nationalityTF.text = nationality
                nationalityBtn.isUserInteractionEnabled = false
            }
            if let dualNationality = defaults.value(forKey: "dualNationality") as? String{
                secNationalityTF.text = dualNationality
            }
            if let home_addr = defaults.value(forKey: "home_addr") as? String{
                streetTF.text = home_addr
            }
            if let employer = defaults.value(forKey: "employer") as? String{
                employerTF.text = employer
            }
            if let income = defaults.value(forKey: "income") as? String{
                expIncomeTF.text = income
            }
            if let work_addr = defaults.value(forKey: "work_addr") as? String{
                workAddressTF.text = work_addr
            }
            if let occupation = defaults.value(forKey: "occupation") as? String{
                occupationTF.text = occupation
            }
            if let str_actualoccupation = defaults.value(forKey: "str_actualoccupation") as? String{
                actualOccTF.text = str_actualoccupation
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
    func createToolbar(){
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
        let today = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -89, to: today)!
        dobTF.inputView = datePicker
    }
    @objc func showdate()
    {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd-MM-yyyy"
        dobTF.text = dateFormat.string(from: datePicker.date)
             
    //        let dateFormat = DateFormatter()
    //        dateFormat.dateFormat = "yyyy-MM-dd"
    //        self.qidexpdatestr = dateFormat.string(from: datePicker.date)
    //
    //
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let showDate = inputFormatter.string(from: datePicker.date)
//            self.qidexpdatestr = inputFormatter.string(from: datePicker.date)
            //inputFormatter.dateFormat = "yyyy-MM-dd"
           // let resultString = inputFormatter.string(from: showDate)
//            print(self.qidexpdatestr)
            
            
            view.endEditing(true)
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
    
    // MARK: phone no Validation :
    func validate(value: String) -> Bool {
        //let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let PHONE_REGEX = "^[0-9]{0,15}$"
        //let PHONE_REGEX = "[a-zA-z]"
        
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func validateFields(){
        
        print("check gender",checkGender)
        
        //new

        

        var str = fullNameTF.text
                str = str!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                print(str)
                // "this is the answer"
                print("strii",str)
                fullNameTF.text =  str
                print("striifullNameTF.text",fullNameTF.text)
                
        
        
        
        //extraspace remove
        let startingString = fullNameTF.text!
        let processedString = startingString.removeExtraSpacesregister()
        print("processedString:\(processedString)")
        fullNameTF.text = processedString
        
        
        //new
        
        //new
        if fullNameTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.fullNameTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        
        self.fullNameTF.layer.borderWidth = 0.8
        self.fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        
        guard let nameEn = fullNameTF.text,fullNameTF.text?.count != 0 else
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
//            print("check name",self.fullNameTF.text)
        
        let bottomOffset = CGPoint(x: 0, y: 0)
        //OR
        //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
        
        
        self.fullNameTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
            self.fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }


        
        self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
        



//
        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
        return
    }
        else
        {
            self.fullNameTF.layer.borderWidth = 0.8
            self.fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }
      
        
        if (!validate (value: self.fullNameTF.text!))
        {
            self.fullNameTF.layer.borderWidth = 0.8
            self.fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

            
        }
        else
        {
//              let alert = UIAlertController(title: "Alert", message: "Please enter valid name", preferredStyle: UIAlertController.Style.alert)
//              alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//              self.present(alert, animated: true, completion: nil)
//              print("check name",self.fullNameTF.text)
            
          //  alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            
            
            self.fullNameTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }


            
            self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
            
            
            
            return
        }
        
        //fullname arabic
        
        var strfullnamear = fullNameArTF.text
        strfullnamear = strfullnamear!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strfullnamear)
        // "this is the answer"
        print("strefullnamear",strfullnamear)
        fullNameArTF.text =  strfullnamear
        
        //extraspace remove
        let startingStringnamear = fullNameArTF.text!
        let processedStringnamear = startingStringnamear.removeExtraSpacesregister()
        print("processedString:\(processedStringnamear)")
        fullNameArTF.text = processedStringnamear
        
        
        var stremail = emailTF.text
        stremail = stremail!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(stremail)
        // "this is the answer"
        print("striistremail",stremail)
        emailTF.text =  stremail
        print("emailTF.text",emailTF.text)

        
        
        //new
        if emailTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.emailTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.emailTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        
        self.emailTF.layer.borderWidth = 0.8
        self.emailTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        
        guard let email = emailTF.text,emailTF.text?.count != 0 else
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
            
            self.emailTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.emailTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            
            return
        }
        else
        {
            self.emailTF.layer.borderWidth = 0.8
            self.emailTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }
        
        //new
        if dobTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.dobBgView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.dobBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        
            self.dobBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        
        guard let dob = dobTF.text,dobTF.text?.count != 0 else
        {
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_dob", comment: ""), action: NSLocalizedString("ok", comment: ""))
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            self.view.makeToast(NSLocalizedString("enter_dob", comment: ""), duration: 3.0, position: .center)
            
            return
        }
    let dobString = dobTF.text // Format: "dd-MM-yyyy"

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"

    guard let dob1 = dateFormatter.date(from: dobString!) else {
        self.view.makeToast("Invalid date format.", duration: 3.0, position: .center)
        
        self.dobBgView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
            self.dobBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        return
    }

    // Calculate the date 18 years ago from today
    let currentDate = Date()
    let calendar = Calendar.current
    guard let eighteenYearsAgo = calendar.date(byAdding: .year, value: -18, to: currentDate) else {
        return
    }

    // Compare dob with eighteenYearsAgo
    if dob1 > eighteenYearsAgo {
        // User is under 18 years old
        self.view.makeToast(NSLocalizedString("invalid_dob", comment: ""), duration: 3.0, position: .center)
        
        self.dobBgView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
            self.dobBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        return
    } else {
        self.dobBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
    }
    /*
        if self.userAge ?? 0.0 < 18.0{
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("invalid_dob", comment: ""), action: NSLocalizedString("ok", comment: ""))
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            self.view.makeToast(NSLocalizedString("invalid_dob", comment: ""), duration: 3.0, position: .center)
            
            self.dobTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.dobTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            return
        }
        else
        {
            self.dobTF.layer.borderWidth = 0.8
            self.dobTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }
        */
        if(nationalityTF.text?.isEmpty == true)
        {
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            let bottomOffset = CGPoint(x: 0, y: 30)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            self.view.makeToast(NSLocalizedString("sel_nationality", comment: ""), duration: 3.0, position: .center)

            self.nationalityBgView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.nationalityBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            return
        }
        
        else
        {
            self.nationalityBgView.layer.borderWidth = 0.8
            self.nationalityBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }
        
        
        /*
        if(secNationalityTF.text?.isEmpty == true)
        {
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            let bottomOffset = CGPoint(x: 0, y: 30)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            self.view.makeToast(NSLocalizedString("seldualnationality", comment: ""), duration: 3.0, position: .center)

            self.secondNationalityBgView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.secondNationalityBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            return
        }
        
        else
        {
            self.secondNationalityBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }
        */
//            if(countryResiBtn.titleLabel?.text == NSLocalizedString("country_of_residence", comment: ""))
//            {
//                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                return
//            }
        //new chnages
        
        

        
        
    self.str_city = "-"
        
        if(zoneTF.text?.isEmpty == true)
        {
            let bottomOffset = CGPoint(x: 0, y: 30)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            self.str_zone = "-"
            print("strr_zonee",str_zone)
            //self.view.makeToast(NSLocalizedString("enter_zone", comment: ""), duration: 3.0, position: .center)
            self.view.makeToast("Please select zone", duration: 3.0, position: .center)
            
            self.zoneBgView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.zoneBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_zone", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            self.zoneBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }


        
        
        
        
        
        var strhomeadress = streetTF.text
        strhomeadress = strhomeadress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strhomeadress)
        // "this is the answer"
        print("strhomeadress",strhomeadress)
        streetTF.text =  strhomeadress
        print("streetTF.text",streetTF.text)
        
        
        //extraspace remove
        let startingStringhomeadress = streetTF.text!
        let processedStringhomeaddress = startingStringhomeadress.removeExtraSpacesregister()
        print("processedStringhomeadress:\(processedStringhomeaddress)")
        streetTF.text = processedStringhomeaddress
        
        
        //new
        if streetTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.streetTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        
        self.streetTF.layer.borderWidth = 0.8
        self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        
        
        
        if ((streetTF.text ?? "").isEmpty)
        {
            // is empty
            str_address = ""
            print("strhomeadressempty",str_address)
        }

        guard let homeAddr = streetTF.text,streetTF.text?.count != 0 else
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
        var string2homeAddr = streetTF.text!

        if let strvalue = string2homeAddr.rangeOfCharacter(from: charSethomeAddr)
        {
            print("true")
//                let alert = UIAlertController(title: "Alert", message: "Please enter valid home adress", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                print("check name",self.fullNameTF.text)
//

           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid home adress", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            let bottomOffset = CGPoint(x: 0, y: 350)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            //self.view.makeToast(NSLocalizedString("Please enter valid home adress", comment: ""), duration: 3.0, position: .center)
            self.view.makeToast("Please enter valid Street", duration: 3.0, position: .center)
            
            self.streetTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }


                          return

        }
        else
        {
            self.streetTF.layer.borderWidth = 0.8
            self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        if (!validate (value: self.streetTF.text!))
        {
            
            self.view.makeToast("Please enter valid Street", duration: 3.0, position: .center)
            
            let bottomOffset = CGPoint(x: 0, y: 350)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            self.streetTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        else
        {
            self.streetTF.layer.borderWidth = 0.8
            self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }

        
      

        
     
        if buildingTF.text?.isEmpty == true
        {
            // is empty
            let bottomOffset = CGPoint(x: 0, y: 350)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.view.makeToast("Please enter building number", duration: 3.0, position: .center)
            
            self.buildingTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            return
        }
        else
        {
            self.buildingTF.layer.borderWidth = 0.8
            self.buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        
        //
        var charSetbuildno = CharacterSet.init(charactersIn: "@#$%+_&'()*,-/:;<=>?[]^`{|}~)(")
        var string2buildno = buildingTF.text!

        if let strvalue = string2buildno.rangeOfCharacter(from: charSetbuildno)
        {
            print("true")
//                let alert = UIAlertController(title: "Alert", message: "Please enter valid home adress", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                print("check name",self.fullNameTF.text)
//

           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid home adress", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            let bottomOffset = CGPoint(x: 0, y: 350)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            //self.view.makeToast(NSLocalizedString("Please enter valid home adress", comment: ""), duration: 3.0, position: .center)
            self.view.makeToast("Please enter valid building number", duration: 3.0, position: .center)
            
            self.buildingTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }


                          return

        }
     else
        {
         self.buildingTF.layer.borderWidth = 0.8
         self.buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

     }
        
        if (!validate (value: self.buildingTF.text!))
        {
            
            let bottomOffset = CGPoint(x: 0, y: 350)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            self.view.makeToast("Please enter valid building number", duration: 3.0, position: .center)
            
            self.buildingTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        else
        {
            self.buildingTF.layer.borderWidth = 0.8
            self.buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

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

            
            self.genderBgView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.genderBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            return
        }
        else
        {
            self.genderBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }
        
    if isRegisteredCust == "N"{
        var strmobile = mobileTF.text
        strmobile = strmobile!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strmobile)
        // "this is the answer"
        print("strmobile",strmobile)
        mobileTF.text =  strmobile
        print("mobileTF.text",mobileTF.text)
        
        //extra space trim
        //extraspace remove
        let startingStringmobile = mobileTF.text!
        let processedStringmobile = startingStringmobile.removeExtraSpacesregisternumbernospace()
        print("processedStringmobile:\(processedStringmobile)")
        mobileTF.text = processedStringmobile
        
        
        
        
        //new
        if mobileTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.mobileTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.mobileTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        
        self.mobileTF.layer.borderWidth = 0.8
        self.mobileTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        guard let mobile = mobileTF.text,mobileTF.text?.count != 0 else
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

            
            self.mobileTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.mobileTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            self.view.makeToast(NSLocalizedString("enter_valid_mob", comment: ""), duration: 3.0, position: .center)

            
            return
        }
        else
        {
            self.mobileTF.layer.borderWidth = 0.8
            self.mobileTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
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
                        
                        self.mobileTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                            self.mobileTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                        }

                        
                        self.view.makeToast(NSLocalizedString("Please enter valid mobile number", comment: ""), duration: 3.0, position: .center)
                        
                      //  alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                        
                    }
        else
        {
            self.mobileTF.layer.borderWidth = 0.8
            self.mobileTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        if (!validate (value: self.mobileTF.text!))
        {
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            let bottomOffset = CGPoint(x: 0, y: 440)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            self.mobileTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.mobileTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            
            self.view.makeToast(NSLocalizedString("Please enter valid mobile number", comment: ""), duration: 3.0, position: .center)

            return
            
        }
        else
        {
            self.mobileTF.layer.borderWidth = 0.8
            self.mobileTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }
    }
        
        var stremployername = employerTF.text
        stremployername = stremployername!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(stremployername)
        // "this is the answer"
        print("stremployername",stremployername)
        employerTF.text =  stremployername
        print("employerTF.text",employerTF.text)
        
        
        //extraspace remove
        let startingStringemployer = employerTF.text!
        let processedStringemployer = startingStringemployer.removeExtraSpacesregister()
        print("processedStringemployer:\(processedStringemployer)")
        employerTF.text = processedStringemployer
        
        
        //new
        if employerTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.employerTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        
        self.employerTF.layer.borderWidth = 0.8
        self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        
        
        guard let employer = employerTF.text,employerTF.text?.count != 0 else
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
//                    print("check name",self.fullNameTF.text)
//
                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid employer", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 460)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.employerTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }

                
                self.view.makeToast(NSLocalizedString("Please enter valid employer", comment: ""), duration: 3.0, position: .center)

                return
                
            }
        else
        {
            self.employerTF.layer.borderWidth = 0.8
            self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        
        if (!validate (value: self.employerTF.text!))
        {
            self.employerTF.layer.borderWidth = 0.8
            self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            
        }
        else
        {
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid employer", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            let bottomOffset = CGPoint(x: 0, y: 460)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            
            
            self.employerTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            self.view.makeToast(NSLocalizedString("Please enter valid employer", comment: ""), duration: 3.0, position: .center)

            
            return
        }
        
        
        
        
        var strexpxetedincome = expIncomeTF.text
        strexpxetedincome = strexpxetedincome!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strexpxetedincome)
        // "this is the answer"
        print("strexpxetedincome",strexpxetedincome)
        expIncomeTF.text =  strexpxetedincome
        print("expIncomeTF.text",expIncomeTF.text)
        
        
        //extraspace remove
        //extraspace remove
        let startingStringexpincome = expIncomeTF.text!
        let processedStringexpincome = startingStringexpincome.removeExtraSpacesregisternumbernospace()
        print("processedStringexpincome:\(processedStringexpincome)")
        expIncomeTF.text = processedStringexpincome
        
        
        
        //new
        if expIncomeTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.expIncomeTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        
        self.expIncomeTF.layer.borderWidth = 0.8
        self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        
        guard let expIncome = expIncomeTF.text,expIncomeTF.text?.count != 0 else
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
            
            self.expIncomeTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            self.view.makeToast(NSLocalizedString("enter_exp_income", comment: ""), duration: 3.0, position: .center)

            return
                       
        }
        else
        {
            self.expIncomeTF.layer.borderWidth = 0.8
            self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }
        
        //
        if (!validate (value: self.expIncomeTF.text!))
        {
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            let bottomOffset = CGPoint(x: 0, y: 480)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.expIncomeTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }

            
            self.view.makeToast(NSLocalizedString("enter_exp_income", comment: ""), duration: 3.0, position: .center)

            
            return
            
        }
        else
        {
            self.expIncomeTF.layer.borderWidth = 0.8
            self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor

        }
    
        var stroccupation = occupationTF.text
        stroccupation = stroccupation!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(stroccupation)
        // "this is the answer"
        print("stroccupation",stroccupation)
        occupationTF.text =  stroccupation
        print("occupationTF.text",occupationTF.text)
        
        
        
        //new
        if occupationTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.occupationBgView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.occupationBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        
        self.occupationBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        guard let occupation = occupationTF.text,occupationTF.text?.count != 0 else
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
        if actualOccTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.actOccupationBgView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.actOccupationBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        

        self.actOccupationBgView.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        guard let actualoccupation = actualOccTF.text,actualOccTF.text?.count != 0 else
        {
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Select Actual Occupation", action: NSLocalizedString("ok", comment: ""))
            
            
            let bottomOffset = CGPoint(x: 0, y: 560)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)

            
            self.view.makeToast(NSLocalizedString("Select Actual Occupation", comment: ""), duration: 3.0, position: .center)
            return
        }

        
        var strworkadress = workAddressTF.text
        strworkadress = strworkadress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strworkadress)
        // "this is the answer"
        print("strworkadress",strworkadress)
        workAddressTF.text =  strworkadress
        print("workAddressTF.text",workAddressTF.text)
        
        
        
        //extraspace remove
        let startingStringworkaddress = workAddressTF.text!
        let processedStringworkaddress = startingStringworkaddress.removeExtraSpacesregister()
        print("processedStringworkaddress:\(processedStringworkaddress)")
        workAddressTF.text = processedStringworkaddress
        
        
        
        
        
        //new
        if workAddressTF.text?.isEmpty == true
        {
           // timer.invalidate()
            self.workAddressTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
        
        self.workAddressTF.layer.borderWidth = 0.8
        self.workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        
        guard let workAddress = workAddressTF.text,workAddressTF.text?.count != 0 else
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
            print("check name",self.workAddressTF.text)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
            
            let bottomOffset = CGPoint(x: 0, y: 500)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.workAddressTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }


            
            self.view.makeToast(NSLocalizedString("Please enter valid working address", comment: ""), duration: 3.0, position: .center)
            return
                       
        }
        else
        {
            self.workAddressTF.layer.borderWidth = 0.8
            self.workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        

        var strregcode = regCodeTF.text
        strregcode = strregcode!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strregcode)
        // "this is the answer"
        print("strexpxetedincome",strregcode)
        regCodeTF.text =  strregcode
        print("expIncomeTF.text",regCodeTF.text)
        
        
        //extraspace remove
        //extraspace remove
        let startingStringregcodee = regCodeTF.text!
        let processedStringregcodee = startingStringregcodee.removeExtraSpacesregisternumbernospace()
        print("processedStringregcode:\(processedStringregcodee)")
        regCodeTF.text = processedStringregcodee
        

        
        
        
        //new
        //(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var charSetregcode = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2regcode = regCodeTF.text!

            if let strvalue = string2regcode.rangeOfCharacter(from: charSetregcode)
            {
                print("true")
//                    let alert = UIAlertController(title: "Alert", message: "Please enter valid employer", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                    print("check name",self.fullNameTF.text)
//
                
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid employer", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
                let bottomOffset = CGPoint(x: 0, y: 460)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.regCodeTF.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.regCodeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
                }

                self.view.makeToast("Please enter valid registration code", duration: 3.0, position: .center)
                //self.view.makeToast(NSLocalizedString("Please enter valid employer", comment: ""), duration: 3.0, position: .center)

                return
                
            }
        else
        {
            self.regCodeTF.layer.borderWidth = 0.8
            self.regCodeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }

        
        
        
        
        self.str_name_en = nameEn
        self.str_name_ar = fullNameArTF.text!
        self.strEmail = email
        self.str_dob = dob
        self.str_address = streetTF.text!
        
        self.str_city = "-"
        
        if(checkGender == 1)
        {
            self.str_gender = "Male"
        }
        if(checkGender == 2)
        {
            self.str_gender = "Female"
        }
        else {
            
        }
    
    if isRegisteredCust == "N"{
        self.strMobile = "974" + (mobileTF.text ?? "")
    }else{
        self.strMobile = "974" + (defaults.string(forKey: "regCustNum") ?? "")
    }
    
    
    self.str_idType = defaults.string(forKey: "id_type") ?? ""
    self.str_id_issuer = defaults.string(forKey: "id_issuer") ?? ""
    self.str_id_no = defaults.string(forKey: "id_no") ?? ""
    self.str_id_exp_date = defaults.string(forKey: "id_exp_date") ?? ""
    
    
    self.str_name_en = fullNameTF.text!
    self.str_name_ar = fullNameArTF.text ?? ""
    self.strEmail = emailTF.text!
    self.str_dob = dobTF.text!
    self.str_nationality = nationalityTF.text!
    self.str_dualNationality = secNationalityTF.text!
    self.str_country = ""
    self.str_city = "-"
    self.str_zone = zoneTF.text!
    self.str_address = streetTF.text!
    self.str_employer = employerTF.text!
    self.str_income = expIncomeTF.text!
    self.str_working_address = workAddressTF.text!
    self.str_occupation = occupationTF.text!
    self.str_actualoccupation = actualOccTF.text!
    self.str_buildingno = buildingTF.text!
    self.str_reg_no = regCodeTF.text ?? ""
    self.str_employer = employerTF.text!
    self.str_income = expIncomeTF.text!
    self.str_working_address = workAddressTF.text!
    
//        self.defaults.removeObject(forKey: "id_type")
//        self.defaults.removeObject(forKey: "id_issuer")
//        self.defaults.removeObject(forKey: "id_no")
//        self.defaults.removeObject(forKey: "id_exp_date")
    self.defaults.removeObject(forKey: "name_en")
    self.defaults.removeObject(forKey: "name_ar")
    self.defaults.removeObject(forKey: "email")
    self.defaults.removeObject(forKey: "dob")
    self.defaults.removeObject(forKey: "nationalityname")
    self.defaults.removeObject(forKey: "nationality")
    self.defaults.removeObject(forKey: "dualnationalityname")
    self.defaults.removeObject(forKey: "dualNationality")
    self.defaults.removeObject(forKey: "nationalitynamestr1")
    self.defaults.removeObject(forKey: "country")
    self.defaults.removeObject(forKey: "municipality")
    self.defaults.removeObject(forKey: "zone")
    self.defaults.removeObject(forKey: "home_addr")
    self.defaults.removeObject(forKey: "gender")
    self.defaults.removeObject(forKey: "mobile")
    self.defaults.removeObject(forKey: "employer")
    self.defaults.removeObject(forKey: "income")
    self.defaults.removeObject(forKey: "work_addr")
    self.defaults.removeObject(forKey: "occupation")
    self.defaults.removeObject(forKey: "str_occupationname")
    self.defaults.removeObject(forKey: "str_actualoccupation")
    self.defaults.removeObject(forKey: "str_occupationname")
    self.defaults.removeObject(forKey: "str_buildingno")
    self.defaults.removeObject(forKey: "reg_code")
    
    
   
    
    
    
//        self.defaults.set(self.str_idType, forKey: "id_type")
//        self.defaults.set(self.str_id_issuer, forKey: "id_issuer")
//        self.defaults.set(self.str_id_no, forKey: "id_no")
//        self.defaults.set(self.str_id_exp_date, forKey: "id_exp_date")
    self.defaults.set(self.str_name_en, forKey: "name_en")
    self.defaults.set(self.str_name_ar, forKey: "name_ar")
    self.defaults.set(self.strEmail, forKey: "email")
    self.defaults.set(self.str_dob, forKey: "dob")
    self.defaults.set(self.str_nationality, forKey: "nationalityname")
    self.defaults.set(self.str_nationality, forKey: "nationality")
    self.defaults.set(self.str_dualNationality, forKey: "dualnationalityname")
    self.defaults.set(self.str_dualNationality, forKey: "dualNationality")
    self.defaults.set(self.str_dualNationality, forKey: "nationalitynamestr1")
    self.defaults.set(self.str_country, forKey: "country")
    self.defaults.set(self.str_city, forKey: "municipality")
    self.defaults.set(self.str_zone, forKey: "zone")
    self.defaults.set(self.str_address, forKey: "home_addr")
    self.defaults.set(self.str_gender, forKey: "gender")
    self.defaults.set(self.strMobile, forKey: "mobile")
    self.defaults.set(self.str_employer, forKey: "employer")
    self.defaults.set(self.str_income, forKey: "income")
    self.defaults.set(self.str_working_address, forKey: "work_addr")
    self.defaults.set(self.str_occupation, forKey: "occupation")
    self.defaults.set(self.str_occupation, forKey: "str_occupationname")
    self.defaults.set(self.str_actualoccupation, forKey: "str_actualoccupation")
    self.defaults.set(self.str_actualoccupation, forKey: "str_actualoccupationname")
    self.defaults.set(self.str_buildingno, forKey: "str_buildingno")
    self.defaults.set(self.str_reg_no, forKey: "reg_code")
     
    
    
    
        getToken(num: 3)
    
}
    
    //MARK: - API Calls
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
//        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
//        let str_encode_val = auth_client_id + ":" + auth_client_secret
//        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
//        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("tokenResp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("accresss toceke\(token)")
                if(num == 1)
                {
//                    self.idValidation(access_token: token)
                }
                else if(num == 3)
                {
                    self.validateEmailMobile(accessToken: token)
                }
                else if(num == 4)
                {
//                    self.branchcustapi(access_token: token)
                }
                break
            case .failure:
                break
            }
        })
    }
    
    func validateEmailMobile(accessToken:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":"","customerPassword":"","mpin":"","customerEmail":self.strEmail,"customerMobile":self.strMobile,"customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"MOBILE_EMAIL","isExistOrValid":"0"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            if(respCode == "E9000" || respCode == "EC2300")
            {
                let RespMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: RespMsg, action: NSLocalizedString("ok", comment: ""))
            }
            else{
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterPasswordVC") as! RegisterPasswordVC
                nextViewController.idImageFrontData = self.idImageFrontData
                nextViewController.idImageBackData = self.idImageBackData
                nextViewController.idImageSelfieVideoData = self.idImageSelfieVideoData
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        
        })
    }
    
    func getCountry() {
        self.countryResArray.removeAll()
        self.nationalityArray.removeAll()
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "casmex/getMasterDetails"
        let params:Parameters = ["type":"nationality"]
        print("urlcountry",url)
        print("paramscountry",params)

        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["data"]
                for i in resultArray.arrayValue{
                    let nationality = CasmexNationality(id: i["id"].stringValue, description: i["description"].stringValue)
                    self.nationalityArray.append(nationality)
                    if(nationality.description == "QATAR")
                    {
                        self.countryResArray.append(nationality)
                    }
                    
                }
                if !self.nationalityArray.isEmpty{
                    self.addPopUp()
                }
                break
            case .failure:
                break
            }
          })
    }
    
    func getMunicipality(searchText:String) {
        
        self.municipalityArray.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "city_listing"
        let params:Parameters = ["lang":"en","keyword":searchText]

        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["city_listing"]
                for i in resultArray.arrayValue{
                    let municipality = CasmexNationality(id: i["id"].stringValue, description: i["ge_city_name"].stringValue)
                    self.municipalityArray.append(municipality)
                }
                if !self.nationalityArray.isEmpty{
                    self.addPopUp()
                }
              break
            case .failure:
                break
            }
          })
    }
    
    func getMunicipalityoccupation() {
        
        self.municipalityArray.removeAll()
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "casmex/getMasterDetails"
        let params:Parameters =  [
            "type":"profession"
        ]

        
        print("urloccuand actualoccu",url)
        print("paramsoccuandactualoccu",params)

        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
                     print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                //let resultArray = myResult!["city_listing"]
                 let resultArray = myResult!["data"]
                for i in resultArray.arrayValue{
                    let municipality = CasmexNationality(id: i["id"].stringValue, description: i["description"].stringValue)
                    self.municipalityArray.append(municipality)
                    
                }
                if !self.municipalityArray.isEmpty{
                    self.addPopUp()
                }
              break
            case .failure:
                break
            }
          })
    }
    
    func getZone() {
        self.zoneArray.removeAll()
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.zoneArray.removeAll()
        let url = api_url + "zone_listing"
        //let params:Parameters = ["municipality":id,"keyword":searchText]
        let params:Parameters = ["municipality":""]

        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
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
                if !self.zoneArray.isEmpty{
                    self.addPopUp()
                }
              break
            case .failure:
                break
            }
          })
    }
    
    
}


extension RegisterIdDetails2VC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == mobileTF)
        {
            let maxLength = 8
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return Bool()
    }
}
