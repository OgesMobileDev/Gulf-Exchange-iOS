//
//  ActualOccupationViewController.swift
//  GulfExchangeApp
//
//  Created by test on 27/11/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit
import AVKit
import Alamofire
import SwiftyJSON
import Kingfisher
import AVFoundation
import Photos


class ActualOccupationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate  {
    
    var lastSelection: NSIndexPath!
    
    let playerViewController = AVPlayerViewController()
    
    var munsibtnnselstr:String = ""
    var occupationselstr:String = ""
    var actualoccupationselstr:String = ""
    
    var updateselcheckstr:String = ""
    
    var photoviewinputstr:String = ""
    
    
    var strBase64videoProfile:String!
    
    var strBase64:String!
    var strBase641:String!
    var strBase642:String!
    
    
    //new
    var checkarrayaoccustr  = Array<String>()
    var checkarrayaoccu  = Array<String>()
    var teststrcls : String = ""
    
    var searchedArray:[String] = Array()
    var occupationselsearchstr:String = ""
    
    
    @IBOutlet var actualocculabel: UILabel!
    
    
    @IBOutlet var actualoccutxtfd: UITextField!
    
    @IBOutlet weak var personalInfoLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameEnLbl: UILabel!
    @IBOutlet weak var fullnameEnTextField: UITextField!
    @IBOutlet weak var fullnameArLbl: UILabel!
    @IBOutlet weak var fullnameArTextField: UITextField!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var nationalityLbl: UILabel!
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var countryResidenceLbl: UILabel!
    @IBOutlet weak var countryResiBtn: UIButton!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var municipalityLbl: UILabel!
    @IBOutlet weak var municipalityBtn: UIButton!
    @IBOutlet weak var zoneLbl: UILabel!
    @IBOutlet weak var zoneBtn: UIButton!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var employerLbl: UILabel!
    @IBOutlet weak var employerTextField: UITextField!
    @IBOutlet weak var expectedIncomeLbl: UILabel!
    @IBOutlet weak var expectedIncomeTextField: UITextField!
    @IBOutlet weak var workingAddrLbl: UILabel!
    @IBOutlet weak var workingAddrTextField: UITextField!
    @IBOutlet weak var occupationLbl: UILabel!
    @IBOutlet weak var occupationTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var identificationDetails: UILabel!
    @IBOutlet weak var idTypeLbl: UILabel!
    @IBOutlet weak var idTypeBtn: UIButton!
    @IBOutlet weak var idIssuerLbl: UILabel!
    @IBOutlet weak var idIssuerBtn: UIButton!
    @IBOutlet weak var idNumLbl: UILabel!
    @IBOutlet weak var idNumTextField: UITextField!
    @IBOutlet weak var idExpLbl: UILabel!
    @IBOutlet weak var idExpTextField: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var updateTop: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tblIdType: UITableView!
    @IBOutlet weak var tblIdIssuer: UITableView!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var nationalityWhiteView: UIView!
    @IBOutlet weak var nationalitySearchTextField: UITextField!
    @IBOutlet weak var tblNationality: UITableView!
    @IBOutlet weak var municipalityView: UIView!
    @IBOutlet weak var municipalityWhiteView: UIView!
    @IBOutlet weak var municipalitySearchView: UITextField!
    @IBOutlet weak var tblMunicipality: UITableView!
    @IBOutlet weak var zoneView: UIView!
    @IBOutlet weak var zoneWhiteView: UIView!
    @IBOutlet weak var zoneSearchTextField: UITextField!
    @IBOutlet weak var tblzone: UITableView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderWhiteView: UIView!
    @IBOutlet weak var checkMaleBtn: UIButton!
    @IBOutlet weak var checkFemaleBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet var idfrontlabel: UILabel!
    
    @IBOutlet var idbacklabel: UILabel!
    
    
    @IBOutlet var idselfielabel: UILabel!
    
    
    @IBOutlet var idfrontbtn: UIButton!
    
    
    @IBAction func idfrontbtnAction(_ sender: Any)
    {
        self.view1.isHidden = true
        self.view2.isHidden = false
        print("id front","id front")
        
      if  updateselcheckstr == "1"
      {
        

        
//        self.strEmail = self.emailTextField.text!
//        self.defaults.set(self.strEmail, forKey: "strEmailnew")
//
//        self.str_name_en = self.fullnameEnTextField.text!
//        self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
        
        
        
        
        
        //new
       
        
        self.str_id_no = self.idNumTextField.text!
        self.defaults.set(self.str_id_no, forKey: "str_id_nonew")
        
        
        self.str_id_exp_date = self.idExpTextField.text!
        self.defaults.set(self.str_id_exp_date, forKey: "str_id_exp_datenew")
        
        
        self.str_name_en = self.fullnameEnTextField.text!
        self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
        
        self.str_name_ar = self.fullnameArTextField.text!
        self.defaults.set(self.str_name_ar, forKey: "str_name_arnew")
        
        self.strEmail = self.emailTextField.text!
        self.defaults.set(self.strEmail, forKey: "strEmailnew")
        
        self.str_dob = self.dobTextField.text!
        self.defaults.set(self.str_dob, forKey: "str_dobnew")
        
        self.defaults.set(self.str_nationality, forKey: "str_nationalitynew")
        
        self.str_address = self.addressTextField.text!
        self.defaults.set(self.str_address, forKey: "str_addressnew")
        
        self.str_city = self.municipalityBtn.titleLabel?.text as! String
        self.defaults.set(self.str_city, forKey: "str_citynew")
        
        self.str_gender = self.genderBtn.titleLabel?.text as! String
        self.defaults.set(self.str_gender, forKey: "str_gendernew")
        
        self.str_employer = self.employerTextField.text!
        self.defaults.set(self.str_employer, forKey: "str_employernew")
        
        //ivde occupation
        //ivde occupation
        //typetextfd only or save in only didselect
//        self.str_occupation = self.occupationTextField.text!
//        self.defaults.set(self.str_occupation, forKey: "str_occupationnew")
        
       // occcunewtextinte
        str_occupationtext = self.occupationTextField.text!
        self.defaults.set(self.str_occupationtext, forKey: "str_occupationnewtext")
        
        self.str_working_address = self.workingAddrTextField.text!
        self.defaults.set(self.str_working_address, forKey: "str_working_addressnew")
        
        
        self.str_income = self.expectedIncomeTextField.text!
        self.defaults.set(self.str_income, forKey: "str_incomenew")
        
        self.str_zone = self.zoneBtn.titleLabel?.text as! String
        self.defaults.set(self.str_zone, forKey: "str_zonenew")
        
        self.strMobile = self.mobileTextField.text!
        self.defaults.set(self.strMobile, forKey: "strMobilenew")


        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfilePhoto1ViewController") as! ProfilePhoto1ViewController
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
//
//        let classAndSubjectVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePhoto1ViewController") as! BuyInsurancedetails
//
//
//        self.navigationController?.pushViewController(classAndSubjectVC, animated: true)
        
      }
    else
      {
        //apiprofileview
        photoviewinputstr = "F"
        self.getToken(num: 3)
        

        
      }
        
        
    }
    
    @IBOutlet var idbackbtn: UIButton!
    
    
    @IBAction func idbackbtnAction(_ sender: Any)
    {
        self.view1.isHidden = true
        self.view2.isHidden = false
        print("idback ","idback")
        
        if  updateselcheckstr == "1"
        {
            
            

            
//
//            self.strEmail = self.emailTextField.text!
//            self.defaults.set(self.strEmail, forKey: "strEmailnew")
//
//            self.str_name_en = self.fullnameEnTextField.text!
//            self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
            
            
            
            //new
           
            
            self.str_id_no = self.idNumTextField.text!
            self.defaults.set(self.str_id_no, forKey: "str_id_nonew")
            
            
            self.str_id_exp_date = self.idExpTextField.text!
            self.defaults.set(self.str_id_exp_date, forKey: "str_id_exp_datenew")
            
            
            self.str_name_en = self.fullnameEnTextField.text!
            self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
            
            self.str_name_ar = self.fullnameArTextField.text!
            self.defaults.set(self.str_name_ar, forKey: "str_name_arnew")
            
            self.strEmail = self.emailTextField.text!
            self.defaults.set(self.strEmail, forKey: "strEmailnew")
            
            self.str_dob = self.dobTextField.text!
            self.defaults.set(self.str_dob, forKey: "str_dobnew")
            
            self.defaults.set(self.str_nationality, forKey: "str_nationalitynew")
            
            self.str_address = self.addressTextField.text!
            self.defaults.set(self.str_address, forKey: "str_addressnew")
            
            self.str_city = self.municipalityBtn.titleLabel?.text as! String
            self.defaults.set(self.str_city, forKey: "str_citynew")
            
            self.str_gender = self.genderBtn.titleLabel?.text as! String
            self.defaults.set(self.str_gender, forKey: "str_gendernew")
            
            self.str_employer = self.employerTextField.text!
            self.defaults.set(self.str_employer, forKey: "str_employernew")
            
            //ivde occupation
            //ivde occupation
            //typetextfd only or save in only didselect
//            self.str_occupation = self.occupationTextField.text!
//            self.defaults.set(self.str_occupation, forKey: "str_occupationnew")
            
            // occcunewtextinte
             str_occupationtext = self.occupationTextField.text!
             self.defaults.set(self.str_occupationtext, forKey: "str_occupationnewtext")

            
            
            self.str_working_address = self.workingAddrTextField.text!
            self.defaults.set(self.str_working_address, forKey: "str_working_addressnew")
            
            
            self.str_income = self.expectedIncomeTextField.text!
            self.defaults.set(self.str_income, forKey: "str_incomenew")
            
            self.str_zone = self.zoneBtn.titleLabel?.text as! String
            self.defaults.set(self.str_zone, forKey: "str_zonenew")
            
            self.strMobile = self.mobileTextField.text!
            self.defaults.set(self.strMobile, forKey: "strMobilenew")

            
            
            
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfilePhoto2ViewController") as! ProfilePhoto2ViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
          
        }
      else
        {
          //apiprofileview
            photoviewinputstr = "B"
            self.getToken(num: 3)

          
        }
        
        
    }
    
    
    @IBOutlet var selfibtn: UIButton!
    
    
    
    @IBAction func selfibtnAction(_ sender: Any)
    {
        self.view1.isHidden = true
        self.view2.isHidden = false
        print("sel;fi ","sel;fi")
        
        if  updateselcheckstr == "1"
        {
            

            
            self.strEmail = self.emailTextField.text!
            self.defaults.set(self.strEmail, forKey: "strEmailnew")
            
            self.str_name_en = self.fullnameEnTextField.text!
            self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
            
            
            
            
            //new
           
            
            self.str_id_no = self.idNumTextField.text!
            self.defaults.set(self.str_id_no, forKey: "str_id_nonew")
            
            
            self.str_id_exp_date = self.idExpTextField.text!
            self.defaults.set(self.str_id_exp_date, forKey: "str_id_exp_datenew")
            
            
            self.str_name_en = self.fullnameEnTextField.text!
            self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
            
            self.str_name_ar = self.fullnameArTextField.text!
            self.defaults.set(self.str_name_ar, forKey: "str_name_arnew")
            
            self.strEmail = self.emailTextField.text!
            self.defaults.set(self.strEmail, forKey: "strEmailnew")
            
            self.str_dob = self.dobTextField.text!
            self.defaults.set(self.str_dob, forKey: "str_dobnew")
            
            self.defaults.set(self.str_nationality, forKey: "str_nationalitynew")
            
            self.str_address = self.addressTextField.text!
            self.defaults.set(self.str_address, forKey: "str_addressnew")
            
            self.str_city = self.municipalityBtn.titleLabel?.text as! String
            self.defaults.set(self.str_city, forKey: "str_citynew")
            
            self.str_gender = self.genderBtn.titleLabel?.text as! String
            self.defaults.set(self.str_gender, forKey: "str_gendernew")
            
            self.str_employer = self.employerTextField.text!
            self.defaults.set(self.str_employer, forKey: "str_employernew")
            
            //ivde occupation
            //ivde occupation
            //typetextfd only or save in only didselect
//            self.str_occupation = self.occupationTextField.text!
//            self.defaults.set(self.str_occupation, forKey: "str_occupationnew")
            
            // occcunewtextinte
             str_occupationtext = self.occupationTextField.text!
             self.defaults.set(self.str_occupationtext, forKey: "str_occupationnewtext")
            
            
            self.str_working_address = self.workingAddrTextField.text!
            self.defaults.set(self.str_working_address, forKey: "str_working_addressnew")
            
            
            self.str_income = self.expectedIncomeTextField.text!
            self.defaults.set(self.str_income, forKey: "str_incomenew")
            
            self.str_zone = self.zoneBtn.titleLabel?.text as! String
            self.defaults.set(self.str_zone, forKey: "str_zonenew")
            
            self.strMobile = self.mobileTextField.text!
            self.defaults.set(self.strMobile, forKey: "strMobilenew")

            
            
            
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViedionewViewController") as! ProfileViedionewViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
          
            
            
          
        }
      else
        {
          //apiprofileview
            photoviewinputstr = "S"
            self.getToken(num: 3)
            

          
        }
        
        
        
    }
    
    
    let defaults = UserDefaults.standard
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    var userAge:Double?
    var udid:String!
    var nationalityArray:[Country] = []
    var countryResArray:[Country] = []
    var zoneArray:[Zone] = []
    var checkCountry:Int = 0
    var nationalityFlagPath:String = ""
    
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
    var str_income:String = ""
    var str_zone:String = ""
    var strMobile:String = ""
    
    var testfirstnamestr:String = ""
    var testlastnamestr:String = ""
    var testmiddlenamestr:String = ""
    
    var municipality_id:String = ""
     var municipality_idoccupationid:String = ""
    
    
    var backbtnteststr:String = ""
    
    
    var municipalityArray:[City] = []
    var checkGender:Int = 0
    
        //test
        static let AlamoFireManager: Alamofire.Session = {
            let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
            let configuration = URLSessionConfiguration.af.default
            return Session(configuration: configuration, serverTrustManager: manager)
        }()
//
        //production
//          static let AlamoFireManager: Alamofire.Session = {
//        //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
//                let configuration = URLSessionConfiguration.af.default
//                return Session(configuration: configuration)
//        //        return Session(configuration: configuration, serverTrustManager: manager)
//            }()
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    let idTypeArray = ["QID"]
    let idIssuerArray = ["Ministry of Interior","Ministry of Foreign Affairs"]
    
    
    override func viewDidLoad() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        

    
        
       // view2.isHidden = true
        //newbackbtn
        let custmBackBtn = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .done, target: self, action: #selector(Backbtnaction))
        self.navigationItem.leftBarButtonItem  = custmBackBtn
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didRecognizeTapGesture(_:)))

         occupationTextField.addGestureRecognizer(tapGesture)
        
        let tapGestureone = UITapGestureRecognizer(target: self, action: #selector(didRecognizeTapGestureone(_:)))

         actualoccutxtfd.addGestureRecognizer(tapGestureone)
        
        
        
        super.viewDidLoad()
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            emailTextField.textAlignment = .right
            fullnameEnTextField.textAlignment = .right
            fullnameArTextField.textAlignment = .right
            dobTextField.textAlignment = .right
            addressTextField.textAlignment = .right
            mobileTextField.textAlignment = .right
            employerTextField.textAlignment = .right
            expectedIncomeTextField.textAlignment = .right
            workingAddrTextField.textAlignment = .right
            occupationTextField.textAlignment = .right
            idNumTextField.textAlignment = .right
            idExpTextField.textAlignment = .right
            nationalitySearchTextField.textAlignment = .right
            municipalitySearchView.textAlignment = .right
            zoneSearchTextField.textAlignment = .right
        } else {
            emailTextField.textAlignment = .left
            fullnameEnTextField.textAlignment = .left
            fullnameArTextField.textAlignment = .left
            dobTextField.textAlignment = .left
            addressTextField.textAlignment = .left
            mobileTextField.textAlignment = .left
            employerTextField.textAlignment = .left
            expectedIncomeTextField.textAlignment = .left
            workingAddrTextField.textAlignment = .left
            occupationTextField.textAlignment = .left
            idNumTextField.textAlignment = .left
            idExpTextField.textAlignment = .left
            nationalitySearchTextField.textAlignment = .left
            municipalitySearchView.textAlignment = .left
            zoneSearchTextField.textAlignment = .left
        }
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: ""), style: .done, target: self, action: #selector(heplVCAction))
        let custmEditProfileBtn = UIBarButtonItem(image: UIImage(named: ""), style: .done, target: self, action: #selector(editProfile))
        self.navigationItem.rightBarButtonItems  = [custmHelpBtn,custmEditProfileBtn]
        self.title = ""
        
        
        navigationItem.rightBarButtonItem?.title = "UPDATE"
        
        nextBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        nextBtn.layer.cornerRadius = 15
        updateBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        updateBtn.layer.cornerRadius = 15
        backBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        backBtn.layer.cornerRadius = 15
        
        nationalityBtn.layer.cornerRadius = 5
        nationalityBtn.layer.borderWidth = 0.8
        nationalityBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
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
        
        idTypeBtn.layer.cornerRadius = 5
        idTypeBtn.layer.borderWidth = 0.8
        idTypeBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        idIssuerBtn.layer.cornerRadius = 5
        idIssuerBtn.layer.borderWidth = 0.8
        idIssuerBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        UserDefaults.standard.removeObject(forKey: "str_actualoccupationhomeupdate")
        
        
//        self.idNumTextField.delegate = self
//
//        self.tblIdType.delegate = self
//        self.tblIdType.dataSource = self
//
//        self.tblIdIssuer.delegate = self
//        self.tblIdIssuer.dataSource = self
//        self.tblNationality.delegate = self
//        self.tblNationality.dataSource = self
//        self.tblMunicipality.dataSource = self
//        self.tblMunicipality.delegate = self
//        self.tblzone.delegate = self
//        self.tblzone.dataSource = self
//        self.nationalitySearchTextField.delegate = self
//        self.municipalitySearchView.delegate = self
//        self.zoneSearchTextField.delegate = self
        
        self.nationalityWhiteView.layer.cornerRadius = 15
        self.municipalityWhiteView.layer.cornerRadius = 15
        self.zoneWhiteView.layer.cornerRadius = 15
        
       // updateTop.constant = 0
      //  setFont()
       // setFontSize()
        
        //self.getToken(num: 1)
       // self.createToolbar()
      //  self.createToolbar1()
       // getMunicipality(searchText: "")
       // nationalitySearchTextField.addTarget(self, action: #selector(ProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
        municipalitySearchView.addTarget(self, action: #selector(ProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
       // zoneSearchTextField.addTarget(self, action: #selector(ProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        //do
            self.tblMunicipality.reloadData()
             municipalityView.isHidden = false
             self.municipalitySearchView.text = ""
             //self.getMunicipality(searchText: "")
         self.getMunicipalityactualoccupationidapi(searchText: "")

         self.municipalitySearchView.isHidden = false
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
    
    @objc func Backbtnaction(){
        
        
        if backbtnteststr == "1"
        {
            municipalityView.isHidden = true
            view1.isHidden = false
            self.backbtnteststr = "0"
        }
        else
        {
//
//            for controller in self.navigationController!.viewControllers as Array {
//                                 if controller.isKind(of: HomeViewController.self) {
//                                     self.navigationController!.popToViewController(controller, animated: true)
//                                     break
//                                 }
//                             }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc private dynamic func didRecognizeTapGesture(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view)

        backbtnteststr = "1"
        occupationselstr = "occubtnselstr"
        munsibtnnselstr = ""
        actualoccupationselstr = ""
        print("benfi---","55554")
       //do
           self.tblMunicipality.reloadData()
            municipalityView.isHidden = false
            self.municipalitySearchView.text = ""
            //self.getMunicipality(searchText: "")
        self.getMunicipalityoccupationidapi(searchText: "")

        self.municipalitySearchView.isHidden = false

        guard gesture.state == .ended, occupationTextField.frame.contains(point) else { return }

        //donomething()
        print("benfi---","55554")
    }
    
    
    
    
    @objc private dynamic func didRecognizeTapGestureone(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view)

        //backbtnteststr = "1"
        occupationselstr = ""
        munsibtnnselstr = ""
        actualoccupationselstr = "actualoccupationselstr"
        print("benfiactualoccu---","55554")
       //do
           self.tblMunicipality.reloadData()
            municipalityView.isHidden = false
            self.municipalitySearchView.text = ""
            //self.getMunicipality(searchText: "")
        self.getMunicipalityactualoccupationidapi(searchText: "")

        self.municipalitySearchView.isHidden = false

        guard gesture.state == .ended, actualoccutxtfd.frame.contains(point) else { return }

        //donomething()
        print("benfi---","55554")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
       // print("benfi---","55554")
        
        print("front---","chikksss")

        
        if ((self.defaults.string(forKey: "frontlabelphotostr")?.isEmpty) != nil) || ((self.defaults.string(forKey: "backlabelphotostr")?.isEmpty) != nil) || ((self.defaults.string(forKey: "selfielabelphotostr")?.isEmpty) != nil || ((self.defaults.string(forKey: "photovcyesstr")?.isEmpty) != nil))
        {
//            self.strEmail = defaults.string(forKey: "strEmailnew")!
//            self.emailTextField.text! = self.strEmail
//
//            self.str_name_en = defaults.string(forKey: "str_name_ennew")!
//            self.fullnameEnTextField.text! = self.str_name_en
            
            
            
            //new
           
            
            if ((self.defaults.string(forKey: "str_id_nonew")?.isEmpty) != nil)
            {
                self.str_id_no = defaults.string(forKey: "str_id_nonew")!
                self.idNumTextField.text! = self.str_id_no
                
            }
            else
            {
                self.str_id_no = ""
                self.idNumTextField.text! = ""
                
            }
           
          //
            if ((self.defaults.string(forKey: "str_id_exp_datenew")?.isEmpty) != nil)
            {
                self.str_id_exp_date = defaults.string(forKey: "str_id_exp_datenew")!
                self.idExpTextField.text! = self.str_id_exp_date
                
            }
            else
            {
                self.str_id_exp_date = ""
                self.idExpTextField.text! = ""
            }
            
      
            //
            if ((self.defaults.string(forKey: "str_name_ennew")?.isEmpty) != nil)
            {
                self.str_name_en = defaults.string(forKey: "str_name_ennew")!
                self.fullnameEnTextField.text! = self.str_name_en
                
                
            }
            else
            {
                self.str_name_en = ""
                self.fullnameEnTextField.text! = ""
                
            }
            
            //
            if ((self.defaults.string(forKey: "str_name_arnew")?.isEmpty) != nil)
            {
                self.str_name_ar = defaults.string(forKey: "str_name_arnew")!
                self.fullnameArTextField.text! = self.str_name_ar
                
                
            }
            else
            {
                self.str_name_ar = ""
                self.fullnameArTextField.text! = ""
                
            }
            
           //
            if ((self.defaults.string(forKey: "strEmailnew")?.isEmpty) != nil)
            {
                self.strEmail = defaults.string(forKey: "strEmailnew")!
                self.emailTextField.text! = self.strEmail
                
            }
            else
            {
                self.strEmail = ""
                self.emailTextField.text! = ""
            }
            
            if ((self.defaults.string(forKey: "str_dobnew")?.isEmpty) != nil)
            {
                self.str_dob = defaults.string(forKey: "str_dobnew")!
                self.dobTextField.text! = self.str_dob

                
            }
            else
            {
                self.str_dob = ""
                self.dobTextField.text! = self.str_dob

            }
            
            if ((self.defaults.string(forKey: "str_nationalitynew")?.isEmpty) != nil)
            {
                
                self.str_nationality = defaults.string(forKey: "str_nationalitynew")!
                self.nationalityBtn.setTitle(str_nationality, for: .normal)
                
            }
            else
            {
                
                self.str_nationality = ""
                self.nationalityBtn.setTitle(str_nationality, for: .normal)
            }
            
            
           // self.defaults.set(self.str_nationality, forKey: "str_nationalitynew")
            
            
            if ((self.defaults.string(forKey: "str_addressnew")?.isEmpty) != nil)
            {
                self.str_address = defaults.string(forKey: "str_addressnew")!
                self.addressTextField.text! = self.str_address
                
            }
            else
            {
                self.str_address = ""
                self.addressTextField.text! = self.str_address
                
            }
            
            
            if ((self.defaults.string(forKey: "str_citynew")?.isEmpty) != nil)
            {
                //self.str_city = self.municipalityBtn.titleLabel?.text as! String
                self.str_city = defaults.string(forKey: "str_citynew")!
                self.municipalityBtn.setTitle(str_city, for: .normal)
            }
            else
            {
                //self.str_city = self.municipalityBtn.titleLabel?.text as! String
                self.str_city = ""
                self.municipalityBtn.setTitle(str_city, for: .normal)
            }
            
            
            
            if ((self.defaults.string(forKey: "str_gendernew")?.isEmpty) != nil)
            {
                // self.str_gender = self.genderBtn.titleLabel?.text as! String
                 self.str_gender = defaults.string(forKey: "str_gendernew")!
                 self.genderBtn.setTitle(str_gender, for: .normal)
                // self.defaults.set(self.str_gender, forKey: "str_gendernew")
                
            }
            
            else
            {
                // self.str_gender = self.genderBtn.titleLabel?.text as! String
                 self.str_gender = ""
                 self.genderBtn.setTitle(str_gender, for: .normal)
                // self.defaults.set(self.str_gender, forKey: "str_gendernew")
            }

            
            if ((self.defaults.string(forKey: "str_employernew")?.isEmpty) != nil)
            {
                self.str_employer = defaults.string(forKey: "str_employernew")!
                self.employerTextField.text! = self.str_employer
                
            }
            else
            {
                self.str_employer = ""
                self.employerTextField.text! = self.str_employer
            }
            
            
      
            if ((self.defaults.string(forKey: "str_occupationnewtext")?.isEmpty) != nil)
            {
                //ivde occupation
               
            self.str_occupationtext = defaults.string(forKey: "str_occupationnewtext")!
            self.occupationTextField.text! = self.str_occupationtext
                
            }
            else
            {
               
            self.str_occupationtext = ""
            self.occupationTextField.text! = self.str_occupationtext
            }
            //
            if ((self.defaults.string(forKey: "str_actualoccupation")?.isEmpty) != nil)
            {
                //ivde occupation
               
            self.str_actualoccupation = defaults.string(forKey: "str_actualoccupation")!
            self.actualoccutxtfd.text! = self.str_occupationtext
                
            }
            else
            {
               
            self.str_actualoccupation = ""
            self.actualoccutxtfd.text! = self.str_actualoccupation
            }
            
            
            

                    
            if ((self.defaults.string(forKey: "str_working_addressnew")?.isEmpty) != nil)
            {
                self.str_working_address = defaults.string(forKey: "str_working_addressnew")!
                
                self.workingAddrTextField.text! = self.str_working_address
                           
                
            }
            else
            {
                self.str_working_address = ""
                
                self.workingAddrTextField.text! = self.str_working_address
                           
            }
            
             
            if ((self.defaults.string(forKey: "str_incomenew")?.isEmpty) != nil)
            {
                self.str_income   = defaults.string(forKey: "str_incomenew")!
                self.expectedIncomeTextField.text! =  self.str_income

                
            }
            else
            {
                self.str_income  = ""
                self.expectedIncomeTextField.text! =  self.str_income

            }
            
           
            if ((self.defaults.string(forKey: "str_zonenew")?.isEmpty) != nil)
            {
                // self.str_zone = self.zoneBtn.titleLabel?.text as! String
                 self.str_zone = defaults.string(forKey: "str_zonenew")!
                 self.zoneBtn.setTitle(str_zone, for: .normal)
                
            }
            else
            {
                // self.str_zone = self.zoneBtn.titleLabel?.text as! String
                 self.str_zone = ""
                 self.zoneBtn.setTitle(str_zone, for: .normal)
                 

            }
            
            if ((self.defaults.string(forKey: "strMobilenew")?.isEmpty) != nil)
            {
                self.strMobile = defaults.string(forKey: "strMobilenew")!
                self.mobileTextField.text! = self.strMobile

                
            }
            else
            {
                self.strMobile = ""
                self.mobileTextField.text! = self.strMobile

            }
                       
            

            
        }
        
       

        
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        self.validateMultipleLogin()
        
        
        
        
        //frontphotocheck
        let userdefaultfrontlabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultfrontlabelphotostr.string(forKey: "frontlabelphotostr"){
            print("Here you will get saved value")
           
            idfrontlabel.text = defaults.string(forKey: "frontlabelphotostr")
            idfrontlabel.textColor = UIColor.black
            //idfrontlabel.font = idfrontlabel.font.withSize(13)

            } else {
                idfrontlabel.text = "  id card front side photo"
                idfrontlabel.textColor = UIColor.lightGray
               // idfrontlabel.font = idfrontlabel.font.withSize(12)
        print("No value in Userdefault,Either you can save value here or perform other operation")
                userdefaultfrontlabelphotostr.set("", forKey: "key")
        }
        
        
        
        //backphotocheck
        let userdefaultbacklabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultbacklabelphotostr.string(forKey: "backlabelphotostr"){
            print("Here you will get saved value")
           
            idbacklabel.text = defaults.string(forKey: "backlabelphotostr")
            idbacklabel.textColor = UIColor.black
            //idbacklabel.font = idbacklabel.font.withSize(13)

            } else {
                idbacklabel.text = "  id card back side photo"
                idbacklabel.textColor = UIColor.lightGray
                //idbacklabel.font = idbacklabel.font.withSize(12)
           
        print("No value in Userdefault,Either you can save value here or perform other operation")
                userdefaultbacklabelphotostr.set("", forKey: "key")
        }
        
        
        
        //selfiphotocheck
        let userdefaultselfielabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultselfielabelphotostr.string(forKey: "selfielabelphotostr"){
            print("Here you will get saved value")
           
            idselfielabel.text = defaults.string(forKey: "selfielabelphotostr")
            idselfielabel.textColor = UIColor.black
           // idselfielabel.font = idselfielabel.font.withSize(13)

            } else {
                idselfielabel.text = "  selfie video"
                idselfielabel.textColor = UIColor.lightGray
                //idselfielabel.font = idselfielabel.font.withSize(12)
        print("No value in Userdefault,Either you can save value here or perform other operation")
                userdefaultselfielabelphotostr.set("", forKey: "key")
        }
        
        
        
    }
    func validateMultipleLogin() {
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            
            let url = api_url + "login_session"
        let params:Parameters = ["id_no":self.defaults.string(forKey: "USERID")!,"session_id":self.udid!]

              AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                self.effectView.removeFromSuperview()
                print("resp1111",response)
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)
                    let code = myresult!["scode"]
                    if(code == 1)
                    {
                        
                    }
                    else if(code == 2)
                    {
                        self.callLogout()
                    }
                    break
                case .failure:
                    break
                
                }
              })
           
        
    }
    func callLogout() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = api_url + "login_session_delete"
        let params:Parameters = ["id_no":self.defaults.string(forKey: "USERID")!,"session_id":udid!]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp2222",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let code = myresult!["scode"]
                
                if(code == 1)
                {
                    self.defaults.set("", forKey: "USERID")
                    self.defaults.set("", forKey: "PASSW")
                    self.defaults.set("", forKey: "PIN")
                    self.defaults.set("", forKey: "REGNO")
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
                    //        self.navigationController?.pushViewController(nextViewController, animated: true)
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                break
            case .failure:
                break
            
            }
          })
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField == nationalitySearchTextField)
        {
            if(nationalitySearchTextField.text?.count == 0)
            {
                view.endEditing(true)
                self.getCountry(searchText: "")
            }
        }
        else if(textField == municipalitySearchView)
        {
            if(municipalitySearchView.text?.count == 0)
            {
                //getMunicipality(searchText: "")
               // getMunicipality(searchText: "")
                view.endEditing(true)
            self.occupationselsearchstr = ""
            self.municipalityArray.removeAll()
                backbtnteststr = ""
            self.getMunicipalityactualoccupationidapi(searchText: "")

            }
            else
            {
          
               //else
                if(municipalitySearchView.text!.count > 0)
                {
                    //if munsibtnnselstr == "munsibtnnselstr"
                    //{
                       //getMunicipality(searchText: "")
                        //self.getMunicipality(searchText: "")
                       // self.getMunicipality(searchText: self.municipalitySearchTextField.text!)
                      //  municipalitySearchView.isHidden = true
                       // tab2View.isHidden = false

                    //}
                   // else
                   // {
                        
                        self.occupationselsearchstr = "searchcliked"
                        self.searchedArray.removeAll()
//                        let fruitsArrayi = ["Orange","Litchi","PineApple","mango"]
//                        AllArray  = ["Orange","Litchi","PineApple","mango"]
//                        AllArrayid  = ["11","12","13","14"]
//
//                        let fruitsArrayiids = ["1","2","3","4"]
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

                        
                    backbtnteststr = ""
                        

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
                        
                    //}
                    
                   
                }
            
        }
            

            ///
        }
        else if(textField == zoneSearchTextField)
        {
            if(zoneSearchTextField.text?.count == 0)
            {
                view.endEditing(true)
                self.getZone(id: municipality_id, searchText: "")
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == nationalitySearchTextField)
        {
            if(nationalitySearchTextField.text?.count != 0)
            {
                self.getCountry(searchText: self.nationalitySearchTextField.text!)
            }
            
        }
        else if(textField == municipalitySearchView)
        {
            if(municipalitySearchView.text?.count != 0)
            {
                self.getMunicipality(searchText: self.municipalitySearchView.text!)
            }
        }
        else if(textField == zoneSearchTextField)
        {
            if(zoneSearchTextField.text?.count != 0)
            {
                self.getZone(id: municipality_id, searchText: self.zoneSearchTextField.text!)
            }
        }
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
    @IBAction func nationalityBtn(_ sender: Any) {
        self.checkCountry = 0
        self.tblNationality.reloadData()
        nationalityView.isHidden = false
        self.nationalitySearchTextField.text = ""
        self.getCountry(searchText: "")
        
    }
    @IBAction func countryResiBtn(_ sender: Any) {
        self.checkCountry = 1
        self.tblNationality.reloadData()
        nationalityView.isHidden = false
        self.nationalitySearchTextField.text = ""
        self.getCountry(searchText: "")
    }
    @IBAction func municipalityBtn(_ sender: Any) {
        
        
        self.occupationselstr = ""
        self.munsibtnnselstr = "munsibtnnselstr"
        self.actualoccupationselstr = ""
        
        self.tblMunicipality.reloadData()
        municipalityView.isHidden = false
        self.municipalitySearchView.text = ""
        self.getMunicipality(searchText: "")
    }
    @IBAction func zoneBtn(_ sender: Any) {
        if(municipalityBtn.titleLabel?.text == "Municipality" || municipality_id == "")
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_municipality", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            self.tblzone.reloadData()
            zoneView.isHidden = false
            self.zoneSearchTextField.text = ""
            self.getZone(id: municipality_id, searchText: self.zoneSearchTextField.text!)
        }
    }
    @IBAction func genderBtn(_ sender: Any) {
        self.genderView.isHidden = false
    }
    @IBAction func checkMaleBtn(_ sender: Any) {
        self.checkGender = 1
        checkMaleBtn.setImage(UIImage(named: "radio_green"), for: .normal)
        checkFemaleBtn.setImage(UIImage(named: "radio_light"), for: .normal)
    }
    @IBAction func checkFemaleBtn(_ sender: Any) {
        self.checkGender = 2
        checkFemaleBtn.setImage(UIImage(named: "radio_green"), for: .normal)
        checkMaleBtn.setImage(UIImage(named: "radio_light"), for: .normal)
    }
    @IBAction func okBtn(_ sender: Any) {
        if(checkGender == 0)
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else if(checkGender == 1)
        {
            genderView.isHidden = true
            self.genderBtn.setTitle("Male", for: .normal)
        }
        else
        {
            genderView.isHidden = true
            self.genderBtn.setTitle("Female", for: .normal)
        }
    }
    
    @objc func editProfile(){
        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pls_update_profile", comment: ""), action: NSLocalizedString("ok", comment: ""))
        self.enableFields()
        updateselcheckstr = "1"
    }
    func enableFields() {
        
        
        updateselcheckstr = "1"
        
        idbackbtn.backgroundColor = UIColor.red
        idfrontbtn.backgroundColor = UIColor.red
        selfibtn.backgroundColor = UIColor.red
        
        idbackbtn.setTitle("Choose", for: .normal)
        idfrontbtn.setTitle("Choose", for: .normal)
        selfibtn.setTitle("Choose", for: .normal)
        
        //frontphotocheck
        let userdefaultfrontlabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultfrontlabelphotostr.string(forKey: "frontlabelphotostr"){
            print("Here you will get saved value")
           
            idfrontlabel.text = defaults.string(forKey: "frontlabelphotostr")
            //idfrontlabel.font = idfrontlabel.font.withSize(13)
            } else {
                idfrontlabel.text = "  id card front side photo"
                //idfrontlabel.font = idfrontlabel.font.withSize(12)
           
        print("No value in Userdefault,Either you can save value here or perform other operation")
                userdefaultfrontlabelphotostr.set("", forKey: "key")
        }
        
        
        
        //backphotocheck
        let userdefaultbacklabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultbacklabelphotostr.string(forKey: "backlabelphotostr"){
            print("Here you will get saved value")
           
            idbacklabel.text = defaults.string(forKey: "backlabelphotostr")
            //idbacklabel.font = idbacklabel.font.withSize(13)
            } else {
                idbacklabel.text = "  id card back side photo"
                //idbacklabel.font = idbacklabel.font.withSize(12)
           
        print("No value in Userdefault,Either you can save value here or perform other operation")
                userdefaultbacklabelphotostr.set("", forKey: "key")
        }
        
        
        
        //selfiphotocheck
        let userdefaultselfielabelphotostr = UserDefaults.standard
        if let savedValue = userdefaultselfielabelphotostr.string(forKey: "selfielabelphotostr"){
            print("Here you will get saved value")
           
            idselfielabel.text = defaults.string(forKey: "selfielabelphotostr")
           // idselfielabel.font = idselfielabel.font.withSize(13)
            } else {
                idselfielabel.text = "  selfie video"
               // idselfielabel.font = idselfielabel.font.withSize(12)
           
        print("No value in Userdefault,Either you can save value here or perform other operation")
                userdefaultselfielabelphotostr.set("", forKey: "key")
        }
        
        
        
      
        
        idbackbtn.setTitleColor(.white, for: .normal)
        idfrontbtn.setTitleColor(.white, for: .normal)
        selfibtn.setTitleColor(.white, for: .normal)
        
       // idfrontlabel.backgroundColor = UIColor.lightGray
        idfrontlabel.layer.cornerRadius = 5
        idfrontlabel.layer.borderWidth = 1
        idfrontlabel.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        idfrontlabel.textColor = UIColor.lightGray
        
        
        //idbacklabel.backgroundColor = UIColor.lightGray
        idbacklabel.layer.cornerRadius = 5
        idbacklabel.layer.borderWidth = 1
        idbacklabel.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
    
        idbacklabel.textColor = UIColor.lightGray
        
        
        
        idselfielabel.layer.cornerRadius = 5
        idselfielabel.layer.borderWidth = 1
        idselfielabel.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
       // idselfielabel.backgroundColor = UIColor.lightGray
        idselfielabel.textColor = UIColor.lightGray
        
        
//        self.emailTextField.isUserInteractionEnabled = true
        self.fullnameEnTextField.isUserInteractionEnabled = true
        self.fullnameArTextField.isUserInteractionEnabled = true
        self.dobTextField.isUserInteractionEnabled = true
        self.nationalityBtn.isUserInteractionEnabled = true
        self.countryResiBtn.isUserInteractionEnabled = true
        self.addressTextField.isUserInteractionEnabled = true
        self.municipalityBtn.isUserInteractionEnabled = true
        self.zoneBtn.isUserInteractionEnabled = true
        self.genderBtn.isUserInteractionEnabled = true
//        self.mobileTextField.isUserInteractionEnabled = true
        self.employerTextField.isUserInteractionEnabled = true
        self.expectedIncomeTextField.isUserInteractionEnabled = true
        self.workingAddrTextField.isUserInteractionEnabled = true
        self.occupationTextField.isUserInteractionEnabled = true
        self.actualoccutxtfd.isUserInteractionEnabled = true
        
//        self.idTypeBtn.isUserInteractionEnabled = true
        self.idIssuerBtn.isUserInteractionEnabled = true
//        self.idNumTextField.isUserInteractionEnabled = true
        self.idExpTextField.isUserInteractionEnabled = true
        self.updateBtn.isHidden = false
        self.updateTop.constant = 30
        self.idbackbtn.isUserInteractionEnabled = true
        self.idfrontbtn.isUserInteractionEnabled = true
        self.selfibtn.isUserInteractionEnabled = true
    }
    func disableFields() {
        self.emailTextField.isUserInteractionEnabled = false
        self.fullnameEnTextField.isUserInteractionEnabled = false
        self.fullnameArTextField.isUserInteractionEnabled = false
        self.dobTextField.isUserInteractionEnabled = false
        self.nationalityBtn.isUserInteractionEnabled = false
        self.countryResiBtn.isUserInteractionEnabled = false
        self.addressTextField.isUserInteractionEnabled = false
        self.municipalityBtn.isUserInteractionEnabled = false
        self.zoneBtn.isUserInteractionEnabled = false
        self.genderBtn.isUserInteractionEnabled = false
        self.mobileTextField.isUserInteractionEnabled = false
        self.employerTextField.isUserInteractionEnabled = false
        self.expectedIncomeTextField.isUserInteractionEnabled = false
        self.workingAddrTextField.isUserInteractionEnabled = false
        self.occupationTextField.isUserInteractionEnabled = false
        self.actualoccutxtfd.isUserInteractionEnabled = false
        self.idTypeBtn.isUserInteractionEnabled = false
        self.idIssuerBtn.isUserInteractionEnabled = false
        self.idNumTextField.isUserInteractionEnabled = false
        self.idExpTextField.isUserInteractionEnabled = false
        self.updateBtn.isHidden = true
        self.updateTop.constant = 0
        
        self.idbackbtn.isUserInteractionEnabled = false
        self.idfrontbtn.isUserInteractionEnabled = false
        self.selfibtn.isUserInteractionEnabled = false
        
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
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
        idExpTextField.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        let today = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -89, to: today)!
        idExpTextField.inputView = datePicker
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
        idExpTextField.text = dateFormat.string(from: datePicker.date)
        view.endEditing(true)
    }
    @objc func showdate1()
        {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd-MM-yyyy"
            dobTextField.text = dateFormat.string(from: datePicker1.date)
            print(dobTextField.text)
            let components = NSCalendar.current.dateComponents([.day,.month,.year],from:dateFormat.date(from: dobTextField.text!)!)
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
            view.endEditing(true)
        }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        print("stractualidpass",self.str_actualoccupation)
        
      if backbtnteststr == "0"
      {
        self.getToken(num: 2)
      }
        else
      {
        
      }
        
//        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
//        self.navigationController?.pushViewController(vc, animated: true)
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
        self.view1.isHidden = true
        self.view2.isHidden = false
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    @IBAction func updateBtn(_ sender: Any) {
//        guard let email = emailTextField.text,emailTextField.text?.count != 0 else
//        {
//            self.view1.isHidden = false
//            self.view2.isHidden = true
//            self.scrollView.setContentOffset(.zero, animated: true)
//            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Please enter email id", action: NSLocalizedString("ok", comment: ""))
//            return
//        }
        

        
        
        var str = fullnameEnTextField.text
        str = str!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(str)
        // "this is the answer"
        print("strii",str)
        fullnameEnTextField.text =  str
        print("striifullnameEnTextField.text",fullnameEnTextField.text)
        
        //extraspace remove
        let startingString = fullnameEnTextField.text!
        let processedString = startingString.removeExtraSpacesprofile()
        print("processedString:\(processedString)")
        fullnameEnTextField.text = processedString
        
        guard let name_en = fullnameEnTextField.text,fullnameEnTextField.text?.count != 0 else
        {
            self.view1.isHidden = false
            self.view2.isHidden = true
            self.scrollView.setContentOffset(.zero, animated: true)
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_fullname_en", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
            
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
             return
         }
        
        
        guard let dob = dobTextField.text,dobTextField.text?.count != 0 else
        {
            self.view1.isHidden = false
            self.view2.isHidden = true
            self.scrollView.setContentOffset(.zero, animated: true)
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_dob", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        let components = NSCalendar.current.dateComponents([.day,.month,.year],from:dateFormat.date(from: dobTextField.text!)!)
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
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("invalid_dob", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        var straddress = addressTextField.text
        straddress = straddress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(straddress)
        // "this is the answer"
        print("straddress",straddress)
        addressTextField.text =  straddress
        print("addressTextField.text",addressTextField.text)
        
        
        //extraspace remove
        let startingStringhomeadress = addressTextField.text!
        let processedStringhomeaddress = startingStringhomeadress.removeExtraSpacesprofile()
        print("processedStringhomeadress:\(processedStringhomeaddress)")
        addressTextField.text = processedStringhomeaddress
        
        guard let addr = addressTextField.text,addressTextField.text?.count != 0 else
        {
            self.view1.isHidden = false
            self.view2.isHidden = true
            self.scrollView.setContentOffset(.zero, animated: true)
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_addr", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        var charSethomeAddr = CharacterSet.init(charactersIn: "@#$%+_&'()*,/:;<=>?[]^`{|}~)(")
                 var string2homeAddr = addr

                 if let strvalue = string2homeAddr.rangeOfCharacter(from: charSethomeAddr)
                 {
                     print("true")
//                     let alert = UIAlertController(title: "Alert", message: "Please enter valid address", preferredStyle: UIAlertController.Style.alert)
//                     alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                     self.present(alert, animated: true, completion: nil)
//                     print("check name",self.addressTextField.text)
                    
                    alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid address", comment: ""), action: NSLocalizedString("ok", comment: ""))
                             return
                     
                 }
        
        
        
        
        
        if(zoneBtn.titleLabel?.text == "Zone")
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_zone", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
//        guard let mobile = mobileTextField.text,mobileTextField.text?.count != 0 else
//        {
//            self.view1.isHidden = false
//            self.view2.isHidden = true
//            self.scrollView.setContentOffset(.zero, animated: true)
//            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Please enter mobile number", action: "Ok")
//            return
//        }
        
        
        var stremployer = employerTextField.text
        stremployer = stremployer!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(stremployer)
        // "this is the answer"
        print("stremployer",stremployer)
        employerTextField.text =  stremployer
        print("employerTextField.text",employerTextField.text)
        
        
        //extraspace remove
        let startingStringemployer = employerTextField.text!
        let processedStringemployer = startingStringemployer.removeExtraSpacesprofile()
        print("processedStringemployer:\(processedStringemployer)")
        employerTextField.text = processedStringemployer
        
        guard let emp = employerTextField.text,employerTextField.text?.count != 0 else
        {
            self.view1.isHidden = false
            self.view2.isHidden = true
            self.scrollView.setContentOffset(.zero, animated: true)
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_employer_name", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
                
                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid employer", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
                   
               }
        
        
        
        
        
        var strexpincome = expectedIncomeTextField.text
        strexpincome = strexpincome!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strexpincome)
        // "this is the answer"
        print("strexpincome",strexpincome)
        expectedIncomeTextField.text =  strexpincome
        print("expectedIncomeTextField.text",expectedIncomeTextField.text)
        
        
        
        //extraspace remove
        let startingStringexpincome = expectedIncomeTextField.text!
        let processedStringexpincome = startingStringexpincome.removeExtraSpacesprofilenospace()
        print("processedStringexpincome:\(processedStringexpincome)")
        expectedIncomeTextField.text = processedStringexpincome
        
        guard let exp_income = expectedIncomeTextField.text,expectedIncomeTextField.text?.count != 0 else
        {
            self.view1.isHidden = false
            self.view2.isHidden = true
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: "Ok")
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
                
                
                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
                           
            }
            
        if (!validate (value: self.expectedIncomeTextField.text!))
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_exp_income", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        
        var strworkaddress = workingAddrTextField.text
        strworkaddress = strworkaddress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strworkaddress)
        // "this is the answer"
        print("stremployer",strworkaddress)
        workingAddrTextField.text =  strworkaddress
        print("workingAddrTextField.text",workingAddrTextField.text)
        
        
        //extraspace remove
        let startingStringworkaddress = workingAddrTextField.text!
        let processedStringworkaddress = startingStringworkaddress.removeExtraSpacesprofile()
        print("processedStringworkaddress:\(processedStringworkaddress)")
        workingAddrTextField.text = processedStringworkaddress
        
        
        guard let work_addr = workingAddrTextField.text,workingAddrTextField.text?.count != 0 else
        {
            self.view1.isHidden = false
            self.view2.isHidden = true
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_working_address", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        var charSetaddress = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
         var string2address = work_addr

        if let strvalue = string2address.rangeOfCharacter(from: charSetaddress)
             {
                 print("true")
//                 let alert = UIAlertController(title: "Alert", message: "Please enter valid working address", preferredStyle: UIAlertController.Style.alert)
//                 alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                 self.present(alert, animated: true, completion: nil)
//                 print("check name",self.workingAddrTextField.text)
                
                
                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid working address", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
                            
             }
        
        
        var stroccupation = occupationTextField.text
        stroccupation = stroccupation!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(stroccupation)
        // "this is the answer"
        print("stremployer",stroccupation)
        occupationTextField.text =  stroccupation
        print("workingAddrTextField.text",occupationTextField.text)
        
        
        guard let occupation = occupationTextField.text,occupationTextField.text?.count != 0 else
        {
            self.view1.isHidden = false
            self.view2.isHidden = true
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_occupation", comment: ""), action: "Ok")
            return
        }
        
        guard let actualoccupation = actualoccutxtfd.text,actualoccutxtfd.text?.count != 0 else
        {
            
            self.view1.isHidden = false
            self.view2.isHidden = true
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Select Actual Occupation", action: NSLocalizedString("ok", comment: ""))
            return
        }

        
        
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
        guard let id_exp_date = idExpTextField.text,idExpTextField.text?.count != 0 else
        {
            self.view1.isHidden = true
            self.view2.isHidden = false
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_exp_date", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(idIssuerBtn.titleLabel?.text == "Ministry of Interior")
        {
           self.str_id_issuer = "QATAR MOI"
        }
        else
        {
            self.str_id_issuer = "QATAR MOFA"
        }
        
        
        var strfullnamear = fullnameArTextField.text
        strfullnamear = strfullnamear!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strfullnamear)
        // "this is the answer"
        print("stremployer",strfullnamear)
        fullnameArTextField.text =  strfullnamear
        
        //extraspace removear
        let startingStringnamear = fullnameArTextField.text!
        let processedStringnamear = startingStringnamear.removeExtraSpacesprofile()
        print("processedString:\(processedStringnamear)")
        fullnameArTextField.text = processedStringnamear
        
        self.str_id_no = self.idNumTextField.text!
        self.str_id_exp_date = self.convertDateFormater1(self.idExpTextField.text!)
        self.str_name_en = self.fullnameEnTextField.text!
        self.str_name_ar = self.fullnameArTextField.text!
        self.strEmail = self.emailTextField.text!
        self.str_dob = self.convertDateFormater1(self.dobTextField.text!)
        self.str_address = self.addressTextField.text!
        self.str_city = self.municipalityBtn.titleLabel?.text as! String
        self.str_gender = self.genderBtn.titleLabel?.text as! String
        self.str_employer = self.employerTextField.text!
       // self.str_occupation = self.occupationTextField.text!
        self.str_working_address = self.workingAddrTextField.text!
        self.str_income = self.expectedIncomeTextField.text!
        self.str_zone = self.zoneBtn.titleLabel?.text as! String
        self.strMobile = self.mobileTextField.text!
        
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
        
        self.str_id_no = self.idNumTextField.text!
        self.defaults.set(self.str_id_no, forKey: "str_id_nonew")
        
        
        self.str_id_exp_date = self.idExpTextField.text!
        self.defaults.set(self.str_id_exp_date, forKey: "str_id_exp_datenew")
        
        
        self.str_name_en = self.fullnameEnTextField.text!
        self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
        
        self.str_name_ar = self.fullnameArTextField.text!
        self.defaults.set(self.str_name_ar, forKey: "str_name_arnew")
        
        self.strEmail = self.emailTextField.text!
        self.defaults.set(self.strEmail, forKey: "strEmailnew")
        
        self.str_dob = self.dobTextField.text!
        self.defaults.set(self.str_dob, forKey: "str_dobnew")
        
        self.defaults.set(self.str_nationality, forKey: "str_nationalitynew")
        
        self.str_address = self.addressTextField.text!
        self.defaults.set(self.str_address, forKey: "str_addressnew")
        
        self.str_city = self.municipalityBtn.titleLabel?.text as! String
        self.defaults.set(self.str_city, forKey: "str_citynew")
        
        self.str_gender = self.genderBtn.titleLabel?.text as! String
        self.defaults.set(self.str_gender, forKey: "str_gendernew")
        
        self.str_employer = self.employerTextField.text!
        self.defaults.set(self.str_employer, forKey: "str_employernew")
        
        //ivde occupation
        //typetextfd only or save in only didselect
//        self.str_occupation = self.occupationTextField.text!
//        self.defaults.set(self.str_occupation, forKey: "str_occupationnew")
        
        self.str_working_address = self.workingAddrTextField.text!
        self.defaults.set(self.str_working_address, forKey: "str_working_addressnew")
        
        
        self.str_income = self.expectedIncomeTextField.text!
        self.defaults.set(self.str_income, forKey: "str_incomenew")
        
        self.str_zone = self.zoneBtn.titleLabel?.text as! String
        self.defaults.set(self.str_zone, forKey: "str_zonenew")
        
        self.strMobile = self.mobileTextField.text!
        self.defaults.set(self.strMobile, forKey: "strMobilenew")
        
        self.getToken(num: 2)
        
    }
    @IBAction func backBtn(_ sender: Any) {
        self.view1.isHidden = false
        self.view2.isHidden = true
        
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    func setFont() {
        personalInfoLbl.font = UIFont(name: "OpenSans-Regular", size: 16)
        emailLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        emailTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        fullnameEnLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        fullnameEnTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        fullnameArLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        fullnameArTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        dobLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        dobTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        nationalityLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        nationalityBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        countryResidenceLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        countryResiBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        addressLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        addressTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        municipalityLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        municipalityBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        zoneLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        zoneBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        genderLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        genderBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        mobileLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        mobileTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        employerLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        employerTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        expectedIncomeLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        expectedIncomeTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        workingAddrLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        workingAddrTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        occupationLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        occupationTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        nextBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        identificationDetails.font = UIFont(name: "OpenSans-Regular", size: 14)
        idTypeLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        idTypeBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        idIssuerLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        idIssuerBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        idNumLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        idNumTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        idExpLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        idExpTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        updateBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        backBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        personalInfoLbl.font = personalInfoLbl.font.withSize(16)
        emailLbl.font = emailLbl.font.withSize(14)
        fullnameEnLbl.font = fullnameEnLbl.font.withSize(14)
        fullnameArLbl.font = fullnameArLbl.font.withSize(14)
        dobLbl.font = dobLbl.font.withSize(14)
        nationalityLbl.font = nationalityLbl.font.withSize(14)
        countryResidenceLbl.font = countryResidenceLbl.font.withSize(14)
        addressLbl.font = addressLbl.font.withSize(14)
        municipalityLbl.font = municipalityLbl.font.withSize(14)
        zoneLbl.font = zoneLbl.font.withSize(14)
        genderLbl.font = genderLbl.font.withSize(14)
        mobileLbl.font = mobileLbl.font.withSize(14)
        employerLbl.font = employerLbl.font.withSize(14)
        expectedIncomeLbl.font = expectedIncomeLbl.font.withSize(14)
        workingAddrLbl.font = workingAddrLbl.font.withSize(14)
        occupationLbl.font = occupationLbl.font.withSize(14)
        identificationDetails.font = identificationDetails.font.withSize(14)
        idTypeLbl.font = idTypeLbl.font.withSize(14)
        idIssuerLbl.font = idIssuerLbl.font.withSize(14)
        idNumLbl.font = idNumLbl.font.withSize(14)
        idExpLbl.font = idExpLbl.font.withSize(14)
        nationalityBtn.titleLabel?.font = nationalityBtn.titleLabel?.font.withSize(14)
        countryResiBtn.titleLabel?.font = countryResiBtn.titleLabel?.font.withSize(14)
        municipalityBtn.titleLabel?.font = municipalityBtn.titleLabel?.font.withSize(14)
        zoneBtn.titleLabel?.font = zoneBtn.titleLabel?.font.withSize(14)
        idTypeBtn.titleLabel?.font = idTypeBtn.titleLabel?.font.withSize(14)
        idIssuerBtn.titleLabel?.font = idIssuerBtn.titleLabel?.font.withSize(14)
    }
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        ProfileViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
                    self.updateProfileactual(access_token: token)
                }
                else if(num == 3)
                {
                    self.profileimageviewapi(access_token: token)
                }
                
                else if(num == 4)
                {
                    self.profileimageviewapi(access_token: token)
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
        let url = ge_api_url + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        ProfileViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
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
                    self.emailTextField.text = self.strEmail
                    print("strEmailstore",self.strEmail)

                }
                else
                {
                    self.emailTextField.text  = ""
                    self.strEmail =  ""
                }

                
                
                UserDefaults.standard.removeObject(forKey: "strEmailnew")
                self.str_name_en = myResult!["workingAddress3"].stringValue
                
                self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
                
                if ((self.defaults.string(forKey: "str_name_ennew")?.isEmpty) != nil)
                {
                    
                    self.fullnameEnTextField.text = self.str_name_en
                    
                    print("str_name_ennewstore",self.str_name_en)

                }
                else
                {
                    self.fullnameEnTextField.text  = ""
                    self.str_name_en =  ""
                }
                
                
                
                
                
                
                self.fullnameArTextField.text = myResult!["customerNameArabic"].stringValue
                self.str_name_ar = myResult!["customerNameArabic"].stringValue
                self.dobTextField.text = self.convertDateFormater(myResult!["customerDOB"].stringValue)
                self.str_dob = myResult!["customerDOB"].stringValue
                self.addressTextField.text = myResult!["customerAddress"].stringValue
                self.str_address = myResult!["customerAddress"].stringValue
                self.municipalityBtn.setTitle(myResult!["customerCity"].stringValue, for: .normal)
                self.str_city = myResult!["customerCity"].stringValue
                self.municipalityBtn.setTitleColor(UIColor.black, for: .normal)
                self.zoneBtn.setTitle(myResult!["workingAddress2"].stringValue, for: .normal)
                self.str_zone = myResult!["mZone"].stringValue
                self.zoneBtn.setTitleColor(UIColor.black, for: .normal)
                self.genderBtn.setTitle(myResult!["gender"].stringValue, for: .normal)
                if(myResult!["gender"].stringValue == "Male")
                {
                    self.checkMaleBtn.setImage(UIImage(named: "radio_green"), for: .normal)
                    self.checkFemaleBtn.setImage(UIImage(named: "radio_light"), for: .normal)
                }
                else{
                    self.checkMaleBtn.setImage(UIImage(named: "radio_light"), for: .normal)
                    self.checkFemaleBtn.setImage(UIImage(named: "radio_green"), for: .normal)
                }
                self.str_gender = myResult!["gender"].stringValue
                self.genderBtn.setTitleColor(UIColor.black, for: .normal)
                self.mobileTextField.text = myResult!["customerMobile"].stringValue
                self.strMobile = myResult!["customerMobile"].stringValue
                self.employerTextField.text = myResult!["employerName"].stringValue
                self.str_employer = myResult!["employerName"].stringValue
                self.expectedIncomeTextField.text = myResult!["expectedIncome"].stringValue
                self.str_income = myResult!["expectedIncome"].stringValue
                self.workingAddrTextField.text = myResult!["workingAddress1"].stringValue
                self.str_working_address = myResult!["workingAddress1"].stringValue
                self.occupationTextField.text = myResult!["workingAddress2"].stringValue
                self.str_occupation = myResult!["occupation"].stringValue
                
                self.actualoccutxtfd.text = myResult!["actualOccupationDesc"].stringValue
                self.str_actualoccupation = myResult!["actualOccupation"].stringValue
                
                
                
                
                print("3 letter code",myResult!["customerNationality"].stringValue)
                self.getCountryName(code: myResult!["customerNationality"].stringValue, from: 1)
                self.str_nationality = myResult!["customerNationality"].stringValue
                self.str_country = myResult!["customerCountry"].stringValue
                self.getCountryName(code: myResult!["customerCountry"].stringValue, from: 2)
                
                self.idTypeBtn.setTitle(myResult!["customerIDType"].stringValue, for: .normal)
                self.idTypeBtn.setTitleColor(UIColor.black, for: .normal)
                self.str_id_issuer = myResult!["customerIDIssuedBy"].stringValue
                if(self.str_id_issuer == "QATAR MOI")
                {
                    self.idIssuerBtn.setTitle("Ministry of Interior", for: .normal)
                    self.idIssuerBtn.setTitleColor(UIColor.black, for: .normal)
                }
                else if(self.str_id_issuer == "QATAR MOFA")
                {
                    self.idIssuerBtn.setTitle("Ministry of Foreign Affairs", for: .normal)
                    self.idIssuerBtn.setTitleColor(UIColor.black, for: .normal)
                }
                self.idNumTextField.text = myResult!["customerIDNo"].stringValue
                self.str_id_no = myResult!["customerIDNo"].stringValue
                self.idExpTextField.text = self.convertDateFormater(myResult!["customerIDExpiryDate"].stringValue)
                self.str_id_exp_date = myResult!["customerIDExpiryDate"].stringValue
            }
        })
    }
    func getCountryName(code:String,from:Int){
        print("from",from)
    self.activityIndicator(NSLocalizedString("loading", comment: ""))
    let url = api_url + "get_country_name_from_3lettercode"
    let params:Parameters = ["code":code]

              AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                self.effectView.removeFromSuperview()
                print("resp",response)
                let myResult = try? JSON(data: response.data!)
                let arrayResult  = myResult!["get_country"]
                for i in arrayResult.arrayValue{
                    if(from == 1)
                    {
                        self.nationalityBtn.setTitle(i["en_short_name"].stringValue, for: .normal)
                        self.nationalityBtn.setTitleColor(UIColor.black, for: .normal)
                    }
                    else if(from == 2)
                    {
                        self.countryResiBtn.setTitle(i["en_short_name"].stringValue, for: .normal)
                        self.countryResiBtn.setTitleColor(UIColor.black, for: .normal)
                    }
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
            print("municipality list",response)
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
    
    
    func getMunicipalityoccupationidapi(searchText:String) {
        
        self.municipalityArray.removeAll()
        self.tblMunicipality.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "shiftservice/showOccupation"
        let params:Parameters = ["":""]

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
                    }
                self.tblMunicipality.reloadData()
              break
            case .failure:
                break
            }
          })
    }
    
    func getMunicipalityactualoccupationidapi(searchText:String) {
        
        self.municipalityArray.removeAll()
        
        self.checkarrayaoccu.removeAll()
        self.checkarrayaoccustr.removeAll()
        
        
        self.tblMunicipality.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "shiftservice/showOccupation"
        let params:Parameters = ["":""]

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
    }

    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return  dateFormatter.string(from: date!)

    }
    func convertDateFormater1(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)

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
    func getZone(id:String,searchText:String) {
        self.zoneArray.removeAll()
        self.tblzone.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.zoneArray.removeAll()
        let url = api_url + "zone_listing"
        let params:Parameters = ["municipality":id,"keyword":searchText]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("zone list",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["zone_listing"]
                for i in resultArray.arrayValue{
                    let zone = Zone(id: i["id"].stringValue, municipality: i["municipality"].stringValue, zone: i["zone"].stringValue)
                    self.zoneArray.append(zone)
                }
                self.tblzone.reloadData()
              break
            case .failure:
                break
            }
          })
    }
    func updateProfileactual(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/updateActualOccupation"
        
        
        let params:Parameters =  ["idNumber":defaults.string(forKey: "USERID"),"regNo":defaults.string(forKey: "REGNO")!,"actualOccupation":str_actualoccupation,"partnerId":partnerId,"token":token,"requestTime":dateTime]
        
        print("urlupdate",url)
        print("paramsupdate",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        ProfileViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"].stringValue
            let respMsg = myResult!["responseMessage"].stringValue
            print("respupdate",response)
            self.effectView.removeFromSuperview()
            
            
            if(responseCode == "S2022")
            {
                      // AlertView.instance.showAlert(msg: respMsg, action: .attention)
                      // self.getPopupNotificationList()
                let respMsg = myResult!["responseMessage"].stringValue
                //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                
                let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { action in
                    
                    
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }))
                self.present(alert, animated: true, completion: nil)

            }

                
                
            else{
                // AlertView.instance.showAlert(msg: respMsg, action: .attention)
                // self.getPopupNotificationList()
          let respMsg = myResult!["responseMessage"].stringValue
          //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
          
          let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle: .alert)
          
          alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { action in
              
              
              self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
              let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
              self.navigationController?.pushViewController(vc, animated: true)
              
              
          }))
          self.present(alert, animated: true, completion: nil)

      }
            
        })
    }
    
    
    func profileimageviewapi(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
       // let url = api_url + "source"
         let url = ge_api_url + "customer/viewcustomerImage"
         let params:Parameters =  ["customerIDNo":str_id_no,"customerImgType": photoviewinputstr]
        print("urlurl",url)
        print("paramsurl",params)
         let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
         
         RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
             let myResult = try? JSON(data: response.data!)
        
            print("resp",response)
           
           
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            
            if myResult!["idImage"].stringValue.isEmpty
            {
                print("respnullll","nullll")
            }
            else
            {
                
                
                let baseimagestr:String =  myResult!["idImage"].string!
    
                print("64444",baseimagestr)
            let base64EncodedString = baseimagestr // Your Base64 Encoded String
                
               // 1

                let url : String = base64EncodedString
                let urlStr : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                let convertedURL : URL = URL(string: urlStr)!
                print("64444URLLLL",convertedURL)
                
            if let imageData = Data(base64Encoded: base64EncodedString) {
                            
                
                //new
                
                let respCode = myResult!["responseCode"]
                
                if(respCode == "S105")
                {
                    
                    if myResult!["idImage"].stringValue.isEmpty
                    {
                        print("respnullll","nullll")
                    }
                    else
                    {
                    
                       
                    
                    let filePath = self.documentsPathForFileName(name: "video.mp4")
                            let imageData = NSData()
                    imageData.write(toFile: filePath, atomically: true)
                            let videoFileURL = NSURL(fileURLWithPath: filePath)
                        
                    
                    print("urllllllllviedio",videoFileURL)
                        
                        
                       /// let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                       // let videoURL = documentsURL.URLByAppendingPathComponent("video.mp4")//what ever your filename and extention
                        
                        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let fileURL = documentURL.appendingPathComponent("video.mp4")
                        
                        
                        imageData.write(to: fileURL, atomically: true)
                        
                        
                       // UISaveVideoAtPathToSavedPhotosAlbum(fileURL.path, self, #selector(self.imagePickerController()), nil)
                        
                        print("urllllllllviedio",fileURL)
                        
                        UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(fileURL.path)
                        //save to galery
                        UISaveVideoAtPathToSavedPhotosAlbum(fileURL.relativePath, self, nil, nil)
                        
                        //UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(fileURL)
                        
                        let dataa = Data()
                        let str = String(decoding: imageData, as: UTF8.self)
                        print("urlllstrstr",str)
                       /// UISaveVideoAtPathToSavedPhotosAlbum(videoFileURL.relativePath!, self, nil, nil)
                       // print("urllllllllviedioalbum",videoFileURL.relativePath!)
//
//                       // DispatchQueue.global(qos: .background).async {
//                            if let url = URL(string: ""),
//                               let urlData = NSData(contentsOf: videoFileURL as URL)
//                            {
//                                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
//                                let filePath="\(documentsPath)/tempFile.mp4"
//                                DispatchQueue.main.async {
//                                    urlData.write(toFile: filePath, atomically: true)
//                                    PHPhotoLibrary.shared().performChanges({
//                                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
//                                    }) { completed, error in
//                                        if completed {
//                                            print("Video is saved!")
//
//                                            let alert = UIAlertController(title: "Success  Video was saved albu", message: "savedgalery", preferredStyle: .alert)
//
//                                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                                            }))
//                                            self.present(alert, animated: true)
//                                        }
//                                    }
//                                }
//                            }
//                        //}
//
                        
                        
                    
                    //code for play
                   // let movieURL = Bundle.main.url(forResource: "ElephantSeals", withExtension: "mp4")!
                   // let player = AVPlayer(url: fileURL as URL)
            let player = AVPlayer(url: NSURL(string: baseimagestr) as! URL)
                        
                        
//                        do{
//
//                        let video = try NSData(contentsOf: nsurlItem as URL, options: .mappedIfSafe) as! NSURL
//                        let nsurlItem = NSURL(dataRepresentation: imageData as Data, relativeTo: nil)
//                        let avAsset = AVAsset(url: video as URL)
//                                   let playerItem = AVPlayerItem(asset: avAsset)
//                                   let player = AVPlayer(playerItem: playerItem)
//                        }
                            
                    //print("movieURLe",movieURL)
                    
                    self.playerViewController.player = player
                    NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.playerViewController.player?.currentItem)
                    
                    self.present(self.playerViewController, animated: true) {
                        self.playerViewController.player!.play()
                    }

                    
                    
                    
                }
                    
                    ///
                }
                
        else
                {
                
                let showAlert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
                        
                                let imageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 255, height: 260))
                let image = UIImage(data: imageData)
                //self.imageView.image = image
                
                                //imageView.image = UIImage(named: "selfie")// Your image here...
                           imageView.image = image// Your image here...
                                showAlert.view.addSubview(imageView)
                                let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 350)
                                let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280)
                                showAlert.view.addConstraint(height)
                                showAlert.view.addConstraint(width)
                        
//                             let label = UILabel(frame: CGRect(x: 15, y: 255, width: 350, height: 60))
//                             label.text = "Please take a selfie holding your ID"
//                             label.font = label.font.withSize(16)
//                             label.numberOfLines = 0
//                             showAlert.view.addSubview(label)
                        let subview :UIView = showAlert.view.subviews.first! as UIView
                        let alertContentView = subview.subviews.first! as UIView
                        alertContentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                        alertContentView.layer.cornerRadius = 15
                        
                        
                                showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                    // your actions here...
                                    
                //                    print("urlss","ttttt")
                //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                //                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                //                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "forgotPIN") as! ForgotPINViewController
                //                    self.navigationController?.pushViewController(nextViewController, animated: true)

                        }))
                        self.present(showAlert, animated: true, completion: nil)
                
                
                
                
                        }
                
            }
            }
            
      //
            
            
            
   
        })
    }
    
    
    func imagePickerController() {
        // code
        
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.playerViewController.dismiss(animated: true)
    }
    
    func documentsPathForFileName(name: String) -> String {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            return documentsPath.appending(name)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if(tableView == tblIdType)
//        {
//            return idTypeArray.count
//        }
//        else if(tableView == tblIdIssuer)
//        {
//            return idIssuerArray.count
//        }
//        else if(tableView == tblNationality)
//        {
//            if(checkCountry == 0)
//            {
//                return nationalityArray.count
//            }
//            else
//            {
//                return countryResArray.count
//            }
//        }
       // else if(tableView == tblMunicipality)
       // {
        if occupationselsearchstr == "searchcliked"
        {
          
        return searchedArray.count
        }
        
        else
        {
        return municipalityArray.count
        }
        //}
//        else if(tableView == tblzone)
//        {
//            return zoneArray.count
//        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if(tableView == tblIdType)
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "profileIdTypeCell") as! LabelTableViewCell
//            cell.label.text = idTypeArray[indexPath.row]
//            return cell
//        }
//        else if(tableView == tblIdIssuer)
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "profileIdIssuerCell") as! LabelTableViewCell
//            cell.label.text = idIssuerArray[indexPath.row]
//            return cell
//        }
//        else if(tableView == tblNationality)
//        {
//           if(checkCountry == 0)
//           {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "nationalityCell") as! CountryTableViewCell
//                       let nationality = nationalityArray[indexPath.row]
//                       cell.setCountry(country: nationality)
//
//                       let code:String = nationality.alpha_2_code.lowercased()
//                       let url = nationalityFlagPath + code + ".png"
//                       let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
//                       cell.flagImg.kf.setImage(with: imgResource)
//                       return cell
//            }
//           else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "nationalityCell") as! CountryTableViewCell
//                       let nationality = countryResArray[indexPath.row]
//                       cell.setCountry(country: nationality)
//
//                       let code:String = nationality.alpha_2_code.lowercased()
//                       let url = nationalityFlagPath + code + ".png"
//                       let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
//                       cell.flagImg.kf.setImage(with: imgResource)
//                       return cell
//            }
//
//        }
       // else if(tableView == tblMunicipality)
      //  {
        
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
      //  }
//        else if(tableView == tblzone)
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCell") as! LabelTableViewCell
//            let zone = zoneArray[indexPath.row]
//            cell.label.text = zone.zone
//            return cell
//        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if(tableView == tblIdType)
//        {
//            let cell: LabelTableViewCell = self.tblIdType.cellForRow(at: indexPath) as! LabelTableViewCell
//            let str: String = cell.label.text!
//            idTypeBtn.setTitle("\(str)", for: .normal)
//            animateIdType(toogle: false)
//            idTypeBtn.setTitleColor(.black, for: .normal)
//        }
//        else if(tableView == tblIdIssuer)
//        {
//            let cell: LabelTableViewCell = self.tblIdIssuer.cellForRow(at: indexPath) as! LabelTableViewCell
//            let str: String = cell.label.text!
//            idIssuerBtn.setTitle("\(str)", for: .normal)
//            animateIdIssuer(toogle: false)
//            idIssuerBtn.setTitleColor(.black, for: .normal)
//        }
//        else if(tableView == tblNationality)
//        {
//            if(checkCountry == 0)
//            {
//                let cell: CountryTableViewCell = self.tblNationality.cellForRow(at: indexPath) as! CountryTableViewCell
//                let str: String = cell.countryLbl.text!
//                let nat = nationalityArray[indexPath.row]
//                nationalityBtn.setTitle("\(str)", for: .normal)
//                self.nationalityBtn.setTitleColor(UIColor.black, for: .normal)
//
//                UserDefaults.standard.removeObject(forKey: "str_nationalitynew")
//                self.str_nationality = nat.alpha_3_code
//                self.defaults.set(self.str_nationality, forKey: "str_nationalitynew")
//
//                nationalityView.isHidden = true
//                view1.isHidden = false
//            }
//            else{
//                let cell: CountryTableViewCell = self.tblNationality.cellForRow(at: indexPath) as! CountryTableViewCell
//                let str: String = cell.countryLbl.text!
//                let country = countryResArray[indexPath.row]
//                self.str_country = country.alpha_3_code
//                countryResiBtn.setTitle("\(str)", for: .normal)
//                nationalityView.isHidden = true
//                view1.isHidden = false
//            }
//        }
       // else if(tableView == tblMunicipality)
        //{
            
//            if munsibtnnselstr == "munsibtnnselstr"
//            {
//
//                           let cell: LabelTableViewCell = self.tblMunicipality.cellForRow(at: indexPath) as! LabelTableViewCell
//                           let str: String = cell.label.text!
//                           municipalityBtn.setTitle("\(str)", for: .normal)
//                           municipalityView.isHidden = true
//                           view1.isHidden = false
//                           let municipality = municipalityArray[indexPath.row]
//                           self.municipality_id = municipality.id
//                           self.zoneBtn.setTitle("Zone", for: .normal)
//                           self.zoneArray.removeAll()
//                           self.tblzone.reloadData()
//                           print("municipality idddd",municipality.id)
//                           self.getZone(id: municipality.id, searchText: "")
//            }
//
//             if occupationselstr == "occubtnselstr"
//             {
//
//                            let cell: LabelTableViewCell = self.tblMunicipality.cellForRow(at: indexPath) as! LabelTableViewCell
//                            let str: String = cell.label.text!
//                           // municipalityBtn.setTitle("\(str)", for: .normal)
//                            occupationTextField.text = str
//
//                            municipalityView.isHidden = true
//                            view1.isHidden = false
//                            let municipality = municipalityArray[indexPath.row]
//                            self.municipality_idoccupationid = municipality.id
//
//                UserDefaults.standard.removeObject(forKey: "str_occupationnew")
//                            self.str_occupation = municipality.id
//
//                self.defaults.set(self.str_occupation, forKey: "str_occupationnew")
//                           // self.zoneBtn.setTitle("Zone", for: .normal)
//                           // self.zoneArray.removeAll()
//                           // self.tblzone.reloadData()
//                            print("occupation idddd",municipality.id)
//                          backbtnteststr = "0"
//
//                           // self.getZone(id: municipality.id, searchText: "")
//             }
          // if  actualoccupationselstr == "actualoccupationselstr"
          // {
        
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
                              
                              municipalitySearchView.isHidden = false
                              //tab2View.isHidden = false
                              let municipality = municipalityArray[indexPath.row]
                             // self.municipality_idoccupationid = municipality.id
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
            str_actualoccupation = firstName
            print("id selkityadastr_occupation:\(str_occupation)")
            
           // str_occupationname = teststrcls
            
           //UserDefaults.standard.removeObject(forKey: "str_occupationname")
            
           // UserDefaults.standard.set(self.str_occupationname, forKey: "str_occupationname")
            
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
        
        //////////////////////////////////
        ///
        
        else
        {
        
                          let cell: LabelTableViewCell = self.tblMunicipality.cellForRow(at: indexPath) as! LabelTableViewCell
                          let str: String = cell.label.text!
                         // municipalityBtn.setTitle("\(str)", for: .normal)
                          actualoccutxtfd.text = str
      
                          //municipalityView.isHidden = true
                         // view1.isHidden = false
                          let municipality = municipalityArray[indexPath.row]
                         // self.municipality_idoccupationid = municipality.id
           
            
            //UserDefaults.standard.removeObject(forKey: "str_actualoccupationhomeupdate")
            self.str_actualoccupation = municipality.id
            //self.defaults.set(self.str_actualoccupation, forKey: "str_actualoccupationhomeupdate")
  
                         // self.zoneBtn.setTitle("Zone", for: .normal)
                         // self.zoneArray.removeAll()
                         // self.tblzone.reloadData()
                          print("occupation idddd",municipality.id)
        
    }
                        backbtnteststr = "0"
        print("kitydafinalymme:\(str_actualoccupation)")
        
       
              
        //CHECK MARK THE CELL
//        if self.lastSelection != nil {
//            tableView.cellForRow(at: self.lastSelection as IndexPath)?.accessoryType = .none
//        }
//
//        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
//
//        self.lastSelection = indexPath as NSIndexPath
//
//        tableView.deselectRow(at: indexPath, animated: true)
        
                         // self.getZone(id: municipality.id, searchText: "")
           //}
           
            
        //}
//        else if(tableView == tblzone)
//        {
//            let cell: LabelTableViewCell = self.tblzone.cellForRow(at: indexPath) as! LabelTableViewCell
//            let str: String = cell.label.text!
//            let zone = zoneArray[indexPath.row]
//            self.str_zone = zone.id
//            self.defaults.set(self.str_zone, forKey: "str_zonenew")
//
//            zoneBtn.setTitle("\(str)", for: .normal)
//            zoneView.isHidden = true
//        }
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
        return true
    }
}
