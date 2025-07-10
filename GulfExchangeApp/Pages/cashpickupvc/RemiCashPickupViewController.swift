//
//  RemiCashPickupViewController.swift
//  GulfExchangeApp
//
//  Created by test on 17/02/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Toast_Swift
import ScreenShield

class RemiCashPickupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var mainStackView: UIStackView!
    var heightCon:NSLayoutConstraint!
    
    //var timer = Timer()
    var timer : Timer?
    var timerGesture = UITapGestureRecognizer()
    
    var counter = 20
    var isTimerRunning = false
    
    //banksearch
    var bankselserchstr:String = ""
    var checkarrayaoccubankstr  = Array<String>()
    var checkarrayaoccubank  = Array<String>()
    var teststrclsbank : String = ""
    var searchedArraybank:[String] = Array()
    
    //branch
    var branchselserchstr:String = ""
    var checkarrayaoccubranchstr  = Array<String>()
    var checkarrayaoccubranch  = Array<String>()
    var teststrclsbranch : String = ""
    var searchedArraybranch:[String] = Array()
    
    
    //nationality
    var natselserchstr:String = ""
    var checkarrayaoccunatstr  = Array<String>()
    var checkarrayaoccunat  = Array<String>()
    var teststrclsnat : String = ""
    var searchedArraynat:[String] = Array()
    
    //country
    var countryselserchstr:String = ""
    var checkarrayaoccucountrystr  = Array<String>()
    var checkarrayaoccucountry  = Array<String>()
    var teststrclscountry : String = ""
    var searchedArraycountry:[String] = Array()

    
    
    //banksearch
    var cityselserchstr:String = ""
    var checkarrayaoccucitystr  = Array<String>()
    var checkarrayaoccucity  = Array<String>()
    var teststrclscity : String = ""
    var searchedArraycity:[String] = Array()

    
    
    @IBOutlet var MobileWalletAccountNotxtfd: UITextField!
    
    @IBOutlet weak var orlabel: UILabel!
    
    @IBOutlet weak var iagreelabel: UILabel!
    
    @IBOutlet weak var selpaymentmodelabel: UILabel!
    
    @IBOutlet weak var enternewrecinfolabel: UILabel!
    
    @IBOutlet weak var otherinfolabel: UILabel!
    
    @IBOutlet weak var checkaccountinfobtn: UIButton!
    
    
    
    
    @IBOutlet var mobilewalletaccountheightconstant: NSLayoutConstraint!
    
    
    
    @IBOutlet var mobilewalletaccounttopconstant: NSLayoutConstraint!
    
    
    
    @IBOutlet var firstnameheightconsraint: NSLayoutConstraint!
    
    @IBOutlet var firstnameconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var middlenamehieghtconstrain: NSLayoutConstraint!
    
    @IBOutlet var middlenameconstrainttop: NSLayoutConstraint!
    @IBOutlet var lastnameheightconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var lastnameconstrainttop: NSLayoutConstraint!
    @IBOutlet var genderbtnhiehtconstraint: NSLayoutConstraint!
    
    @IBOutlet var genderconstraintop: NSLayoutConstraint!
    
    @IBOutlet var nationalitybtnhieghtconstraint: NSLayoutConstraint!
    
    @IBOutlet var nationaltyconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var bankntnheightconstraint: NSLayoutConstraint!
    
    @IBOutlet var bankfcitybtnconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var branchbtnheightconstaint: NSLayoutConstraint!
    
    @IBOutlet var branchbtnconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var addressheightconstraint: NSLayoutConstraint!
    
    @IBOutlet var addressconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var serviceproviderbankbtnheightconstrain: NSLayoutConstraint!
    //@IBOutlet var cityhieghtconstraint: NSLayoutConstraint!
    
    @IBOutlet var serviceproviderconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var mobileheightconstraint: NSLayoutConstraint!
    
    @IBOutlet var mobileconstrainttop: NSLayoutConstraint!
    
    
    
    @IBOutlet var Citydroptxtfiledhieghtconstraint: NSLayoutConstraint!
    
    @IBOutlet var citydropconstrainttop: NSLayoutConstraint!
    
    
    var servicetypestr:String = ""
    
    var servicetypestronce:String = ""
    
    var cityzero:String = ""
    
    
    var bankcodeonebankstr:String = ""
    var banknameonebankstr:String = ""
    var mwalletaccnocheckstr:String = ""
    var mobilelengnthcheckstr:String = ""
    
     var codetypestr:String = ""
    
    var purpuseclickcheckstr:String = ""
    
    var nationalityclickcheckstr:String = ""
    var nationalityclickcheckstrviewben:String = ""
    
    var genderclickcheckstr:String = ""
    var genderclickcheckstrviewben:String = ""
    
    var middlenameclickcheckstr:String = ""
    
    var bankserviceprovidermoboperstr:String = ""
    
    var mwalletaccountnoyesnoclickcheckstr:String = ""
    var genderyesnoclickcheckstr:String = ""
    var nationalityyesnoclickcheckstr:String = ""
    var mobileyesnoclickcheckstr:String = ""
    var addressyesnoclickcheckstr:String = ""
    
    var nationalitybtnselstr:String = ""
    var countrybtnselstr:String = ""
    
    var str_gender:String = ""
    var str_nationalitycode:String = ""
    
    var serviceproviderormobopbtnstr:String = ""
    var citydropbtstr:String = ""
    
    var str_benificiaryserialnostr:String = ""
    
    var Mobilenonolengthstr:String = ""
    var MobileWalletaccnonolengthstr:String = ""
    
    var middlenamestrstored:String = ""
    
    
    @IBOutlet var CITYDROPTXTFILED: UITextField!
    @IBOutlet weak var cashPickupBtn: UIButton!
    @IBOutlet weak var accountTransferBtn: UIButton!
    @IBOutlet weak var selectReceiverBtn: UIButton!
    @IBOutlet weak var tblBeneficiary: UITableView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet var middleNameTextField: UITextField!
    
    @IBOutlet weak var bankBtn: UIButton!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var accountNum: UITextField!
    @IBOutlet weak var iban: UITextField!
    @IBOutlet weak var swiftCode: UITextField!
    @IBOutlet weak var sortCode: UITextField!
    @IBOutlet weak var routingCode: UITextField!
    @IBOutlet weak var ifscCode: UITextField!
    @IBOutlet weak var checkBtn1: UIButton!
    @IBOutlet weak var checkBtn2: UIButton!
    @IBOutlet weak var sourceOfFundBtn: UIButton!
    @IBOutlet weak var tblSource: UITableView!
    @IBOutlet weak var purposeBtn: UIButton!
    @IBOutlet weak var tblPurpose: UITableView!
    @IBOutlet weak var relationshipBtn: UIButton!
    @IBOutlet weak var tblRelationship: UITableView!
    @IBOutlet weak var checkBtn3: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var tblCountry: UITableView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryWhiteView: UIView!
    @IBOutlet weak var benView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var bankWhiteView: UIView!
    @IBOutlet weak var tblBank: UITableView!
    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var branchWhiteView: UIView!
    @IBOutlet weak var tblBranch: UITableView!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var termsWhiteView: UIView!
    @IBOutlet weak var termsLbl: UILabel!
    @IBOutlet weak var termsContent: UITextView!
    @IBOutlet weak var acceptBtn: UIButton!
    
    @IBOutlet weak var countryBtn: UIButton!
    
    @IBOutlet weak var branchBtn: UIButton!
    @IBOutlet weak var accNoTop: NSLayoutConstraint!
    @IBOutlet weak var ifscTop: NSLayoutConstraint!
    @IBOutlet weak var swiftCodeTop: NSLayoutConstraint!
    @IBOutlet weak var sortCodeTop: NSLayoutConstraint!
    @IBOutlet weak var routingCodeTop: NSLayoutConstraint!
    @IBOutlet weak var ibanTop: NSLayoutConstraint!
    @IBOutlet weak var checkTop: NSLayoutConstraint!
    @IBOutlet weak var searchCountry: UITextField!
    @IBOutlet weak var serchCountryBtn: UIButton!
    @IBOutlet weak var searchBank: UITextField!
    @IBOutlet weak var searchBankBtn: UIButton!
    @IBOutlet weak var searchBranch: UITextField!
    @IBOutlet weak var segmentStackView: UIStackView!
    @IBOutlet weak var segmentContainerView: UIView!
    @IBOutlet weak var cashSegmentImageView: UIImageView!
    
    let messageFrame = UIView()
    
    
    @IBOutlet var genderbtn: UIButton!
    
    
    @IBAction func genderbtnAction(_ sender: Any)
    {
        genderclickcheckstr = "1"
        let showAlert = UIAlertController(title: "Select Gender", message: nil, preferredStyle: .alert)
        
        let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280)
        showAlert.view.addConstraint(height)
        showAlert.view.addConstraint(width)
        
        //                            let label = UILabel(frame: CGRect(x: 45, y: 200, width: 350, height: 60))
        //                            label.text = "Male"
        //                            label.font = label.font.withSize(16)
        //                            label.numberOfLines = 0
        //                            showAlert.view.addSubview(label)
        let subview :UIView = showAlert.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        alertContentView.layer.cornerRadius = 15
        
        
        showAlert.addAction(UIAlertAction(title: "Male", style: .default, handler: { action in
            // your actions here...
            print("male","male")
            self.genderbtn.setTitle("MALE", for: .normal)
            self.genderbtn.setTitleColor(UIColor.black, for: .normal)
            self.str_gender = "Male"
            
        }))
        //
        showAlert.addAction(UIAlertAction(title: "Female", style: .default, handler: { action in
            // your actions here...
            print("female","female")
            self.genderbtn.setTitle("FEMALE", for: .normal)
            self.genderbtn.setTitleColor(UIColor.black, for: .normal)
            self.str_gender = "Female"
            
        }))
        
        
        self.present(showAlert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func AccounttransferbtnAction(_ sender: Any)
    {
       // self.getTokenACTBtn(num: 1)
        timer?.invalidate()
        timer = nil
       // resetTimer()

        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem1") as! RemittancePage1ViewController
        //                    self.present(nextViewController, animated:true, completion:nil)
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    @IBOutlet var servicetypebtn: UIButton!
    
    
    @IBAction func servicetypebtnAction(_ sender: Any)
    {
        let showAlert = UIAlertController(title: "Select Service Type", message: nil, preferredStyle: .alert)
        
        let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 140)
        let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280)
        showAlert.view.addConstraint(height)
        showAlert.view.addConstraint(width)
        
        //                            let label = UILabel(frame: CGRect(x: 45, y: 200, width: 350, height: 60))
        //                            label.text = "Male"
        //                            label.font = label.font.withSize(16)
        //                            label.numberOfLines = 0
        //                            showAlert.view.addSubview(label)
        let subview :UIView = showAlert.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        alertContentView.layer.cornerRadius = 15
        
        
        showAlert.addAction(UIAlertAction(title: "CASH PICKUP", style: .default, handler: { action in
            // your actions here...
            print("cashtomob","male")
            self.servicetypebtn.titleLabel?.text == "CASH PICKUP"
            self.servicetypebtn.setTitle("CASH PICKUP", for: .normal)
            self.servicetypestr = "CASH"
            self.servicetypestronce = "CASH"
            // self.servicetypebtn.setTitle("SERVICE TYPE", for: .normal)
            self.servicetypebtn.setTitleColor(UIColor.black, for: .normal)
            
            
            UserDefaults.standard.removeObject(forKey: "servicetypestoresel")
             self.servicetypestr = "CASH"
            UserDefaults.standard.set(self.servicetypestr, forKey: "servicetypestoresel")
            
            
            //self.clearBenforServiceTypechange()
            self.clearBenforservicetypechange()
            
            if  self.servicetypestr == "CASH_TO_MOBILE"
            {
                self.serviceproviderbtn.setTitle(NSLocalizedString("MOBILEOPERATOR", comment: ""), for: .normal)
                self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
            }
            
            
            if  self.servicetypestr == "CASH"
            {
            self.serviceproviderbtn.setTitle(NSLocalizedString("SERVICEPROVIDER", comment: ""), for: .normal)
            self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
            }

            
        }))
        //
        showAlert.addAction(UIAlertAction(title: "CASH TO MOBILE", style: .default, handler: { action in
            // your actions here...
            print("cash","female")
            
            
            self.servicetypebtn.titleLabel?.text == "CASH TO MOBILE"
            self.servicetypebtn.setTitle("CASH TO MOBILE", for: .normal)
            self.servicetypestr = "CASH_TO_MOBILE"
            self.servicetypestronce = "CASH_TO_MOBILE"
            //self.servicetypebtn.setTitle("SERVICE TYPE", for: .normal)
            self.servicetypebtn.setTitleColor(UIColor.black, for: .normal)
            
            
            UserDefaults.standard.removeObject(forKey: "servicetypestoresel")
            self.servicetypestr = "CASH_TO_MOBILE"
            UserDefaults.standard.set(self.servicetypestr, forKey: "servicetypestoresel")
            
            //self.clearBenforServiceTypechange()
            self.clearBenforservicetypechange()
            
            if  self.servicetypestr == "CASH_TO_MOBILE"
            {
                self.serviceproviderbtn.setTitle(NSLocalizedString("MOBILEOPERATOR", comment: ""), for: .normal)
                self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
            }
            
            
            if  self.servicetypestr == "CASH"
            {
            self.serviceproviderbtn.setTitle(NSLocalizedString("SERVICEPROVIDER", comment: ""), for: .normal)
            self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
            }
            //            self.serviceproviderbtn.setTitle(NSLocalizedString("MOBILE OPERATOR", comment: ""), for: .normal)
            //            self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
            
            
        }))
        
        
        self.present(showAlert, animated: true, completion: nil)
    }
    
    
    @IBOutlet var serviceproviderbtn: UIButton!
    
    @IBOutlet var nationalitybtn: UIButton!
    
    @IBAction func nationalitybtnAction(_ sender: Any)
    {
        
        //self.timerGesture.isEnabled = false
        self.resetTimer()
        
        searchCountry.isHidden = false
        self.countrySearchFlag = 0
        self.benView.isHidden = true
        self.countryView.isHidden = false
        scrollView.setContentOffset(.zero, animated: true)
        //self.getCountry(keyword: "")
        self.getCountry(keyword: "")
        self.searchCountry.text = ""
        nationalitybtnselstr = "nationalitybtnselstr"
        countrybtnselstr = ""
        
    }
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    //otp
    var email:String = ""
    var mobile:String = ""
    
    var strselectuser:String = ""
    var alreadysvaedcustomerstr:String = ""
    
    var nationalityFlagPath:String = ""
    var countryArray:[Country] = []
    var countryArraySearch:[Country] = []
    var bankArray:[Bank] = []
    var branchArray:[Branch] = []
    var checkClick = false
    var termsClick = false
    var countrySearchFlag:Int = 0
    var bankSearchFlag:Int = 0
    
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
    
    let defaults = UserDefaults.standard
    var beneficiaryList:[Beneficiary] = []
    
    var sourceArray:[Source] = []
    var purposeeArray:[Source] = []
    var relationArray:[Source] = []
    
    var str_country:String = ""
    var str_countrynationality:String = ""
    
    var str_bank_code:String = ""
    
    var str_bank_citydropcode:String = ""
    
    
    var serviceproviderstored:String = ""
    
    
    var serialnostored:String = ""
    
    var bankbranschshow:String = ""
    var bankcitytypestr:String = ""
    
    var str_branch_code:String = ""
    var str_first_name:String = ""
    var str_last_name:String = ""
    
    var str_bank_citydropcodeviewben:String = ""
     var servicetypeviewben:String = ""
    
    var serviceproviderBANKname:String = ""
    var serviceproviderBRANCHname:String = ""
    var citydropname:String = ""
    
    var str_middle_name:String = ""
    var str_gender_name:String = ""
    var str_nationality_name:String = ""
    
    
    var MobileWalletAccountNostr:String = ""
    
    var fullnamestr:String = ""
    
    var str_country_name:String = ""
    var str_bank_name:String = ""
    var str_branch_name:String = ""
    var str_address:String = ""
    var str_city:String = ""
    var str_mobile:String = ""
    var str_acc_no:String = ""
    var str_ifsc:String = ""
    var str_source:String = ""
    var str_purpose:String = ""
    var str_relation:String = ""
    var str_serial_no:String = ""
    var str_ben_account:String = ""
    var str_country_2_code:String = ""
    var udid:String!
    
    
    //hidebuton
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //timer.invalidate()
        
        //new
        timer?.invalidate()
     
        
        timer = nil
        
        counter = 0
        if counter > 0 {
              print("\(counter) seconds to the end of the world")
            counter -= 15*60
            //counter = 0
          }
        print("\(counter) timer resetcountdw")
        
        self.timerGesture.isEnabled = true
        


        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        //
        
        self.mobilewalletaccountheightconstant.constant = 0
        self.mobilewalletaccounttopconstant.constant = 0
        self.MobileWalletAccountNotxtfd.isHidden = true
        
        
        
        self.genderyesnoclickcheckstr = "0"
        self.nationalityyesnoclickcheckstr = "0"
        self.mobileyesnoclickcheckstr = "0"
        self.addressyesnoclickcheckstr = "0"
        
        self.bankserviceprovidermoboperstr = "0"
        
        
        self.mwalletaccountnoyesnoclickcheckstr = "0"
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        //new commonly
        self.CITYDROPTXTFILED.isHidden = true
        self.citydropconstrainttop.constant = 0
        self.Citydroptxtfiledhieghtconstraint.constant = 0
        
        //bankbtn ic city serviceprovider new addbtn
        //new cleared
        UserDefaults.standard.removeObject(forKey: "country_code")
        UserDefaults.standard.removeObject(forKey: "bank_code")
        UserDefaults.standard.removeObject(forKey: "branch_code")
        UserDefaults.standard.removeObject(forKey: "first_name")
        UserDefaults.standard.removeObject(forKey: "last_name")
        UserDefaults.standard.removeObject(forKey: "country_name")
        UserDefaults.standard.removeObject(forKey: "bank_name")
        UserDefaults.standard.removeObject(forKey: "branch_name")
        UserDefaults.standard.removeObject(forKey: "address")
        UserDefaults.standard.removeObject(forKey: "mobile")
        
        //citynotcleared
        UserDefaults.standard.removeObject(forKey: "acc_no")
        UserDefaults.standard.removeObject(forKey: "ifsc")
        UserDefaults.standard.removeObject(forKey: "source")
        UserDefaults.standard.removeObject(forKey: "source")
        UserDefaults.standard.removeObject(forKey: "purpose")
        UserDefaults.standard.removeObject(forKey: "relation")
        UserDefaults.standard.removeObject(forKey: "serial_no")
        UserDefaults.standard.removeObject(forKey: "ben_country_3_letter")
        UserDefaults.standard.removeObject(forKey: "benficiaryseioalnostored")
        
        UserDefaults.standard.removeObject(forKey: "ibanstrenterd")
        
        
        UserDefaults.standard.removeObject(forKey: "middlenamestrstored")
        UserDefaults.standard.removeObject(forKey: "ifsc")
        
        
        //new hihlihterd
        
        self.firstNameTextField.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.firstNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.lastNameTextField.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.lastNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.middleNameTextField.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.middleNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.CITYDROPTXTFILED.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.CITYDROPTXTFILED.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
        self.address.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.address.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.mobileNumber.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.mobileNumber.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        
        self.accountNum.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.accountNum.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }

//        self.ifscCode.layer.borderWidth = 0.8
//        if #available(iOS 13.0, *) {
//            self.ifscCode.layer.borderColor = UIColor.systemGray5.cgColor
//        } else {
//            // Fallback on earlier versions
//        }

        self.iban.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.iban.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }


        
        
        //
        //localize
        
        self.selpaymentmodelabel.text = (NSLocalizedString("sel_payment_mode", comment: ""))
        self.enternewrecinfolabel.text = (NSLocalizedString("enter_rece_info", comment: ""))
    
        self.servicetypebtn.setTitle(NSLocalizedString("servicetype", comment: ""), for: .normal)
       // self.servicetypebtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.middleNameTextField.placeholder = (NSLocalizedString("middlename1", comment: ""))
        
        self.checkaccountinfobtn.setTitle(NSLocalizedString("i_checked", comment: ""), for: .normal)
        
        self.selectReceiverBtn.setTitle(NSLocalizedString("sel_existing_rece", comment: ""), for: .normal)
      accountTransferBtn.setTitle(NSLocalizedString("acc_transfer", comment: ""), for: .normal)
        cashPickupBtn.setTitle(NSLocalizedString("cash_pickup", comment: ""), for: .normal)
        
        
        self.firstNameTextField.placeholder = (NSLocalizedString("first_name1", comment: ""))
        
        //self.firstNameTextField.text = (NSLocalizedString("first_name1", comment: ""))
        self.lastNameTextField.placeholder = (NSLocalizedString("lastname1", comment: ""))
        self.countryBtn.setTitle(NSLocalizedString("country", comment: ""), for: .normal)
       // self.countryBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
       // self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
       // self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
        
       // self.city.placeholder = (NSLocalizedString("city1", comment: ""))
        self.mobileNumber.placeholder = (NSLocalizedString("mob_no1", comment: ""))
        self.address.placeholder = (NSLocalizedString("address1", comment: ""))
        
        self.genderbtn.setTitle(NSLocalizedString("GENDERR", comment: ""), for: .normal)
        self.nationalitybtn.setTitle(NSLocalizedString("nationalityy", comment: ""), for: .normal)
        self.iban.placeholder = (NSLocalizedString("iban1", comment: ""))
        self.accountNum.placeholder = (NSLocalizedString("acc_no1", comment: ""))
        
  
        self.sourceOfFundBtn.setTitle(NSLocalizedString("source1", comment: ""), for: .normal)
        
        self.purposeBtn.setTitle(NSLocalizedString("purpose1", comment: ""), for: .normal)
        self.relationshipBtn.setTitle(NSLocalizedString("relationship1", comment: ""), for: .normal)
        
        self.deleteBtn.setTitle(NSLocalizedString("delete", comment: ""), for: .normal)
        self.saveBtn.setTitle(NSLocalizedString("save_next", comment: ""), for: .normal)
        
        self.iagreelabel.text = (NSLocalizedString("i_agree", comment: ""))
    self.termsBtn.setTitle(NSLocalizedString("terms_conditions2", comment: ""), for: .normal)
        self.otherinfolabel.text = (NSLocalizedString("other_info1", comment: ""))
        self.orlabel.text = (NSLocalizedString("or", comment: ""))
        
        
        self.serviceproviderbtn.setTitle(NSLocalizedString("SERVICEPROVIDER", comment: ""), for: .normal)
       // self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        
        
        
        
        
        
        alreadysvaedcustomerstr = "0"
        let custmBackBtn = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .done, target: self, action: #selector(HomeVCAction))
        self.navigationItem.leftBarButtonItem  = custmBackBtn
        
        //  self.bankBtn.isHidden = true
        //  self.bankcitybtnheightconstraint.constant = 0
        
        CITYDROPTXTFILED.isHidden = true
        branchBtn.isHidden = true
        //        branchbtnconstrainttop.constant = 10
        //        branchbtnheightconstaint.constant = 40
        //        heightCon =  middleNameTextField.heightAnchor.constraint(equalToConstant: 0)
        //       heightCon.isActive = true
        //        heightCon =  genderbtn.heightAnchor.constraint(equalToConstant: 0.0)
        //        heightCon.isActive = false
        //
        //       //hide button working
        //        genderbtn.heightAnchor.constraint(equalToConstant: 0.0).isActive = true
        print("text1",self.strselectuser)
        if  self.strselectuser == ""
        {
            
        }
        
        
        selectReceiverBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 300, bottom: 0, right: 0);
        //        let view = UIView()
        //        let selectReceiverBtn = UIButton()
        //        selectReceiverBtn.setTitle("Skip", for: .normal)
        //          selectReceiverBtn.setImage(#imageLiteral(resourceName:"down_arrow1"), for: .normal)
        //        selectReceiverBtn.semanticContentAttribute = .forceRightToLeft
        //        selectReceiverBtn.sizeToFit()
        //        view.addSubview(selectReceiverBtn)
        //        view.frame = selectReceiverBtn.bounds
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
        
        //selectReceiverBtn.semanticContentAttribute = UIApplication.shared
        // .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            firstNameTextField.textAlignment = .right
            lastNameTextField.textAlignment = .right
            middleNameTextField.textAlignment = .right
            address.textAlignment = .right
            mobileNumber.textAlignment = .right
           // city.textAlignment = .right
            accountNum.textAlignment = .right
            iban.textAlignment = .right
            swiftCode.textAlignment = .right
            sortCode.textAlignment = .right
            routingCode.textAlignment = .right
            ifscCode.textAlignment = .right
            searchCountry.textAlignment = .right
            searchBank.textAlignment = .right
            searchBranch.textAlignment = .right
            cashSegmentImageView.image = UIImage(named: "cash_blank1")
            cashPickupBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            accountTransferBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            
            
            sourceOfFundBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            countryBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            bankBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            branchBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            purposeBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            relationshipBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        } else {
            firstNameTextField.textAlignment = .left
            lastNameTextField.textAlignment = .left
            middleNameTextField.textAlignment = .left
            address.textAlignment = .left
            mobileNumber.textAlignment = .left
            //city.textAlignment = .left
            iban.textAlignment = .left
            swiftCode.textAlignment = .left
            sortCode.textAlignment = .left
            routingCode.textAlignment = .left
            ifscCode.textAlignment = .left
            searchCountry.textAlignment = .left
            searchBank.textAlignment = .left
            searchBranch.textAlignment = .left
            cashSegmentImageView.image = UIImage(named: "cash_blank2")
            cashPickupBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            accountTransferBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        }
        
        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("remittance", comment: "")
        


        
        searchCountry.delegate = self
        searchBank.delegate = self
        searchBranch.delegate = self
        saveBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        saveBtn.layer.cornerRadius = 15
        deleteBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        deleteBtn.layer.cornerRadius = 15
        countryWhiteView.layer.cornerRadius = 10
        bankWhiteView.layer.cornerRadius = 10
        branchWhiteView.layer.cornerRadius = 10
        termsWhiteView.layer.cornerRadius = 10
        acceptBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        acceptBtn.layer.cornerRadius = 15
        
        selectReceiverBtn.layer.cornerRadius = 5
        selectReceiverBtn.layer.borderWidth = 1
        selectReceiverBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        //textfielddesign
        countryBtn.layer.cornerRadius = 5
        countryBtn.layer.borderWidth = 1
        countryBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        //genderbtn
        genderbtn.layer.cornerRadius = 5
        genderbtn.layer.borderWidth = 1
        genderbtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        //nationalitybtn
        nationalitybtn.layer.cornerRadius = 5
        nationalitybtn.layer.borderWidth = 1
        nationalitybtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        //servicetype btn
        
        servicetypebtn.layer.cornerRadius = 5
        servicetypebtn.layer.borderWidth = 1
        servicetypebtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        //serviceproviderbtn
        serviceproviderbtn.layer.cornerRadius = 5
        serviceproviderbtn.layer.borderWidth = 1
        serviceproviderbtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        
        bankBtn.layer.cornerRadius = 5
        bankBtn.layer.borderWidth = 1
        bankBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        branchBtn.layer.cornerRadius = 5
        branchBtn.layer.borderWidth = 1
        branchBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        sourceOfFundBtn.layer.cornerRadius = 5
        sourceOfFundBtn.layer.borderWidth = 1
        sourceOfFundBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        purposeBtn.layer.cornerRadius = 5
        purposeBtn.layer.borderWidth = 1
        purposeBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        relationshipBtn.layer.cornerRadius = 5
        relationshipBtn.layer.borderWidth = 1
        relationshipBtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        self.countrySearchFlag = 0
        // self.accNoTop.constant = 0
        self.ifscTop.constant = 0
        self.ibanTop.constant = 0
        self.checkTop.constant = 10
        self.sortCodeTop.constant = 0
        self.swiftCodeTop.constant = 0
        self.routingCodeTop.constant = 0
        
        self.relationshipBtn.isUserInteractionEnabled = true
        
        getToken(num: 1)
        self.tblBeneficiary.dataSource = self
        self.tblBeneficiary.delegate = self
        
        tblSource.dataSource = self
        tblSource.delegate = self
        
        tblRelationship.dataSource = self
        tblRelationship.delegate = self
        
        tblCountry.dataSource = self
        tblCountry.delegate = self
        
        tblBank.dataSource = self
        tblBank.delegate = self
        
        tblBranch.dataSource = self
        tblBranch.delegate = self
        
        mobileNumber.delegate = self
        
        address.delegate = self
        
        
        //self.getSource()
        self.getRelation()
        self.setFont()
        self.getTermsandConditions()
        
        
        searchCountry.addTarget(self, action: #selector(RemiCashPickupViewController.textFieldDidChange(_:)), for: .editingChanged)
        searchBank.addTarget(self, action: #selector(RemiCashPickupViewController.textFieldDidChange(_:)), for: .editingChanged)
        searchBranch.addTarget(self, action: #selector(RemiCashPickupViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        //new
        firstNameTextField.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        middleNameTextField.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)

        lastNameTextField.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        address.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        mobileNumber.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        accountNum.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        ifscCode.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        iban.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        
        //new
        self.firstNameTextField.layer.borderWidth = 0.8
        self.firstNameTextField.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        self.lastNameTextField.layer.borderWidth = 0.8
        self.lastNameTextField.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        self.middleNameTextField.layer.borderWidth = 0.8
        self.middleNameTextField.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        self.CITYDROPTXTFILED.layer.borderWidth = 0.8
        self.CITYDROPTXTFILED.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        
        self.address.layer.borderWidth = 0.8
        self.address.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        self.mobileNumber.layer.borderWidth = 0.8
        self.mobileNumber.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor


    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(true)
           
           // Protect ScreenShot
//                  ScreenShield.shared.protect(view: self.mainStackView)
                  
                  // Protect Screen-Recording
                  ScreenShield.shared.protectFromScreenRecording()
          
       }
    @objc func userIsInactive() {
        // Alert user
        
        print("\(counter) timer countlogout")
        
//        let alert = UIAlertController(title: "remicashYou have been inactive for 5 minutes. We're going to log you off for security reasons.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
//        //Log user off
//        }))
//        present(alert, animated: true)
        
        timer?.invalidate()

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


        timer?.invalidate()
        
        return
     }

    @objc func resetTimer() {
        print("Reset")
        timer?.invalidate()
        
        counter = 0
        if counter > 0 {
              print("\(counter) seconds to the end of the world")
            counter -= 15*60
            //counter = 20
          }
        print("\(counter) timer resetcountdw")
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }
    
    
    @objc func HomeVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    // MARK: phone no Validation :
    func validate(value: String) -> Bool {
        //let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let PHONE_REGEX = "^[0-9]{0,15}$"
        //let PHONE_REGEX = "[a-zA-z]"
        
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer?.invalidate()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
       // timer.invalidate()
        //timer.fire()
       resetTimer()
        
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        self.validateMultipleLogin()
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
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField == searchCountry)
        {
            
            if countrybtnselstr == "countrybtnselstr"
            {
                if natselserchstr == "natselserchstr"
                {
                    
                }
                else
                {
                    if(searchCountry.text?.count == 0)
                    {
                        view.endEditing(true)
                        self.countrySearchFlag = 0
                        self.countryArray.removeAll()
                        natselserchstr = ""
                        countryselserchstr = ""
                        self.getCountrynew(keyword: "")
                        
                    }
                    else
                    {
                        //newcountry
                    if(self.searchCountry.text?.count != 0)
                    {
                        
                        self.countryselserchstr = "searchcliked"
                        self.searchedArraycountry.removeAll()
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
                            searchedArraycountry.removeAll()
                            for itemnat in checkarrayaoccucountry {
                                if itemnat.lowercased().hasPrefix(searchTextnat.lowercased()) {
                                    searchedArraycountry.append(itemnat)
                                }
                            }
                        }

                        
                        
              print("serchedarrrrcountry---",self.searchedArraycountry)
                      self.tblCountry.reloadData()
                        
                    }
                }
                    
                }
                
                
            }
                
            else
            {
            
            if(searchCountry.text?.count == 0)
            {
                view.endEditing(true)
                self.countrySearchFlag = 0
                self.countryArray.removeAll()
                natselserchstr = ""
                countryselserchstr = ""
                self.getCountry(keyword: "")
                
            }
            //newserch
            else
            {
            if(self.searchCountry.text?.count != 0)
            {
                
                self.natselserchstr = "searchcliked"
                self.searchedArraynat.removeAll()
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
                }

                
                
      print("serchedarrrr---",self.searchedArraynat)
              self.tblCountry.reloadData()
                
            }
        }
        }

//            if(searchCountry.text?.count == 0)
//            {
//                view.endEditing(true)
//                self.countrySearchFlag = 0
//                self.countryArray.removeAll()
//                self.getCountry(keyword: "")
//            }
            
        }
        else if(textField == searchBank)
        {
    
           if citydropbtstr == "citydropclick"
            {
               //new
               
               if(searchBank.text?.count == 0)
               {
                   cityselserchstr = ""
                   self.bankSearchFlag = 0
                   self.bankArray.removeAll()
                   
                   self.getToken(num: 8)
               }

               else
               {
               if(searchBank.text?.count != 0)
               {
                   //self.bankselserchstr = "searchcliked"
                   
                   self.cityselserchstr = "searchcliked"
                   self.searchedArraycity.removeAll()
                   let fruitsArrayi = ["Orange","Litchi","PineApple","mango"]
                  // AllArray  = ["Orange","Litchi","PineApple","mango"]
                  // AllArrayid  = ["11","12","13","14"]
                   
                   let fruitsArrayiids = ["1","2","3","4"]
   //                    fruitsArray.append("Orange")
   //                    fruitsArray.append("Litchi")
   //                    fruitsArray.append("PineApple")
                   
                   
                   
                   
                   
                   
                    print("stringyyy---","sytringyuu")
   //        for str in checkarrayaoccubank {
   //        let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
   //        if range != nil {
   //        self.searchedArraybank.append(str)
   //        }
   //
   //
   //
   //    }
                   
                   
                   let searchText  = textField.text!
                   if !searchText.isEmpty {
                       //searching = true
                       searchedArraycity.removeAll()
                       for item in checkarrayaoccucity {
                           if item.lowercased().hasPrefix(searchText.lowercased()) {
                               searchedArraycity.append(item)
                           }
                       }
                   }

                   
                   
         print("serchedarrrr---",self.searchedArraycity)
                 self.tblBank.reloadData()
                   
               }
           }
           }

            else
            {
                
                if(searchBank.text?.count == 0)
                {
                    self.bankselserchstr = ""
                    self.bankSearchFlag = 0
                    self.bankArray.removeAll()
                    
                    self.getToken(num: 2)
                    
                }

                        //new
                else
                {
                        if(searchBank.text?.count != 0)
                        {
                            
                            self.bankselserchstr = "searchcliked"
                            self.searchedArraybank.removeAll()
                            let fruitsArrayi = ["Orange","Litchi","PineApple","mango"]
                           // AllArray  = ["Orange","Litchi","PineApple","mango"]
                           // AllArrayid  = ["11","12","13","14"]
                            
                            let fruitsArrayiids = ["1","2","3","4"]
            //                    fruitsArray.append("Orange")
            //                    fruitsArray.append("Litchi")
            //                    fruitsArray.append("PineApple")
                            
                            
                            
                            
                            
                            
                             print("stringyyy---","sytringyuu")
            //        for str in checkarrayaoccubank {
            //        let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
            //        if range != nil {
            //        self.searchedArraybank.append(str)
            //        }
            //
            //
            //
            //    }
                            
                            
                            let searchText  = textField.text!
                            if !searchText.isEmpty {
                                //searching = true
                                searchedArraybank.removeAll()
                                for item in checkarrayaoccubank {
                                    if item.lowercased().hasPrefix(searchText.lowercased()) {
                                        searchedArraybank.append(item)
                                    }
                                }
                            }

                            
                            
                  print("serchedarrrr---",self.searchedArraybank)
                          self.tblBank.reloadData()
                            
                        }
            }
            
        ///
        }
//old
//            if(searchBank.text?.count == 0)
//            {
//                view.endEditing(true)
//                self.bankSearchFlag = 0
//                self.bankArray.removeAll()
//                self.getToken(num: 2)
//            }
        }
        else if(textField == searchBranch)
        {
            
            if(searchBranch.text?.count == 0)
            {
                self.branchselserchstr = ""
                
                self.branchArray.removeAll()
                
                self.getToken(num: 3)
            }
            
            else
            {
            
            if(searchBranch.text?.count != 0)
            {
                
                self.branchselserchstr = "searchcliked"
                self.searchedArraybranch.removeAll()
                let fruitsArrayi = ["Orange","Litchi","PineApple","mango"]
               // AllArray  = ["Orange","Litchi","PineApple","mango"]
               // AllArrayid  = ["11","12","13","14"]
                
                let fruitsArrayiids = ["1","2","3","4"]
//                    fruitsArray.append("Orange")
//                    fruitsArray.append("Litchi")
//                    fruitsArray.append("PineApple")
                
                
                
                
                
                
                 print("stringyyy---","sytringyuu")
//        for str in checkarrayaoccubranch {
//        let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
//        if range != nil {
//        self.searchedArraybranch.append(str)
//        }
//
//
//
//    }
                
                let searchTextbranch  = textField.text!
                if !searchTextbranch.isEmpty {
                    //searching = true
                    searchedArraybranch.removeAll()
                    for itembranch in checkarrayaoccubranch {
                        if itembranch.lowercased().hasPrefix(searchTextbranch.lowercased()) {
                            searchedArraybranch.append(itembranch)
                        }
                    }
                }

                
                
                
      print("serchedarrrr---",self.searchedArraybranch)
              self.tblBranch.reloadData()
                
            }
        }

            //old
//            if(searchBranch.text?.count == 0)
//            {
//                view.endEditing(true)
//                self.branchArray.removeAll()
//                self.getToken(num: 3)
//            }
        }
       // self.timerGesture.isEnabled = false
        resetTimer()
    }
    func setFont() {
        deleteBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        saveBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        acceptBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        
    }
    @IBAction func countryBtn(_ sender: Any) {
        
        if(servicetypebtn.titleLabel?.text == "SERVICE TYPE")
        {
            self.view.makeToast("select service type", duration: 3.0, position: .center)

            //self.alertMessage(title: "gulf_exchange", msg: "select service type", action:"ok")
        }
        else
        {
            //self.timerGesture.isEnabled = false
            self.resetTimer()
            
            searchCountry.isHidden = false
            self.countrySearchFlag = 0
            self.benView.isHidden = true
            self.countryView.isHidden = false
            scrollView.setContentOffset(.zero, animated: true)
            //self.getCountry(keyword: "")
            self.getCountrynew(keyword: "")
            self.searchCountry.text = ""
            countrybtnselstr = "countrybtnselstr"
            nationalitybtnselstr = ""
           // clearBenforCountrychange()
            self.clearBenforcountrychange()
            
            //bankapiservproviderautoselectpurp
           // self.getToken(num: 2)
            
            
            //
            
            if  self.servicetypestr == "CASH_TO_MOBILE"
            {
                self.serviceproviderbtn.setTitle(NSLocalizedString("MOBILEOPERATOR", comment: ""), for: .normal)
                self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
            }
            
            if  self.servicetypestr == "CASH"
                {
                self.serviceproviderbtn.setTitle(NSLocalizedString("SERVICEPROVIDER", comment: ""), for: .normal)
                self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
                }
        }
    }
    
    
    @IBAction func serviceprocidermobpoeratorbtnAct(_ sender: Any)
    {
        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
        {
            self.view.makeToast(NSLocalizedString("sel_country", comment: ""), duration: 3.0, position: .center)
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            
            //self.timerGesture.isEnabled = false
            self.resetTimer()
            
            serviceproviderormobopbtnstr = "clicksecviceormobbtn"
            citydropbtstr = ""
            
            clearBenforbankchange()
            
            self.searchBank.text = ""
            self.benView.isHidden = true
            self.bankView.isHidden = false
            scrollView.setContentOffset(.zero, animated: true)
            self.getToken(num: 2)
            
            self.timerGesture.isEnabled = false
            self.resetTimer()

        }
    }
    
    
    
    
    @IBAction func bankBtn(_ sender: Any) {
        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
//    if(bankBtn.titleLabel?.text == NSLocalizedString("bank_name1", comment: ""))
//        {
//        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_bank", comment: ""), action: NSLocalizedString("ok", comment: ""))
//        }
//
        else{
            
            resetTimer()
            
            serviceproviderormobopbtnstr = ""
            citydropbtstr = "citydropclick"
            
            clearBenforcitydropchange()
            
            self.searchBank.text = ""
            self.benView.isHidden = true
            self.bankView.isHidden = false
            scrollView.setContentOffset(.zero, animated: true)
            self.getToken(num: 8)
        }
    }
    @IBAction func branchBtn(_ sender: Any) {
        if(bankBtn.titleLabel?.text == NSLocalizedString("city1", comment: ""))
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_city", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
//        if(city.titleLabel?.text == NSLocalizedString("bank_name1", comment: ""))
//            {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_bank", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                return
//            }
            
        else{
            
            //self.timerGesture.isEnabled = false
            self.resetTimer()
            
            self.searchBranch.text = ""
            self.branchView.isHidden = false
            self.benView.isHidden = true
            self.getToken(num: 3)
            scrollView.setContentOffset(.zero, animated: true)
        }
    }
    
    @IBAction func selectReceiverBtn(_ sender: Any) {
        resetTimer()
        
        timerGesture.isEnabled = false
        UIView.animate(withDuration: 0.3){
            if self.tblBeneficiary.isHidden{
                self.animateBeneficiary(toogle: true)
            }
            else{
                self.animateBeneficiary(toogle: false)
            }
        }
    }
    @IBAction func deleteBtn(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("delete", comment: ""), message: NSLocalizedString("want_to_delete_beneficiary", comment: ""), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "yes", comment: ""), style: .default, handler: { action in
            if(self.selectReceiverBtn.titleLabel?.text == NSLocalizedString("sel_existing_rece", comment: ""))
            {
                self.clearBen()
            }
            else{
                self.str_first_name = self.firstNameTextField.text!
                self.str_last_name = self.lastNameTextField.text!
                self.str_country_name = self.countryBtn.titleLabel?.text as! String
                self.str_bank_name = self.bankBtn.titleLabel?.text as! String
                self.str_branch_name = self.branchBtn.titleLabel?.text as! String
                self.str_address = self.address.text!
                // self.str_city = self.city.text!
                self.str_mobile = self.mobileNumber.text!
                self.str_acc_no = self.accountNum.text!
                self.str_ifsc = self.ifscCode.text!
                self.str_source = self.sourceOfFundBtn.titleLabel?.text as! String
                self.str_purpose = self.purposeBtn.titleLabel?.text as! String
                self.str_relation = self.relationshipBtn.titleLabel?.text as! String
                
                self.getToken(num: 6)
                
            }
        }))
        alert.addAction(UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "no", comment: ""), style: .cancel, handler: { action in
            
        }))
        self.present(alert, animated: true)
    }
    @IBAction func searchCountryBtn(_ sender: Any) {
        if(self.searchCountry.text?.count == 0)
        {
            self.countrySearchFlag = 0
            self.countryArray.removeAll()
            self.getCountry(keyword: "")
        }
        else
        {
            self.countrySearchFlag = 1
            let keyword  = searchCountry.text!
            self.countryArray.removeAll()
            self.getCountry(keyword: keyword)
        }
    }
    @IBAction func searchBankBtn(_ sender: Any) {
        if(self.searchBank.text?.count == 0)
        {
            self.bankSearchFlag = 0
            self.bankArray.removeAll()
            self.getToken(num: 2)
        }
        else
        {
            self.bankSearchFlag = 1
            let keyword  = searchBank.text!
            self.bankArray.removeAll()
            self.getToken(num: 2)
        }
    }
    @IBAction func saveBtn(_ sender: Any) {
        
        
        
        if alreadysvaedcustomerstr == "0"
        {
        
        var str = firstNameTextField.text
        str = str!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(str)
        // "this is the answer"
        print("strii",str)
        firstNameTextField.text =  str
        print("firstNameTextField.text",firstNameTextField.text)
        
        
        
        //extraspace remove
        let startingStringfname = firstNameTextField.text!
        let processedStringfname = startingStringfname.removeExtraSpacesremcash()
        print("processedString:\(processedStringfname)")
        firstNameTextField.text = processedStringfname
            
            if firstNameTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.firstNameTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.firstNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            else
            {
                self.firstNameTextField.layer.borderWidth = 1
                if #available(iOS 13.0, *) {
                    self.firstNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

        
        
        guard let firstName = firstNameTextField.text,firstNameTextField.text?.count != 0 else
        {
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            
         
            
            self.view.makeToast(NSLocalizedString("enter_firstname", comment: ""), duration: 3.0, position: .center)
          //  alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("enter_firstname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if (!validate(value: self.firstNameTextField.text!))
        {
            
            
        }
        else
            
        {
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("enter_firstname", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("enter_firstname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        
        var charSet = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2 = firstName
        
        if let strvalue = string2.rangeOfCharacter(from: charSet)
        {
            print("true")
            
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        var strlastname = lastNameTextField.text
        strlastname = strlastname!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strlastname)
        // "this is the answer"
        print("strlastname",strlastname)
        lastNameTextField.text =  strlastname
        print("lastNameTextField.text",lastNameTextField.text)
        
        
        //extraspace remove
        let startingStringlname = lastNameTextField.text!
        let processedStringlname = startingStringlname.removeExtraSpacesremcash()
        print("processedString:\(processedStringlname)")
        lastNameTextField.text = processedStringlname
            
            
            
            if lastNameTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.lastNameTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.lastNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            else
            {
                self.lastNameTextField.layer.borderWidth = 1
                if #available(iOS 13.0, *) {
                    self.lastNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

        
        
        guard let lastName = lastNameTextField.text,lastNameTextField.text?.count != 0 else
        {
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("enter_lastname", comment: ""), duration: 3.0, position: .center)

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_lastname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if (!validate(value: self.lastNameTextField.text!))
        {
            
            
        }
        else
        {
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("enter_lastname", comment: ""), duration: 3.0, position: .center)

            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_lastname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        var charSetlastname = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2lastname = lastName
        
        if let strvalue = string2lastname.rangeOfCharacter(from: charSetlastname)
        {
            print("true")
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)

            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        //middlename
        
        
        var strmiddlenamee = middleNameTextField.text
        strmiddlenamee = strmiddlenamee!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strmiddlenamee)
        // "this is the answer"
        print("strlastname",strmiddlenamee)
        middleNameTextField.text =  strmiddlenamee
        print("lastNameTextField.text",middleNameTextField.text)
        
        
        //extraspace remove
        let startingStringmname = middleNameTextField.text!
        let processedStringmname = startingStringmname.removeExtraSpacesremcash()
        print("processedString:\(processedStringmname)")
        middleNameTextField.text = processedStringmname
        
       let middlenamee = middleNameTextField.text
        
        
        
        
        
        if middlenameclickcheckstr == "1"
       {
            
    guard let middlenamee = middleNameTextField.text,middleNameTextField.text?.count != 0 else
            {
        
        let bottomOffset = CGPoint(x: 0, y: 0)
        //OR
        //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
        self.view.makeToast(NSLocalizedString("entermiddlename", comment: ""), duration: 3.0, position: .center)
        
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("entermiddlename", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            }
       }
        else
        {
        
        }
      //  {
//            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_lastname", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
        //}
        
        
//        if (!validate(value: self.middleNameTextField.text!))
//        {
//
//
//        }
//        else
//        {
//            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }
        
        
        

        
        
        
        var charSetmiddlename = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2middlename = middlenamee
        
        if let strvalue = string2middlename!.rangeOfCharacter(from: charSetmiddlename)
        {
            print("true")
            
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
        {
            let bottomOffset = CGPoint(x: 0, y: 0)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("sel_country", comment: ""), duration: 3.0, position: .center)
            
            self.countryBtn.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.countryBtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
                }

            
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
            else
            {
                if #available(iOS 13.0, *) {
                    self.countryBtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }

                
            }
//        if(bankBtn.titleLabel?.text == NSLocalizedString("bank_name1", comment: ""))
//        {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_bank", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }
        
        
        
        
//        if genderclickcheckstr == "1"
//       {
//
//       }
//        else
//        {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }
//
//
//
//        if nationalityclickcheckstr == "1"
//       {
//           if nationalityclickcheckstrviewben == "1"
//           {
//
//           }
//           else
//           {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//
//           }
//
//
//
//       }
//        else
//        {
//
//        }
        
 
       if  genderyesnoclickcheckstr == "1"
        
       {
        print("genderbtn.titleLabel?.text",genderbtn.titleLabel?.text)
          print("genderbtnlo9calize.titleLabel?.text",NSLocalizedString("GENDERR", comment: ""))
          if(genderbtn.titleLabel?.text == NSLocalizedString("GENDERR", comment: ""))
          {
              
              let bottomOffset = CGPoint(x: 0, y: 0)
              //OR
              //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
              self.scrollView.setContentOffset(bottomOffset, animated: true)
              self.view.makeToast(NSLocalizedString("sel_gender", comment: ""), duration: 3.0, position: .center)
              
              self.genderbtn.layer.borderColor = UIColor.red.cgColor
              Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                  if #available(iOS 13.0, *) {
                      self.genderbtn.layer.borderColor = UIColor.systemGray5.cgColor
                  } else {
                      // Fallback on earlier versions
                  }
                  }

              
              //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
              return
          }
       }
            else
            {
                if #available(iOS 13.0, *) {
                    self.genderbtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

        
        if  nationalityyesnoclickcheckstr == "1"
        {
            if(nationalitybtn.titleLabel?.text ==  NSLocalizedString("nationalityy", comment: ""))
            {
                let bottomOffset = CGPoint(x: 0, y: 40)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("sel_nationality", comment: ""), duration: 3.0, position: .center)
                self.nationalitybtn.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.nationalitybtn.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                    }

               // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.nationalitybtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        else
        {
            
        }

        
  

        
        
        
        
        
        if bankbranschshow == "YES"
        {
            
            if(branchBtn.titleLabel?.text == NSLocalizedString("branch_name1", comment: ""))
            {
                let bottomOffset = CGPoint(x: 0, y: 160)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("enter_branch_name", comment: ""), duration: 3.0, position: .center)
                
               // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_branch_name", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
        }
        
      if  addressyesnoclickcheckstr == "1"
      {
        var straddress = address.text
        straddress = straddress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(straddress)
        // "this is the answer"
        print("straddress",straddress)
        address.text =  straddress
        print("addresstxtfiled.text",address.text)
        
        //extraspace remove
        let startingStringaddress = address.text!
        let processedStringaddress = startingStringaddress.removeExtraSpacesremcash()
        print("processedString:\(processedStringaddress)")
        address.text = processedStringaddress
          
          
          
          if address.text?.isEmpty == true
          {
             // timer.invalidate()
              self.address.layer.borderColor = UIColor.red.cgColor
              Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                  if #available(iOS 13.0, *) {
                      self.address.layer.borderColor = UIColor.systemGray5.cgColor
                  } else {
                      // Fallback on earlier versions
                  }
              }
          }
          else
          {
              self.address.layer.borderWidth = 1
              if #available(iOS 13.0, *) {
                  self.address.layer.borderColor = UIColor.systemGray5.cgColor
              } else {
                  // Fallback on earlier versions
              }
          }
        
        guard let addr = address.text,address.text?.count != 0 else
        {
            
            let bottomOffset = CGPoint(x: 0, y: 180)
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
//            print("true")
//            let alert = UIAlertController(title: "Alert", message: "Please enter valid  address", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            print("check name",self.address.text)
//            return
//
            
            let bottomOffset = CGPoint(x: 0, y: 180)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("Please enter valid  address", comment: ""), duration: 3.0, position: .center)
            
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid  address", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
        }
        
        
      }
        else
      {
        
      }
        
       
        
        
        
        
        if bankbranschshow == "YES"
        {
            
            if bankcitytypestr == "D"
            {
//                var strcity = city.text
//                strcity = strcity!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//                print(strcity)
//                // "this is the answer"
//                print("strcity",strcity)
//                city.text =  strcity
//                print("addresstxtfiled.text",city.text)
                
                //guard let citytext = city.text,city.text?.count != 0 else
            if(bankBtn.titleLabel?.text == NSLocalizedString("city1", comment: ""))
                {
                
                let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("enter_city", comment: ""), duration: 3.0, position: .center)
                
                    //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_city", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                
            }
            
            if bankcitytypestr == "T"
            {
                var strcity = city.text
                strcity = strcity!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                print(strcity)
                // "this is the answer"
                print("strcity",strcity)
                city.text =  strcity
                print("addresstxtfiled.text",city.text)
                
                //extraspace remove
                let startingStringcity = city.text!
                let processedStringcity = startingStringcity.removeExtraSpacesremcash()
                print("processedString:\(processedStringcity)")
                city.text = processedStringcity
                
                if city.text?.isEmpty == true
                {
                   // timer.invalidate()
                    self.city.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        if #available(iOS 13.0, *) {
                            self.city.layer.borderColor = UIColor.systemGray5.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                else
                {
                    self.city.layer.borderWidth = 1
                    if #available(iOS 13.0, *) {
                        self.city.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }

                
                
                guard let citytext = city.text,city.text?.count != 0 else
                {
                    let bottomOffset = CGPoint(x: 0, y: 240)
                    //OR
                    //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                    self.scrollView.setContentOffset(bottomOffset, animated: true)
                    self.view.makeToast(NSLocalizedString("enter_city", comment: ""), duration: 3.0, position: .center)
                    
                    //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_city", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                
                var charSetcitytext = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                var string2citytext = citytext
                
                if let strvalue = string2citytext.rangeOfCharacter(from: charSetcitytext)
                {
                    print("true")
                    let alert = UIAlertController(title: "Alert", message: "Please enter valid city", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print("check name",self.city.text)
                    
                }
                
                
                
                
                
            }
            
        }
        
      if  mobileyesnoclickcheckstr == "1"
      {
        
        if (!isValid(testStr: self.mobileNumber.text!))
        {
            
        }
        else
        {
            
            let bottomOffset = CGPoint(x: 0, y: 240)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("enter_mobile", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        
        var strmobile = mobileNumber.text
        strmobile = strmobile!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strmobile)
        // "this is the answer"
        print("strcity",strmobile)
        mobileNumber.text =  strmobile
        print("addresstxtfiled.text",mobileNumber.text)
        
        
        //extraspace remove
        let startingStringmobile = mobileNumber.text!
        let processedStringmobile = startingStringmobile.removeExtraSpacesaccountnumber()
        print("processedStringmobile:\(processedStringmobile)")
        mobileNumber.text = processedStringmobile
          
          if mobileNumber.text?.isEmpty == true
          {
             // timer.invalidate()
              self.mobileNumber.layer.borderColor = UIColor.red.cgColor
              Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                  if #available(iOS 13.0, *) {
                      self.mobileNumber.layer.borderColor = UIColor.systemGray5.cgColor
                  } else {
                      // Fallback on earlier versions
                  }
              }
          }
          else
          {
              self.mobileNumber.layer.borderWidth = 1
              if #available(iOS 13.0, *) {
                  self.mobileNumber.layer.borderColor = UIColor.systemGray5.cgColor
              } else {
                  // Fallback on earlier versions
              }
          }
          
        
        guard let mobile = mobileNumber.text,mobileNumber.text?.count != 0 else
        {
            let bottomOffset = CGPoint(x: 0, y: 240)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("enter_mobile", comment: ""), duration: 3.0, position: .center)
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        var charSetMOBNo = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
                    var string2MOBNo = mobile
                    
                    if let strvalue = string2MOBNo.rangeOfCharacter(from: charSetMOBNo)
                    {
                        print("true")
        //                let alert = UIAlertController(title: "Alert", message: "Please enter valid account number", preferredStyle: UIAlertController.Style.alert)
        //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        //                self.present(alert, animated: true, completion: nil)
        //                print("check name",self.accountNum.text)
                        
                        let bottomOffset = CGPoint(x: 0, y: 240)
                        //OR
                        //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                        self.scrollView.setContentOffset(bottomOffset, animated: true)
                        self.view.makeToast(NSLocalizedString("Please enter valid mobile number", comment: ""), duration: 3.0, position: .center)
                        
                        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                        
                    }
        
        
           //mobilenolength validation getbank api
        
        
        let rrcheckmob = alreadysvaedcustomerstr
        
        print("rrcheck",rrcheckmob)
        let x = rrcheckmob
        let y = "0"
        if x == y
        {
            print("mobileNumberlengthprint",mobileNumber.text!.count)
            print("Mobilenonolengthstr",Mobilenonolengthstr)
           if Mobilenonolengthstr == "0"||Mobilenonolengthstr.isEmpty||Mobilenonolengthstr == ""
            {
               
        
            }
         else
          {
           
           //mobileNumber.text!.count
                  print("mobileNumberlengthprint",mobileNumber.text!.count)
                 let myString1 = Mobilenonolengthstr
                 let myInt1 = Int(myString1)
                 
                 if mobileNumber.text!.count == myInt1
                 {
                   print("5printno",mobileNumber.text!.count)
                 }
              else
               {
                  let bottomOffset = CGPoint(x: 0, y: 240)
                  //OR
                  //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                  self.scrollView.setContentOffset(bottomOffset, animated: true)
                  self.view.makeToast(NSLocalizedString("Please enter valid mobile number", comment: ""), duration: 3.0, position: .center)
                  
                  // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                   return
                   
               }
           
          }
        
        
        }
      }
      else
      {
        
      }

    ////////////////
     
        
//
//        let rrcheckmobw = alreadysvaedcustomerstr
//
//        print("rrcheck",rrcheckmobw)
//        let x = rrcheckmobw
//        let y = "0"
//        if x == y
//        {
//            if  self.servicetypestr == "CASH_TO_MOBILE"
//            {
//
//            //neew
//            if mwalletaccountnoyesnoclickcheckstr == "1"
//            {
//               // if MobileWalletAccountNotxtfd.text?.isEmpty
//                if MobileWalletAccountNotxtfd.text?.isEmpty ?? true
//
//
//
//                {
//                    print("textField is empty")
//                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Please Enter Mobile Number", action: NSLocalizedString("ok", comment: ""))
//                return
//                }
//            }
//
//
//            print("mobileNumberlengthprint",mobileNumber.text!.count)
//            print("Mobilenonolengthstr",Mobilenonolengthstr)
//           if Mobilenonolengthstr == "0"||Mobilenonolengthstr.isEmpty||Mobilenonolengthstr == ""
//            {
//
//
//            }
//         else
//          {
//
//           //mobileNumber.text!.count
//                  print("MobileWalletAccountNotxtfdlengthprint",MobileWalletAccountNotxtfd.text!.count)
//                 let myStringw1 = Mobilenonolengthstr
//                 let myIntw1 = Int(myStringw1)
//
//                 if MobileWalletAccountNotxtfd.text!.count == myIntw1
//                 {
//                   print("5printno",MobileWalletAccountNotxtfd.text!.count)
//                 }
//              else
//               {
//                   alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Please Enter Valid Mobile Number", action: NSLocalizedString("ok", comment: ""))
//                   return
//
//               }
//
//          }
//
//    }
//        }
//
//
    
        
    /////////
        
        if alreadysvaedcustomerstr == "0"
        {
        
         //if bankserviceprovidermoboperstr == "1"
         //{
            
        if  self.servicetypestr == "CASH"
        {
            if(serviceproviderbtn.titleLabel?.text == NSLocalizedString("SERVICEPROVIDER", comment: ""))
            {
                let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast("Select Service provider", duration: 3.0, position: .center)
                
                self.serviceproviderbtn.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.serviceproviderbtn.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                    }

                
                //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Select Service provider", action: NSLocalizedString("ok", comment: ""))
                return
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.serviceproviderbtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
      
            
        }
        
        if  self.servicetypestr == "CASH_TO_MOBILE"
        {
            if(serviceproviderbtn.titleLabel?.text == NSLocalizedString("MOBILEOPERATOR", comment: ""))
            {
                let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast("Select Mobile Operator", duration: 3.0, position: .center)
                
                self.serviceproviderbtn.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.serviceproviderbtn.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                    }
                
               // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Select Mobile Operator", action: NSLocalizedString("ok", comment: ""))
                return
                
            }
            else
            {
                if #available(iOS 13.0, *) {
                    self.serviceproviderbtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
         
            
        }
         //}
            
        }
        
        /////////////////
    }
        
        
        //        if(countryBtn.titleLabel?.text == "India")
        //        {
        //            guard let accNo = accountNum.text,accountNum.text?.count != 0 else
        //            {
        //                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_account", comment: ""), action: NSLocalizedString("ok", comment: ""))
        //                return
        //            }
        //            guard let ifsc = ifscCode.text,ifscCode.text?.count != 0 else
        //            {
        //                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_ifsc", comment: ""), action: NSLocalizedString("ok", comment: ""))
        //                return
        //            }
        //        }
        //        else
        //        {
        //            guard let accNo = accountNum.text,accountNum.text?.count != 0 else
        //            {
        //                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_account", comment: ""), action: NSLocalizedString("ok", comment: ""))
        //                return
        //            }
        //        }
        if(!checkClick)
        {
            self.view.makeToast(NSLocalizedString("confirm_account", comment: ""), duration: 3.0, position: .center)
           // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("confirm_account", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(sourceOfFundBtn.titleLabel?.text == NSLocalizedString("source1", comment: ""))
        {
            self.view.makeToast(NSLocalizedString("sel_source", comment: ""), duration: 3.0, position: .center)
            
            self.sourceOfFundBtn.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.sourceOfFundBtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
                }
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_source", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.sourceOfFundBtn.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }

        }
        if(purposeBtn.titleLabel?.text == NSLocalizedString("purpose1", comment: ""))
        {
            
            self.view.makeToast(NSLocalizedString("sel_purpose", comment: ""), duration: 3.0, position: .center)
            
            self.purposeBtn.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.purposeBtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
                }
            
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_purpose", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.purposeBtn.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        
        if purpuseclickcheckstr == "1"
       {
      
       }
        else
        {
            self.view.makeToast(NSLocalizedString("sel_purpose", comment: ""), duration: 3.0, position: .center)
        //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_purpose", comment: ""), action: NSLocalizedString("ok", comment: ""))
          return
        }
        
        
        if(str_relation == NSLocalizedString("relationship1", comment: "") || str_relation == "")
        {
            self.view.makeToast(NSLocalizedString("sel_relation", comment: ""), duration: 3.0, position: .center)
            
            self.relationshipBtn.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.relationshipBtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
                }
           // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_relation", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            if #available(iOS 13.0, *) {
                self.relationshipBtn.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }
        }
        if(!termsClick)
        {
            self.view.makeToast(NSLocalizedString("pls_agree", comment: ""), duration: 3.0, position: .center)
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pls_agree", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
    
        
//        //new MobileWalletAccountNo
//        if MobileWalletAccountNotxtfd.text?.isEmpty ?? true {
//            print("MobileWalletAccountNostr is empty")
//            self.MobileWalletAccountNostr = ""
//        } else {
//            print("MobileWalletAccountNostr text")
//            self.MobileWalletAccountNostr = MobileWalletAccountNotxtfd.text!
//            print("MobileWalletAccountNostr some text",MobileWalletAccountNostr)
//
//
//        }
//
        
        
        
        if middleNameTextField.text?.isEmpty ?? true {
            print("middlenametextField is empty")
            self.str_middle_name = ""
        } else {
            print("middletextField has some text")
            self.str_middle_name = middleNameTextField.text!
            print("middletextField has some text",str_middle_name)
        }
        
        
        //middlename
        var strmiddlename = middleNameTextField.text
               strmiddlename = strmiddlename!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
               print(strmiddlename)
               // "this is the answer"
               print("strlastname",strmiddlename)
               middleNameTextField.text =  strmiddlename
               print("lastNameTextField.text",middleNameTextField.text)
        
        
        
        self.str_first_name = firstNameTextField.text!
        self.str_last_name = lastNameTextField.text!
        
        self.str_middle_name = strmiddlename!
        self.str_country_name = countryBtn.titleLabel?.text as! String
        self.str_bank_name = bankBtn.titleLabel?.text as! String
        self.str_branch_name = branchBtn.titleLabel?.text as! String
        self.str_address = address.text!
        // self.str_city = citytext
        self.str_mobile = mobileNumber.text!
        self.str_acc_no = accountNum.text!
        self.str_ifsc = ifscCode.text!
        self.str_source = sourceOfFundBtn.titleLabel?.text as! String
        self.str_purpose = purposeBtn.titleLabel?.text as! String
        
        print("partnerId",partnerId)
        print("token",token)
        print("customerRegNo",defaults.string(forKey: "REGNO"))
        print("customerIDNo",defaults.string(forKey: "USERID"))
        print("beneficiaryAccountName",self.str_first_name + " " + self.str_last_name)
        print("beneficiaryNickName","")
        print("beneficiaryAccountNumber",self.str_acc_no)
        print("beneficiaryBankName",self.str_bank_code)
        print("beneficiaryIFSCCode",self.str_ifsc)
        print("beneficiaryBankBranchName",self.str_branch_code)
        print("beneficiaryAccountType","SAVINGS")
        print("beneficiaryBankCountryCode",self.str_country)
        print("beneficiaryMobile",self.str_mobile)
        print("beneficiaryEmail","")
        print("beneficiaryAddress",self.str_address)
        // print("beneficiaryCity",self.str_city)
        print("beneficiaryFirstName",self.str_first_name)
        print("beneficiaryLastName",str_last_name)
        print("relationship",self.str_relation)
        
        //new
        UserDefaults.standard.removeObject(forKey: "mobilewalletaccnostored")
        self.defaults.set(self.mobileNumber.text!, forKey: "mobilewalletaccnostored")
        
        let rrcheck = alreadysvaedcustomerstr
        
        print("rrcheck",rrcheck)
        let a = rrcheck
        let b = "1"
        if a == b
        {
            print("apinotcalingalredysaved","apinotcall")
            
            
           // self.getToken(num: 4)
            //6
            
            serialnostored =  defaults.string(forKey: "benficiaryseioalnostored")!
            
            print("serialnostoreddww",serialnostored)
            
               if serialnostored != ""
               
            {
                
                
                
                
                self.defaults.set(self.str_country, forKey: "country_code")
                self.defaults.set(self.str_bank_code, forKey: "bank_code")
                self.defaults.set(self.str_branch_code, forKey: "branch_code")
                self.defaults.set(self.str_first_name, forKey: "first_name")
                self.defaults.set(self.str_last_name, forKey: "last_name")
                self.defaults.set(self.str_country_name, forKey: "country_name")
                self.defaults.set(self.str_bank_name, forKey: "bank_name")
                self.defaults.set(self.str_branch_name, forKey: "branch_name")
                self.defaults.set(self.str_address, forKey: "address")
                // self.defaults.set(self.str_city, forKey: "city")
                self.defaults.set(self.str_mobile, forKey: "mobile")
                self.defaults.set(self.str_acc_no, forKey: "acc_no")
                self.defaults.set(self.str_ifsc, forKey: "ifsc")
                self.defaults.set(self.str_source, forKey: "source")
                self.defaults.set(self.str_purpose, forKey: "purpose")
                self.defaults.set(self.str_relation, forKey: "relation")
                self.defaults.set(self.str_serial_no, forKey: "serial_no")
                self.defaults.set(self.str_country, forKey: "ben_country_3_letter")
                
                
                   timer?.invalidate()
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem2") as! RemittancePage2ViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            else
            {
                print("apinotcalingalredysaved","apinotcallqqq")
                print("invalid","invalid")
                
                
                self.view.makeToast(NSLocalizedString("no_data_available", comment: ""), duration: 3.0, position: .center)
                
               // self.alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("no_data_available", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
            }
            
            //benficiaryseioalnostored
            
            
        }
        else
            
        {
            timer?.invalidate()
           // self.getToken(num: 4)
            self.getToken(num: 7)
            //FOR TOKENOTP
            
            
        if str_bank_citydropcode == ""
            {
            UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
             self.citydropname = ""
            UserDefaults.standard.set(self.citydropname, forKey: "beneficiaryCity1")
            }

        }
        
        
        
    }
    @IBAction func sourceBtn(_ sender: Any) {
        
        
        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
           {
               self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
           }
            
            
        
        else
        {
            
            self.codetypestr = "SOURCE"
            
            self.getToken(num: 9)
            
            timerGesture.isEnabled = false
        
        UIView.animate(withDuration: 0.3){
            if self.tblSource.isHidden{
                self.animateSource(toogle: true)
            }
            else{
                self.animateSource(toogle: false)
            }
        }
            
        }
        
        
    }
    @IBAction func purposeBtn(_ sender: Any) {
        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            
            self.codetypestr = "PURPOSE"
            self.getToken(num: 10)
            
            timerGesture.isEnabled = false
            
            UIView.animate(withDuration: 0.3){
                if self.tblPurpose.isHidden{
                    self.animatePurpose(toogle: true)
                }
                else{
                    self.animatePurpose(toogle: false)
                }
            }
        }
    }
    @IBAction func relationBtn(_ sender: Any) {
        
        timerGesture.isEnabled = false
        
        UIView.animate(withDuration: 0.3){
            if self.tblRelationship.isHidden{
                self.animateRelation(toogle: true)
            }
            else{
                self.animateRelation(toogle: false)
            }
        }
    }
    
    @IBAction func checkBtn1(_ sender: Any) {
        if(checkClick)
        {
            checkClick = false
            checkBtn1.setImage(UIImage(named: "radio_light"), for: .normal)
        }
        else
        {
            checkClick = true
            checkBtn1.setImage(UIImage(named: "radio_green"), for: .normal)
        }
    }
    @IBAction func checkBtn2(_ sender: Any) {
        if(checkClick)
        {
            checkClick = false
            checkBtn1.setImage(UIImage(named: "radio_light"), for: .normal)
        }
        else
        {
            checkClick = true
            checkBtn1.setImage(UIImage(named: "radio_green"), for: .normal)
        }
    }
    @IBAction func checkBtn3(_ sender: Any) {
        if(termsClick)
        {
            termsClick = false
            checkBtn3.setImage(UIImage(named: "radio_light"), for: .normal)
        }
        else
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("read_terms", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
    }
    @IBAction func termsBtn(_ sender: Any) {
        self.benView.isHidden = true
        self.termsView.isHidden = false
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    @IBAction func acceptBtn(_ sender: Any) {
        self.benView.isHidden = false
        self.termsView.isHidden = true
        self.checkBtn3.setImage(UIImage(named: "radio_green"), for: .normal)
        termsClick = true
    }
    @IBAction func cashPickup(_ sender: Any) {
        //AlertView.instance.showAlert(msg: NSLocalizedString("coming_soon", comment: ""), action: .info)
    //self.getTokenpickup(num: 1)
        
        
        timer?.invalidate()
        timer = nil
        //resetTimer()

        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RemiCashPickupViewController") as! RemiCashPickupViewController
        //                    self.present(nextViewController, animated:true, completion:nil)
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    func clearBen() {
        self.selectReceiverBtn.setTitle(NSLocalizedString("sel_existing_rece", comment: ""), for: .normal)
        self.firstNameTextField.text = ""
        self.lastNameTextField.text = ""
        self.middleNameTextField.text = ""
        self.MobileWalletAccountNotxtfd.text = ""
        self.genderbtn.setTitle(NSLocalizedString("GENDERR", comment: ""), for: .normal)
        self.genderbtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        self.nationalitybtn.setTitle(NSLocalizedString("nationalityy", comment: ""), for: .normal)
        self.nationalitybtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        self.serviceproviderbtn.setTitle(NSLocalizedString("SERVICEPROVIDER", comment: ""), for: .normal)
        self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        self.countryBtn.setTitle(NSLocalizedString("country", comment: ""), for: .normal)
        self.countryBtn.setTitleColor(UIColor.lightGray, for: .normal)
        // self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
        self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        self.genderbtn.setTitle(NSLocalizedString("GENDERR", comment: ""), for: .normal)
        self.genderbtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        self.nationalitybtn.setTitle(NSLocalizedString("nationalityy", comment: ""), for: .normal)
        self.nationalitybtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        
        
        
        self.address.text = ""
        // self.city.text = ""
        self.mobileNumber.text = ""
        self.accountNum.text = ""
        self.ifscCode.text = ""
        self.swiftCode.text = ""
        self.sortCode.text = ""
        self.routingCode.text = ""
        self.iban.text = ""
        self.checkBtn1.setImage(UIImage(named: "radio_light"), for: .normal)
        self.checkClick = false
        self.sourceOfFundBtn.setTitle(NSLocalizedString("source1", comment: ""), for: .normal)
        self.purposeBtn.setTitle(NSLocalizedString("purpose1", comment: ""), for: .normal)
        self.relationshipBtn.setTitle(NSLocalizedString("relationship1", comment: ""), for: .normal)
        self.checkBtn3.setImage(UIImage(named: "radio_light"), for: .normal)
        self.termsClick = false
        self.accountNum.isHidden = true
        self.ifscCode.isHidden = true
        print("asdf11111")
        //self.accNoTop.constant = 0
        self.ifscTop.constant = 0
        self.ibanTop.constant = 0
        self.checkTop.constant = 10
        self.sortCodeTop.constant = 0
        self.swiftCodeTop.constant = 0
        self.routingCodeTop.constant = 0
        
        // servicetypebtn
        self.servicetypebtn.setTitle("SERVICE TYPE", for: .normal)
        self.servicetypebtn.setTitleColor(UIColor.gray, for: .normal)
        
        
        self.str_country = ""
        self.str_bank_code = ""
        self.str_branch_code = ""
        self.str_first_name = ""
        self.str_last_name = ""
        self.str_country_name = ""
        self.str_bank_name = ""
        self.str_branch_name = ""
        self.str_address = ""
        // self.str_city = ""
        self.str_mobile = ""
        self.str_acc_no = ""
        self.str_ifsc = ""
        self.str_source = ""
        self.str_purpose = ""
        self.str_relation = ""
        self.str_serial_no = ""
        self.str_ben_account = ""
        self.str_country_2_code = ""
        self.checkClick = false
        self.termsClick = false
    }
//    func clearBenforServiceTypechange() {
//        self.selectReceiverBtn.setTitle(NSLocalizedString("sel_existing_rece", comment: ""), for: .normal)
//        self.firstNameTextField.text = ""
//        self.lastNameTextField.text = ""
//        self.middleNameTextField.text = ""
//        self.genderbtn.setTitle(NSLocalizedString("GENDER", comment: ""), for: .normal)
//        self.genderbtn.setTitleColor(UIColor.lightGray, for: .normal)
//
//        self.nationalitybtn.setTitle(NSLocalizedString("NATIONALITY", comment: ""), for: .normal)
//        self.nationalitybtn.setTitleColor(UIColor.lightGray, for: .normal)
//
//        self.serviceproviderbtn.setTitle(NSLocalizedString("SERVICE PROVIDER", comment: ""), for: .normal)
//        self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
//
//        self.countryBtn.setTitle(NSLocalizedString("country", comment: ""), for: .normal)
//        self.countryBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        // self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
//        self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
//        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
//        self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.address.text = ""
//        // self.city.text = ""
//        self.mobileNumber.text = ""
//        self.accountNum.text = ""
//        self.ifscCode.text = ""
//        self.swiftCode.text = ""
//        self.sortCode.text = ""
//        self.routingCode.text = ""
//        self.iban.text = ""
//        self.checkBtn1.setImage(UIImage(named: "radio_light"), for: .normal)
//        self.checkClick = false
//        self.sourceOfFundBtn.setTitle(NSLocalizedString("source1", comment: ""), for: .normal)
//        self.purposeBtn.setTitle(NSLocalizedString("purpose1", comment: ""), for: .normal)
//        self.relationshipBtn.setTitle(NSLocalizedString("relationship1", comment: ""), for: .normal)
//        self.checkBtn3.setImage(UIImage(named: "radio_light"), for: .normal)
//        self.termsClick = false
//        self.accountNum.isHidden = true
//        self.ifscCode.isHidden = true
//        print("asdf11111")
//        // self.accNoTop.constant = 0
//        self.ifscTop.constant = 0
//        self.ibanTop.constant = 0
//        self.checkTop.constant = 10
//        self.sortCodeTop.constant = 0
//        self.swiftCodeTop.constant = 0
//        self.routingCodeTop.constant = 0
//
//        // servicetypebtn
//        //self.servicetypebtn.setTitle("SERVICE TYPE", for: .normal)
//        // self.servicetypebtn.setTitleColor(UIColor.gray, for: .normal)
//
//
//        self.str_country = ""
//        self.str_bank_code = ""
//        self.str_branch_code = ""
//        self.str_first_name = ""
//        self.str_last_name = ""
//        self.str_country_name = ""
//        self.str_bank_name = ""
//        self.str_branch_name = ""
//        self.str_address = ""
//        // self.str_city = ""
//        self.str_mobile = ""
//        self.str_acc_no = ""
//        self.str_ifsc = ""
//        self.str_source = ""
//        self.str_purpose = ""
//        self.str_relation = ""
//        self.str_serial_no = ""
//        self.str_ben_account = ""
//        self.str_country_2_code = ""
//        self.checkClick = false
//        self.termsClick = false
//    }
//
//    func clearBenforCountrychange() {
//        self.selectReceiverBtn.setTitle(NSLocalizedString("sel_existing_rece", comment: ""), for: .normal)
//        self.firstNameTextField.text = ""
//        self.lastNameTextField.text = ""
//        self.middleNameTextField.text = ""
//        self.genderbtn.setTitle(NSLocalizedString("GENDER", comment: ""), for: .normal)
//        self.genderbtn.setTitleColor(UIColor.lightGray, for: .normal)
//
//        self.nationalitybtn.setTitle(NSLocalizedString("NATIONALITY", comment: ""), for: .normal)
//        self.nationalitybtn.setTitleColor(UIColor.lightGray, for: .normal)
//
//        self.serviceproviderbtn.setTitle(NSLocalizedString("SERVICE PROVIDER", comment: ""), for: .normal)
//        self.serviceproviderbtn.setTitleColor(UIColor.lightGray, for: .normal)
//
//        //self.countryBtn.setTitle(NSLocalizedString("country", comment: ""), for: .normal)
//        // self.countryBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        //self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
//        self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
//
//        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
//        self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.address.text = ""
//        // self.city.text = ""
//        self.mobileNumber.text = ""
//        self.accountNum.text = ""
//        self.ifscCode.text = ""
//        self.swiftCode.text = ""
//        self.sortCode.text = ""
//        self.routingCode.text = ""
//        self.iban.text = ""
//        self.checkBtn1.setImage(UIImage(named: "radio_light"), for: .normal)
//        self.checkClick = false
//        self.sourceOfFundBtn.setTitle(NSLocalizedString("source1", comment: ""), for: .normal)
//        self.purposeBtn.setTitle(NSLocalizedString("purpose1", comment: ""), for: .normal)
//        self.relationshipBtn.setTitle(NSLocalizedString("relationship1", comment: ""), for: .normal)
//        self.checkBtn3.setImage(UIImage(named: "radio_light"), for: .normal)
//        self.termsClick = false
//        self.accountNum.isHidden = true
//        self.ifscCode.isHidden = true
//        print("asdf11111")
//        // self.accNoTop.constant = 0
//        self.ifscTop.constant = 0
//        self.ibanTop.constant = 0
//        self.checkTop.constant = 10
//        self.sortCodeTop.constant = 0
//        self.swiftCodeTop.constant = 0
//        self.routingCodeTop.constant = 0
//
//        // servicetypebtn
//        //self.servicetypebtn.setTitle("SERVICE TYPE", for: .normal)
//        // self.servicetypebtn.setTitleColor(UIColor.gray, for: .normal)
//
//
//        self.str_country = ""
//        self.str_bank_code = ""
//        self.str_branch_code = ""
//        self.str_first_name = ""
//        self.str_last_name = ""
//        self.str_country_name = ""
//        self.str_bank_name = ""
//        self.str_branch_name = ""
//        self.str_address = ""
//        // self.str_city = ""
//        self.str_mobile = ""
//        self.str_acc_no = ""
//        self.str_ifsc = ""
//        self.str_source = ""
//        self.str_purpose = ""
//        self.str_relation = ""
//        self.str_serial_no = ""
//        self.str_ben_account = ""
//        self.str_country_2_code = ""
//        self.checkClick = false
//        self.termsClick = false
//    }
    
    func clearBenforservicetypechange()
     {
         self.countryBtn.setTitle(NSLocalizedString("country", comment: ""), for: .normal)
         self.countryBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
       // self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
         self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
         self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
         self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
          self.ifscCode.text = ""
         self.str_bank_code = ""
         self.str_branch_code = ""
         self.str_country = ""
        self.str_bank_citydropcode = ""
        
        self.firstNameTextField.text = ""
        self.lastNameTextField.text = ""
        self.middleNameTextField.text = ""
        
        UserDefaults.standard.removeObject(forKey: "serviceproviderBRANCHname")
        UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
     }
    
     //self.clearBen()
     func clearBenforcountrychange()
     {
        self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
        
         self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
         self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
          self.ifscCode.text = ""
         self.str_bank_code = ""
         self.str_branch_code = ""
         self.str_country = ""
        self.str_bank_citydropcode = ""
        
        
        self.middleNameTextField.text = ""
        self.MobileWalletAccountNotxtfd.text = ""
        
            
        self.accountNum.text = ""
       // self.city.text = ""
        self.iban.text = ""
        
        
        self.sourceOfFundBtn.setTitle(NSLocalizedString("source1", comment: ""), for: .normal)
        self.purposeBtn.setTitle(NSLocalizedString("purpose1", comment: ""), for: .normal)
       // self.relationshipBtn.setTitle(NSLocalizedString("relationship1", comment: ""), for: .normal)
        
        
        UserDefaults.standard.removeObject(forKey: "serviceproviderBRANCHname")
        UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
     }
     
     func clearBenforbankchange()
     {
         
         self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
         self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
          self.ifscCode.text = ""
         self.str_bank_code = ""
        UserDefaults.standard.removeObject(forKey: "str_bank_codeserviceprovidercode")
         self.str_branch_code = ""
        self.str_bank_citydropcode = ""
        
        UserDefaults.standard.removeObject(forKey: "serviceproviderBRANCHname")
        UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
     }
    
    func clearBenforcitydropchange()
     {
         
         self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
         self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
          //self.ifscCode.text = ""
         //self.str_bank_code = ""
         self.str_branch_code = ""
        self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
        self.str_bank_citydropcode = ""
     }
    
    
    
    func animateBeneficiary(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.tblBeneficiary.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.tblBeneficiary.isHidden = true
            }
        }
    }
    func animateSource(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.tblSource.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.tblSource.isHidden = true
            }
        }
    }
    func animatePurpose(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.tblPurpose.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.tblPurpose.isHidden = true
            }
        }
    }
    func animateRelation(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.tblRelationship.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3){
                self.tblRelationship.isHidden = true
            }
        }
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    
    
    
    
    //pickup
    func getTokenpickup(num:Int) {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        ChangeEmailViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                
                print("token4  ",token)
                if(num == 1)
                {
                    self.validateRemittanceStatus(check: 1, accessToken: token)
                }else if(num == 2)
                {
                    // self.getNotificationCount(accessToken: token)
                }
                break
            case .failure:
                break
            }
        })
    }
    
    //pickup
    func validateRemittanceStatus(check:Int,accessToken:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print("appVersion",appVersion)
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":appVersion,"customerPhone":"IOS","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"ISREMITALLOWED","isExistOrValid":"0"]
        
        
        print("urlvalidationpik ",url)
        print("paramsvalidationpik ",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        ChangeEmailViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            let respMsg = myResult!["responseMessage"].stringValue
            if(respCode == "S1111")
            {
                if(check == 1)
                {
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RemiCashPickupViewController") as! RemiCashPickupViewController
                    //                    self.present(nextViewController, animated:true, completion:nil)
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
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
                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                let okAction = UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .cancel){ (action:UIAlertAction) in
                    
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RemiCashPickupViewController") as! RemiCashPickupViewController
                    //                    self.present(nextViewController, animated:true, completion:nil)
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                }
                commonAlert.addAction(okAction)
                self.present(commonAlert, animated: true, completion: nil)
            }
            else if(respCode == "E7111" || respCode == "E7112")
            {
                AlertView.instance.showAlert(msg: respMsg, action: .attention)
            }
            else
            {
                AlertView.instance.showAlert(msg: NSLocalizedString("u_r_not_allowed", comment: "") + NSLocalizedString("contact_customer_care", comment: ""), action: .attention)
            }
            
            
        })
    }
    
    //AccounttransferbtnaCTION
    
    
    
    func getTokenACTBtn(num:Int) {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        ChangeEmailViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                
                print("token4  ",token)
                if(num == 1)
                {
                    self.validateRemittanceStatusACTBtn(check: 1, accessToken: token)
                }else if(num == 2)
                {
                    // self.getNotificationCount(accessToken: token)
                }
                break
            case .failure:
                break
            }
        })
    }
    
    func validateRemittanceStatusACTBtn(check:Int,accessToken:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print("appVersion",appVersion)
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":appVersion,"customerPhone":"IOS","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"ISREMITALLOWED","isExistOrValid":"0"]
        
         print("urlvalidation ",url)
         print("paramsvalidation ",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        ChangeEmailViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            let respMsg = myResult!["responseMessage"].stringValue
            if(respCode == "S1111")
            {
                if(check == 1)
                {
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem1") as! RemittancePage1ViewController
                    //                    self.present(nextViewController, animated:true, completion:nil)
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
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
                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                let okAction = UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .cancel){ (action:UIAlertAction) in
                    
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem1") as! RemittancePage1ViewController
                    //                    self.present(nextViewController, animated:true, completion:nil)
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                }
                commonAlert.addAction(okAction)
                self.present(commonAlert, animated: true, completion: nil)
            }
            else if(respCode == "E7111" || respCode == "E7112")
            {
                AlertView.instance.showAlert(msg: respMsg, action: .attention)
            }
            else
            {
                AlertView.instance.showAlert(msg: NSLocalizedString("u_r_not_allowed", comment: "") + NSLocalizedString("contact_customer_care", comment: ""), action: .attention)
            }
            
            
        })
    }
    
    
    
    
    
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        print("tokenurl",url)
        
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        RemiCashPickupViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token  ",token)
                if(num == 1)
                {
                    self.getBeneficiary(access_token: token)
                }
                else if(num == 2)
                {
                    self.getBank(access_token: token)
                }
                else if(num == 3)
                {
                    self.getBranch(access_token: token, bankCode: self.str_bank_code)
                }
                else if(num == 4)
                {
                    self.saveBeneficiary(access_token: token)
                }
                else if(num == 5)
                {
                    self.viewBeneficiary(access_token: token, serial_no: self.str_serial_no, accountNo: self.str_ben_account)
                }
                else if(num == 6)
                {
                    self.deleteBeneficiary(access_token: token)
                }
                    
                else if(num == 7)
                {
                    self.viewCustomer(access_token: token)
                }
                else if(num == 8)
                {
                    self.getBankcitydrop(access_token:token)
                }
                
                else if(num == 9)
                    {
                    self.getSource(access_token: token)
                    }
                else if(num == 10)
                    {
                    self.getPurpose(access_token: token)
                    }
                
                
                break
            case .failure:
                break
            }
            
        })
    }
    
    
    func getBeneficiary(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.beneficiaryList.removeAll()
        let arrayValue = Beneficiary(beneficiaryNickName: "", beneficiarySerialNo: "", beneficiaryBankName: "", beneficiaryAccountNo: "", beneficiaryAccountType: "", beneficiaryBankCountryName: "", beneficiaryAccountName: NSLocalizedString("sel_existing_rece", comment: ""), beneficiaryIfscCode: "", beneficiaryBankBranchName: "", beneficiaryBankCountryCode: "", beneficiaryMobile: "", beneficiaryEmail: "", beneficiaryCity: "", beneficiaryAddress: "", beneficiaryIBAN: "")
        self.beneficiaryList.append(arrayValue)
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "beneficiary/listbeneficiary"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerUserID":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"mpin":defaults.string(forKey: "PIN")!,"serviceType":"CASH"]
        print("urllistben",url)
        print("paramslistben",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemiCashPickupViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            let resultArray = myResult!["benelist"]
            print("resp",resultArray)
            for i in resultArray.arrayValue{
                let beneficiary = Beneficiary(beneficiaryNickName: i["beneficiaryNickName"].stringValue, beneficiarySerialNo: i["beneficiarySerialNo"].stringValue, beneficiaryBankName: i["beneficiaryBankName"].stringValue, beneficiaryAccountNo: i["beneficiaryAccountNo"].stringValue, beneficiaryAccountType: i["beneficiaryAccountType"].stringValue, beneficiaryBankCountryName: i["beneficiaryBankCountryName"].stringValue, beneficiaryAccountName: i["beneficiaryAccountName"].stringValue, beneficiaryIfscCode: i["beneficiaryIfscCode"].stringValue, beneficiaryBankBranchName: i["beneficiaryBankBranchName"].stringValue, beneficiaryBankCountryCode: i["beneficiaryBankCountryCode"].stringValue, beneficiaryMobile: i["beneficiaryMobile"].stringValue, beneficiaryEmail: i["beneficiaryEmail"].stringValue, beneficiaryCity: i["beneficiaryCity"].stringValue, beneficiaryAddress: i["beneficiaryAddress"].stringValue, beneficiaryIBAN: i["beneficiaryIBAN"].stringValue)
                self.beneficiaryList.append(beneficiary)
                self.tblBeneficiary.reloadData()
            }
            
        }
        
        )
        
        //self.resetTimer()
    }
    func saveBeneficiary(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "beneficiary/savebeneficiary"
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print("appVersion",appVersion)
        
        if str_middle_name != ""
        {
            fullnamestr = self.str_first_name + " " + str_middle_name + " "  + self.str_last_name
        }
        else
        {
            fullnamestr = self.str_first_name + " " + self.str_last_name
        }
        
//        if str_bank_citydropcode == ""
//        {
//            UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
//            self.citydropname = ""
//            UserDefaults.standard.set(self.citydropname, forKey: "beneficiaryCity1")
//        }
        
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO"),"customerIDNo":defaults.string(forKey: "USERID"),"beneficiaryAccountName":fullnamestr,"beneficiaryNickName":"","beneficiaryAccountNumber":"","beneficiaryBankName":self.str_bank_code,"beneficiaryIFSCCode":self.str_ifsc,"beneficiaryBankBranchName":self.str_branch_code,"beneficiaryAccountType":"SAVINGS","serviceType":self.servicetypestr,"beneficiaryGender": str_gender,"beneficiaryNationality": self.str_countrynationality,"beneficiaryBankCountryCode":self.str_country,"beneficiaryMobile":self.str_mobile,"beneficiaryEmail":"","beneficiaryAddress":self.str_address,"beneficiaryCity":self.str_bank_citydropcode,"beneficiaryIBAN":"","beneficiarySwiftCode":"","beneficiarySortCode":"","beneficiaryRoutingCode":"","beneficiaryFirstName":self.str_first_name,"beneficiaryMiddleName":self.str_middle_name,"beneficiaryLastName":str_last_name,"deviceType":"IOS","versionName":appVersion,"relationship":self.str_relation,"action":""]
        
        
        //middlename
        //gender
        //nationatiy
        //servicetype static
        
        //check 2 beneficiaryCity dropdown id
        
        
        //,"serviceType":"CREDIT","beneficiaryMiddleName": "kl","beneficiaryGender": "male","beneficiaryNationality": "ZMB"
        print("urlbeneficiary/savebeneficiary",url)
        print("urlbeneficiary/savebeneficiaryparams",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemiCashPickupViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { [self] (response) in
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            print("resp",respCode)
            print("responsecashpick svavebenif",response)
            self.effectView.removeFromSuperview()
            
            
            if respCode == "S105"
            {
                
                
                UserDefaults.standard.removeObject(forKey: "benficiaryseioalnostored")
                self.str_benificiaryserialnostr = myResult!["generatedSerialNo"].stringValue
                UserDefaults.standard.set(self.str_benificiaryserialnostr, forKey: "benficiaryseioalnostored")
                //let generatedSerialNoCode = myResult!["generatedSerialNo"].stringValue
            }
            
           // self.str_benificiaryserialnostr =  defaults.string(forKey: "benficiaryseioalnostored")!
            
            print("serialnostoreddww","serialnostoredwww")
            
            if(respCode == "S105" && self.str_benificiaryserialnostr != ""  )
            //if(respCode == "S105" || respCode == "S108" )
            {
                
                self.defaults.set(self.str_country, forKey: "country_code")
                self.defaults.set(self.str_bank_code, forKey: "bank_code")
                self.defaults.set(self.str_branch_code, forKey: "branch_code")
                self.defaults.set(self.str_first_name, forKey: "first_name")
                self.defaults.set(self.str_last_name, forKey: "last_name")
                self.defaults.set(self.str_country_name, forKey: "country_name")
                self.defaults.set(self.str_bank_name, forKey: "bank_name")
                self.defaults.set(self.str_branch_name, forKey: "branch_name")
                self.defaults.set(self.str_address, forKey: "address")
                // self.defaults.set(self.str_city, forKey: "city")
                self.defaults.set(self.str_mobile, forKey: "mobile")
                self.defaults.set(self.str_acc_no, forKey: "acc_no")
                self.defaults.set(self.str_ifsc, forKey: "ifsc")
                self.defaults.set(self.str_source, forKey: "source")
                self.defaults.set(self.str_purpose, forKey: "purpose")
                self.defaults.set(self.str_relation, forKey: "relation")
                self.defaults.set(self.str_serial_no, forKey: "serial_no")
                self.defaults.set(self.str_country, forKey: "ben_country_3_letter")
                
                
                
                self.middlenamestrstored = self.str_middle_name
                print("middlenamestrstored ",self.middlenamestrstored)
                print("str_middle_name ",self.str_middle_name)
                
                if self.middlenamestrstored.isEmpty || self.middlenamestrstored == ""
                {
                UserDefaults.standard.removeObject(forKey: "middlenamestrstored")
                self.middlenamestrstored = ""
                UserDefaults.standard.set(self.middlenamestrstored, forKey: "middlenamestrstored")
                    
                }
                else
                {
                UserDefaults.standard.removeObject(forKey: "middlenamestrstored")
                self.middlenamestrstored = self.str_middle_name
                UserDefaults.standard.set(self.middlenamestrstored, forKey: "middlenamestrstored")
                    
                }
                
    
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem2") as! RemittancePage2ViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            else
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            }
        })
    }
    func deleteBeneficiary(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "beneficiary/savebeneficiary"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"beneficiaryAccountName":"","beneficiaryNickName":"","beneficiaryAccountNumber":self.str_acc_no,"beneficiaryBankName":"","beneficiaryIFSCCode":"","beneficiaryBankBranchName":"","beneficiaryAccountType":"","beneficiaryBankCountryCode":"","beneficiaryMobile":"","beneficiaryEmail":"","beneficiaryAddress":"","beneficiaryCity":"","beneficiaryIBAN":"","beneficiarySwiftCode":"","beneficiarySortCode":"","beneficiaryRoutingCode":"","beneficiaryFirstName":"","beneficiaryMiddleName":"","beneficiaryLastName":"","relationship":"","serviceType":self.servicetypestr,"beneficiarySerialNo":self.str_serial_no,"action":"DELETE"]
        
        
        //beneficiarySerialNo
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemiCashPickupViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(respCode == "S2001")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("ben_deleted", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.getToken(num: 1)
                self.clearBen()
                self.scrollView.setContentOffset(.zero, animated: true)
                
            }
            else
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            }
            
        })
    }
    
    func viewBeneficiary(access_token:String,serial_no:String,accountNo:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "beneficiary/viewbeneficiary"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"password":defaults.string(forKey: "PASSW")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerRegNo":defaults.string(forKey: "REGNO")!,"mpin":defaults.string(forKey: "PIN")!,"beneficiarySerialNo":serial_no,"beneficiaryAccountNumber":accountNo,"serviceType":"CASH"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemiCashPickupViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { [self] (response) in
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(respCode == "S106")
            {
                self.selectReceiverBtn.setTitleColor(UIColor.black, for: .normal)
                self.firstNameTextField.text = myResult!["beneficiaryFirstName"].stringValue
                self.lastNameTextField.text = myResult!["beneficiaryLastName"].stringValue
                self.countryBtn.setTitle("\(myResult!["countryName"].stringValue)", for: .normal)
                self.countryBtn.setTitleColor(UIColor.black, for: .normal)
                self.str_country = myResult!["beneficiaryBankCountryCode"].stringValue
                self.getPurpose(access_token: self.str_country)
                self.bankBtn.setTitle("\(myResult!["beneficiaryCity1"].stringValue)", for: .normal)
                self.bankBtn.setTitleColor(UIColor.black, for: .normal)
                self.serviceproviderbtn.setTitle("\(myResult!["beneficiaryBankName1"].stringValue)", for: .normal)
                self.serviceproviderbtn.setTitleColor(UIColor.black, for: .normal)
                self.genderbtn.setTitle("\(myResult!["beneficiaryGender"].stringValue)", for: .normal)
                self.genderbtn.setTitleColor(UIColor.black, for: .normal)
                self.nationalitybtn.setTitle("\(myResult!["beneficiaryNationality1"].stringValue)", for: .normal)
                self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                self.middleNameTextField.text = myResult!["beneficiaryMiddleName"].stringValue
                
                self.str_bank_code = myResult!["beneficiaryBankName"].stringValue
                self.branchBtn.setTitle("\(myResult!["beneficiaryBankBranchName1"].stringValue)", for: .normal)
                self.branchBtn.setTitleColor(UIColor.black, for: .normal)
                self.str_branch_code = myResult!["beneficiaryBankBranchName"].stringValue
                self.address.text = myResult!["beneficiaryAddress"].stringValue
                // self.city.text = myResult!["beneficiaryCity"].stringValue
                self.mobileNumber.text = myResult!["beneficiaryMobile"].stringValue
                print("country... ",myResult!["countryName"].stringValue)
                self.servicetypebtn.setTitle("\(myResult!["serviceType"].stringValue)", for: .normal)
                self.servicetypebtn.setTitleColor(UIColor.black, for: .normal)
                
               // self.MobileWalletAccountNotxtfd.text = myResult!["beneficiaryAccountNumber"].stringValue
                
      
                
                
                self.middlenamestrstored = myResult!["beneficiaryMiddleName"].stringValue
                
                if myResult!["beneficiaryMiddleName"].stringValue.isEmpty
                {
                UserDefaults.standard.removeObject(forKey: "middlenamestrstored")
                self.middlenamestrstored = ""
                UserDefaults.standard.set(self.middlenamestrstored, forKey: "middlenamestrstored")
                    
                }
                else
                {
                UserDefaults.standard.removeObject(forKey: "middlenamestrstored")
                self.middlenamestrstored = myResult!["beneficiaryMiddleName"].stringValue
                UserDefaults.standard.set(self.middlenamestrstored, forKey: "middlenamestrstored")
                    
                }
                
                //
                
                
                //newstore
                self.str_benificiaryserialnostr = myResult!["beneficiarySerialNo"].stringValue
                UserDefaults.standard.removeObject(forKey: "benficiaryseioalnostored")
                UserDefaults.standard.set(self.str_benificiaryserialnostr, forKey: "benficiaryseioalnostored")
                
                
                
                //
                UserDefaults.standard.removeObject(forKey: "countrycodestored")
                self.str_country = myResult!["beneficiaryBankCountryCode"].stringValue
                UserDefaults.standard.set(self.str_country, forKey: "countrycodestored")
                //
                UserDefaults.standard.removeObject(forKey: "str_bank_codeserviceprovidercode")
                self.str_bank_code = myResult!["beneficiaryBankName"].stringValue
                UserDefaults.standard.set(self.str_bank_code, forKey: "str_bank_codeserviceprovidercode")
                //
                UserDefaults.standard.removeObject(forKey: "str_branch_code")
                self.str_branch_code = myResult!["beneficiaryBankBranchName"].stringValue
                UserDefaults.standard.set(self.str_branch_code, forKey: "str_branch_code")
                //
                
                
                UserDefaults.standard.removeObject(forKey: "servicetypestoresel")
                //let servicetype
                self.servicetypeviewben = myResult!["serviceType"].stringValue
                UserDefaults.standard.set(self.servicetypeviewben, forKey: "servicetypestoresel")
                
                self.servicetypestr = myResult!["serviceType"].stringValue
                print("sertypesavben",myResult!["serviceType"].stringValue)
                print("sertypesavbenstr",self.servicetypestr)
                
                
                
                UserDefaults.standard.removeObject(forKey: "str_bank_citydropcode")
                self.str_bank_citydropcodeviewben = myResult!["beneficiaryCity"].stringValue
                UserDefaults.standard.set(self.str_bank_citydropcodeviewben, forKey: "str_bank_citydropcode")
            
            UserDefaults.standard.removeObject(forKey: "serviceproviderBANKname")
            self.serviceproviderBANKname = myResult!["beneficiaryBankName1"].stringValue
            UserDefaults.standard.set(self.serviceproviderBANKname, forKey: "serviceproviderBANKname")
                
                
        UserDefaults.standard.removeObject(forKey: "serviceproviderBRANCHname")
        self.serviceproviderBRANCHname = myResult!["beneficiaryBankBranchName1"].stringValue
        UserDefaults.standard.set(self.serviceproviderBRANCHname, forKey: "serviceproviderBRANCHname")
                
                
                
                //removing here
               // UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
                UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
                self.citydropname = myResult!["beneficiaryCity1"].stringValue
                UserDefaults.standard.set(self.citydropname, forKey: "beneficiaryCity1")
                
                
                //removehere a/c transfer page city
               // UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
                
                
                if(myResult!["countryName"].stringValue == "India")
                {
                    print("asdf22222")
                    self.accountNum.isHidden = false
                    self.ifscCode.isHidden = false
                    //self.accNoTop.constant = 10
                    self.ifscTop.constant = 10
                    self.ibanTop.constant = 0
                    self.checkTop.constant = 10
                    self.sortCodeTop.constant = 0
                    self.swiftCodeTop.constant = 0
                    self.routingCodeTop.constant = 0
                    self.accountNum.text = myResult!["beneficiaryAccountNumber"].stringValue
                    self.ifscCode.text = myResult!["beneficiaryIFSCCode"].stringValue
                }
                else{
                    print("asdf33333")
                    self.str_ifsc = ""
                    self.ifscCode.isHidden = true
                    self.accountNum.isHidden = false
                    // self.accNoTop.constant = 10
                    self.ifscTop.constant = 0
                    self.ibanTop.constant = 0
                    self.checkTop.constant = 10
                    self.sortCodeTop.constant = 0
                    self.swiftCodeTop.constant = 0
                    self.routingCodeTop.constant = 0
                    self.accountNum.text = myResult!["beneficiaryAccountNumber"].stringValue
                }
                self.ifscCode.isHidden = true
                self.accountNum.isHidden = true
                self.swiftCode.isHidden = true
                self.sortCode.isHidden = true
                self.routingCode.isHidden = true
                self.iban.isHidden = true
                
                //cheknull
                if myResult!["beneficiaryFirstName"].stringValue.isEmpty
                {
                    print("printy",myResult!["beneficiaryFirstName"].stringValue)
                    self.firstNameTextField.isHidden = true
                    self.firstnameheightconsraint.constant = 0
                }
                else
                {
                    self.firstNameTextField.isHidden = false
                    self.firstnameheightconsraint.constant = 40
                }
                
                if myResult!["beneficiaryLastName"].stringValue.isEmpty
                {
                    print("printy",myResult!["beneficiaryLastName"].stringValue)
                    self.lastNameTextField.isHidden = true
                    self.lastnameheightconstraint.constant = 0
                }
                else
                {
                    self.lastNameTextField.isHidden = false
                    self.lastnameheightconstraint.constant = 40
                }
                
                if  myResult!["beneficiaryMiddleName"].stringValue.isEmpty
                {
                    print("printy",myResult!["beneficiaryMiddleName"].stringValue)
                    self.middleNameTextField.isHidden = true
                    self.middlenamehieghtconstrain.constant = 0
                    
                    self.middlenameclickcheckstr = "0"
                }
                else
                {
                    self.middleNameTextField.isHidden = false
                    self.middlenamehieghtconstrain.constant = 40
                    
                    self.middlenameclickcheckstr = "1"
                }
                
                if myResult!["beneficiaryGender"].stringValue.isEmpty
                {
                    print("printy",myResult!["beneficiaryGender"].stringValue)
                    
                    self.genderbtn.isHidden = true
                    self.genderbtnhiehtconstraint.constant = 0
                    
                    self.genderyesnoclickcheckstr = "0"
                }
                else
                {
                    self.genderbtn.isHidden = false
                    self.genderbtnhiehtconstraint.constant = 40
                    
                    self.genderyesnoclickcheckstr = "1"
                }
//                
//                if myResult!["beneficiaryBankName1"].stringValue.isEmpty
//                {
//                    print("printy",myResult!["beneficiaryBankName1"].stringValue)
//                    //                    self.bankBtn.isHidden = true
//                    //                    self.bankntnheightconstraint.constant = 0
//                    //                    //test
//                    //                    self.CITYDROPTXTFILED.isHidden = true
//                    //                    self.Citydroptxtfiledhieghtconstraint.constant = 0
//                    
//                    self.serviceproviderbtn.isHidden = true
//                    self.serviceproviderconstrainttop.constant = 0
//                    self.serviceproviderbankbtnheightconstrain.constant = 0
//                    
//            UserDefaults.standard.removeObject(forKey: "str_bank_codeserviceprovidercode")
//            UserDefaults.standard.removeObject(forKey: "serviceproviderBANKname")
//                    
//                    
//                }
//                else
//                {
//                    //                  self.bankBtn.isHidden = false
//                    //                self.bankntnheightconstraint.constant = 40
//                    //
//                    //                    //test
//                    //                    self.CITYDROPTXTFILED.isHidden = false
//                    //                    self.Citydroptxtfiledhieghtconstraint.constant = 40
//                    
//                    self.serviceproviderbtn.isHidden = false
//                    self.serviceproviderconstrainttop.constant = 10
//                    self.serviceproviderbankbtnheightconstrain.constant = 40
//                    
//                    
//                }
                if myResult!["beneficiaryBankBranchName1"].stringValue.isEmpty
                {
                    self.branchBtn.isHidden = true
                    self.branchbtnheightconstaint.constant = 0
                    UserDefaults.standard.removeObject(forKey: "str_branch_code")
                    UserDefaults.standard.removeObject(forKey: "serviceproviderBRANCHname")
                    
                }
                else
                {
                    self.branchBtn.isHidden = false
                    self.branchbtnheightconstaint.constant = 40
                }
                
//                if myResult!["beneficiaryGender"].stringValue.isEmpty
//                {
//                    self.genderbtn.isHidden = true
//                    self.genderbtnhiehtconstraint.constant = 0
//
//
//
//                }
//                else
//                {
//                    self.genderbtn.isHidden = false
//                    self.genderbtnhiehtconstraint.constant = 40
//
//
//                }
//
                
                
                
                
                
                //new //serv iceprovider or moboperator
                
                if myResult!["beneficiaryBankName1"].stringValue.isEmpty
                {
                    self.serviceproviderbtn.isHidden = true
                   
                    self.serviceproviderbankbtnheightconstrain.constant = 0
                    self.serviceproviderconstrainttop.constant = 0
                }
                else
                {
                    self.serviceproviderbtn.isHidden = false
                    self.serviceproviderbankbtnheightconstrain.constant = 40
                    self.serviceproviderconstrainttop.constant = 10
                }
                
                if myResult!["beneficiaryAddress"].stringValue.isEmpty
                {
                    self.address.isHidden = true
                    self.addressheightconstraint.constant = 0
                    
                    self.addressyesnoclickcheckstr = "0"
                }
                else
                {
                    self.address.isHidden = false
                    self.addressheightconstraint.constant = 40
                    
                    self.addressyesnoclickcheckstr = "1"
                }
                if myResult!["beneficiaryMobile"].stringValue.isEmpty
                {
                    self.mobileNumber.isHidden = true
                    self.mobileheightconstraint.constant = 0
                    
                    self.mobileyesnoclickcheckstr = "0"
                }
                else
                {
                    self.mobileNumber.isHidden = false
                    self.mobileheightconstraint.constant = 40
                    
                    self.mobileyesnoclickcheckstr = "1"
                }
                
                
                //new mobilewalletaccountno
//                if myResult!["beneficiaryAccountNumber"].stringValue.isEmpty
//                {
//                    self.mobilewalletaccountheightconstant.constant = 0
//                    self.mobilewalletaccounttopconstant.constant = 0
//                    self.MobileWalletAccountNotxtfd.isHidden = true
//                }
//                else
//                {
//                    self.mobilewalletaccountheightconstant.constant = 40
//                    self.mobilewalletaccounttopconstant.constant = 7
//                    self.MobileWalletAccountNotxtfd.isHidden = false
//
//
//                }
                
                
                if myResult!["beneficiaryNationality1"].stringValue.isEmpty
                 {
                    self.nationalitybtn.isHidden = true
                    self.nationaltyconstrainttop.constant = 0
                    self.nationalitybtnhieghtconstraint.constant = 0
                    
                    self.nationalityyesnoclickcheckstr = "0"
                }
                else
                {
                self.nationalitybtn.isHidden = false
                self.nationaltyconstrainttop.constant = 10
                self.nationalitybtnhieghtconstraint.constant = 40
                    
                    self.nationalityyesnoclickcheckstr = "1"
                    
                               
                               //                    self.nationalitybtn.isHidden = true
                               //                    self.nationalitybtnconstrainttop.constant = 0
                               //                    self.nationalitybtnhieghtconstraint.constant = 0
                               
                           }
                           
                
                if myResult!["beneficiaryCity1"].stringValue.isEmpty
                {
                    self.bankBtn.isHidden = true
                    self.bankfcitybtnconstrainttop.constant = 0
                    self.bankntnheightconstraint.constant = 0
                    
                    
                UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
//                    self.citydropname = ""
//                    UserDefaults.standard.set(self.citydropname, forKey: "beneficiaryCity1")
                }
                else
                {
                    
                    self.bankBtn.isHidden = false
                    self.bankfcitybtnconstrainttop.constant = 10
                    self.bankntnheightconstraint.constant = 40
                    
                    self.cityzero = myResult!["beneficiaryCity"].stringValue
                    if self.cityzero == "0"
                    {
                        UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
                    }
                    else
                    {
                        
                    }
                    
                    
//                    UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
//                    self.citydropname = myResult!["beneficiaryCity1"].stringValue
//                    UserDefaults.standard.set(self.citydropname, forKey: "beneficiaryCity1")
                    
                    
                    
                }
                self.CITYDROPTXTFILED.isHidden = true
                self.citydropconstrainttop.constant = 0
                self.Citydroptxtfiledhieghtconstraint.constant = 0
                
                self.relationshipBtn.setTitle(myResult!["relationship"].stringValue, for: .normal)
                self.relationshipBtn.isUserInteractionEnabled = false
                self.str_relation = myResult!["relationship"].stringValue
                
                if myResult!["relationship"].stringValue.isEmpty
                {
                    self.relationshipBtn.setTitleColor(UIColor.gray, for: .normal)
                }
                else
                {
                    self.relationshipBtn.setTitleColor(UIColor.black, for: .normal)
                }

                
                
                self.checkClick = false
                self.checkBtn1.setImage(UIImage(named: "radio_light"), for: .normal)
                
                self.termsClick = false
                self.checkBtn3.setImage(UIImage(named: "radio_light"), for: .normal)
                
                self.sourceOfFundBtn.setTitle(NSLocalizedString("source1", comment: ""), for: .normal)
                
                self.purposeBtn.setTitle(NSLocalizedString("purpose1", comment: ""), for: .normal)
            }
            else
            {
                self.relationshipBtn.isUserInteractionEnabled = true
                self.selectReceiverBtn.setTitleColor(UIColor.lightGray, for: .normal)
                self.clearBen()
            }
        })
    }
    func getBank(access_token:String) {
        let searchText = self.searchBank.text!.uppercased()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.bankArray.removeAll()
        
        //newserch
        self.checkarrayaoccubank.removeAll()
        self.checkarrayaoccubankstr.removeAll()

        
        self.tblBank.reloadData()
        self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
        print("code",str_country)
        print("code1",self.searchBank.text!)
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/getbanks"
        let params:Parameters =  ["receiveContry":str_country,"searchText":searchText, "serviceType": self.servicetypestr,"sendCountryCode":"QAT"]
        
        print("urlbanklist",url)
        print("paramsbanklist",params)
        
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemiCashPickupViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("respgetbankapi",response)
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            for i in resultArray.arrayValue{
                let bank = Bank(bankAddress: i["requiredBranch"].stringValue, bankCode: i["bankCode"].stringValue, bankName: i["bankName"].stringValue, bankcitytype: i["cityType"].stringValue,Accountnolength: i["accountNumberLength"].stringValue,Mobnolength: i["recMobLength"].stringValue,ifscnolength: i["recMobLength"].stringValue,Minaccnolength: i["maxWalletAccountNo"].stringValue)
                self.bankArray.append(bank)
                
                self.bankcodeonebankstr = i["bankCode"].stringValue
                self.banknameonebankstr = i["bankName"].stringValue
                //self.mwalletaccnocheckstr = i["maxWalletAccountNo"].stringValue
                self.mobilelengnthcheckstr = i["recMobLength"].stringValue
                
                print("mwallet oneee",i["maxWalletAccountNo"].stringValue)
                print("bankkkkk oneee",i["bankName"].stringValue)
                //new
                self.checkarrayaoccubank.append(i["bankName"].stringValue)
                self.checkarrayaoccubankstr.append(i["bankCode"].stringValue)

            }
            self.bankArray.count
            print("bankArray.count",self.bankArray.count)
            if self.bankArray.count == 1
            {
                print("count oneee")
                self.str_bank_code = self.bankcodeonebankstr
                
                
                UserDefaults.standard.removeObject(forKey: "str_bank_codeserviceprovidercode")
                UserDefaults.standard.set(self.str_bank_code, forKey: "str_bank_codeserviceprovidercode")
                
                print(self.str_bank_code)
                print(self.banknameonebankstr)
               // self.MobileWalletaccnonolengthstr = self.mwalletaccnocheckstr
                self.Mobilenonolengthstr = self.mobilelengnthcheckstr
                
                //self.bankBtn.setTitle("\(str)", for: .normal)
                self.serviceproviderbtn.setTitle("\(self.banknameonebankstr)", for: .normal)
                self.serviceproviderbtn.setTitleColor(UIColor.black, for: .normal)
            }
            
            
            self.tblBank.reloadData()
        })
    }
    
    //MobWalletaccnolength
    
    func getBankcitydrop(access_token:String) {
        let searchText = self.searchBank.text!.uppercased()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.bankArray.removeAll()
        
        //newserch
        self.checkarrayaoccucity.removeAll()
        self.checkarrayaoccucitystr.removeAll()

        
        self.tblBank.reloadData()
        self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
        print("code",str_country)
        print("code1",self.searchBank.text!)
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "shiftservice/getCountryCities"
        let params:Parameters =  ["countryCode":self.str_country,"serviceType":self.servicetypestr,"correspondantId":self.str_bank_code]
        
        print("urlbanklist",url)
        print("paramsbanklist",params)
        
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemiCashPickupViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            for i in resultArray.arrayValue{
                let bank = Bank(bankAddress: i["cityCode"].stringValue, bankCode: i["cityCode"].stringValue, bankName: i["cityEnglishName"].stringValue, bankcitytype: i["cityEnglishName"].stringValue,Accountnolength: i["accountNumberLength"].stringValue,Mobnolength: i["recMobLength"].stringValue,ifscnolength: i["recMobLength"].stringValue,Minaccnolength: i["recMobLength"].stringValue)
                self.bankArray.append(bank)
                
                //new
                self.checkarrayaoccucity.append(i["cityEnglishName"].stringValue)
                self.checkarrayaoccucitystr.append(i["cityCode"].stringValue)

            }
            
            self.timerGesture.isEnabled = false
            self.resetTimer()
            self.tblBank.reloadData()
        })
    }
    
    
    func getBranch(access_token:String,bankCode:String) {
        let searchText = self.searchBranch.text!.uppercased()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.branchArray.removeAll()
        
        self.checkarrayaoccubranch.removeAll()
        self.checkarrayaoccubranchstr.removeAll()

        
        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
        self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.tblBranch.reloadData()
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/getbankbranches"
        let params:Parameters =  ["receiveContry":str_country,"bankCode":bankCode,"searchText":searchText,"serviceType":self.servicetypestr,"cityCode":self.str_bank_citydropcode]
        print("citydropcitycodeparams",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemiCashPickupViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            for i in resultArray.arrayValue{
                let branch = Branch(bankCode: i["bankCode"].stringValue, brAddress: i["brAddress"].stringValue, branchCode: i["branchCode"].stringValue, branchName: i["branchName"].stringValue, ifsccode: i["ifsccode"].stringValue, receiveContry: i["receiveContry"].stringValue)
                self.branchArray.append(branch)
                
                self.checkarrayaoccubranch.append(i["branchName"].stringValue)
                self.checkarrayaoccubranchstr.append(i["branchCode"].stringValue)

            }
            
            if self.branchArray.isEmpty == true
            {
                self.benView.isHidden = false
                self.branchView.isHidden = true
                
                self.alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("no_data_available", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
            
            self.timerGesture.isEnabled = false
            self.resetTimer()
            
            self.tblBranch.reloadData()
            
        })
    }
    func getCountry(keyword:String) {
        self.countryArray.removeAll()
        self.countryArraySearch.removeAll()
        
        //newserch
        self.checkarrayaoccunat.removeAll()
        self.checkarrayaoccunatstr.removeAll()

        
        self.tblCountry.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "nationalities_listing"
        let params:Parameters = ["lang":"en","keyword":keyword]
        print("conurl",url)
        print("conparams",params)
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("historygetcontryapi",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["nationalities_listing"]
                self.nationalityFlagPath = myResult!["file_path"].stringValue
                for i in resultArray.arrayValue{
                    let nationality = Country(id: i["id"].stringValue, num_code: i["num_code"].stringValue, alpha_2_code: i["alpha_2_code"].stringValue, alpha_3_code: i["alpha_3_code"].stringValue, en_short_name: i["en_short_name"].stringValue, nationality: i["nationality"].stringValue)
                    //if(nationality.alpha_3_code == "IND" || nationality.alpha_3_code == "LKA" || nationality.alpha_3_code == "NPL" || nationality.alpha_3_code == "IDN" || nationality.alpha_3_code == "BGD" || nationality.alpha_3_code == "PHL" || nationality.alpha_3_code == "EGY" || nationality.alpha_3_code == "ETH" || nationality.alpha_3_code == "KEN" || nationality.alpha_3_code == "NGA" || nationality.alpha_3_code == "PAK" || nationality.alpha_3_code == "TUR")
                    // {
                    if(self.countrySearchFlag == 0)
                    {
                        self.countryArray.append(nationality)
                    }
                    else
                    {
                        self.countryArraySearch.append(nationality)
                    }
                    //}
                    
                    //new
                    self.checkarrayaoccunat.append(i["en_short_name"].stringValue)
                    self.checkarrayaoccunatstr.append(i["alpha_3_code"].stringValue)

                }
                self.timerGesture.isEnabled = false
                self.resetTimer()
                
                self.tblCountry.reloadData()
                break
            case .failure:
                break
            }
        })
    }
    
    
    
    func getCountrynew(keyword:String) {
        self.countryArray.removeAll()
        self.countryArraySearch.removeAll()
        
        //newserch
        self.checkarrayaoccucountry.removeAll()
        self.checkarrayaoccucountrystr.removeAll()

        
        self.tblCountry.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        // let url = api_url + "nationalities_listing"
        let dateTime:String = getCurrentDateTime()
        
        let url = ge_api_url + "shiftservice/showCountryList"
        //let params:Parameters = ["lang":"en","keyword":keyword]
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerUserID":defaults.string(forKey: "USERID")!,"serviceType":self.servicetypestr]
        
        print("shiftconurl",url)
        print("shiftconparams",params)
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
            print("historygetcontryapi",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["countryList"]
                // self.nationalityFlagPath = myResult!["file_path"].stringValue
                self.nationalityFlagPath =  "https://gulfexchange.com.qa/storage/datafolder/flags/flags-medium/"
                for i in resultArray.arrayValue{
                    let nationality = Country(id: i["id"].stringValue, num_code: i["num_code"].stringValue, alpha_2_code: i["countryCodeTL"].stringValue, alpha_3_code: i["countryCode"].stringValue, en_short_name: i["countryName"].stringValue, nationality: i["nationality"].stringValue)
                    //if(nationality.alpha_3_code == "IND" || nationality.alpha_3_code == "LKA" || nationality.alpha_3_code == "NPL" || nationality.alpha_3_code == "IDN" || nationality.alpha_3_code == "BGD" || nationality.alpha_3_code == "PHL" || nationality.alpha_3_code == "EGY" || nationality.alpha_3_code == "ETH" || nationality.alpha_3_code == "KEN" || nationality.alpha_3_code == "NGA" || nationality.alpha_3_code == "PAK" || nationality.alpha_3_code == "TUR")
                    //{
                    if(self.countrySearchFlag == 0)
                    {
                        self.countryArray.append(nationality)
                    }
                    else
                    {
                        self.countryArraySearch.append(nationality)
                    }
                    // }
                    //new
                    self.checkarrayaoccucountry.append(i["countryName"].stringValue)
                    self.checkarrayaoccucountrystr.append(i["countryCode"].stringValue)

                }
                
                self.timerGesture.isEnabled = false
                self.resetTimer()
                
                self.tblCountry.reloadData()
                //self.getCountrynewshowconfigapi(keyword:"")
                break
            case .failure:
                break
            }
        })
    }
    
    
    func getCountrynewshowconfigapi(keyword:String) {
        // self.countryArray.removeAll()
        // self.countryArraySearch.removeAll()
        self.tblCountry.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        // let url = api_url + "nationalities_listing"
        let dateTime:String = getCurrentDateTime()
        
        let url = ge_api_url + "shiftservice/showConfiguration"
        //let params:Parameters = ["lang":"en","keyword":keyword]
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerUserID":defaults.string(forKey: "USERID")!,"serviceType":self.servicetypestr,"countryCode":keyword]
        
        print("shiftconurl",url)
        print("shiftconparams",params)
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
            print("historygetcontryconfigshowapi",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let firstnamestr:String = myResult!["firstName"].string!
                print("firstnamestr",firstnamestr)
                let middlenamestr:String = myResult!["middleName"].string!
                print("firstnamestr",firstnamestr)
                let lastnamestr:String = myResult!["lastName"].string!
                print("firstnamestr",firstnamestr)
                let genderstr:String = myResult!["gender"].string!
                print("firstnamestr",firstnamestr)
                let nationalitystr:String = myResult!["nationality"].string!
                print("firstnamestr",firstnamestr)
                let addressstr:String = myResult!["address"].string!
                print("firstnamestr",firstnamestr)
                let mobileNostr:String = myResult!["mobileNo"].string!
                print("firstnamestr",firstnamestr)
                let accountNostr:String = myResult!["accountNo"].string!
                let ibanNostr:String = myResult!["ibanNo"].string!
                let swiftCodestr:String = myResult!["swiftCode"].string!
                let sortCodestr:String = myResult!["sortCode"].string!
                let routingCodestr:String = myResult!["routingCode"].string!
                let ifscCodestr:String = myResult!["ifscCode"].string!
                let bankNamestr:String = myResult!["city"].string!
                let branchNamestr:String = myResult!["branchName"].string!
                let citystr:String = myResult!["city"].string!
                //let mobileWalletAccNo:String = myResult!["mobileWalletAccNo"].string!
                let bankserviceproviderNamestr:String = myResult!["bankName"].string!
                
                //new
//
//                if bankserviceproviderNamestr == "1"
//                {
//                    self.serviceproviderbtn.isHidden = false
//                    self.serviceproviderbankbtnheightconstrain.constant = 40
//                    self.serviceproviderconstrainttop.constant = 10
//
//                    self.bankserviceprovidermoboperstr = "1"
//                }
//                else
//                {
//                    self.serviceproviderbtn.isHidden = true
//                    self.serviceproviderbankbtnheightconstrain.constant = 0
//                    self.serviceproviderconstrainttop.constant = 0
//
//                    self.bankserviceprovidermoboperstr = "0"
//            UserDefaults.standard.removeObject(forKey: "str_bank_codeserviceprovidercode")
//                }
                
                if firstnamestr == "1"
                {
                    print("firstnamestrequal1",firstnamestr)
                    
                    self.firstNameTextField.isHidden = false
                    self.firstnameconstrainttop.constant = 10
                    self.firstnameheightconsraint.constant = 40
                    
                    
                }
                else
                {
                    self.firstNameTextField.isHidden = true
                    self.firstnameconstrainttop.constant = 0
                    self.firstnameheightconsraint.constant = 0
                    
                }
                
                
                if middlenamestr == "1"
                {
                    print("middlenamestr",middlenamestr)
                    //self.heightCon =
                    // self.middleNameTextField.heightAnchor.constraint(equalToConstant: 10)
                    //self.heightCon.isActive = false
                    self.middleNameTextField.isHidden = false
                    self.middlenameconstrainttop.constant = 10
                    //self.middleNameTextField.heightAnchor.constraint(equalToConstant: 0.0).isActive = true
                    self.middlenamehieghtconstrain.constant = 40
                    
                    self.middlenameclickcheckstr = "1"
                }
                else
                {
                    // self.heightCon =
                    // self.middleNameTextField.heightAnchor.constraint(equalToConstant: 0)
                    //self.heightCon.isActive = true
                    self.middleNameTextField.isHidden = true
                    self.middlenameconstrainttop.constant = 0
                    // self.middleNameTextField.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
                    self.middlenamehieghtconstrain.constant = 0
                    
                    self.middlenameclickcheckstr = "0"
                }
                
                if lastnamestr == "1"
                {
                    print("lastnamestr",lastnamestr)
                    self.lastNameTextField.isHidden = false
                    self.lastnameconstrainttop.constant = 10
                    self.lastnameheightconstraint.constant = 40
                }
                    
                else
                {
                    self.lastNameTextField.isHidden = true
                    self.lastnameconstrainttop.constant = 0
                    self.lastnameheightconstraint.constant = 0
                }
                
                if genderstr == "1"
                {
                    print("genderstr",genderstr)
                    self.genderbtn.isHidden = false
                    self.genderconstraintop.constant = 10
                    self.genderbtnhiehtconstraint.constant = 40
                    self.genderyesnoclickcheckstr = "1"
                }
                else
                {
                    self.genderbtn.isHidden = true
                    self.genderconstraintop.constant = 0
                    self.genderbtnhiehtconstraint.constant = 0
                    
                    self.genderyesnoclickcheckstr = "0"
                }
                
                
                
                
                if nationalitystr == "1"
                {
                    print("nationalitystr",nationalitystr)
                    self.nationalitybtn.isHidden = false
                    self.nationaltyconstrainttop.constant = 10
                    self.nationalitybtnhieghtconstraint.constant = 40
                    
                    self.nationalityyesnoclickcheckstr = "1"
                }
                else
                {
                    self.nationalitybtn.isHidden = true
                    self.nationaltyconstrainttop.constant = 0
                    self.nationalitybtnhieghtconstraint.constant = 0
                    
                    self.nationalityyesnoclickcheckstr = "0"
                }
                
                
                if addressstr == "1"
                {
                    print("addressstr",addressstr)
                    self.address.isHidden = false
                    self.addressconstrainttop.constant = 10
                    self.addressheightconstraint.constant = 40
                    
                    self.addressyesnoclickcheckstr = "1"
                }
                else
                {
                    self.address.isHidden = true
                    self.addressconstrainttop.constant = 0
                    self.addressheightconstraint.constant = 0
                    
                    self.addressyesnoclickcheckstr = "0"
                }
                
                if mobileNostr == "1"
                {
                    print("mobileNostr",mobileNostr)
                    self.mobileNumber.isHidden = false
                    self.mobileconstrainttop.constant = 10
                    self.mobileheightconstraint.constant = 40
                    
                    self.mobileyesnoclickcheckstr = "1"
                }
                else
                {
                    self.mobileNumber.isHidden = true
                    self.mobileconstrainttop.constant = 0
                    self.mobileheightconstraint.constant = 0
                    
                    self.mobileyesnoclickcheckstr = "0"
                }
                
                if accountNostr == "1"
                {
                    print("accountNostr",accountNostr)
                    
                    self.accountNum.isHidden = true
                    
                    // self.accNoTop.constant = 10
                    // self.ifscTop.constant = 10
                    
                }
                    
                else
                {
                    self.accountNum.isHidden = true
                    // self.accNoTop.constant = 0
                    //self.ifscTop.constant = 10
                }
                
                if ibanNostr == "1"
                {
                    print("ibanNostr",ibanNostr)
                    self.iban.isHidden = false
                    self.ibanTop.constant = 10
                }
                else
                {
                    self.iban.isHidden = true
                    self.ibanTop.constant = 0
                }
                
                if swiftCodestr == "1"
                {
                    print("swiftCodestr",swiftCodestr)
                    self.swiftCode.isHidden = false
                    self.swiftCodeTop.constant = 10
                }
                    
                else
                {
                    self.swiftCode.isHidden = true
                    self.swiftCodeTop.constant = 0
                }
                
                if sortCodestr == "1"
                {
                    print("sortCodestr",sortCodestr)
                    self.sortCode.isHidden = false
                    self.sortCodeTop.constant = 10
                }
                else
                {
                    self.sortCode.isHidden = true
                    self.sortCodeTop.constant = 0
                }
                
                
                if routingCodestr == "1"
                {
                    print("routingCodestr",routingCodestr)
                    self.routingCode.isHidden = false
                    self.routingCodeTop.constant = 10
                }
                    
                else
                {
                    self.routingCode.isHidden = true
                    self.routingCodeTop.constant = 0
                }
                
                
                if ifscCodestr == "1"
                {
                    print("ifscCodestr",ifscCodestr)
                    self.ifscCode.isHidden = false
                    self.ifscTop.constant = 10
                }
                else
                {
                    self.ifscCode.isHidden = true
                    self.ifscTop.constant = 0
                }
                
                
                
                if bankNamestr == "1"
                {
                    print("bankNamestr",bankNamestr)
                    self.bankBtn.isHidden = false
                    self.bankfcitybtnconstrainttop.constant = 10
                    self.bankntnheightconstraint.constant = 40
                }
                else
                {
                    self.bankBtn.isHidden = true
                    self.bankfcitybtnconstrainttop.constant = 0
                    self.bankntnheightconstraint.constant = 0
                }
                
                
                
                if branchNamestr == "1"
                {
                    print("branchNamestr",branchNamestr)
                    self.branchBtn.isHidden = false
                    self.branchbtnconstrainttop.constant = 10
                    self.branchbtnheightconstaint.constant = 40
                    
                    
                    
                }
                else
                {
                    self.branchBtn.isHidden = true
                    self.branchbtnconstrainttop.constant = 0
                    self.branchbtnheightconstaint.constant = 0
                }
                
                //new
//                if mobileWalletAccNo == "1"
//                {
//                    self.mobilewalletaccountheightconstant.constant = 40
//                    self.mobilewalletaccounttopconstant.constant = 7
//                    self.MobileWalletAccountNotxtfd.isHidden = false
//
//                    self.mwalletaccountnoyesnoclickcheckstr = "1"
//                }
//                else
//                {
//                    self.mobilewalletaccountheightconstant.constant = 0
//                    self.mobilewalletaccounttopconstant.constant = 0
//                    self.MobileWalletAccountNotxtfd.isHidden = true
//
//                    self.mwalletaccountnoyesnoclickcheckstr = "0"
//
//                }
                
                
                self.accountNum.isHidden = true
                
                //                if citystr == "1"
                //               {
                //                    print("citystr",citystr)
                //                self.city.isHidden = false
                //                self.cityhieghtconstraint.constant = 40
                //               }
                //
                //                else
                //                {
                //                    self.city.isHidden = true
                //                    self.cityhieghtconstraint.constant = 0
                //                }
                
                
                
                //0
                
                
                
                
                let resultArray = myResult!["countryList"]
                // self.nationalityFlagPath = myResult!["file_path"].stringValue
                self.nationalityFlagPath =  "https://gulfexchange.com.qa/storage/datafolder/flags/flags-medium/"
                for i in resultArray.arrayValue{
                    let nationality = Country(id: i["id"].stringValue, num_code: i["num_code"].stringValue, alpha_2_code: i["countryCodeTL"].stringValue, alpha_3_code: i["countryCode"].stringValue, en_short_name: i["countryName"].stringValue, nationality: i["nationality"].stringValue)
                    //if(nationality.alpha_3_code == "IND" || nationality.alpha_3_code == "LKA" || nationality.alpha_3_code == "NPL" || nationality.alpha_3_code == "IDN" || nationality.alpha_3_code == "BGD" || nationality.alpha_3_code == "PHL" || nationality.alpha_3_code == "EGY" || nationality.alpha_3_code == "ETH" || nationality.alpha_3_code == "KEN" || nationality.alpha_3_code == "NGA" || nationality.alpha_3_code == "PAK" || nationality.alpha_3_code == "TUR")
                    
                }
                self.tblCountry.reloadData()
                break
            case .failure:
                break
            }
        })
    }
    
    
    
     
     func getSource(access_token:String) {
         self.activityIndicator(NSLocalizedString("loading", comment: ""))
        // let url = api_url + "source"
          let url = ge_api_url + "shiftservice/showDescription"
          let params:Parameters =  ["codeType":self.codetypestr,"serivceType": self.servicetypestr,"receiveCountry":self.str_country]
         print("urlurl",url)
         print("paramsurl",params)
          let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
          
          RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
              let myResult = try? JSON(data: response.data!)
         
             print("resp",response)
             
             
              self.sourceArray.removeAll()
             self.effectView.removeFromSuperview()
             let resultArray = myResult![]
     
                 for i in resultArray.arrayValue{
                     let content = Source(desc: i["description"].stringValue)
                     self.sourceArray.append(content)
                 }
                 self.tblSource.reloadData()
    
         })
     }
     
      
      func getPurpose(access_token:String) {
          self.activityIndicator(NSLocalizedString("loading", comment: ""))
         // let url = api_url + "source"
           let url = ge_api_url + "shiftservice/showDescription"
           let params:Parameters =  ["codeType":self.codetypestr,"serivceType": self.servicetypestr,"receiveCountry":self.str_country]
          print("urlurl",url)
          print("paramsurl",params)
           let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
           
           RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
               let myResult = try? JSON(data: response.data!)
          
              print("resp",response)
             
              self.purposeeArray.removeAll()
              self.effectView.removeFromSuperview()
              let resultArray = myResult![]
      
                 for i in resultArray.arrayValue{
                 let content = Source(desc: i["description"].stringValue)
                 self.purposeeArray.append(content)
                 }
             self.tblPurpose.reloadData()
     
          })
      }
    
    
    
//    func getSource() {
//        self.activityIndicator(NSLocalizedString("loading", comment: ""))
//        let url = api_url + "source"
//        let params:Parameters = ["lang":"en"]
//
//        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//            print("historygetsourceapi",response)
//            self.effectView.removeFromSuperview()
//            switch response.result{
//            case .success:
//                let myResult = try? JSON(data: response.data!)
//                let resultArray = myResult!["source"]
//                for i in resultArray.arrayValue{
//                    let content = Source(desc: i["description"].stringValue)
//                    self.sourceArray.append(content)
//                }
//                self.tblSource.reloadData()
//                break
//            case .failure:
//                break
//            }
//        })
//    }
//    func getPurpose(country:String) {
//        self.activityIndicator(NSLocalizedString("loading", comment: ""))
//        self.purposeBtn.titleLabel?.text = NSLocalizedString("purpose1", comment: "")
//        self.purposeeArray.removeAll()
//        self.tblPurpose.reloadData()
//        let url = api_url + "purpose_new"
//        let params:Parameters = ["country":country]
//
//        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//            print("historygetpurposeapi",response)
//            self.effectView.removeFromSuperview()
//            switch response.result{
//            case .success:
//                let myResult = try? JSON(data: response.data!)
//                let resultArray = myResult!["purpose"]
//                for i in resultArray.arrayValue{
//                    let content = Source(desc: i["purpose"].stringValue)
//                    self.purposeeArray.append(content)
//                }
//                self.tblPurpose.reloadData()
//                break
//            case .failure:
//                break
//            }
//        })
//    }
//
    
    
    
    func getRelation() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "relations"
        let params:Parameters = ["lang":"en"]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("historygetrelationapi",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["relations"]
                for i in resultArray.arrayValue{
                    let content = Source(desc: i["description"].stringValue)
                    self.relationArray.append(content)
                }
                self.tblRelationship.reloadData()
                break
            case .failure:
                break
            }
        })
    }
    func setAccountDetails(country:String) {
        accountNum.text = ""
        iban.text = ""
        swiftCode.text = ""
        sortCode.text = ""
        routingCode.text = ""
        ifscCode.text = ""
        accountNum.isHidden = true
        ifscCode.isHidden = true
        print("asdf44444")
        //        self.accNoTop.constant = 0
        //        self.ifscTop.constant = 0
        //        self.ibanTop.constant = 0
        //        self.checkTop.constant = 10
        //        self.sortCodeTop.constant = 0
        //        self.swiftCodeTop.constant = 0
        //        self.routingCodeTop.constant = 0
        
        //        if(country == "India")
        //        {
        //            print("asdf55555")
        //            accountNum.isHidden = false
        //            ifscCode.isHidden = false
        //            iban.isHidden = true
        //            swiftCode.isHidden = true
        //            sortCode.isHidden = true
        //            routingCode.isHidden = true
        //            accountNum.placeholder = NSLocalizedString("acc_no1", comment: "")
        //            iban.text = ""
        //            swiftCode.text = ""
        //            sortCode.text = ""
        //            routingCode.text = ""
        //            self.accNoTop.constant = 10
        //            self.ifscTop.constant = 10
        //            self.ibanTop.constant = 0
        //            self.checkTop.constant = 10
        //            self.sortCodeTop.constant = 0
        //            self.swiftCodeTop.constant = 0
        //            self.routingCodeTop.constant = 0
        //        }
        //        else if(country == "Pakistan"  || country == "Turkey" || country == "Jordan" || country == "Kuwait" || country == "Bahrain" || country == "Saudi Arabia")
        //        {
        //            //pak and Turkey
        //            //city and branch hide
        //            print("asdf66666")
        //            iban.isHidden = false
        //            accountNum.isHidden = true
        //            swiftCode.isHidden = true
        //            sortCode.isHidden = true
        //            routingCode.isHidden = true
        //            ifscCode.isHidden = true
        //
        //            //new
        //           // city.isHidden = true
        //           // branchBtn.isHidden = true
        //
        //            accountNum.text = ""
        //            swiftCode.text = ""
        //            sortCode.text = ""
        //            routingCode.text = ""
        //            ifscCode.text = ""
        //            self.accNoTop.constant = 0
        //            self.ifscTop.constant = 0
        //            self.ibanTop.constant = 10
        //            self.checkTop.constant = 10
        //            self.sortCodeTop.constant = 0
        //            self.swiftCodeTop.constant = 0
        //            self.routingCodeTop.constant = 0
        //        }
        //        else if(country == "Bangladesh" || country == "Sri Lanka" || country == "Nepal" || country == "Philippines" || country == "Indonesia" || country == "Egypt" || country == "Moroco")
        //        {
        //
        //            iban.isHidden = true
        //            accountNum.isHidden = false
        //            swiftCode.isHidden = true
        //            sortCode.isHidden = true
        //            routingCode.isHidden = true
        //            ifscCode.isHidden = true
        //            print("asdf7777")
        //            iban.text = ""
        //            swiftCode.text = ""
        //            sortCode.text = ""
        //            routingCode.text = ""
        //            ifscCode.text = ""
        //            accountNum.placeholder = NSLocalizedString("acc_no1", comment: "")
        //            self.accNoTop.constant = 10
        //            self.ifscTop.constant = 0
        //            self.ibanTop.constant = 0
        //            self.checkTop.constant = 10
        //            self.sortCodeTop.constant = 0
        //            self.swiftCodeTop.constant = 0
        //            self.routingCodeTop.constant = 0
        //        }
        //        else if(country == "Tunisia")
        //        {
        //            iban.isHidden = true
        //            accountNum.isHidden = false
        //            swiftCode.isHidden = false
        //            sortCode.isHidden = true
        //            routingCode.isHidden = true
        //            ifscCode.isHidden = true
        //            print("asdf88888")
        //            iban.text = ""
        //            sortCode.text = ""
        //            routingCode.text = ""
        //            ifscCode.text = ""
        //            accountNum.placeholder = NSLocalizedString("acc_no1", comment: "")
        //            self.accNoTop.constant = 10
        //            self.ifscTop.constant = 0
        //            self.ibanTop.constant = 0
        //            self.checkTop.constant = 10
        //            self.sortCodeTop.constant = 0
        //            self.swiftCodeTop.constant = 10
        //            self.routingCodeTop.constant = 0
        //        }
        //        else if(country == "United Kingdom of Great Britain and Northern Ireland")
        //        {
        //            iban.isHidden = true
        //            accountNum.isHidden = false
        //            swiftCode.isHidden = true
        //            sortCode.isHidden = false
        //            routingCode.isHidden = true
        //            ifscCode.isHidden = true
        //            print("asdf99999")
        //            iban.text = ""
        //            swiftCode.text = ""
        //            routingCode.text = ""
        //            ifscCode.text = ""
        //            accountNum.placeholder = NSLocalizedString("acc_no1", comment: "")
        //            self.accNoTop.constant = 10
        //            self.ifscTop.constant = 0
        //            self.ibanTop.constant = 0
        //            self.checkTop.constant = 10
        //            self.sortCodeTop.constant = 10
        //            self.swiftCodeTop.constant = 0
        //            self.routingCodeTop.constant = 0
        //        }
        //        else if(country == "United States of America")
        //        {
        //            iban.isHidden = true
        //            accountNum.isHidden = false
        //            swiftCode.isHidden = false
        //            sortCode.isHidden = true
        //            routingCode.isHidden = false
        //            ifscCode.isHidden = true
        //            print("asdf000000")
        //            iban.text = ""
        //            ifscCode.text = ""
        //            sortCode.text = ""
        //            accountNum.placeholder = NSLocalizedString("acc_no1", comment: "")
        //            self.accNoTop.constant = 10
        //            self.ifscTop.constant = 0
        //            self.ibanTop.constant = 0
        //            self.checkTop.constant = 10
        //            self.sortCodeTop.constant = 0
        //            self.swiftCodeTop.constant = 10
        //            self.routingCodeTop.constant = 10
        //        }
        //        else{
        //            iban.isHidden = false
        //            accountNum.isHidden = true
        //            swiftCode.isHidden = false
        //            sortCode.isHidden = true
        //            routingCode.isHidden = true
        //            ifscCode.isHidden = true
        //            print("asdfaaaaaa")
        //            accountNum.text = ""
        //            routingCode.text = ""
        //            ifscCode.text = ""
        //            sortCode.text = ""
        //            self.accNoTop.constant = 0
        //            self.ifscTop.constant = 0
        //            self.ibanTop.constant = 10
        //            self.checkTop.constant = 10
        //            self.sortCodeTop.constant = 0
        //            self.swiftCodeTop.constant = 10
        //            self.routingCodeTop.constant = 0
        //        }
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
                    self.termsContent.attributedText = content.htmlToAttributedString
                    self.termsContent.font = UIFont(name: "OpenSans-Regular", size: 14)
                    self.termsContent.font = .systemFont(ofSize: 14)
                    self.adjustUITextViewHeight(arg: self.termsContent)
                    
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
        
        print("urlviewcustomer",url)
        print("inputviewcustomer",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemiCashPickupViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
        let params:Parameters = ["id_no":defaults.string(forKey: "USERID")!,"mobile_no":self.mobile,"email":self.email,"type":"5"]
        
        print("USER ID ",defaults.string(forKey: "USERID")!)
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(msg != "")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: msg, action: NSLocalizedString("ok", comment: ""))
            }
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["code"]
            if(respCode == "1")
            {
                
                
                
                
                
                let alertControllerotp = UIAlertController(title: "", message: "We've sent a OTP to your registered Mobile number", preferredStyle: .alert)
                //        alertController.addTextField { (textField : UITextField!) -> Void in
                //            textField.placeholder = "Enter Second Name"
                //        }
                let saveAction = UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                    let firstTextField = alertControllerotp.textFields![0] as UITextField
                    // let secondTextField = alertController.textFields![1] as UITextField
                    firstTextField.placeholder = "Enter OTP"
                    print("firstNamestrotp \(firstTextField.text)")
                    
                    var strotp = firstTextField.text
                    strotp = strotp!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    print(strotp)
                    // "this is the answer"
                    print("strotp",strotp)
                    firstTextField.text =  strotp
                    print("otpfiled.text",firstTextField.text)
                    
                    guard let mobile = firstTextField.text,firstTextField.text?.count != 0 else
                    {
                        
                        self.present(alertControllerotp, animated: true, completion: nil)
                        self.showToast(message: NSLocalizedString("enter_otp", comment: ""), font: .systemFont(ofSize: 12.0))
                        
                        //  self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        
                        // self.present(alertControllerotp, animated: true, completion: nil)
                        
                        return
                    }
                    
                    
                    //viewapiforotp
                    // self.getToken(num: 7)
                    self.verifyOTP(otp: firstTextField.text!)
                    
                })
                // let cancelAction = UIAlertAction(title: "Resend", style: .default, handler: { (action : UIAlertAction!) -> Void in })
                let cancelAction = UIAlertAction(title: "Resend", style: .default, handler: { alert -> Void in
                    self.getToken(num: 7)
                    
                })
                alertControllerotp.addTextField { (textField : UITextField!) -> Void in
                    textField.placeholder = "Enter OTP"
                    
                    
                    
                }
                
                alertControllerotp.addAction(saveAction)
                alertControllerotp.addAction(cancelAction)
                
                
                self.present(alertControllerotp, animated: true, completion: nil)
                
                
                
                
                
                print("saveapicalling","apicallinggg")
                // self.getToken(num: 4)
                
                
                
            }
            
        })
    }
    
    func verifyOTP(otp:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "otp_verification"
        let params:Parameters = ["id_no":defaults.string(forKey: "USERID")!,"mobile_no":self.mobile,"email":self.email,"otp_no":otp,"imei_no":udid!,"type":"5"]
        
        print("urlverifyotpbadd",url)
        print("inputverifyotpbadd",params)
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp",response)
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["code"]
            if(respCode == "1")
            {
                // self.getToken(num: 2)
                print("saveapicalling","apicallinggg")
                self.getToken(num: 4)
            }
            else
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("invalid_otp", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
    
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = true
    }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblBeneficiary)
        {
            return beneficiaryList.count
        }
        else if(tableView == tblSource)
        {
            return sourceArray.count
        }
        else if(tableView == tblRelationship)
        {
            return relationArray.count
        }
        else if(tableView == tblCountry)
        {
            
            if countryselserchstr == "searchcliked"
            {
                return searchedArraycountry.count
            }
            if natselserchstr == "searchcliked"
            {
                return searchedArraynat.count
            }
            else
            {
            if(self.countrySearchFlag == 0)
            {
                return countryArray.count
            }
            else
            {
                return countryArraySearch.count
            }
            }
        }
        else if(tableView == tblPurpose)
        {
            return purposeeArray.count
        }
        else if(tableView == tblBank)
        {
            if bankselserchstr == "searchcliked"
            {
               // else
                //{
                return searchedArraybank.count
                //}
            }
            if self.cityselserchstr == "searchcliked"
            {
                return searchedArraycity.count
            }

            
            else
            {
                return bankArray.count
            }
            
        }
        else if(tableView == tblBranch)
        {
            
            if branchselserchstr == "searchcliked"
            {
               
                return searchedArraybranch.count
                }
            
            else
            {
            return branchArray.count
            }
        }
        
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tblBeneficiary)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "beneficiaryCell") as! BeneficiaryTableViewCell
            let beneficiary = beneficiaryList[indexPath.row]
            cell.setBeneficiary(beneficiary: beneficiary)
            return cell
        }
        else if(tableView == tblSource)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell") as! LabelTableViewCell
            let source = sourceArray[indexPath.row]
            cell.label.text = source.desc
            return cell
        }
        else if(tableView == tblRelationship)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "relationCell") as! LabelTableViewCell
            let relation = relationArray[indexPath.row]
            cell.label.text = relation.desc
            return cell
        }
        else if(tableView == tblCountry)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
            
            if countryselserchstr == "searchcliked"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
                
                //for code getting
                
                
                
                ////
               
                cell.countryLbl.text = searchedArraycountry[indexPath.row]
                //let code:String = country.alpha_2_code.lowercased()
                let url = nationalityFlagPath + "code" + ".png"
              // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                let imgResource = URL(string: url)
                cell.flagImg.kf.setImage(with: imgResource)
                return cell
                
                
            }
            if natselserchstr == "searchcliked"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
                
                //for code getting
                
                
                
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

            
            if(self.countrySearchFlag == 0)
            {
                let country = countryArray[indexPath.row]
                cell.countryLbl.text = country.en_short_name
                let code:String = country.alpha_2_code.lowercased()
                let url = nationalityFlagPath + code + ".png"
                //let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                let imgResource = URL(string: url)
                cell.flagImg.kf.setImage(with: imgResource)
                return cell
            }
            else{
                let country = countryArraySearch[indexPath.row]
                cell.countryLbl.text = country.en_short_name
                let code:String = country.alpha_2_code.lowercased()
                let url = nationalityFlagPath + code + ".png"
               // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                let imgResource = URL(string: url)
                cell.flagImg.kf.setImage(with: imgResource)
                return cell
            }
        }
            
        }
        else if(tableView == tblPurpose)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "purposeCell") as! LabelTableViewCell
            let purpose = purposeeArray[indexPath.row]
            cell.label.text = purpose.desc
            return cell
        }
        else if(tableView == tblBank)
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "bankCell") as! LabelTableViewCell

            
            if citydropbtstr == "citydropclick"
            {
               if self.cityselserchstr == "searchcliked"
                {
                   if searchedArraycity.isEmpty == true
                   {
                       
                   }
                   else
                   {
                   
                   let cell = tableView.dequeueReusableCell(withIdentifier: "bankCell") as! LabelTableViewCell
                  
                   cell.label.text = searchedArraycity[indexPath.row]
                   return cell
                   }
               }
                else
                {
         
                let cell = tableView.dequeueReusableCell(withIdentifier: "bankCell") as! LabelTableViewCell
                let bank = bankArray[indexPath.row]
                cell.label.text = bank.bankName
                return cell
                }
                
            }
        
           if serviceproviderormobopbtnstr == "clicksecviceormobbtn"
            {
               if bankselserchstr == "searchcliked"
               {
                   
                   let cell = tableView.dequeueReusableCell(withIdentifier: "bankCell") as! LabelTableViewCell
                  
                   cell.label.text = searchedArraybank[indexPath.row]
                   return cell
                   
               }
               
       

               else
               {
        
               let cell = tableView.dequeueReusableCell(withIdentifier: "bankCell") as! LabelTableViewCell
               let bank = bankArray[indexPath.row]
               cell.label.text = bank.bankName
               return cell
               }
           }
            

        }
           
        
        else if(tableView == tblBranch)
        {
            if branchselserchstr == "searchcliked"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "branchCell") as! LabelTableViewCell
                cell.label.text = searchedArraybranch[indexPath.row]
                return cell
                
            }
            else
            {
            let cell = tableView.dequeueReusableCell(withIdentifier: "branchCell") as! LabelTableViewCell
            let branch = branchArray[indexPath.row]
            cell.label.text = branch.branchName
            return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == tblBeneficiary)
        {
            let cell: BeneficiaryTableViewCell = self.tblBeneficiary.cellForRow(at: indexPath) as! BeneficiaryTableViewCell
            let str: String = cell.beneficiaryLbl.text!
            selectReceiverBtn.setTitle("\(str)", for: .normal)
            self.strselectuser = str
            print("selectuser---",str)
            print("selectuserglob---",self.strselectuser)
            animateBeneficiary(toogle: false)
            selectReceiverBtn.setTitleColor(.black, for: .normal)
            selectReceiverBtn.titleLabel?.font = selectReceiverBtn.titleLabel?.font.withSize(14)
            let ben = beneficiaryList[indexPath.row]
            self.str_serial_no = ben.beneficiarySerialNo
            self.str_ben_account = ben.beneficiaryAccountNo
            print("benfi---",str)
            print("seralno selcted---",self.str_serial_no)
            
            
            if indexPath.row == 0
            {
                print("Nullcontentpopupcheck",str)
                firstNameTextField.isUserInteractionEnabled = true
                lastNameTextField.isUserInteractionEnabled = true
                mobileNumber.isUserInteractionEnabled = true
                // city.isUserInteractionEnabled = true
                address.isUserInteractionEnabled = true
                bankBtn.isEnabled = true
                countryBtn.isEnabled = true
                branchBtn.isEnabled = true
                servicetypebtn.isEnabled = true
                genderbtn.isEnabled = true
                
                nationalitybtn.isEnabled = true
                serviceproviderbtn.isEnabled = true
                genderbtn.isEnabled = true
                iban.isUserInteractionEnabled = true
                
                middleNameTextField.isUserInteractionEnabled = true
               // MobileWalletAccountNotxtfd.isUserInteractionEnabled = true
                
                //ifscCode.isUserInteractionEnabled = true
                // accountNum.isUserInteractionEnabled = true
                
                alreadysvaedcustomerstr = "0"
                
                genderclickcheckstr = "0"
                nationalityclickcheckstr = "0"
                
                
                self.sourceOfFundBtn.setTitleColor(UIColor.lightGray, for: .normal)
                self.purposeBtn.setTitleColor(UIColor.lightGray, for: .normal)
                self.relationshipBtn.setTitleColor(UIColor.lightGray, for: .normal)


                
            }
                
                
                //            let a = "SELECT AN EXISTING RECEIVER"
                //               let b = str
                //            if a == b {
                //                 print("Nullcontentpopupcheck",str)
                //                firstNameTextField.isUserInteractionEnabled = true
                //                lastNameTextField.isUserInteractionEnabled = true
                //                mobileNumber.isUserInteractionEnabled = true
                //                city.isUserInteractionEnabled = true
                //                address.isUserInteractionEnabled = true
                //                    bankBtn.isEnabled = true
                //                    countryBtn.isEnabled = true
                //                    branchBtn.isEnabled = true
                //                ifscCode.isUserInteractionEnabled = true
                //                accountNum.isUserInteractionEnabled = true
                //
                //            }
            else
            {
                firstNameTextField.isUserInteractionEnabled = false
                lastNameTextField.isUserInteractionEnabled = false
                mobileNumber.isUserInteractionEnabled = false
                // city.isUserInteractionEnabled = false
                address.isUserInteractionEnabled = false
                bankBtn.isEnabled = false
                countryBtn.isEnabled = false
                branchBtn.isEnabled = false
                ifscCode.isUserInteractionEnabled = false
                accountNum.isUserInteractionEnabled = false
                accountNum.isHidden = true
                genderbtn.isEnabled = false
                nationalitybtn.isEnabled = false
                serviceproviderbtn.isEnabled = false
                genderbtn.isEnabled = false
                iban.isUserInteractionEnabled = false
                
                servicetypebtn.isEnabled = false
                middleNameTextField.isUserInteractionEnabled = false
               // MobileWalletAccountNotxtfd.isUserInteractionEnabled = false
                
                
                self.sourceOfFundBtn.setTitleColor(UIColor.lightGray, for: .normal)
                self.purposeBtn.setTitleColor(UIColor.lightGray, for: .normal)
                self.relationshipBtn.setTitleColor(UIColor.black, for: .normal)

                
                alreadysvaedcustomerstr = "1"
                
            }
            if(str == NSLocalizedString("sel_existing_rece", comment: ""))
            {
                self.relationshipBtn.isUserInteractionEnabled = true
                print("benfi---",str)
                self.relationshipBtn.setTitle(NSLocalizedString("relationship1", comment: ""), for: .normal)
                self.selectReceiverBtn.setTitleColor(UIColor.darkGray, for: .normal)
                self.clearBen()
            }
            else{
                self.relationshipBtn.isUserInteractionEnabled = false
                self.selectReceiverBtn.setTitleColor(UIColor.black, for: .normal)
                self.getToken(num: 5)
            }
        }
        else if(tableView == tblSource)
        {
            let cell: LabelTableViewCell = self.tblSource.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            sourceOfFundBtn.setTitle("\(str)", for: .normal)
            animateSource(toogle: false)
            self.sourceOfFundBtn.setTitleColor(UIColor.black, for: .normal)
        }
        else if(tableView == tblRelationship)
        {
            let cell: LabelTableViewCell = self.tblRelationship.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            relationshipBtn.setTitle("\(str)", for: .normal)
            animateRelation(toogle: false)
            self.str_relation = str
            
            self.relationshipBtn.setTitleColor(UIColor.black, for: .normal)
        }
        else if(tableView == tblCountry)
        {
            let cell: CountryTableViewCell = self.tblCountry.cellForRow(at: indexPath) as! CountryTableViewCell
            //let str: String = cell.countryLbl.text!
            
            self.timerGesture.isEnabled = false
            
            if countrybtnselstr == "countrybtnselstr"
            {
                let str: String = cell.countryLbl.text!
                if(self.countrySearchFlag == 0)
                {
                    if countryselserchstr == "searchcliked"
                    {
                        let cell: CountryTableViewCell = self.tblCountry.cellForRow(at: indexPath) as! CountryTableViewCell
                        
                        
                        teststrclscountry = searchedArraycountry[indexPath.row]
                                        print("selectednamesearch",teststrclscountry)
                        
                        
                        
                        
                       // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                        guard let index = checkarrayaoccucountry.firstIndex(of: teststrclscountry) else { return }
                        print(index)
                         print("kityda:\(index)")
                        
                        var indexone = index
                       // let firstName = AllArrayid[indexone]
                        let firstName = checkarrayaoccucountrystr[indexone]
                        print("id selkityada:\(firstName)")
                        str_country = firstName
                        print("id selkityadastr_countryid:\(str_country)")
                        
                        
                        
                        self.countryBtn.setTitle("\(teststrclscountry)", for: .normal)
                        self.countryBtn.setTitleColor(UIColor.black, for: .normal)
                        
                        
                        
                        //new
                        //self.str_country = nat.alpha_3_code
                        
                       
                        //self.getPurpose(country: str_country)
                        self.setAccountDetails(country: "")
                         //self.str_country_2_code = nat.alpha_2_code
                        self.getCountrynewshowconfigapi(keyword:str_country)
                        //newwwwwwautosel
                        self.getToken(num: 2)

                        
                        
                      //last
                        countryselserchstr = ""
                    }
                    //new
                    else
                    {
                    
                    let nat = countryArray[indexPath.row]
                    countryBtn.setTitle("\(str)", for: .normal)
                    self.countryBtn.setTitleColor(UIColor.black, for: .normal)
                    self.str_country = nat.alpha_3_code
                    
                   
                    //self.getPurpose(country: str_country)
                    self.setAccountDetails(country: nat.en_short_name)
                    self.str_country_2_code = nat.alpha_2_code
                    self.getCountrynewshowconfigapi(keyword:nat.alpha_3_code)
                    //newwwwwwautosel
                    self.getToken(num: 2)
                    
                    if(nat.en_short_name != "India")
                    {
                        self.str_ifsc = ""
                    }
                    
                }
                    
                    UserDefaults.standard.removeObject(forKey: "countrycodestored")
                    UserDefaults.standard.set(self.str_country, forKey: "countrycodestored")
                    
                    countryView.isHidden = true
                    benView.isHidden = false
                    
                    
                }
                else{
                    
                    if countryselserchstr == "searchcliked"
                    {
                        let cell: CountryTableViewCell = self.tblCountry.cellForRow(at: indexPath) as! CountryTableViewCell
                        
                        
                        teststrclscountry = searchedArraycountry[indexPath.row]
                                        print("selectednamesearch",teststrclscountry)
                        
                        
                        
                        
                       // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                        guard let index = checkarrayaoccucountry.firstIndex(of: teststrclscountry) else { return }
                        print(index)
                         print("kityda:\(index)")
                        
                        var indexone = index
                       // let firstName = AllArrayid[indexone]
                        let firstName = checkarrayaoccucountrystr[indexone]
                        print("id selkityada:\(firstName)")
                        str_country = firstName
                        print("id selkityadastr_countryid:\(str_country)")
                        
                        
                        
                        self.countryBtn.setTitle("\(teststrclscountry)", for: .normal)
                        self.countryBtn.setTitleColor(UIColor.black, for: .normal)
                        
                        
                        //new
                        //self.str_country = nat.alpha_3_code
                        
                       
                        //self.getPurpose(country: str_country)
                        self.setAccountDetails(country: "")
                         //self.str_country_2_code = nat.alpha_2_code
                        self.getCountrynewshowconfigapi(keyword:str_country)
                        //newwwwwwautosel
                        self.getToken(num: 2)
                        
                      //last
                        countryselserchstr = ""
                    }

                    else
                    {
                    
                    let nat = countryArraySearch[indexPath.row]
                    self.countryBtn.setTitle("\(str)", for: .normal)
                    self.countryBtn.setTitleColor(UIColor.black, for: .normal)
                    self.str_country = nat.alpha_3_code
                    
                   // self.getPurpose(country: str_country)
                    self.setAccountDetails(country: nat.en_short_name)
                    self.str_country_2_code = nat.alpha_2_code
                    self.getCountrynewshowconfigapi(keyword:nat.alpha_3_code)
                    
                    //newwwwwwautosel
                    self.getToken(num: 2)
                    
                    
                    if(nat.en_short_name != "India")
                    {
                        self.str_ifsc = ""
                    }
                }
                    
                    UserDefaults.standard.removeObject(forKey: "countrycodestored")
                    UserDefaults.standard.set(self.str_country, forKey: "countrycodestored")
                    
                    countryView.isHidden = true
                    benView.isHidden = false

                    
                    
            }//new
                
                countryselserchstr = ""
                
            }
            
            if nationalitybtnselstr == "nationalitybtnselstr"
            {
                let str: String = cell.countryLbl.text!
                if(self.countrySearchFlag == 0)
                {
                    let nat = countryArray[indexPath.row]
                    
                    if natselserchstr == "searchcliked"
                    {
                        let cell: CountryTableViewCell = self.tblCountry.cellForRow(at: indexPath) as! CountryTableViewCell
                        
                        
                        teststrclsnat = searchedArraynat[indexPath.row]
                                        print("selectednamesearch",teststrclsnat)
                        
                        
                        
                        
                       // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                        guard let index = checkarrayaoccunat.firstIndex(of: teststrclsnat) else { return }
                        print(index)
                         print("kityda:\(index)")
                        
                        var indexone = index
                       // let firstName = AllArrayid[indexone]
                        let firstName = checkarrayaoccunatstr[indexone]
                        print("id selkityada:\(firstName)")
                        str_countrynationality = firstName
                        print("id selkityadastr_natid:\(str_country_2_code)")
                        
                        
                        
                        self.nationalitybtn.setTitle("\(teststrclsnat)", for: .normal)
                        self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                        
                      //last
                        natselserchstr = ""
                    }

                    else
                    {
                        nationalitybtn.setTitle("\(str)", for: .normal)
                        self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                        // self.str_country = nat.alpha_3_code
                        self.str_countrynationality = nat.alpha_3_code
                        self.str_country_2_code = nat.alpha_2_code

                    }

                    
                    
                    
                    //nationalitybtn.setTitle("\(str)", for: .normal)
                   // self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                    // self.str_country = nat.alpha_3_code
                    //self.str_countrynationality = nat.alpha_3_code
                    
                    countryView.isHidden = true
                    benView.isHidden = false
                    //  self.getPurpose(country: str_country)
                    // self.setAccountDetails(country: nat.en_short_name)
                    //self.str_country_2_code = nat.alpha_2_code
                    // self.getCountrynewshowconfigapi(keyword:nat.alpha_3_code)
                    
                    if(nat.en_short_name != "India")
                    {
                        self.str_ifsc = ""
                    }
                }
                else{
                    let nat = countryArraySearch[indexPath.row]
                    //self.nationalitybtn.setTitle("\(str)", for: .normal)
                   // self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                    // self.str_country = nat.alpha_3_code
                    countryView.isHidden = true
                    benView.isHidden = false
                    //  self.getPurpose(country: str_country)
                    //self.setAccountDetails(country: nat.en_short_name)
                    //self.str_country_2_code = nat.alpha_2_code
                    
                    //self.str_countrynationality = nat.alpha_3_code
                    // self.getCountrynewshowconfigapi(keyword:nat.alpha_3_code)
                    
                    if natselserchstr == "searchcliked"
                    {
                        let cell: CountryTableViewCell = self.tblCountry.cellForRow(at: indexPath) as! CountryTableViewCell
                        
                        
                        teststrclsnat = searchedArraynat[indexPath.row]
                                        print("selectednamesearch",teststrclsnat)
                        
                        
                        
                        
                       // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                        guard let index = checkarrayaoccunat.firstIndex(of: teststrclsnat) else { return }
                        print(index)
                         print("kityda:\(index)")
                        
                        var indexone = index
                       // let firstName = AllArrayid[indexone]
                        let firstName = checkarrayaoccunatstr[indexone]
                        print("id selkityada:\(firstName)")
                        str_countrynationality = firstName
                        print("id selkityadastr_natid:\(str_country_2_code)")
                        
                        
                        
                        self.nationalitybtn.setTitle("\(teststrclsnat)", for: .normal)
                        self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                        
                      //last
                        natselserchstr = ""
                    }

                    else
                    {
                        nationalitybtn.setTitle("\(str)", for: .normal)
                        self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                        // self.str_country = nat.alpha_3_code
                        self.str_countrynationality = nat.alpha_3_code
                        self.str_country_2_code = nat.alpha_2_code

                    }
                    

                    
                    if(nat.en_short_name != "India")
                    {
                        self.str_ifsc = ""
                    }
                }
                print("str_countrynationalityfinaly",str_countrynationality)
                
                let bottomOffset = CGPoint(x: 0, y: 250)
                scrollView.setContentOffset(bottomOffset, animated: true)
            }
        }
        else if(tableView == tblPurpose)
        {
            let cell: LabelTableViewCell = self.tblPurpose.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            purposeBtn.setTitle("\(str)", for: .normal)
            purpuseclickcheckstr = "1"
            animatePurpose(toogle: false)
            
            self.purposeBtn.setTitleColor(UIColor.black, for: .normal)
        }
        else if(tableView == tblBank)
        {
            
            
            if serviceproviderormobopbtnstr == "clicksecviceormobbtn"
            {
                
                let cell: LabelTableViewCell = self.tblBank.cellForRow(at: indexPath) as! LabelTableViewCell
                let str: String = cell.label.text!
                let bank = bankArray[indexPath.row]
                self.benView.isHidden = false
                self.bankView.isHidden = true
                bankbranschshow = bank.bankAddress
                bankcitytypestr = bank.bankcitytype
                
                Mobilenonolengthstr = bank.Mobnolength
                print("Mobilenonolengthstr",Mobilenonolengthstr)
                
                
                
                
                if bankselserchstr == "searchcliked"
                {
                    let cell: LabelTableViewCell = self.tblBank.cellForRow(at: indexPath) as! LabelTableViewCell
                    
                    
                    teststrclsbank = searchedArraybank[indexPath.row]
                                    print("selectednamesearch",teststrclsbank)
                    
                    UserDefaults.standard.removeObject(forKey: "str_bank_codeserviceprovidercode")
                    
                    
                   // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                    guard let index = checkarrayaoccubank.firstIndex(of: teststrclsbank) else { return }
                    print(index)
                     print("kityda:\(index)")
                    
                    var indexone = index
                   // let firstName = AllArrayid[indexone]
                    let firstName = checkarrayaoccubankstr[indexone]
                    print("id selkityada:\(firstName)")
                    str_bank_code = firstName
                    print("id selkityadastr_bankid:\(str_bank_code)")
                    
                   // self.str_bank_name  = teststrclsbank
                    self.serviceproviderbtn.setTitle("\(teststrclsbank)", for: .normal)
                    self.serviceproviderbtn.setTitleColor(UIColor.black, for: .normal)

                    
                  //last
                    bankselserchstr = ""
                }
                
                else
                {
                    UserDefaults.standard.removeObject(forKey: "str_bank_codeserviceprovidercode")
                    self.str_bank_code = bank.bankCode
                    //self.bankBtn.setTitle("\(str)", for: .normal)
                    self.serviceproviderbtn.setTitle("\(str)", for: .normal)
                    self.serviceproviderbtn.setTitleColor(UIColor.black, for: .normal)

                }

                
               // MobileWalletaccnonolengthstr = bank.MobWalletaccnolength
                //print("MobileWalletaccnonolengthstr",MobileWalletaccnonolengthstr)
                print("bankseviceprovidercodefinaly",str_bank_code)
                
                UserDefaults.standard.set(self.str_bank_code, forKey: "str_bank_codeserviceprovidercode")
                
                //name for cashpickup
                print("bankseviceprovidername",str)
                
                UserDefaults.standard.removeObject(forKey: "serviceproviderBANKname")
              
                UserDefaults.standard.set(str, forKey: "serviceproviderBANKname")
                
                
                print("bankbranschshowtext1",self.bankbranschshow)
                print("bankcitytypestrtext1",self.bankcitytypestr)
                if bankbranschshow == "YES"
                {
                    
                    
                    self.branchBtn.isHidden = false
                    branchbtnconstrainttop.constant = 10
                    self.branchbtnheightconstaint.constant = 40
                    
                    //
                    self.CITYDROPTXTFILED.isHidden = false
                    self.citydropconstrainttop.constant = 10
                    self.Citydroptxtfiledhieghtconstraint.constant = 40
                    
                    self.bankBtn.isHidden = false
                    bankfcitybtnconstrainttop.constant = 8
                    self.bankntnheightconstraint.constant = 40
                    
                    //new commonly
                    self.CITYDROPTXTFILED.isHidden = true
                    self.citydropconstrainttop.constant = 0
                    self.Citydroptxtfiledhieghtconstraint.constant = 0
                    
                    if bankcitytypestr == "D"

                    {
                        self.bankBtn.isHidden = false
                        bankfcitybtnconstrainttop.constant = 8
                        self.bankntnheightconstraint.constant = 40
                        
                    }
                    else
                    {
                        self.bankBtn.isHidden = true
                        bankfcitybtnconstrainttop.constant = 0
                        self.bankntnheightconstraint.constant = 0
                        
                    }
                    
                    if bankcitytypestr == "T"
                    {
//                        self.CITYDROPTXTFILED.isHidden = false
//                        self.citydropconstrainttop.constant = 10
//                        self.Citydroptxtfiledhieghtconstraint.constant = 40
                    }
                    else
                    {
//                        self.CITYDROPTXTFILED.isHidden = true
//                        self.citydropconstrainttop.constant = 0
//                        self.Citydroptxtfiledhieghtconstraint.constant = 0
                    }
                    
                    
                    
                }
                //            else
                //            {
                //             self.branchBtn.isHidden = true
                //            branchbtnconstrainttop.constant = 0
                //             self.branchbtnheightconstaint.constant = 0
                //
                //            }
                //
                
                
                if bankbranschshow == "NO"
                {
                    //new
                    UserDefaults.standard.removeObject(forKey: "str_branch_code")
                    UserDefaults.standard.removeObject(forKey: "str_bank_citydropcode")
                    
                    
                    self.branchBtn.isHidden = true
                    branchbtnconstrainttop.constant = 0
                    self.branchbtnheightconstaint.constant = 0
                    
                    self.CITYDROPTXTFILED.isHidden = true
                    self.citydropconstrainttop.constant = 0
                    self.Citydroptxtfiledhieghtconstraint.constant = 0
                    self.bankBtn.isHidden = true
                    bankfcitybtnconstrainttop.constant = 0
                    self.bankntnheightconstraint.constant = 0
                }
                
                
                
            }
            
            if citydropbtstr == "citydropclick"
            {
                let cell: LabelTableViewCell = self.tblBank.cellForRow(at: indexPath) as! LabelTableViewCell
                let str: String = cell.label.text!
                let bank = bankArray[indexPath.row]
                
                self.benView.isHidden = false
                self.bankView.isHidden = true
                //bankbranschshow = bank.bankAddress
                //  bankcitytypestr = bank.bankcitytype
                print("bankbranschshowtext1",self.bankbranschshow)
                print("bankcitytypestrtext1",self.bankcitytypestr)
                
                //newsearch
                if self.cityselserchstr == "searchcliked"
                {
                    let cell: LabelTableViewCell = self.tblBank.cellForRow(at: indexPath) as! LabelTableViewCell
                    
                    UserDefaults.standard.removeObject(forKey: "str_bank_citydropcode")

                    
                    
                    teststrclscity = searchedArraycity[indexPath.row]
                                    print("selectednamesearch",teststrclsbank)
                    
                    
                    
                    
                   // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                    guard let index = checkarrayaoccucity.firstIndex(of: teststrclscity) else { return }
                    print(index)
                     print("kityda:\(index)")
                    
                    var indexone = index
                   // let firstName = AllArrayid[indexone]
                    let firstName = checkarrayaoccucitystr[indexone]
                    print("id selkityada:\(firstName)")
                    str_bank_citydropcode = firstName
                    print("id selkityadastrstr_bank_citydropcode:\(str_bank_citydropcode)")
                    
                   // self.str_bank_name  = teststrclsbank
                    self.bankBtn.setTitle("\(str)", for: .normal)
                    self.bankBtn.setTitleColor(UIColor.black, for: .normal)

                    
                  //last
                    cityselserchstr = ""
                }
                
                else
                {
                    UserDefaults.standard.removeObject(forKey: "str_bank_citydropcode")

                    self.str_bank_citydropcode = bank.bankCode
                    //self.bankBtn.setTitle("\(str)", for: .normal)
                    self.bankBtn.setTitle("\(str)", for: .normal)
                    self.bankBtn.setTitleColor(UIColor.black, for: .normal)
                }

                
                
                
                
                
                
                //self.str_bank_citydropcode = bank.bankCode
                UserDefaults.standard.set(self.str_bank_citydropcode, forKey: "str_bank_citydropcode")
                print("selectedcitydropcodefinaly",self.str_bank_citydropcode)
                
                
                //
                UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
                
                UserDefaults.standard.set(str, forKey: "beneficiaryCity1")
                
                citydropbtstr = ""
                
            }
            
            serviceproviderormobopbtnstr = ""
            citydropbtstr = ""
            
            let bottomOffset = CGPoint(x: 0, y: 300)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
        }
        else if(tableView == tblBranch)
        {
            let cell: LabelTableViewCell = self.tblBranch.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            let branch = branchArray[indexPath.row]

            self.benView.isHidden = false
            self.branchView.isHidden = true
            
            //newsearch
            if branchselserchstr == "searchcliked"
            {
                let cell: LabelTableViewCell = self.tblBranch.cellForRow(at: indexPath) as! LabelTableViewCell
                
                
                teststrclsbranch = searchedArraybranch[indexPath.row]
                                print("selectednamesearch",teststrclsbranch)
                
                
                UserDefaults.standard.removeObject(forKey: "str_branch_code")
                
               // guard let index = AllArray.firstIndex(of: teststrcls) else { return }
                guard let index = checkarrayaoccubranch.firstIndex(of: teststrclsbranch) else { return }
                print(index)
                 print("kityda:\(index)")
                
                var indexone = index
               // let firstName = AllArrayid[indexone]
                UserDefaults.standard.removeObject(forKey: "str_branch_code")
                let firstName = checkarrayaoccubranchstr[indexone]
                print("id selkityada:\(firstName)")
                str_branch_code = firstName
                print("id selkityadastr_branchid:\(str_branch_code)")
                
                //self.str_branch_name  = teststrclsbranch
                self.branchBtn.setTitle("\(teststrclsbranch)", for: .normal)
                self.branchBtn.setTitleColor(UIColor.black, for: .normal)
                
              //last
                branchselserchstr = ""
            }
            else
            {
                UserDefaults.standard.removeObject(forKey: "str_branch_code")
                self.str_branch_code = branch.branchCode
                self.branchBtn.setTitle("\(str)", for: .normal)
                self.branchBtn.setTitleColor(UIColor.black, for: .normal)
            }

            
            
            print("branch codefinal",str_branch_code)
            
            UserDefaults.standard.set(self.str_branch_code, forKey: "str_branch_code")
            
            //namerem3displaysavefirsttime
            UserDefaults.standard.removeObject(forKey: "serviceproviderBRANCHname")
            UserDefaults.standard.set(str, forKey: "serviceproviderBRANCHname")
            
            
            let bottomOffset = CGPoint(x: 0, y: 300)
            scrollView.setContentOffset(bottomOffset, animated: true)
            
        }
        self.timerGesture.isEnabled = true
        resetTimer()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == searchCountry || textField == searchBank || textField == searchBranch)
        {
            let maxLength = 20
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        if(textField == mobileNumber)
        {
            let maxLength = 20
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        if(textField == address)
        {
            let maxLength = 100
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        
        return Bool()
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == searchCountry)
        {
//            if(self.searchCountry.text?.count != 0)
//            {
//                self.countrySearchFlag = 1
//                let keyword  = searchCountry.text!
//                self.countryArray.removeAll()
//                self.getCountry(keyword: keyword)
//            }
        }
        else if(textField == searchBank)
        {
//            if(searchBank.text?.count != 0)
//            {
//                self.getToken(num: 2)
//            }
        }
        else if(textField == searchBranch)
        {
//            if(searchBranch.text?.count != 0)
//            {
//                self.getToken(num: 3)
//            }
        }
        self.resetTimer()
    }
}


extension String {

    func removeExtraSpacesremcash() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }

}
