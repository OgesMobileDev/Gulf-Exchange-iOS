//
//  EditProfileVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 25/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
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

enum EditProfileDropDownSelection{
    case nationality
    case secondNationality
    case zone
    case occupation
    case actualOcc
    case idIssuer
}



class EditProfileVC: UIViewController, GenderSelectionPopupViewDelegate, EditProfilePopupViewDelegate{
   
    
    
    //MARK: - Variable Declaration
    @IBOutlet weak var screenShootView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet var hideLbls: [UILabel]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var emptyBtns: [UIButton]!
    @IBOutlet weak var personalInfoLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var fullNameArLbl: UILabel!
    @IBOutlet weak var fullNameArTF: UITextField!
//    @IBOutlet weak var emailLbl: UILabel!
//    @IBOutlet weak var emailTF: UITextField!
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
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var genderBgView: UIView!
//    @IBOutlet weak var mobileLbl: UILabel!
//    @IBOutlet weak var mobileTF: UITextField!
//    @IBOutlet weak var mobileCodeTF: UITextField!
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
    
//    @IBOutlet weak var idDetailsView: pro\\\!
    
    @IBOutlet weak var idDetailsView: UIView!
    @IBOutlet weak var idImagesView: UIView!
    @IBOutlet weak var idDetailsLbl: UILabel!
    @IBOutlet weak var idIssuerLbl: UILabel!
    @IBOutlet weak var idIssuerTF: UITextField!
    @IBOutlet weak var idExpLbl: UILabel!
    @IBOutlet weak var idExpTF: UITextField!
    @IBOutlet weak var idTypeLbl: UILabel!
    @IBOutlet weak var idTypeTF: UITextField!
    @IBOutlet weak var idNumberLbl: UILabel!
    @IBOutlet weak var idNumberTF: UITextField!
    @IBOutlet weak var idFrontLbl: UILabel!
    @IBOutlet weak var idFrontImg: UIImageView!
    @IBOutlet weak var idBackLbl: UILabel!
    @IBOutlet weak var idBackImg: UIImageView!
    @IBOutlet weak var idUpdateBtnView: UIView!
    @IBOutlet weak var idUpdateBtn: UIButton!
    @IBOutlet weak var idUpdateLbl: UILabel!
    @IBOutlet weak var idDetailsHeight: NSLayoutConstraint!
    
    
    let popUpView = Bundle.main.loadNibNamed("GenderSelectionPopupView", owner: self, options: nil)?.first as! GenderSelectionPopupView
    let popUpView1 = Bundle.main.loadNibNamed("EditProfilePopupView", owner: self, options: nil)?.first as! EditProfilePopupView
    
    let playerViewController = AVPlayerViewController()
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    
    var str_id_issuer:String = ""
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
    var str_employer:String = ""
    var str_occupation:String = ""
    var str_actualoccupation:String = ""
    var str_occupationtext:String = ""
    var str_working_address:String = ""
    var str_buildingnotxtfd:String = ""
    var str_income:String = ""
    var str_zone:String = ""
    var str_regCode:String = ""
    var strMobile:String = ""
    var dualnationalityselstr:String = ""
//    no change
    var str_customerBirthPlace:String = ""
    var str_customerIDIssuedCountry:String = ""
    var str_customerFirstName:String = ""
    var str_customerLastName:String = ""
    var str_customerMiddleName:String = ""
    var str_customerPhone :String = ""
    var str_customerZipCode :String = ""
    var str_visaExpiryDate :String = ""
    var str_visaIssuedBy :String = ""
    var str_visaIssuedDate :String = ""
    var str_visaNo :String = ""
    var str_visaType :String = ""
    var str_workingAddress3 :String = ""
    
    var photoviewinputstr:String = ""
    var currentDropdownSelection:EditProfileDropDownSelection = .nationality
    var tapGesture = UITapGestureRecognizer()
    var nationalityArray:[CasmexNationality] = []
    var secNationalityArray:[CasmexNationality] = []
    var countryResArray:[CasmexNationality] = []
    var zoneArray:[Zone] = []
    var occupationArray:[City] = []
    var actualOccArray:[City] = []
    var checkarrayaoccustr  = Array<String>()
    var checkarrayaoccu  = Array<String>()
    var teststrcls : String = ""
    var checkCountry:Int = 0
    var nationalityFlagPath:String = ""
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    var userAge:Double?
    var udid:String!
    var natselserchstr:String = ""
    var checkarrayaoccunatstr  = Array<String>()
    var checkarrayaoccunat  = Array<String>()
    var teststrclsnat : String = ""
    var searchedArraynat:[String] = Array()
    
    //zonesearch
    var zoneselserchstr:String = ""
    var checkarrayaoccuzonestr  = Array<String>()
    var checkarrayaoccuzone  = Array<String>()
    var teststrclszone : String = ""
    var searchedArrayzone:[String] = Array()
    
    var strBase64videoProfile:String!
    var strBase64:String!
    var strBase641:String!
    var strBase642:String!
    var strBase64Selfie:String!
    
    var testfirstnamestr:String = ""
    var testlastnamestr:String = ""
    var testmiddlenamestr:String = ""
    var isIdView = false
    var isShuftiDone = false
    
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
    
    
    //MARK: - Vew LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        setView()
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
               let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               if appLang == "ar" || appLang == "ur" {
                   fullNameTF.textAlignment = .right
                   fullNameArTF.textAlignment = .right
//                   emailTF.textAlignment = .right
                   dobTF.textAlignment = .right
                   nationalityTF.textAlignment = .right
                   secNationalityTF.textAlignment = .right
                   zoneTF.textAlignment = .right
                   streetTF.textAlignment = .right
                   buildingTF.textAlignment = .right
                   genderTF.textAlignment = .right
//                   mobileTF.textAlignment = .right
//                   mobileCodeTF.textAlignment = .right
                   employerTF.textAlignment = .right
                   expIncomeTF.textAlignment = .right
                   workAddressTF.textAlignment = .right
                   occupationTF.textAlignment = .right
                   actualOccTF.textAlignment = .right
                   regCodeTF.textAlignment = .right
//                   idIssuerTF.textAlignment = .right
//                   idExpTF.textAlignment = .right
               } else {
                   fullNameTF.textAlignment = .left
                   fullNameArTF.textAlignment = .left
//                   emailTF.textAlignment = .left
                   dobTF.textAlignment = .left
                   nationalityTF.textAlignment = .left
                   secNationalityTF.textAlignment = .left
                   zoneTF.textAlignment = .left
                   streetTF.textAlignment = .left
                   buildingTF.textAlignment = .left
                   genderTF.textAlignment = .left
//                   mobileTF.textAlignment = .left
//                   mobileCodeTF.textAlignment = .left
                   employerTF.textAlignment = .left
                   expIncomeTF.textAlignment = .left
                   workAddressTF.textAlignment = .left
                   occupationTF.textAlignment = .left
                   actualOccTF.textAlignment = .left
                   regCodeTF.textAlignment = .left
//                   idIssuerTF.textAlignment = .left
//                   idExpTF.textAlignment = .left
               }
        popUpView.delegate = self
        popUpView1.delegate = self
        self.getToken(num: 1)
        getZone()
        fetchApis()
        createToolbar1()
        createToolbar()

        nextLbl.text = NSLocalizedString("next", comment: "")
        
        //localized
        setLabelWithAsterisk(label: self.nationalityLbl, text: NSLocalizedString("nationality", comment: ""))
        setLabelWithAsterisk(label: self.genderLbl, text: NSLocalizedString("gender", comment: ""))
        setLabelWithAsterisk(label: self.dobLbl, text: NSLocalizedString("dob", comment: ""))
        setLabelWithAsterisk(label: self.workAddressLbl, text: NSLocalizedString("working_add", comment: ""))
        setLabelWithAsterisk(label: self.occupationLbl, text: NSLocalizedString("occupation", comment: ""))
        setLabelWithAsterisk(label: self.actualOccLbl, text: NSLocalizedString("ActualOccupation", comment: ""))
        setLabelWithAsterisk(label: self.employerLbl, text: NSLocalizedString("employer", comment: ""))
        setLabelWithAsterisk(label: self.expIncomeLbl, text: NSLocalizedString("exp_income", comment: ""))
//        setLabelWithAsterisk(label: self.idExpLbl, text: NSLocalizedString("id_exp_date", comment: ""))
//        setLabelWithAsterisk(label: self.idIssuerLbl, text: NSLocalizedString("id_issuer", comment: ""))
        setLabelWithAsterisk(label: self.fullNameLbl, text: NSLocalizedString("fullname_en", comment: ""))
        setLabelWithAsterisk(label: self.zoneLbl, text: NSLocalizedString("zone", comment: ""))
        setLabelWithAsterisk(label: self.streetLbl, text: NSLocalizedString("Street", comment: ""))
        setLabelWithAsterisk(label: self.buildingLbl, text: NSLocalizedString("BuildingNumber", comment: ""))
        setLabelWithAsterisk(label: idTypeLbl, text: NSLocalizedString("id_type", comment: ""))
        setLabelWithAsterisk(label: idNumberLbl, text: NSLocalizedString("id_number", comment: ""))
        setLabelWithAsterisk(label: idIssuerLbl, text: NSLocalizedString("id_issuer", comment: ""))
        setLabelWithAsterisk(label: idExpLbl, text: NSLocalizedString("id_exp_date", comment: ""))
        self.regCodeLbl.text = (NSLocalizedString("reg_code", comment: ""))
        self.fullNameArLbl.text = (NSLocalizedString("fullname_ar", comment: ""))
        self.secNationalityLbl.text = (NSLocalizedString("dualnationality", comment: ""))
        /*
        self.mobileLbl.text = (NSLocalizedString("mobile_no", comment: ""))
        self.emailLbl.text = (NSLocalizedString("Email", comment: ""))
//        self.nationalityLbl.text = (NSLocalizedString("nationality", comment: ""))
        self.genderLbl.text = (NSLocalizedString("gender", comment: ""))
////        //self.user.text = (NSLocalizedString("mobile_no", comment: ""))
        self.dobLbl.text = (NSLocalizedString("dob", comment: ""))
//        self.addressLbl1.text = (NSLocalizedString("address", comment: ""))
        self.workAddressLbl.text = (NSLocalizedString("working_add", comment: ""))
        self.occupationLbl.text = (NSLocalizedString("occupation", comment: ""))
        self.actualOccLbl.text = (NSLocalizedString("ActualOccupation", comment: ""))
        self.employerLbl.text = (NSLocalizedString("employer", comment: ""))
        self.expIncomeLbl.text = (NSLocalizedString("exp_income", comment: ""))
//        self.idNumLbl1.text = (NSLocalizedString("id_number", comment: ""))
        self.idExpLbl.text = (NSLocalizedString("id_exp_date", comment: ""))
//        self.idTypeLbl1.text = (NSLocalizedString("id_type", comment: ""))
        self.idIssuerLbl.text = (NSLocalizedString("id_issuer", comment: ""))
//        self.idSelfieLbl.text = (NSLocalizedString("SelfieWithID", comment: ""))
//        self.idFrontLbl.text = (NSLocalizedString("IDFront", comment: ""))
//        self.idBackLbl.text = (NSLocalizedString("IDBack", comment: ""))
//        self.branchLbl1.text = (NSLocalizedString("UserBranch", comment: ""))
        self.fullNameLbl.text = (NSLocalizedString("fullname_en", comment: ""))
       
        self.zoneLbl.text = (NSLocalizedString("zone", comment: ""))
        self.streetLbl.text = (NSLocalizedString("Street", comment: ""))
        self.buildingLbl.text = (NSLocalizedString("BuildingNumber", comment: ""))
        self.regCodeLbl.text = (NSLocalizedString("reg_code", comment: ""))
        */
        regCodeTF.isUserInteractionEnabled = false
        setTxtToSpeech()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.udid = UIDevice.current.identifierForVendor!.uuidString
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
        for labl in hideLbls{
            ScreenShield.shared.protect(view: labl)
        }
        
//        ScreenShield.shared.protect(view: screenShootView)
        ScreenShield.shared.protect(view: nextBtn)
        ScreenShield.shared.protect(view: nextLbl)
        ScreenShield.shared.protect(view: idDetailsLbl)
        ScreenShield.shared.protect(view: idIssuerTF)
        ScreenShield.shared.protect(view: idExpTF)
        ScreenShield.shared.protect(view: idTypeTF)
        ScreenShield.shared.protect(view: idNumberTF)
        ScreenShield.shared.protect(view: idFrontImg)
        ScreenShield.shared.protect(view: idBackImg)
        
        
        ScreenShield.shared.protect(view: self.fullNameTF)
        ScreenShield.shared.protect(view: self.fullNameArTF)
//        ScreenShield.shared.protect(view: self.mobileTF)
//        ScreenShield.shared.protect(view: self.emailTF)
        ScreenShield.shared.protect(view: self.nationalityTF)
        ScreenShield.shared.protect(view: self.genderTF)
        ScreenShield.shared.protect(view: self.genderBgView)
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
//        ScreenShield.shared.protect(view: self.idExpTF)
        ScreenShield.shared.protect(view: self.regCodeTF)
//        ScreenShield.shared.protect(view: self.idIssuerTF)
//        ScreenShield.shared.protect(view: self.mobileCodeTF)
        ScreenShield.shared.protectFromScreenRecording()
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
    
    //MARK: - TextTo Speech
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fullNameLblTapped(_:)))
        fullNameLbl.isUserInteractionEnabled = true
        fullNameLbl.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(fullnameinarabicLblTapped(_:)))
        fullNameArLbl.isUserInteractionEnabled = true
        fullNameArLbl.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(secondnationalityTapped(_:)))
        secNationalityLbl.isUserInteractionEnabled = true
        secNationalityLbl.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(zoneLblTapped(_:)))
        zoneLbl.isUserInteractionEnabled = true
        zoneLbl.addGestureRecognizer(tapGesture3)

        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(nationalityLblTapped(_:)))
        nationalityLbl.isUserInteractionEnabled = true
        nationalityLbl.addGestureRecognizer(tapGesture4)
        
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(genderLblTapped(_:)))
        genderLbl.isUserInteractionEnabled = true
        genderLbl.addGestureRecognizer(tapGesture5)
        
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(stretLblTapped(_:)))
        streetLbl.isUserInteractionEnabled = true
        streetLbl.addGestureRecognizer(tapGesture6)
        
        let tapGesture7 = UITapGestureRecognizer(target: self, action: #selector(dobLblTapped(_:)))
        dobLbl.isUserInteractionEnabled = true
        dobLbl.addGestureRecognizer(tapGesture7)
        
        let tapGesture8 = UITapGestureRecognizer(target: self, action: #selector(buildingnoLblTapped(_:)))
        buildingLbl.isUserInteractionEnabled = true
        buildingLbl.addGestureRecognizer(tapGesture8)
        
        let tapGesture9 = UITapGestureRecognizer(target: self, action: #selector(occupationLblTapped(_:)))
        occupationLbl.isUserInteractionEnabled = true
        occupationLbl.addGestureRecognizer(tapGesture9)
        
        let tapGesture10 = UITapGestureRecognizer(target: self, action: #selector(actualoccupationLblTapped(_:)))
        actualOccLbl.isUserInteractionEnabled = true
        actualOccLbl.addGestureRecognizer(tapGesture10)
        
        let tapGesture11 = UITapGestureRecognizer(target: self, action: #selector(employerLblTapped(_:)))
        employerLbl.isUserInteractionEnabled = true
        employerLbl.addGestureRecognizer(tapGesture11)
        
        let tapGesture12 = UITapGestureRecognizer(target: self, action: #selector(workaddressLblTapped(_:)))
        workAddressLbl.isUserInteractionEnabled = true
        workAddressLbl.addGestureRecognizer(tapGesture12)
        
        let tapGesture13 = UITapGestureRecognizer(target: self, action: #selector(expectedincomeLblTapped(_:)))
        expIncomeLbl.isUserInteractionEnabled = true
        expIncomeLbl.addGestureRecognizer(tapGesture13)
        
        let tapGesture14 = UITapGestureRecognizer(target: self, action: #selector(registrationcodeLblTapped(_:)))
        regCodeLbl.isUserInteractionEnabled = true
        regCodeLbl.addGestureRecognizer(tapGesture14)
        
        let tapGesture15 = UITapGestureRecognizer(target: self, action: #selector(idexpiryLblTapped(_:)))
        idExpLbl.isUserInteractionEnabled = true
        idExpLbl.addGestureRecognizer(tapGesture15)
        
        let tapGesture16 = UITapGestureRecognizer(target: self, action: #selector(personalinformationLblTapped(_:)))
        personalInfoLbl.isUserInteractionEnabled = true
        personalInfoLbl.addGestureRecognizer(tapGesture16)
        
        let tapGesture17 = UITapGestureRecognizer(target: self, action: #selector(idissuerLblTapped(_:)))
        idIssuerLbl.isUserInteractionEnabled = true
        idIssuerLbl.addGestureRecognizer(tapGesture17)
        
        let tapGesture18 = UITapGestureRecognizer(target: self, action: #selector(identificationdetailsLblTapped(_:)))
        idDetailsLbl.isUserInteractionEnabled = true
        idDetailsLbl.addGestureRecognizer(tapGesture18)
        
        let tapGesture19 = UITapGestureRecognizer(target: self, action: #selector(idNumberLblTapped(_:)))
        idNumberLbl.isUserInteractionEnabled = true
        idNumberLbl.addGestureRecognizer(tapGesture17)
        
        let tapGesture20 = UITapGestureRecognizer(target: self, action: #selector(idTypeLblTapped(_:)))
        idTypeLbl.isUserInteractionEnabled = true
        idTypeLbl.addGestureRecognizer(tapGesture18)
        
        
        
    }
    @objc func fullNameLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("full name in english", languageCode: "en")
            }
        }
    }
    @objc func fullnameinarabicLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("full name in arabic", languageCode: "en")
            }
        }
        
    }
    
    @objc func secondnationalityTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("second nationality", languageCode: "en")
            }
        }
    }
    
    @objc func zoneLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("zone", languageCode: "en")
            }
        }
    }
    
    @objc func nationalityLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("nationality", languageCode: "en")
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
    
    @objc func stretLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("street", languageCode: "en")
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
    
    @objc func buildingnoLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("building number", languageCode: "en")
            }
        }
    }
    
    @objc func occupationLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("occupation", languageCode: "en")
            }
        }
    }
    
    @objc func actualoccupationLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("actual occupation", languageCode: "en")
            }
        }
    }
    
    
    @objc func employerLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("employer", languageCode: "en")
            }
        }
    }
    
    @objc func workaddressLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("work address", languageCode: "en")
            }
        }
    }
    
    @objc func expectedincomeLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("expected income", languageCode: "en")
            }
        }
    }
    
    @objc func registrationcodeLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("registration code", languageCode: "en")
            }
        }
    }
    
    @objc func idexpiryLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id expiration date", languageCode: "en")
            }
        }
    }
    
    @objc func personalinformationLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("personal information", languageCode: "en")
            }
        }
    }
    
    @objc func idissuerLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id issuer", languageCode: "en")
            }
        }
    }
    
    @objc func identificationdetailsLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("identification details", languageCode: "en")
            }
        }
    }
    
    @objc func idNumberLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id Number", languageCode: "en")
            }
        }
    }
    
    @objc func idTypeLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id Type", languageCode: "en")
            }
        }
    }

    
    
    
    
    
    
    //MARK: - Button Actions
    
    @IBAction func genderBtnTapped(_ sender: Any) {
        showGenderPopup()
    }
    @IBAction func updateIdBtnTapped(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IDVerificationBaseVC") as! IDVerificationBaseVC
        nextViewController.verificationType = .update
        self.navigationController?.pushViewController(nextViewController, animated: true)
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
    @IBAction func nextBtnTapped(_ sender: Any) {
//        ValidateFields()
        setShuftiView()
        if isIdView{
            ValidateFields()
        }else{
            idDetailsView.isHidden = false
            isIdView.toggle()
            nextLbl.text = NSLocalizedString("update", comment: "")
        }
        
        
    }
    
    //MARK: - Functions
    
    func fetchApis(){
        let mainGroup = DispatchGroup()
        
        mainGroup.enter()
        getCountry { [self] in
            mainGroup.leave()
            
            mainGroup.enter()
            getOccupations {
                mainGroup.leave()
            }
        }
    }
    func navigateToIDUpdate(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IDVerificationBaseVC") as! IDVerificationBaseVC
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IDVerificationBaseVC1") as! IDVerificationBaseVC
        
        nextViewController.verificationType = .update
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    func ValidateFields(){
        
        //        guard let email = emailTextField.text,emailTextField.text?.count != 0 else
        //        {
        //            self.view1.isHidden = false
        //            self.view2.isHidden = true
        //            self.scrollView.setContentOffset(.zero, animated: true)
        //            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Please enter email id", action: NSLocalizedString("ok", comment: ""))
        //            return
        //        }
        
        var str = fullNameTF.text
        str = str!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(str)
        // "this is the answer"
        print("strii",str)
        fullNameTF.text =  str
        print("striifullnameEnTextField.text",fullNameTF.text)
        
        //extraspace remove
        let startingString = fullNameTF.text!
        let processedString = startingString.removeExtraSpacesprofile()
        print("processedString:\(processedString)")
        fullNameTF.text = processedString
        
        
        
        //new
        if fullNameTF.text?.isEmpty == true
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            // timer.invalidate()
            self.fullNameTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                
                self.fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
            
            
            self.fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        
        guard let name_en = fullNameTF.text,fullNameTF.text?.count != 0 else
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            self.scrollView.setContentOffset(.zero, animated: true)
            
            self.view.makeToast(NSLocalizedString("enter_fullname_en", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_fullname_en", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        var charSet = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2 = name_en
        
        if let strvalue = string2.rangeOfCharacter(from: charSet)
        {
            print("true")
            //             let alert = UIAlertController(title: "Alert", message: "Please enter valid name", preferredStyle: UIAlertController.Style.alert)
            //             alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //             self.present(alert, animated: true, completion: nil)
            //             print("check name",self.fullnameEnTextField.text)
            //
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            self.scrollView.setContentOffset(.zero, animated: true)
            
            self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        //new
        if dobTF.text?.isEmpty == true
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            // timer.invalidate()
            self.dobTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.dobTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
            
            self.dobTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        guard let dob = dobTF.text,dobTF.text?.count != 0 else
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            self.scrollView.setContentOffset(.zero, animated: true)
            
            self.view.makeToast(NSLocalizedString("enter_dob", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_dob", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        let components = NSCalendar.current.dateComponents([.day,.month,.year],from:dateFormat.date(from: dobTF.text!)!)
        if let day = components.day, let month = components.month, let year = components.year {
            let dayString = "\(day)"
            let monthString = "\(month)"
            let yearString = "\(year)"
            
            let myDOB = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
            
            let myAge = Calendar.current.dateComponents([.month], from: myDOB, to: Date()).month!
            print("my age",myAge)
            
            let years = myAge / 12
            let months = myAge % 12
            print("Age : \(years).\(months)")
            self.userAge = Double("\(years)"+"."+"\(months)")
            print(self.userAge)
        }
        if self.userAge ?? 0.0 < 18.0{
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("invalid_dob", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            self.scrollView.setContentOffset(.zero, animated: true)
            
            self.view.makeToast(NSLocalizedString("invalid_dob", comment: ""), duration: 3.0, position: .center)
            
            self.dobTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.dobTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            
            
            return
        }
        else
        {
            
            self.dobTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            
        }
        
        
        
        if(zoneTF.text?.isEmpty == true)
        {
            str_zone = ""
            //            self.view1.isHidden = false
            //            self.view2.isHidden = true
            //           // self.scrollView.setContentOffset(.zero, animated: true)
            //
            //            let bottomOffset = CGPoint(x: 0, y: 180)
            //            //OR
            //            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            //            scrollView.setContentOffset(bottomOffset, animated: true)
            //
            // self.view.makeToast(NSLocalizedString("enter_zone", comment: ""), duration: 3.0, position: .center)
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            let bottomOffset = CGPoint(x: 0, y: 230)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            
            self.zoneTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.zoneTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            
            self.view.makeToast("Please select zone", duration: 3.0, position: .center)
            
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_zone", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            
            self.zoneTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            
        }
        
        
        
        var straddress = streetTF.text
        straddress = straddress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(straddress)
        // "this is the answer"
        print("straddress",straddress)
        streetTF.text =  straddress
        print("addressTextField.text",streetTF.text)
        
        
        //extraspace remove
        let startingStringhomeadress = streetTF.text!
        let processedStringhomeaddress = startingStringhomeadress.removeExtraSpacesprofile()
        print("processedStringhomeadress:\(processedStringhomeaddress)")
        streetTF.text = processedStringhomeaddress
        
        //new
        if streetTF.text?.isEmpty == true
        {
            // timer.invalidate()
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            self.streetTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
            
            
            self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        guard let addr = streetTF.text,streetTF.text?.count != 0 else
        {
            // self.scrollView.setContentOffset(.zero, animated: true)
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            let bottomOffset = CGPoint(x: 0, y: 300)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            //self.view.makeToast(NSLocalizedString("enter_addr", comment: ""), duration: 3.0, position: .center)
            self.view.makeToast("Enter street", duration: 3.0, position: .center)
            
            
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_addr", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        var charSethomeAddr = CharacterSet.init(charactersIn: "@#$%+_&'()*,-/:;<=>?[]^`{|}~)(")
        var string2homeAddr = streetTF.text!
        
        if let strvalue = string2homeAddr.rangeOfCharacter(from: charSethomeAddr)
        {
            print("true")
            
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            let bottomOffset = CGPoint(x: 0, y: 300)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            
            //                     let alert = UIAlertController(title: "Alert", message: "Please enter valid address", preferredStyle: UIAlertController.Style.alert)
            //                     alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //                     self.present(alert, animated: true, completion: nil)
            //                     print("check name",self.addressTextField.text)
            self.streetTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            
            
            self.view.makeToast("Please enter valid street", duration: 3.0, position: .center)
            
            //self.view.makeToast(NSLocalizedString("Please enter valid address", comment: ""), duration: 3.0, position: .center)
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid address", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        else
        {
            
            self.streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            
        }
        
        
        
        if buildingTF.text?.isEmpty == true
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            let bottomOffset = CGPoint(x: 0, y: 370)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            self.buildingTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            
            
            self.view.makeToast("Please enter building number", duration: 3.0, position: .center)
            
            return
        }
        else
        {
            
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
            //                print("check name",self.fullNameEnTextField.text)
            //
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid home adress", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            let bottomOffset = CGPoint(x: 0, y: 370)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            //self.view.makeToast(NSLocalizedString("Please enter valid home adress", comment: ""), duration: 3.0, position: .center)
            self.view.makeToast("Please enter valid building number", duration: 3.0, position: .center)
            
            self.buildingTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            
            
            return
            
        }
        else
        {
            
            self.buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            
            
        }
        
        
        
        //        guard let mobile = mobileTextField.text,mobileTextField.text?.count != 0 else
        //        {
        //            self.view1.isHidden = false
        //            self.view2.isHidden = true
        //            self.scrollView.setContentOffset(.zero, animated: true)
        //            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Please enter mobile number", action: "Ok")
        //            return
        //        }
        
        
        var stremployer = employerTF.text
        stremployer = stremployer!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(stremployer)
        // "this is the answer"
        print("stremployer",stremployer)
        employerTF.text =  stremployer
        print("employerTextField.text",employerTF.text)
        
        
        //extraspace remove
        let startingStringemployer = employerTF.text!
        let processedStringemployer = startingStringemployer.removeExtraSpacesprofile()
        print("processedStringemployer:\(processedStringemployer)")
        employerTF.text = processedStringemployer
        
        
        if employerTF.text?.isEmpty == true
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            // timer.invalidate()
            self.employerTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
            
            self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        
        guard let emp = employerTF.text,employerTF.text?.count != 0 else
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            //self.scrollView.setContentOffset(.zero, animated: true)
            let bottomOffset = CGPoint(x: 0, y: 600)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.view.makeToast(NSLocalizedString("enter_employer_name", comment: ""), duration: 3.0, position: .center)
            
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_employer_name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        
        var charSetemployer = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2employerr = emp
        
        if let strvalue = string2employerr.rangeOfCharacter(from: charSetemployer)
        {
            print("true")
            //                   let alert = UIAlertController(title: "Alert", message: "Please enter valid employer", preferredStyle: UIAlertController.Style.alert)
            //                   alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //                   self.present(alert, animated: true, completion: nil)
            //                   print("check name",self.employerTextField.text)
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            self.employerTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            //self.scrollView.setContentOffset(.zero, animated: true)
            let bottomOffset = CGPoint(x: 0, y: 600)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            
            self.view.makeToast(NSLocalizedString("Please enter valid employer", comment: ""), duration: 3.0, position: .center)
            
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid employer", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        else
        {
            
            self.employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        
        
        
        
        var strexpincome = expIncomeTF.text
        strexpincome = strexpincome!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strexpincome)
        // "this is the answer"
        print("strexpincome",strexpincome)
        expIncomeTF.text =  strexpincome
        print("expectedIncomeTextField.text",expIncomeTF.text)
        
        
        
        //extraspace remove
        let startingStringexpincome = expIncomeTF.text!
        let processedStringexpincome = startingStringexpincome.removeExtraSpacesprofilenospace()
        print("processedStringexpincome:\(processedStringexpincome)")
        expIncomeTF.text = processedStringexpincome
        
        
        
        //new
        if expIncomeTF.text?.isEmpty == true
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            // timer.invalidate()
            self.expIncomeTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
            
            self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        
        
        guard let exp_income = expIncomeTF.text,expIncomeTF.text?.count != 0 else
        {
            
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            let bottomOffset = CGPoint(x: 0, y: 670)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.view.makeToast(NSLocalizedString("enter_exp_income", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: "Ok")
            return
        }
        
        var charSetexpIncome = CharacterSet.init(charactersIn: "@#$%+_&'()*,/:;<=>?[]^`{|}~)(")
        var string2expIncome = exp_income
        
        if let strvalue = string2expIncome.rangeOfCharacter(from: charSetexpIncome)
        {
            print("true")
            //                let alert = UIAlertController(title: "Alert", message: "Please enter valid working address", preferredStyle: UIAlertController.Style.alert)
            //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //                self.present(alert, animated: true, completion: nil)
            
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            let bottomOffset = CGPoint(x: 0, y: 670)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.expIncomeTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            
            
            
            self.view.makeToast(NSLocalizedString("enter_exp_income", comment: ""), duration: 3.0, position: .center)
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        else
        {
            self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            
        }
        
        
        if (!validate (value: self.expIncomeTF.text!))
        {
            
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            let bottomOffset = CGPoint(x: 0, y: 670)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.expIncomeTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            
            
            
            self.view.makeToast(NSLocalizedString("enter_exp_income", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        else
        {
            
            
            self.expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            
        }
        
        
        var strworkaddress = workAddressTF.text
        strworkaddress = strworkaddress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strworkaddress)
        // "this is the answer"
        print("stremployer",strworkaddress)
        workAddressTF.text =  strworkaddress
        print("workingAddrTextField.text",workAddressTF.text)
        
        
        //extraspace remove
        let startingStringworkaddress = workAddressTF.text!
        let processedStringworkaddress = startingStringworkaddress.removeExtraSpacesprofile()
        print("processedStringworkaddress:\(processedStringworkaddress)")
        workAddressTF.text = processedStringworkaddress
        
        //new
        if workAddressTF.text?.isEmpty == true
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            // timer.invalidate()
            self.workAddressTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
            
            self.workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            
        }
        
        
        
        guard let work_addr = workAddressTF.text,workAddressTF.text?.count != 0 else
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            let bottomOffset = CGPoint(x: 0, y: 740)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.view.makeToast(NSLocalizedString("enter_working_address", comment: ""), duration: 3.0, position: .center)
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_working_address", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        var charSetaddress = CharacterSet.init(charactersIn: "@#$%+_&'()*,-/:;<=>?[]^`{|}~)(")
        var string2address = work_addr
        
        if let strvalue = string2address.rangeOfCharacter(from: charSetaddress)
        {
            print("true")
            //                 let alert = UIAlertController(title: "Alert", message: "Please enter valid working address", preferredStyle: UIAlertController.Style.alert)
            //                 alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //                 self.present(alert, animated: true, completion: nil)
            //                 print("check name",self.workingAddrTextField.text)
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            
            let bottomOffset = CGPoint(x: 0, y: 740)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.view.makeToast(NSLocalizedString("Please enter valid working address", comment: ""), duration: 3.0, position: .center)
            
            self.workAddressTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        else
        {
            
            self.workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            
        }
        
        
        var stroccupation = occupationTF.text
        stroccupation = stroccupation!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(stroccupation)
        // "this is the answer"
        print("stremployer",stroccupation)
        occupationTF.text =  stroccupation
        print("workingAddrTextField.text",occupationTF.text)
        
        
        //new
        if occupationTF.text?.isEmpty == true
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            // timer.invalidate()
            self.occupationTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.occupationTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
            
            self.occupationTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        
        guard let occupation = occupationTF.text,occupationTF.text?.count != 0 else
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            
            //                        let bottomOffset = CGPoint(x: 0, y: 540)
            //OR
            let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.view.makeToast(NSLocalizedString("enter_occupation", comment: ""), duration: 3.0, position: .center)
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_occupation", comment: ""), action: "Ok")
            return
        }
        
        
        //new
        if actualOccTF.text?.isEmpty == true
        {
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            // timer.invalidate()
            self.actualOccTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.actualOccTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
        }
        else
        {
            
            self.actualOccTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        }
        
        guard let actualoccupation = actualOccTF.text,actualOccTF.text?.count != 0 else
        {
            
            self.isIdView = false
            self.idDetailsView.isHidden = true
             self.nextLbl.text = NSLocalizedString("next", comment: "")
            //                        let bottomOffset = CGPoint(x: 0, y: 540)
            //OR
            let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.view.makeToast(NSLocalizedString("Select Actual Occupation", comment: ""), duration: 3.0, position: .center)
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Select Actual Occupation", action: NSLocalizedString("ok", comment: ""))
            return
        }
        /* - not needed as per now
         
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
        */
        /*
        guard let id_exp_date = idExpTF.text,idExpTF.text?.count != 0 else
        {
           
            self.isIdView = true
            self.idDetailsView.isHidden = false
            self.nextLbl.text = NSLocalizedString("update", comment: "")
            self.view.makeToast(NSLocalizedString("enter_id_exp_date", comment: ""), duration: 3.0, position: .center)
            self.idExpTF.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.idExpTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
            }
            return
        }
        if(idIssuerTF.text == "Ministry of Interior")
        {
           self.str_id_issuer = "QATAR MOI"
        }
        else
        {
            self.str_id_issuer = "QATAR MOFA"
        }
        */
        
        
        //        guard let id_no = idNumTextField.text,idNumTextField.text?.count != 0 else
        //        {
        //            self.view1.isHidden = true
        //            self.view2.isHidden = false
        //            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Please enter id number", action: NSLocalizedString("ok", comment: ""))
        //            return
        //        }
        //        if(idNumTextField.text?.count != 11)
        //        {
        //            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Please enter a valid id number", action: "Ok")
        //            return
        //        }
        
        
        
        var strfullnamear = fullNameArTF.text
        strfullnamear = strfullnamear!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strfullnamear)
        // "this is the answer"
        print("stremployer",strfullnamear)
        fullNameArTF.text =  strfullnamear
        
        //extraspace removear
        let startingStringnamear = fullNameArTF.text!
        let processedStringnamear = startingStringnamear.removeExtraSpacesprofile()
        print("processedString:\(processedStringnamear)")
        fullNameArTF.text = processedStringnamear
        
        //                    self.str_id_no = self.idNumTextField.text!
//                            self.str_id_exp_date = self.convertDateFormater1(self.idExpTextField.text!)
        
        self.str_name_en = self.fullNameTF.text!
        self.str_name_ar = self.fullNameArTF.text!
//        self.strEmail = self.emailTF.text!
        self.str_dob = self.convertDateFormater1(self.dobTF.text!)
        self.str_address = self.streetTF.text!
        //self.str_city = self.municipalityBtn.titleLabel?.text as! String
        self.str_gender = self.genderTF.text as! String
        self.str_employer = self.employerTF.text!
//        self.str_occupation = self.occupationTF.text!
        self.str_working_address = self.workAddressTF.text!
        self.str_income = self.expIncomeTF.text!
        self.str_zone = self.zoneTF.text as! String
        self.str_regCode = self.regCodeTF.text as! String
//        self.strMobile = self.mobileTF.text!
//        self.str_id_exp_date = self.convertDateFormater1(self.idExpTF.text!)
        print("1",str_id_no)
        print("2",str_id_exp_date)
        print("3",str_name_en)
        print("4",str_name_ar)
        print("5",strEmail)
        print("6",str_dob)
        print("7",str_nationality)
        print("8",str_address)
        print("9",str_city)
        print("10",str_gender)
        print("11",str_employer)
        print("12",str_occupation)
        print("13",str_working_address)
        print("14",str_income)
        print("15",str_zone)
        print("16",strMobile)
        print("17",defaults.string(forKey: "REGNO")!)
        print("18",defaults.string(forKey: "PIN")!)
        print("19",defaults.string(forKey: "PASSW"))
        
        //new
        
        if ((self.defaults.string(forKey: "str_id_nonew")?.isEmpty) != nil)
        {
            
        }
        else
        {
            
        }
        
        //                    self.str_id_no = self.idNumTextField.text!
        //                    self.defaults.set(self.str_id_no, forKey: "str_id_nonew")
        //
        //
        //                    self.str_id_exp_date = self.idExpTextField.text!
        //                    self.defaults.set(self.str_id_exp_date, forKey: "str_id_exp_datenew")
        
        
        self.str_name_en = self.fullNameTF.text!
        self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
        
        self.str_name_ar = self.fullNameArTF.text!
        self.defaults.set(self.str_name_ar, forKey: "str_name_arnew")
        
//        self.strEmail = self.emailTF.text!
        self.defaults.set(self.strEmail, forKey: "strEmailnew")
        
//        self.str_dob = self.dobTF.text!
        self.defaults.set(self.str_dob, forKey: "str_dobnew")
        
        self.defaults.set(self.str_nationality, forKey: "str_nationalitynew")
        self.defaults.set(self.dualnationalityselstr, forKey: "dualnationalityselstr")
        
        self.defaults.set(self.dualnationalityselstr, forKey: "dualnationalityselstr")
        
        self.str_address = self.streetTF.text!
        self.defaults.set(self.str_address, forKey: "str_addressnew")
        
        //self.str_city = self.municipalityBtn.titleLabel?.text as! String
        self.defaults.set(self.str_city, forKey: "str_citynew")
        
        self.str_gender = self.genderTF.text as! String
        self.defaults.set(self.str_gender, forKey: "str_gendernew")
        
        self.str_employer = self.employerTF.text!
        self.defaults.set(self.str_employer, forKey: "str_employernew")
        
        //ivde occupation
        //typetextfd only or save in only didselect
        //        self.str_occupation = self.occupationTextField.text!
        //        self.defaults.set(self.str_occupation, forKey: "str_occupationnew")
        
        self.str_working_address = self.workAddressTF.text!
        self.defaults.set(self.str_working_address, forKey: "str_working_addressnew")
        
        
        self.str_buildingnotxtfd = self.buildingTF.text!
        self.defaults.set(self.str_buildingnotxtfd, forKey: "str_buildingnotxtfd")
        
        self.str_income = self.expIncomeTF.text!
        self.defaults.set(self.str_income, forKey: "str_incomenew")
        
        // self.str_zone = self.zoneBtn.titleLabel?.text as! String
        //self.str_zone = str_zone
        self.defaults.set(self.str_zone, forKey: "str_zonenew")
        
        //new
        //self.str_buildingnotxtfd = self.buildiongnotxtfd.text!
        // self.defaults.set(self.str_buildingnotxtfd, forKey: "str_buildingnotxtfd")
        
        
//        self.strMobile = self.mobileTF.text!
        self.defaults.set(self.strMobile, forKey: "strMobilenew")
        
        self.getToken(num: 2)
        
        
    }
    func setShuftiView(){
        
       
        if isShuftiDone{
            idImagesView.isHidden = false
            idUpdateBtnView.isHidden = true
            idDetailsHeight.constant = 950
            setNewImages()
        }else{
            idImagesView.isHidden = true
            idUpdateBtnView.isHidden = false
            idDetailsHeight.constant = 500
        }
    }
    func setView(){
        setShuftiView()
//        idUpdateLbl.text = "Update Your ID"
//        idFrontLbl.text = "Front ID image"
//        idBackLbl.text = "Back ID image"
        if isIdView{
            idDetailsView.isHidden = false
        }else{
            idDetailsView.isHidden = true
        }
        
        for btn in emptyBtns{
            btn.setTitle("", for: .normal)
        }
        nextLbl.text = NSLocalizedString("next", comment: "")
        personalInfoLbl.text = NSLocalizedString("personal_info", comment: "")
        nationalityTF.delegate = self
        secNationalityTF.delegate = self
        zoneTF.delegate = self
        occupationTF.delegate = self
        actualOccTF.delegate = self
//        idIssuerTF.delegate = self
//        emailTF.isUserInteractionEnabled = false
//        mobileTF.isUserInteractionEnabled = false
//        mobileCodeTF.isUserInteractionEnabled = false
        genderTF.isUserInteractionEnabled = false
        expIncomeTF.keyboardType = .numberPad
        buildingTF.keyboardType = .numberPad
        
        fullNameTF.layer.borderWidth = 0.8
        fullNameTF.layer.cornerRadius = 4
        fullNameTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        dobTF.layer.borderWidth = 0.8
        dobTF.layer.cornerRadius = 4
        dobTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        zoneTF.layer.borderWidth = 0.8
        zoneTF.layer.cornerRadius = 4
        zoneTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        streetTF.layer.borderWidth = 0.8
        streetTF.layer.cornerRadius = 4
        streetTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        buildingTF.layer.borderWidth = 0.8
        buildingTF.layer.cornerRadius = 4
        buildingTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        employerTF.layer.borderWidth = 0.8
        employerTF.layer.cornerRadius = 4
        employerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        expIncomeTF.layer.borderWidth = 0.8
        expIncomeTF.layer.cornerRadius = 4
        expIncomeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        workAddressTF.layer.borderWidth = 0.8
        workAddressTF.layer.cornerRadius = 4
        workAddressTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        occupationTF.layer.borderWidth = 0.8
        occupationTF.layer.cornerRadius = 4
        occupationTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        actualOccTF.layer.borderWidth = 0.8
        actualOccTF.layer.cornerRadius = 4
        actualOccTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        idExpTF.layer.borderWidth = 0.8
        idExpTF.layer.cornerRadius = 4
        idExpTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        idIssuerTF.layer.borderWidth = 0.8
        idIssuerTF.layer.cornerRadius = 4
        idIssuerTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        idNumberTF.layer.borderWidth = 0.8
        idNumberTF.layer.cornerRadius = 4
        idNumberTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
        idTypeTF.layer.borderWidth = 0.8
        idTypeTF.layer.cornerRadius = 4
        idTypeTF.layer.borderColor = UIColor.rgba(232, 233, 233, 1).cgColor
    }
    
    func setNewImages(){
        
        idNumberTF.text = defaults.string(forKey: "USERID")
        idExpTF.text = defaults.string(forKey: "shufti_update_id_exp_date")
        
        strBase64 = defaults.string(forKey: "strBase64")
        strBase641 = defaults.string(forKey: "strBase641")
//            strBase642 = defaults.string(forKey: "strBase642")
    strBase64Selfie = defaults.string(forKey: "strBase64video")
//        strBase64Selfie = defaults.string(forKey: "strBase64Selfie")check
        
        //new
        
        
        if defaults.object(forKey: "frontimage") == nil
        {
            print("No value in Userdefault frontimage")
        }
        else
        {
            let imageData = defaults.data(forKey: "frontimage")
            let orgImage : UIImage = UIImage(data: imageData!)!
            idFrontImg.image = orgImage

        }
        
        
        if defaults.object(forKey: "backimage") == nil
        {
            print("No value in Userdefault backimage")
        }
        else
        {
        
        let imageDataback = defaults.data(forKey: "backimage")
        let orgImageback : UIImage = UIImage(data: imageDataback!)!
            idBackImg.image = orgImageback
        }
        
    }
    
    func extractName(){
        let string = str_name_en
        testmiddlenamestr = ""
        testlastnamestr = ""
        testfirstnamestr = ""
        let result = string.components(separatedBy: " ")
        
        
        if result.count == 0
        {
            //middle name ""
            testmiddlenamestr = ""
            testlastnamestr = ""
            testfirstnamestr = ""
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
        //newaboves
        
        
        
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
        self.navigationItem.title = "Update Profile"
    }
    @objc func customBackButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
        
        if isIdView{
            idDetailsView.isHidden = true
            isIdView.toggle()
            nextLbl.text = NSLocalizedString("next", comment: "")
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
    
    func createToolbar1(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
            datePicker1.preferredDatePickerStyle = .wheels
            datePicker1.backgroundColor = UIColor.white
        }
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate1))
        toolbar.setItems([done], animated: true)
        dobTF.inputAccessoryView = toolbar
        datePicker1.datePickerMode = .date
        datePicker1.maximumDate = Date()
        dobTF.inputView = datePicker1
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
//        idExpTF.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        let today = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -89, to: today)!
//        idExpTF.inputView = datePicker
    }
    
    @objc func showdate1()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        dobTF.text = dateFormat.string(from: datePicker1.date)
        print(dobTF.text)
        let components = NSCalendar.current.dateComponents([.day,.month,.year],from:dateFormat.date(from: dobTF.text!)!)
        if let day = components.day, let month = components.month, let year = components.year {
            let dayString = "\(day)"
            let monthString = "\(month)"
            let yearString = "\(year)"
            
            let myDOB = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
            
            let myAge = Calendar.current.dateComponents([.month], from: myDOB, to: Date()).month!
            print("my age",myAge)
            
            let years = myAge / 12
            let months = myAge % 12
            print("Age : \(years).\(months)")
            self.userAge = Double("\(years)"+"."+"\(months)")
            print("user age - \(self.userAge)")
        }
        view.endEditing(true)
    }
    @objc func showdate()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
//        idExpTF.text = dateFormat.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    func convertDateFormater(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return  dateFormatter.string(from: date!)
    }
    func convertDateFormater1(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
    }
    func documentsPathForFileName(name: String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentsPath.appending(name)
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.playerViewController.dismiss(animated: true)
    }
    func validate(value: String) -> Bool {
        //let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let PHONE_REGEX = "^[0-9]{0,15}$"
        //let PHONE_REGEX = "[a-zA-z]"
        
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    

    
    // popups
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
        case .nationality:
            popUpView1.nationalityFlagPath = self.nationalityFlagPath
            popUpView1.nationalityArray = self.nationalityArray
            popUpView1.searchCountry = self.nationalityArray
        case .secondNationality:
            popUpView1.nationalityFlagPath = self.nationalityFlagPath
            popUpView1.secNationalityArray = self.secNationalityArray
            popUpView1.searchCountry = self.secNationalityArray
        case .zone:
            popUpView1.zoneArray = self.zoneArray
            popUpView1.searchZone = self.zoneArray
        case .occupation:
            popUpView1.occupationArray = self.occupationArray
            popUpView1.searchOccupation = self.occupationArray
        case .actualOcc:
            popUpView1.actualOccArray = self.actualOccArray
            popUpView1.searchOccupation = self.actualOccArray
            
        case .idIssuer:
            print("idIssuer")
        }
        popUpView1.setupTableView()
        popUpView1.baseTableView.reloadData()
        view.addSubview(popUpView1)
        print("PopUpView")
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView1.alpha = 1.0
        })
    }
    // data from popupView
    
    func editProfilePopupView(_ vc: EditProfilePopupView, selection: EditProfileDropDownSelection, didSelectCountry country: CasmexNationality?) {
        self.nationalityTF.text = country?.description
    }
    
    func editProfilePopupView(_ vc: EditProfilePopupView, selection: EditProfileDropDownSelection, didSelectSecondCountry secondCountry: CasmexNationality?) {
        self.secNationalityTF.text = secondCountry?.description
    }
    
//    func editProfilePopupView(_ vc: EditProfilePopupView, selection: EditProfileDropDownSelection, didSelectCountry country: Country?) {
//        self.nationalityTF.text = country?.en_short_name
//    }
//    
//    func editProfilePopupView(_ vc: EditProfilePopupView, selection: EditProfileDropDownSelection, didSelectSecondCountry secondCountry: Country?) {
//        self.secNationalityTF.text = secondCountry?.en_short_name
//    }
//    
    func editProfilePopupView(_ vc: EditProfilePopupView, selection: EditProfileDropDownSelection, didSelectZone zone: Zone?) {
        self.zoneTF.text = zone?.zone
    }
    
    func editProfilePopupView(_ vc: EditProfilePopupView, selection: EditProfileDropDownSelection, didSelectOccupation occupation: City?) {
        self.occupationTF.text = occupation?.ge_city_name
        self.str_occupation = occupation?.ge_city_name ?? ""
    }
    
    func editProfilePopupView(_ vc: EditProfilePopupView, selection: EditProfileDropDownSelection, didSelectActualOccupation actualOccupation: City?) {
        self.actualOccTF.text = actualOccupation?.ge_city_name
        self.str_actualoccupation = actualOccupation?.ge_city_name ?? ""
    }
    
    func editProfilePopupView(_ vc: EditProfilePopupView, selection: EditProfileDropDownSelection, didSelectIdIssuer issuer: String?) {
//        self.idIssuerTF.text = issuer
        print("nil")
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
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    
    
    //MARK: - API Calls
    
    func getToken(num:Int) {
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
                if(num == 1)
                {
                    self.getProfileInfo(access_token: token)
                }
                else if(num == 2)
                {
                    self.updateProfile(access_token: token)
                }
                else if(num == 3)
                {
                    //                    self.profileimageviewapi(access_token: token)
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
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let respCode = myResult!["responseCode"]
                if(respCode == "S104")
                {
                    
                    //store local in app
                    
                    
                    
                    // self.emailTextField.text = myResult!["email"].stringValue
                    UserDefaults.standard.removeObject(forKey: "strEmailnew")
                    self.strEmail = myResult!["email"].stringValue
                    
                    self.defaults.set(self.strEmail, forKey: "strEmailnew")
                    
                    if ((self.defaults.string(forKey: "strEmailnew")?.isEmpty) != nil)
                    {
//                        self.emailTF.text = self.strEmail
                        print("strEmailstore",self.strEmail)
                        
                    }
                    else
                    {
//                        self.emailTF.text  = ""
                        self.strEmail =  ""
                    }
                    
                    
                    
                    UserDefaults.standard.removeObject(forKey: "strEmailnew")
                    self.str_name_en = myResult!["workingAddress3"].stringValue
                    
                    self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
                    
                    if ((self.defaults.string(forKey: "str_name_ennew")?.isEmpty) != nil)
                    {
                        
                        self.fullNameTF.text = self.str_name_en
                        
                        
                        print("str_name_ennewstore",self.str_name_en)
                        
                    }
                    else
                    {
                        self.fullNameTF.text  = ""
                        self.str_name_en =  ""
                    }
                    // check
                    self.fullNameArTF.text = myResult!["customerNameArabic"].stringValue
                    self.str_name_ar = myResult!["customerNameArabic"].stringValue
                    self.dobTF.text = self.convertDateFormater(myResult!["customerDOB"].stringValue)
                    self.str_dob = myResult!["customerDOB"].stringValue
                    
                    //   xgfghfhg
                    
                    if(myResult!["street"].stringValue == "-")
                    {
                        self.streetTF.text = ""
                        self.str_address = ""
                    }
                    else
                    {
                        self.streetTF.text = myResult!["street"].stringValue
                        self.str_address = myResult!["street"].stringValue
                    }
                    
                    if(myResult!["customerCity"].stringValue == "-" ) || (myResult!["customerCity"].stringValue == "Municipality")
                    {
                        
                        self.str_city = ""
                        //                self.municipalityBtn.titleLabel?.text = "Municipality"
                        //                    self.municipalityBtn.setTitleColor(UIColor.gray, for: .normal)
                    }
                    else
                    {
                        //                    self.municipalityBtn.setTitle(myResult!["customerCity"].stringValue, for: .normal)
                        self.str_city = myResult!["customerCity"].stringValue
                        //                    self.municipalityBtn.setTitleColor(UIColor.black, for: .normal)
                    }
                    
                    if(myResult!["mZone"].stringValue == "-") || (myResult!["mZone"].stringValue == "Zone")
                    {
                        self.zoneTF.text = "-"
                    }
                    else
                    {
                        self.zoneTF.text = myResult!["mZone"].stringValue
                        self.str_zone = myResult!["mZone"].stringValue
                    }
                    
                    if(myResult!["buildingNo"].stringValue == "-") || (myResult!["buildingNo"].stringValue == "<null>") || (myResult!["buildingNo"].stringValue.isEmpty == true)
                        
                    {
                        self.buildingTF.text = ""
                    }
                    else
                    {
                        self.buildingTF.text = myResult!["buildingNo"].stringValue
                    }
                    if(myResult!["customerRegNo"].stringValue == "-") || (myResult!["customerRegNo"].stringValue == "<null>") || (myResult!["customerRegNo"].stringValue.isEmpty == true)
                        
                    {
                        self.regCodeTF.text = ""
                    }
                    else
                    {
                        self.regCodeTF.text = myResult!["customerRegNo"].stringValue
                    }
                    self.genderTF.text = myResult!["gender"].stringValue
                    self.str_gender = myResult!["gender"].stringValue
//                    self.mobileTF.text = myResult!["customerMobile"].stringValue
                    self.strMobile = myResult!["customerMobile"].stringValue
                    self.employerTF.text = myResult!["employerName"].stringValue
                    self.str_employer = myResult!["employerName"].stringValue
                    self.expIncomeTF.text = myResult!["expectedIncome"].stringValue
                    self.str_income = myResult!["expectedIncome"].stringValue
                    self.workAddressTF.text = myResult!["workingAddress1"].stringValue
                    self.str_working_address = myResult!["workingAddress1"].stringValue
                    self.occupationTF.text = myResult!["occupation"].stringValue
                    self.str_occupationtext = myResult!["occupation"].stringValue
                    self.str_occupation = myResult!["occupation"].stringValue
                    self.actualOccTF.text = myResult!["actualOccupation"].stringValue
                    self.str_actualoccupation = myResult!["actualOccupation"].stringValue
                    print("3 letter code",myResult!["customerNationality"].stringValue)
                    self.nationalityTF.text = myResult!["customerNationality"].stringValue
                    self.secNationalityTF.text = myResult!["customerCountry"].stringValue
//                    self.getCountryName(code: myResult!["customerNationality"].stringValue, from: 1)
                    self.str_nationality = myResult!["customerNationality"].stringValue
                    self.str_country = myResult!["customerCountry"].stringValue
//                    self.getCountryName(code: myResult!["customerCountry"].stringValue, from: 2)
                    self.dualnationalityselstr = myResult!["customerCountry"].stringValue
                    // store
    //                self.i.text = myResult!["customerIDType"].stringValue
    //                self.idTypeBtn.setTitle(myResult!["customerIDType"].stringValue, for: .normal)
    //                self.idTypeBtn.setTitleColor(UIColor.black, for: .normal)
                    self.str_id_issuer = myResult!["customerIDIssuedBy"].stringValue
                    self.str_id_no = myResult!["customerIDNo"].stringValue
                    self.str_id_exp_date = myResult!["customerIDExpiryDate"].stringValue
                    self.str_id_exp_date = self.convertDateFormater(self.str_id_exp_date)
                    self.str_id_exp_date = self.convertDateFormater1(self.str_id_exp_date)
                    
                    self.str_customerBirthPlace = myResult!["customerBirthPlace"].stringValue
                    self.str_customerIDIssuedCountry = myResult!["customerIDIssuedCountry"].stringValue
                    self.str_customerLastName = myResult!["customerLastName"].stringValue
                    self.str_customerMiddleName = myResult!["customerMiddleName"].stringValue
                    self.str_customerPhone = myResult!["customerPhone"].stringValue
                    self.str_customerZipCode = myResult!["customerZipCode"].stringValue
                     self.str_visaExpiryDate = myResult!["visaExpiryDate"].stringValue
                    self.str_visaIssuedBy = myResult!["visaIssuedBy"].stringValue
                    self.str_visaIssuedDate = myResult!["visaIssuedDate"].stringValue
                    self.str_visaNo = myResult!["visaNo"].stringValue
                    self.str_visaType = myResult!["visaType"].stringValue
                    self.str_workingAddress3 = myResult!["workingAddress3"].stringValue
                    if(self.str_id_issuer == "QATAR MOI")
                    {
                        self.idIssuerTF.text = "Ministry of Interior"
                    }
                    else if(self.str_id_issuer == "QATAR MOFA")
                    {
                        self.idIssuerTF.text = "Ministry of Foreign Affairs"
                    }
                     let expDate = myResult!["customerIDExpiryDate"].stringValue
                    if expDate != ""{
                        self.idExpTF.text = self.convertDateFormater(expDate)
                    }
//                    self.str_id_exp_date = myResult!["customerIDExpiryDate"].stringValue
                    self.idTypeTF.text = "QID"
                    self.idNumberTF.text = myResult!["customerIDNo"].stringValue
                    
                }
            case .failure:
                break
            }

            
        })
    }
    func updateProfile(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "customer/updatecustomer"
       
        print("1",str_id_no)
        print("2",defaults.string(forKey: "REGNO")!)
        print("3",str_name_en)
        print("4",str_name_ar)
        print("5",str_address)
        print("6",str_city)
        print("7",strMobile)
        //print("7",str_country)
        print("8",str_dob)
        print("9",str_nationality)
        print("9.1",self.dualnationalityselstr)
        print("10",str_gender)
        print("11",str_occupation)
        print("12",strEmail)
        print("13",str_id_exp_date)
        print("14",str_id_issuer)
        print("15",defaults.string(forKey: "PASSW")!)
        print("16",defaults.string(forKey: "PIN")!)
        print("17",str_employer)
        print("18",str_working_address)
        print("19",str_income)
        print("20",str_zone)
        print("21",str_regCode)
        
        //new
        // self.str_buildingnotxtfd = self.buildiongnotxtfd.text!
        //self.defaults.set(self.str_buildingnotxtfd, forKey: "str_buildingnotxtfd")
        
        
        //new
//        self.str_dob = self.convertDateFormater1(self.dobTF.text!)
       
        
        
        // profile images
        
       /*
        //frontphotocheck
        let userdefaultfrontlabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultfrontlabelphotostr.string(forKey: "strBase64photo"){
            print("Here you will get saved value")
            
            strBase64 = defaults.string(forKey: "strBase64photo")
            
        } else {
            strBase64 = ""
            
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultfrontlabelphotostr.set("", forKey: "key")
        }
        
        
        
        //backphotocheck
        let userdefaultbacklabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultbacklabelphotostr.string(forKey: "strBase641photo1"){
            print("Here you will get saved value")
            
            strBase641 = defaults.string(forKey: "strBase641photo1")
            
        } else {
            strBase641 = ""
            
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultbacklabelphotostr.set("", forKey: "key")
        }
        
        
        
        //selfiphotocheck
        let userdefaultselfielabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultselfielabelphotostr.string(forKey: "strBase64videoProfile"){
            print("Here you will get saved value")
            
            strBase64videoProfile = defaults.string(forKey: "strBase64videoProfile")
            
        } else {
            
            strBase64videoProfile = ""
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultselfielabelphotostr.set("", forKey: "key")
        }
        */
        
        
        
        
        
        
        
        
        
        //        let fullName = "testing abducio medina"
        //        var components = fullName.components(separatedBy: " ")
        //        if components.count > 0 {
        //         let firstName = components.removeFirst()
        //         let lastName = components.joined(separator: " ")
        //         debugPrint(firstName)
        //         debugPrint(lastName)
        //        }
        
        let string = str_name_en
        let result = string.components(separatedBy: " ")
        
        
        if result.count == 0
        {
            //middle name ""
            testmiddlenamestr = ""
            testlastnamestr = ""
            testfirstnamestr = ""
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
        //newaboves
        
        
        
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
        // shufti details
        
        if let savedValue = defaults.string(forKey: "shufti_update_nationality"), savedValue != ""{
            str_nationality = savedValue
        } else {
            defaults.removeObject(forKey: "shufti_update_nationality")
//            defaults.set("", forKey: "shufti_update_nationality")
        }
        print("Rahul")
        print(defaults.string(forKey: "shufti_update_dob") ?? "Rahul")
        if let savedValue = defaults.string(forKey: "shufti_update_dob"), savedValue != ""{
            str_dob = convertDateFormater1(savedValue)
//            "2004-05-09 00:00:00.0";
        } else {
            defaults.removeObject(forKey: "shufti_update_dob")
//            defaults.set("", forKey: "shufti_update_dob")
        }
        
        if let savedValue = defaults.string(forKey: "shufti_update_name_en"), savedValue != ""{
            str_name_en = savedValue
            extractName()
        } else {
            defaults.removeObject(forKey: "shufti_update_name_en")
//            defaults.set("", forKey: "shufti_update_name_en")
            
//            testmiddlenamestr = str_customerMiddleName
//            testlastnamestr = str_customerLastName
//            testfirstnamestr = str_customerFirstName
            
        }
        
        if let savedValue = defaults.string(forKey: "shufti_update_name_ar"), savedValue != ""{
            str_name_ar = savedValue
        } else {
            defaults.removeObject(forKey: "shufti_update_name_ar")
//            defaults.set("", forKey: "shufti_update_name_ar")
        }
        
        if let savedValue = defaults.string(forKey: "shufti_update_id_exp_date"), savedValue != ""{
            
            str_id_exp_date = self.convertDateFormater1(savedValue)
        } else {
            defaults.removeObject(forKey: "shufti_update_id_exp_date")
//            defaults.set("", forKey: "shufti_update_id_exp_date")
        }
        
//        if let savedValue = defaults.string(forKey: "shufti_update_id_no"){
//            str_id_no = savedValue
//        } else {
//            defaults.set("", forKey: "shufti_update_id_no")
//        }
        
        
        //testfirstnamestr
        //testmiddlenamestr
        let appVersion = AppInfo.version
        print("appVersion",appVersion)
        print("testfirstnamestr",testfirstnamestr)
        
        let params:Parameters =  [
            "partnerId":partnerId,
            "token":token,
            "requestTime":dateTime,
            "customerIDNo":str_id_no,
            "customerRegNo":defaults.string(forKey: "REGNO")!,
            "customerFullName":str_name_en,
            "customerFirstName":testfirstnamestr,
            "customerMiddleName":testmiddlenamestr,
            "customerLastName":testlastnamestr,
            "customerFullNameArabic":str_name_ar,
            "customerAddress":str_address,
            "customerCity":str_city,
//            "customerMobile":"97498000092",
            "customerMobile":strMobile,
            "customerPhone":appVersion,
            "customerZipCode":"IOS",
//            "customerZipCode":self.str_customerZipCode,
            "customerCountry":self.dualnationalityselstr,
            "customerDOB":self.str_dob,
            "customerCountryOfBirth":"VIDEOS",
            "customerBirthPlace":str_nationality,
            "gender":str_gender,
            "customerNationality":str_nationality,
            "occupation":str_occupation,
            "email":strEmail,
            "customerIDType":"QID",
            "customerIDIssuedDate":self.str_id_exp_date,
            "customerIDExpiryDate":self.str_id_exp_date,
            "customerIDIssuedBy":self.str_id_issuer,
            "customerIDIssuedCountry":self.str_customerIDIssuedCountry,
            "visaNo":self.str_visaNo,
            "visaIssuedBy":self.str_visaIssuedBy,
            "visaIssuedDate":self.str_visaIssuedDate,
            "visaExpiryDate":self.str_visaExpiryDate,
            "visaType":self.str_visaType,
            "password":defaults.string(forKey: "PASSW")!,
            "mpin":defaults.string(forKey: "PIN")!,
            "idImageFront":strBase64 ?? "",
//            "idImageFront": "",
            "idImageBack":strBase641 ?? "",
//            "idImageBack": "",
            "idImageSelfie":strBase64Selfie ?? "",
//            "idImageSelfie": "",
            "idDocAdditional1":"",
            "idDocAdditional2":"",
            "employerName":str_employer,
            "workingAddress1":str_working_address,
            "workingAddress2":str_actualoccupation,
            "workingAddress3":self.str_workingAddress3,
            "expectedIncome":str_income,
            "mZone":str_zone,
            "securityQuestion3":str_buildingnotxtfd]
        
        print("urlupdate",url)
        print("paramsupdate",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            print("myResultupdate",response)
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let responseCode = myResult!["responseCode"].stringValue
                let respMsg = myResult!["responseMessage"].stringValue
                print("respupdate",response)
                self.effectView.removeFromSuperview()
                
                
                if(responseCode == "E9999")
                {
                    // AlertView.instance.showAlert(msg: respMsg, action: .attention)
                    // self.getPopupNotificationList()
                    self.getNewVersionalertList()
                }
                
                if(responseCode.contains("S"))
                {
                    // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                    
                    let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { action in
                        
                        
                        //self.disableFields()
                        
                        UserDefaults.standard.removeObject(forKey: "frontlabelphotostr")
                        UserDefaults.standard.removeObject(forKey: "backlabelphotostr")
                        UserDefaults.standard.removeObject(forKey: "selfielabelphotostr")
                        UserDefaults.standard.removeObject(forKey: "selfielabelphotostr")
                        
                        UserDefaults.standard.removeObject(forKey: "strBase64photo")
                        UserDefaults.standard.removeObject(forKey: "strBase641photo1")
                        UserDefaults.standard.removeObject(forKey: "strBase642photo2")
                        
                        
                        
                        
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        let vc: CustomTabController = UIStoryboard.init(name: "Main10", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                }
                else if(responseCode.contains("E")){
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                    
                    UserDefaults.standard.removeObject(forKey: "frontlabelphotostr")
                    UserDefaults.standard.removeObject(forKey: "backlabelphotostr")
                    UserDefaults.standard.removeObject(forKey: "selfielabelphotostr")
                    
                    UserDefaults.standard.removeObject(forKey: "strBase64photo")
                    UserDefaults.standard.removeObject(forKey: "strBase641photo1")
                    UserDefaults.standard.removeObject(forKey: "strBase642photo2")
                }
                
                
                
                else{
                    //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("acc_verif", comment: ""), action: "Ok")
                    
                    let respMsg = myResult!["responseMessage"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                    
                    // self.disableFields()
                    
                    UserDefaults.standard.removeObject(forKey: "frontlabelphotostr")
                    UserDefaults.standard.removeObject(forKey: "backlabelphotostr")
                    UserDefaults.standard.removeObject(forKey: "selfielabelphotostr")
                    
                    UserDefaults.standard.removeObject(forKey: "strBase64photo")
                    UserDefaults.standard.removeObject(forKey: "strBase641photo1")
                    UserDefaults.standard.removeObject(forKey: "strBase642photo2")
                }
            case .failure:
                break
            }
            
            
        })
    }
    func getNewVersionalertList() {
        var notificMessageList1: [String] = []
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "application_update_notification"
        let params:Parameters = ["lang": appLang,"device_type":"IOS"]
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
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
    
    
    func getCountryName(code:String,from:Int){
        print("from",from)
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "get_country_name_from_3lettercode"
        let params:Parameters = ["code":code]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp",response)
            let myResult = try? JSON(data: response.data!)
            let arrayResult  = myResult!["get_country"]
            for i in arrayResult.arrayValue{
                if(from == 1)
                {
                    self.nationalityTF.text = i["en_short_name"].stringValue
                }
                else if(from == 2)
                {
                    self.secNationalityTF.text = i["en_short_name"].stringValue
                }
            }
        })
    }
    func getCountry(completion: @escaping () -> Void) {
        self.countryResArray.removeAll()
        self.nationalityArray.removeAll()
        self.secNationalityArray.removeAll()
        //newserch
        self.checkarrayaoccunat.removeAll()
        self.checkarrayaoccunatstr.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "casmex/getMasterDetails"
        let params:Parameters = ["type":"nationality"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getCountry history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["data"]
//                self.nationalityFlagPath = myResult!["file_path"].stringValue
                for i in resultArray.arrayValue{
                    let nationality = CasmexNationality(id: i["id"].stringValue, description: i["description"].stringValue)
                    self.nationalityArray.append(nationality)
                    self.secNationalityArray.append(nationality)
                    if(nationality.description == "QATAR")
                    {
                        self.countryResArray.append(nationality)
                    }
                    
                    //new
                    self.checkarrayaoccunat.append(i["description"].stringValue)
                    self.checkarrayaoccunatstr.append(i["description"].stringValue)
                    
                }
                //                self.timerGesture.isEnabled = false
                //                self.timer.invalidate()
                
                break
            case .failure:
                break
            }
            completion()
        })
    }
    func getZone() {
        self.zoneArray.removeAll()
        
        //newserch
        self.checkarrayaoccuzone.removeAll()
        self.checkarrayaoccuzonestr.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.zoneArray.removeAll()
        let url = api_url + "zone_listing"
        //let params:Parameters = ["municipality":id,"keyword":searchText]
        let params:Parameters = ["municipality":""]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("zone list",response)
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
                
                //                self.timerGesture.isEnabled = false
                //                self.timer.invalidate()
                break
            case .failure:
                break
            }
        })
    }
    func getOccupations(completion: @escaping () -> Void) {
        
        self.occupationArray.removeAll()
        self.actualOccArray.removeAll()
        self.checkarrayaoccu.removeAll()
        self.checkarrayaoccustr.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "casmex/getMasterDetails"
        let params:Parameters =  [
            "type":"profession"
        ]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
            print("getOccupations history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                //let resultArray = myResult!["city_listing"]
                let resultArray = myResult!["data"]
                for i in resultArray.arrayValue{
                    let municipality = City(ge_city_name: i["description"].stringValue, id: i["id"].stringValue)
                    self.occupationArray.append(municipality)
                    self.actualOccArray.append(municipality)
                    self.checkarrayaoccu.append(i["description"].stringValue)
                    self.checkarrayaoccustr.append(i["id"].stringValue)
                    
                }
                //                    self.timerGesture.isEnabled = false
                //                    self.timer.invalidate()
                break
            case .failure:
                break
            }
            completion()
        })
    }
    
    
}
extension EditProfileVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == nationalityTF {
            currentDropdownSelection = .nationality
            //            addDropDown()
            addPopUp()
            return false
        }
        if textField == secNationalityTF {
            currentDropdownSelection = .secondNationality
            //            addDropDown()
            addPopUp()
            return false
        }
        if textField == zoneTF {
            currentDropdownSelection = .zone
            //            addDropDown()
            addPopUp()
            return false
        }
        if textField == occupationTF {
            currentDropdownSelection = .occupation
            //            addDropDown()
            addPopUp()
            return false
        }
        if textField == actualOccTF {
            currentDropdownSelection = .actualOcc
            //            addDropDown()
            addPopUp()
            return false
        }
//        if textField == idIssuerTF {
//            currentDropdownSelection = .idIssuer
//            //            addDropDown()
//            addPopUp()
//            return false
//        }
        return true
    }
}


