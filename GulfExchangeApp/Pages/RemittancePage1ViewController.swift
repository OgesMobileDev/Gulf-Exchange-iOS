//
//  RemittancePage1ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 10/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Toast_Swift
import ScreenShield
class RemittancePage1ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var mainStackView: UIStackView!
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


    
    var heightCon:NSLayoutConstraint!
    
    
    @IBOutlet weak var orlabel: UILabel!
    
    
    @IBOutlet weak var otherinfolabel: UILabel!
    
    
    @IBOutlet weak var checkaccountinfobtn: UIButton!
    
    
    
    @IBOutlet weak var iagreelabel: UILabel!
    
    
    
    @IBOutlet weak var selpaymentmodelabel: UILabel!
    
    
    @IBOutlet weak var enternewrecinfolabel: UILabel!
    
    
    
    
    @IBOutlet var firstnameheightconsraint: NSLayoutConstraint!
    
    @IBOutlet var middlenamehieghtconstrain: NSLayoutConstraint!
    
    @IBOutlet var middlenameconstrainttop: NSLayoutConstraint!
    @IBOutlet var lastnameheightconstraint: NSLayoutConstraint!
    
    @IBOutlet var lastnameconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var genderbtnhiehtconstraint: NSLayoutConstraint!
    
    @IBOutlet var genderbtnconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var nationalitybtnhieghtconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var nationalitybtnconstrainttop: NSLayoutConstraint!
    @IBOutlet var bankntnheightconstraint: NSLayoutConstraint!
    
    @IBOutlet var bankbtnslakviewconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var branchbtnheightconstaint: NSLayoutConstraint!
    
    @IBOutlet var branchbtnslakviiewconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var addressheightconstraint: NSLayoutConstraint!
    
    @IBOutlet var addressconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var cityhieghtconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var mobileheightconstraint: NSLayoutConstraint!
    
    @IBOutlet var mobileconstrainttop: NSLayoutConstraint!
    
    
    @IBOutlet var cityconstrainttop: NSLayoutConstraint!
    
    @IBOutlet var citydropbtnconstarintop: NSLayoutConstraint!
    
    var nationalitybtnselstr:String = ""
    var countrybtnselstr:String = ""
    
    var citydropriaselstr:String = ""
    
    var codetypestr:String = ""
    
    var ibanstrenterdstored:String = ""
    
    var cityzero:String = ""
    
    var ibanzero:String = ""
    
    var fullnamestr:String = ""
    
    
    var purpuseclickcheckstr:String = ""
    
    var nationalityclickcheckstr:String = ""
    var nationalityclickcheckstrviewben:String = ""
    
    var genderclickcheckstr:String = ""
    var genderclickcheckstrviewben:String = ""
    
    var middlenameclickcheckstr:String = ""
    
    var accountnoclickcheckstr:String = ""
    var ibanclickcheckstr:String = ""
    
    var accountnboalertstrcheck:String = ""
    var ibanglobstrcheckappearstr:String = ""
    var accountnoglobstrcheckappearstr:String = ""
    
    var str_bank_citydropcode:String = ""
    
    var bankbranschshow:String = ""
    var bankcitytypestr:String = ""
    var Accountnolengthstr:String = ""
     var Accountnolengthint:Int = 0
    var minAccountnolengthstr:String = ""
    var ifscnolengthstr:String = ""
    
    var str_gender:String = ""
    var str_nationalitycode:String = ""
    
    var citydropname:String = ""
    
    var servicetypestr:String = ""
    
    
    var serialnostored:String = ""
    
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
    
    
    @IBOutlet var citydrop: UIButton!
    
    @IBAction func citydropAction(_ sender: Any)
    {
        
        
        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else
        {
            
//            self.timerGesture.isEnabled = false
//            resetTimer()
            
            searchCountry.isHidden = true
            
            self.countrySearchFlag = 0
            self.benView.isHidden = true
            self.countryView.isHidden = false
            scrollView.setContentOffset(.zero, animated: true)
            //self.getCountry(keyword: "")
            self.getToken(num: 10)
            self.searchCountry.text = ""
            
            countrybtnselstr = ""
            nationalitybtnselstr = ""
            citydropriaselstr = "citydropriaselstr"
        
        
        }
        
    }
    
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
    
    
    @IBAction func AccounttransferBtnAction(_ sender: Any)
    {
       // self.getTokenACTBtn(num: 1)
        
        timer?.invalidate()
        timer = nil
       // timer.fire()
        // resetTimer()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem1") as! RemittancePage1ViewController
        //                    self.present(nextViewController, animated:true, completion:nil)
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBOutlet var servicetypebtn: UIButton!
    
    @IBOutlet var serviceproviderbtn: UIButton!
    
    
    
    
    
    @IBOutlet var nationalitybtn: UIButton!
    
    @IBAction func nationalitybtnAction(_ sender: Any)
    {
        self.timerGesture.isEnabled = false
        resetTimer()
        
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
        citydropriaselstr = ""

    }
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    //otp
    var email:String = ""
    var mobile:String = ""
    
    
    var olduserchkstr:String = ""
    
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
    //
    
    
    
    let defaults = UserDefaults.standard
    var beneficiaryList:[Beneficiary] = []
    
    var sourceArray:[Source] = []
    var purposeeArray:[Source] = []
    var relationArray:[Source] = []
    var CityArray:[City] = []
    
    var str_benificiaryserialnostr:String = ""
    
    var str_country:String = ""
    var str_countrynationality:String = ""
    var str_bank_code:String = ""
    var str_branch_code:String = ""
    var str_first_name:String = ""
    var str_last_name:String = ""
    
    
    var BRANCHNAMENEW:String = ""
    var CITYNAMENEW:String = ""
    
    var middlenamestrstored:String = ""
    
    var str_bank_citydropcodeviewben:String = ""
    var servicetypeviewben:String = ""
    
    var str_middle_name:String = ""
    var str_gender_name:String = ""
    var str_nationality_name:String = ""
    
    
    
    var str_country_name:String = ""
    var str_bank_name:String = ""
    var str_branch_name:String = ""
    var str_address:String = ""
    var str_city:String = ""
    var str_mobile:String = ""
    var str_acc_no:String = ""
    var str_ifsc:String = ""
    var ibanstrenterd:String = ""
    
    var str_source:String = ""
    var str_purpose:String = ""
    var str_relation:String = ""
    var str_serial_no:String = ""
    var str_ben_account:String = ""
    var str_country_2_code:String = ""
    
    
    var citydropcodenew:String = ""
    var udid:String!
    
    
    //hidebuton
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  timer.invalidate()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light

 

            
        } else {
            // Fallback on earlier versions
        }
        
        
        alreadysvaedcustomerstr = "0"
        self.olduserchkstr = "0"
        
        self.accountnoclickcheckstr = "0"
        self.ibanclickcheckstr = "0"
        
        
        
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
        
        self.timerGesture.isEnabled = true


        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didRecognizeTapGesture(_:)))
//
//        city.addGestureRecognizer(tapGesture)
        
        //self.mobileNumber.keyboardType = UIKeyboardType.numberPad
        //self.mobileNumber.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
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
        
        UserDefaults.standard.removeObject(forKey: "city")
        
        //citycleared
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
        
        self.city.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            self.city.layer.borderColor = UIColor.systemGray5.cgColor
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

        self.ifscCode.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.ifscCode.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }

        self.iban.layer.borderWidth = 0.8
        if #available(iOS 13.0, *) {
            self.iban.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }

        
        //localize
        //self.firstNameTextField.text = (NSLocalizedString("first_name1", comment: ""))
       // self.lastNameTextField.text = (NSLocalizedString("lastname1", comment: ""))
//        self.countryBtn.setTitle(NSLocalizedString("country", comment: ""), for: .normal)
//        self.countryBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
//        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
//        self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
//
//        self.genderbtn.setTitle(NSLocalizedString("GENDERR", comment: ""), for: .normal)
//        self.genderbtn.setTitleColor(UIColor.lightGray, for: .normal)
//
//        self.nationalitybtn.setTitle(NSLocalizedString("nationalityy", comment: ""), for: .normal)
//        self.nationalitybtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        
        
        
        //localize
        
        self.selpaymentmodelabel.text = (NSLocalizedString("sel_payment_mode", comment: ""))
        self.enternewrecinfolabel.text = (NSLocalizedString("enter_rece_info", comment: ""))
    
        self.checkaccountinfobtn.setTitle(NSLocalizedString("i_checked", comment: ""), for: .normal)
        
        self.selectReceiverBtn.setTitle(NSLocalizedString("sel_existing_rece", comment: ""), for: .normal)
      accountTransferBtn.setTitle(NSLocalizedString("acc_transfer", comment: ""), for: .normal)
        cashPickupBtn.setTitle(NSLocalizedString("cash_pickup", comment: ""), for: .normal)
        
        
        self.firstNameTextField.placeholder = (NSLocalizedString("first_name1", comment: ""))
        
        //self.firstNameTextField.text = (NSLocalizedString("first_name1", comment: ""))
        self.lastNameTextField.placeholder = (NSLocalizedString("lastname1", comment: ""))
        self.middleNameTextField.placeholder = (NSLocalizedString("middlename1", comment: ""))
        
        self.countryBtn.setTitle(NSLocalizedString("country", comment: ""), for: .normal)
       // self.countryBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
       // self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
      //  self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        self.city.placeholder = (NSLocalizedString("city1", comment: ""))
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
        
        
        
        
        
        
        alreadysvaedcustomerstr = "0"
        //alreadysvaedcustomerstr = "0"
        let custmBackBtn = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .done, target: self, action: #selector(HomeVCAction))
        self.navigationItem.leftBarButtonItem  = custmBackBtn
        citydrop.isHidden = true
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
            city.textAlignment = .right
            accountNum.textAlignment = .right
            iban.textAlignment = .right
            swiftCode.textAlignment = .right
            sortCode.textAlignment = .right
            routingCode.textAlignment = .right
            ifscCode.textAlignment = .right
            searchCountry.textAlignment = .right
            searchBank.textAlignment = .right
            searchBranch.textAlignment = .right
            cashSegmentImageView.image = UIImage(named: "cash_blank2")
            cashPickupBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            accountTransferBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            
            
            sourceOfFundBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            countryBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            bankBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            branchBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            purposeBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            relationshipBtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            nationalitybtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            genderbtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        } else {
            firstNameTextField.textAlignment = .left
            lastNameTextField.textAlignment = .left
            middleNameTextField.textAlignment = .left
            address.textAlignment = .left
            mobileNumber.textAlignment = .left
            city.textAlignment = .left
            iban.textAlignment = .left
            swiftCode.textAlignment = .left
            sortCode.textAlignment = .left
            routingCode.textAlignment = .left
            ifscCode.textAlignment = .left
            searchCountry.textAlignment = .left
            searchBank.textAlignment = .left
            searchBranch.textAlignment = .left
            cashSegmentImageView.image = UIImage(named: "cash_blank1")
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
        
        //citydropbtn
        citydrop.layer.cornerRadius = 5
        citydrop.layer.borderWidth = 1
        citydrop.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        //servicetype btn
        //
        //               servicetypebtn.layer.cornerRadius = 5
        //               servicetypebtn.layer.borderWidth = 1
        //               servicetypebtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        //
        //               //serviceproviderbtn
        //               serviceproviderbtn.layer.cornerRadius = 5
        //               serviceproviderbtn.layer.borderWidth = 1
        //               serviceproviderbtn.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        
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
        self.accNoTop.constant = 0
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
        
        
        searchCountry.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        searchBank.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        searchBranch.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        //new
        firstNameTextField.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        middleNameTextField.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)

        lastNameTextField.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        city.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        address.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        mobileNumber.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        accountNum.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        ifscCode.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)
        iban.addTarget(self, action: #selector(RemittancePage1ViewController.textFieldDidChange(_:)), for: .editingChanged)


        //new
        //new
        self.firstNameTextField.layer.borderWidth = 0.8
        self.firstNameTextField.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        self.lastNameTextField.layer.borderWidth = 0.8
        self.lastNameTextField.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        self.middleNameTextField.layer.borderWidth = 0.8
        self.middleNameTextField.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        self.city.layer.borderWidth = 0.8
        self.city.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        
        self.address.layer.borderWidth = 0.8
        self.address.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        self.mobileNumber.layer.borderWidth = 0.8
        self.mobileNumber.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(true)
               
               // Protect ScreenShot
                     // ScreenShield.shared.protect(view: self.mainStackView)
                      
                      // Protect Screen-Recording
                      //ScreenShield.shared.protectFromScreenRecording()
              
           }
    @objc func userIsInactive() {
        // Alert user
        print("\(counter) timer countlogout")
        
//        let alert = UIAlertController(title: "rem1You have been inactive for 5 minutes. We're going to log you off for security reasons.", message: nil, preferredStyle: .alert)
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
           // counter = 0
          }
        print("\(counter) timer resetcountdw")
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }

    
    
    
//    @objc private dynamic func didRecognizeTapGesture(_ gesture: UITapGestureRecognizer) {
//        let point = gesture.location(in: gesture.view)
//
//        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
//        {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
//        }
//        else
//        {
//            self.countrySearchFlag = 0
//            self.benView.isHidden = true
//            self.countryView.isHidden = false
//            scrollView.setContentOffset(.zero, animated: true)
//            //self.getCountry(keyword: "")
//            self.getToken(num: 10)
//            self.searchCountry.text = ""
//
//            countrybtnselstr = ""
//            nationalitybtnselstr = ""
//            citydropriaselstr = "citydropriaselstr"
//
//        }
//
//        print("benficitydrop---","newria")
//       //do
//
//
//
//        guard gesture.state == .ended, city.frame.contains(point) else { return }
//
//        //donomething()
//        print("benfi---","55554")
//    }
//
    
    
    
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
        
        //timer.invalidate()
       // timer.fire()
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
            
//            if(searchBank.text?.count == 0)
//            {
//                view.endEditing(true)
//                self.bankSearchFlag = 0
//                self.bankArray.removeAll()
//                self.getToken(num: 2)
//            }
//
//            if(searchBank.text?.count != 0)
//            {
//                self.getToken(num: 2)
//            }
            
            if(searchBank.text?.count == 0)
            {
                bankselserchstr = ""
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

        }
        else if(textField == searchBranch)
        {
            
            if(searchBranch.text?.count == 0)
            {
                branchselserchstr = ""
                
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

//            if(searchBranch.text?.count == 0)
//            {
//                view.endEditing(true)
//                self.branchArray.removeAll()
//                self.getToken(num: 3)
//            }
        }
        
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
        
       // self.timerGesture.isEnabled = false
        resetTimer()
        
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
        citydropriaselstr = ""

         self.clearBenforcountrychange()
    }
    @IBAction func bankBtn(_ sender: Any) {
        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            
            //self.timerGesture.isEnabled = false
            resetTimer()
            
            clearBenforbankchange()
            
            self.searchBank.text = ""
            self.benView.isHidden = true
            self.bankView.isHidden = false
            scrollView.setContentOffset(.zero, animated: true)
            self.getToken(num: 2)
        }
    }
    @IBAction func branchBtn(_ sender: Any) {
        if(bankBtn.titleLabel?.text == NSLocalizedString("bank_name1", comment: ""))
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_bank", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            
            //self.timerGesture.isEnabled = false
            resetTimer()
            
            self.searchBranch.text = ""
            self.branchView.isHidden = false
            self.benView.isHidden = true
            self.getToken(num: 3)
            scrollView.setContentOffset(.zero, animated: true)
        }
    }
    
    @IBAction func selectReceiverBtn(_ sender: Any) {
        timerGesture.isEnabled = false
        
        resetTimer()
        
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
        
//        if olduserchkstr == "1"
//        {
//
//            //new
//
//            if alreadysvaedcustomerstr == "1"
//            {
//
//                if olduserchkstr == "1"
//                {
//                    if(genderbtn.titleLabel?.text == NSLocalizedString("GENDERR", comment: ""))
//                    {
//                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                        return
//                    }
//
//
//
//                    if(nationalitybtn.titleLabel?.text ==  NSLocalizedString("nationalityy", comment: ""))
//                    {
//                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                        return
//                    }
//
//                }
//
//            }
//
//            self.getToken(num: 11)
//
//
//        }
//        else
//
//        {
        
        
        
        
        
        
        
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
                self.str_city = self.city.text!
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
    
    
    
//}
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
        
        if olduserchkstr == "1"
        {
            
            //new
            
            if alreadysvaedcustomerstr == "1"
            {
                
                if olduserchkstr == "1"
                {
                    if(genderbtn.titleLabel?.text == NSLocalizedString("GENDERR", comment: ""))
                    {
                        self.view.makeToast(NSLocalizedString("sel_gender", comment: ""), duration: 3.0, position: .center)

                       // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                    }
                    
                    
                    
                    if(nationalitybtn.titleLabel?.text ==  NSLocalizedString("nationalityy", comment: ""))
                    {
                        self.view.makeToast(NSLocalizedString("sel_nationality", comment: ""), duration: 3.0, position: .center)
                        //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                    }
                    
                }
                
            }
            
            self.getToken(num: 11)
            
            
        }
        
        else
        {
        
        //        if middleNameTextField.text?.isEmpty ?? true {
        //               print("middlenametextField is empty")
        //               self.str_middle_name = ""
        //           } else {
        //               print("middletextField has some text")
        //                self.str_middle_name = middleNameTextField.text!
        //               print("middletextField has some text",str_middle_name)
        //           }
        //
        //        self.str_gender_name = genderbtn.titleLabel?.text as! String
        //         print("gendernamee",str_gender_name)
        //        self.str_nationality_name = nationalitybtn.titleLabel?.text as! String
        //        print("nationalityname",str_nationality_name)
        
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
        let processedStringfname = startingStringfname.removeExtraSpacesremac()
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
                    }                }
            }
            else
            {

            self.firstNameTextField.layer.borderWidth = 1
                
                if #available(iOS 13.0, *) {
                    self.lastNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }


        
        
        guard let firstName = firstNameTextField.text,firstNameTextField.text?.count != 0 else
        {
            self.scrollView.setContentOffset(.zero, animated: true)
            
      
            
            
            self.view.makeToast(NSLocalizedString("enter_firstname", comment: ""), duration: 3.0, position: .center)
           // alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("enter_firstname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if (!validate(value: self.firstNameTextField.text!))
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
        
        
        
        var strlastname = lastNameTextField.text
        strlastname = strlastname!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strlastname)
        // "this is the answer"
        print("strlastname",strlastname)
        lastNameTextField.text =  strlastname
        print("lastNameTextField.text",lastNameTextField.text)
        
        
        //extraspace remove
        let startingStringlname = lastNameTextField.text!
        let processedStringlname = startingStringlname.removeExtraSpacesremac()
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
            self.scrollView.setContentOffset(.zero, animated: true)
            self.view.makeToast(NSLocalizedString("enter_lastname", comment: ""), duration: 3.0, position: .center)

            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_lastname", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if (!validate(value: self.lastNameTextField.text!))
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
        
        
        
        //middle name
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
        let processedStringmname = startingStringmname.removeExtraSpacesremac()
        print("processedString:\(processedStringmname)")
        middleNameTextField.text = processedStringmname
        
        
       let middlenamee = middleNameTextField.text
        
  
        
        
        if middlenameclickcheckstr == "1"
       {
            
            
            if middleNameTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.middleNameTextField.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.middleNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            else
            {

            self.middleNameTextField.layer.borderWidth = 1
                
                if #available(iOS 13.0, *) {
                    self.middleNameTextField.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }

            
    guard let middlenamee = middleNameTextField.text,middleNameTextField.text?.count != 0 else
            {
        self.scrollView.setContentOffset(.zero, animated: true)
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
//
        
        

        
        
        
        var charSetmiddlename = CharacterSet.init(charactersIn: "123456789@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2middlename = middlenamee
        
        if let strvalue = string2middlename!.rangeOfCharacter(from: charSetmiddlename)
        {
            print("true")
            
            self.scrollView.setContentOffset(.zero, animated: true)
            self.view.makeToast(NSLocalizedString("Please enter valid name", comment: ""), duration: 3.0, position: .center)
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid name", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        
        
        
        
        
        
        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
        {
            self.scrollView.setContentOffset(.zero, animated: true)
            
            self.countryBtn.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.countryBtn.layer.borderColor = UIColor.systemGray5.cgColor
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
                self.countryBtn.layer.borderColor = UIColor.systemGray5.cgColor
            } else {
                // Fallback on earlier versions
            }

            
        }
        
        
        
//        if genderclickcheckstr != "1"
//       {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//
//       }
//        else
//        {
//
//        }
//
//
//
//        if nationalityclickcheckstr != "1"
//        {
//
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//
//
//        }
//
//        else
//        {
//
//        }
        
        
        
        print("genderbtn.titleLabel?.text",genderbtn.titleLabel?.text)
          print("genderbtnlo9calize.titleLabel?.text",NSLocalizedString("GENDERR", comment: ""))
        
        
        if alreadysvaedcustomerstr == "0"
        {
            
        
          if(genderbtn.titleLabel?.text == NSLocalizedString("GENDERR", comment: ""))
          {
              self.scrollView.setContentOffset(.zero, animated: true)
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
            else
            {
                if #available(iOS 13.0, *) {
                    self.genderbtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
        
        print("nationalitybtn.titleLabel?.text",NSLocalizedString("nationalityy", comment: ""))

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
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
        
        //new
        
        if alreadysvaedcustomerstr == "1"
        {
            
            if olduserchkstr == "1"
            {
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
                   // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_gender", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                else
                {
                    if #available(iOS 13.0, *) {
                        self.genderbtn.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
                
                
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
                    //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_nationality", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
            
        }
        
        print("bank.titleLabel?.text",bankBtn.titleLabel?.text)
        print("banklocaliz.titleLabel?.text",NSLocalizedString("bank_name1", comment: ""))
        if(bankBtn.titleLabel?.text == NSLocalizedString("bank_name1", comment: ""))
        {
            let bottomOffset = CGPoint(x: 0, y: 160)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("sel_bank", comment: ""), duration: 3.0, position: .center)
            
            self.bankBtn.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.bankBtn.layer.borderColor = UIColor.systemGray5.cgColor
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
                    self.bankBtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
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
                
                self.branchBtn.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.branchBtn.layer.borderColor = UIColor.systemGray5.cgColor
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
                    self.branchBtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        
        var straddress = address.text
        straddress = straddress!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(straddress)
        // "this is the answer"
        print("straddress",straddress)
        address.text =  straddress
        print("addresstxtfiled.text",address.text)
        
        
        
        //extraspace remove
        let startingStringaddress = address.text!
        let processedStringaddress = startingStringaddress.removeExtraSpacesremac()
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
            print("true")
//            let alert = UIAlertController(title: "Alert", message: "Please enter valid  address", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            print("check name",self.address.text)
            
            let bottomOffset = CGPoint(x: 0, y: 180)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("Please enter valid  address", comment: ""), duration: 3.0, position: .center)
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid  address", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        
        if bankbranschshow == "YES"
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
            let processedStringcity = startingStringcity.removeExtraSpacesremac()
            print("processedString:\(processedStringcity)")
            city.text = processedStringcity
            
            
            
            if bankcitytypestr == "T"
            {
                
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
                    let bottomOffset = CGPoint(x: 0, y: 180)
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
//                    let alert = UIAlertController(title: "Alert", message: "Please enter valid city", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                    print("check name",self.city.text)
                    
                    self.view.makeToast(NSLocalizedString("enter_city", comment: ""), duration: 3.0, position: .center)
                    //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_city", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                    
                }
                
                
                
                
            }
            if bankcitytypestr == "D"
            {
                if(citydrop.titleLabel?.text == NSLocalizedString("city1", comment: ""))
                {
               // guard let citytext = city.text,city.text?.count != 0 else
               // {
                    let bottomOffset = CGPoint(x: 0, y: 180)
                    //OR
                    //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                    self.scrollView.setContentOffset(bottomOffset, animated: true)
                    self.view.makeToast(NSLocalizedString("enter_city", comment: ""), duration: 3.0, position: .center)
                    
                    self.citydrop.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        if #available(iOS 13.0, *) {
                            self.citydrop.layer.borderColor = UIColor.systemGray5.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                        }
                   // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_city", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    return
                }
                else
                {
                    if #available(iOS 13.0, *) {
                        self.citydrop.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            
            
            
        }
        
        if (!isValid(testStr: self.mobileNumber.text!))
        {
            
        }
        else
        {
            
            let bottomOffset = CGPoint(x: 0, y: 220)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            self.view.makeToast(NSLocalizedString("enter_mobile", comment: ""), duration: 3.0, position: .center)
           // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
        print("processedStringmobie:\(processedStringmobile)")
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
            let bottomOffset = CGPoint(x: 0, y: 220)
            //OR
            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
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
        
        
        
        if(countryBtn.titleLabel?.text == "India")
        {
            
            var straccountnoind = accountNum.text
            straccountnoind = straccountnoind!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(straccountnoind)
            // "this is the answer"
            print("straccountnoind",straccountnoind)
            accountNum.text =  straccountnoind
            print("accountNum.textind",accountNum.text)
            
            
            //extraspace remove
            let startingStringaccountnoind = accountNum.text!
            let processedStringaccountnoind = startingStringaccountnoind.removeExtraSpacesaccountnumber()
            print("processedStringhomeadress:\(processedStringaccountnoind)")
            accountNum.text = processedStringaccountnoind
            
            if accountNum.text?.isEmpty == true
            {
               // timer.invalidate()
                self.accountNum.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.accountNum.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            else
            {

            self.accountNum.layer.borderWidth = 1
                
                if #available(iOS 13.0, *) {
                    self.accountNum.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }

            
            
            guard let accNo = accountNum.text,accountNum.text?.count != 0 else
            {
                let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast(NSLocalizedString("enter_account", comment: ""), duration: 3.0, position: .center)
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_account", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            var charSetaccNo = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
            var string2accNo = accNo
            
            if let strvalue = string2accNo.rangeOfCharacter(from: charSetaccNo)
            {
                print("true")
                let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast(NSLocalizedString("Please enter valid account number", comment: ""), duration: 3.0, position: .center)

               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid account number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return            }
            
            
            //ifsc trim
            var straccountifsc = ifscCode.text
            straccountifsc = straccountifsc!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print(straccountifsc)
            // "this is the answer"
            print("straccountnoind",straccountifsc)
            ifscCode.text =  straccountifsc
            print("accountNum.textind",accountNum.text)
            
            //extraspace remove
//            let startingStringifsc = ifscCode.text!
//            let processedStringifsc = startingStringifsc.removeExtraSpacesaccountnumber()
//            print("processedStringhomeadress:\(processedStringifsc)")
//            ifscCode.text = processedStringifsc
            
            
            
            if ifscCode.text?.isEmpty == true
            {
               // timer.invalidate()
                self.ifscCode.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.ifscCode.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            else
            {

            self.ifscCode.layer.borderWidth = 1
                
                if #available(iOS 13.0, *) {
                    self.ifscCode.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }

            }
            
            guard let ifsc = ifscCode.text,ifscCode.text?.count != 0 else
            {
                let bottomOffset = CGPoint(x: 0, y: 260)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("enter_ifsc", comment: ""), duration: 3.0, position: .center)
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_ifsc", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            var charSetifsc = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
            var string2ifsc = ifsc
            if let strvalue = string2ifsc.rangeOfCharacter(from: charSetifsc)
            {
                let bottomOffset = CGPoint(x: 0, y: 260)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                self.view.makeToast(NSLocalizedString("enter_ifsc", comment: ""), duration: 3.0, position: .center)
                //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_ifsc", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            
        }
        else
        {
            
            
            
             if accountnboalertstrcheck == "1"
             {
                
             }
            else
             {
                
                var straccountnoindout = accountNum.text
                straccountnoindout = straccountnoindout!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                print(straccountnoindout)
                // "this is the answer"
                print("straccountnoindout",straccountnoindout)
                accountNum.text =  straccountnoindout
                print("accountNum.textindout",accountNum.text)
                
                //extraspace remove
                let startingStringaccountnoindout = accountNum.text!
                let processedStringaccountnoindout = startingStringaccountnoindout.removeExtraSpacesaccountnumber()
                print("processedStringhomeadress:\(processedStringaccountnoindout)")
                accountNum.text = processedStringaccountnoindout
                
                if accountNum.text?.isEmpty == true
                {
                   // timer.invalidate()
                    self.accountNum.layer.borderColor = UIColor.red.cgColor
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                        if #available(iOS 13.0, *) {
                            self.accountNum.layer.borderColor = UIColor.systemGray5.cgColor
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                else
                {

                self.accountNum.layer.borderWidth = 1
                    
                    if #available(iOS 13.0, *) {
                        self.accountNum.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        // Fallback on earlier versions
                    }

                }
            
            guard let accNo = accountNum.text,accountNum.text?.count != 0 else
            {
                let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
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
                
                let bottomOffset = CGPoint(x: 0, y: 240)
                //OR
                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                self.view.makeToast(NSLocalizedString("Please enter valid account number", comment: ""), duration: 3.0, position: .center)
               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid account number", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
                
            }
            
    }
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
              
         

          }
            
            
            
       //self.ibanglobstrcheckappearstr = "1"
          
            
        }
        
        
        
        //accountnolength validation getbank api
        
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
        
     
            
        }
        
        
        if(!checkClick)
        {
            self.view.makeToast(NSLocalizedString("confirm_account", comment: ""), duration: 3.0, position: .center)
           // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("confirm_account", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(sourceOfFundBtn.titleLabel?.text == NSLocalizedString("source1", comment: ""))
        {
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_source", comment: ""), action: NSLocalizedString("ok", comment: ""))
            self.view.makeToast(NSLocalizedString("sel_source", comment: ""), duration: 3.0, position: .center)
            self.sourceOfFundBtn.layer.borderColor = UIColor.red.cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                if #available(iOS 13.0, *) {
                    self.sourceOfFundBtn.layer.borderColor = UIColor.systemGray5.cgColor
                } else {
                    // Fallback on earlier versions
                }
                }
            
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
//        if(purposeBtn.titleLabel?.text == NSLocalizedString("purpose1", comment: ""))
//            {
//                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_purpose", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                return
//            }
//        if str_purpose == NSLocalizedString("purpose1", comment: "")
//        {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_purpose", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }
       print("purp",NSLocalizedString("purpose1", comment: ""))
        print("purpst",purposeBtn.titleLabel?.text)
        
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
         self.relationshipBtn.titleLabel?.text as! String
        str_purpose == purposeBtn.titleLabel?.text as! String
        print("purpstrr",str_purpose)
        
//        if(str_purpose == NSLocalizedString("purpose1", comment: "") || str_purpose == "")
//        {
//        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_relation", comment: ""), action: NSLocalizedString("ok", comment: ""))
//        return
//       }
        
        if purpuseclickcheckstr == "1"
       {
      
       }
        else
        {
            self.view.makeToast(NSLocalizedString("sel_purpose", comment: ""), duration: 3.0, position: .center)
        //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_purpose", comment: ""), action: NSLocalizedString("ok", comment: ""))
        return
        }
        
//        if(purposeBtn.titleLabel?.text == NSLocalizedString("purpose1", comment: ""))
//        {
//            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_purpose", comment: ""), action: NSLocalizedString("ok", comment: ""))
//            return
//        }
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
            //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_relation", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
           // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pls_agree", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
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
               print("middlenaetxtfd.text",middleNameTextField.text)
        
        //extraspace remove
        let startingStringmnamee = middleNameTextField.text!
        let processedStringmnamee = startingStringmnamee.removeExtraSpacesremac()
        print("processedString:\(processedStringmnamee)")
        middleNameTextField.text = processedStringmnamee
        
        
        
        //purpuse oftransaction alertcheck
        
    
//       if str_relation == ""
//       {
//
//       }
        
        
            self.str_first_name = firstNameTextField.text!
            self.str_last_name = lastNameTextField.text!
        self.str_middle_name = middleNameTextField.text!
        self.str_country_name = countryBtn.titleLabel?.text as! String
        self.str_bank_name = bankBtn.titleLabel?.text as! String
        self.str_branch_name = branchBtn.titleLabel?.text as! String
            self.str_address = address.text!
        // self.str_city = citytext
        
        if bankcitytypestr == "D"
        {
            self.str_city = citydropcodenew
        }
        else
        {
            self.str_city = city.text!
        }
        
        
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
        print("beneficiaryCity",self.str_city)
        print("beneficiaryFirstName",self.str_first_name)
        print("beneficiaryLastName",str_last_name)
        print("relationship",self.str_relation)
        
        self.servicetypestr = "CREDIT"
        
        UserDefaults.standard.removeObject(forKey: "servicetypestoresel")
        UserDefaults.standard.set(self.servicetypestr, forKey: "servicetypestoresel")
        
        self.str_bank_citydropcode = ""
        UserDefaults.standard.removeObject(forKey: "str_bank_citydropcode")
        UserDefaults.standard.set(self.str_bank_citydropcode, forKey: "str_bank_citydropcode")
        
        
        
        
        let rrcheck = alreadysvaedcustomerstr
        
        print("rrcheck",rrcheck)
        let a = rrcheck
        let b = "1"
        if a == b
        {
            print("saveapinotcalingalredysaved","apinotcall")
            
            
           // self.getToken(num: 4)
            //6
            
            
            serialnostored = defaults.string(forKey: "benficiaryseioalnostored")!
            print("serialnostoreddwwcredit","serialnostoredwwwcredit")
            
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
                self.defaults.set(self.str_city, forKey: "city")
                self.defaults.set(self.str_mobile, forKey: "mobile")
                self.defaults.set(self.str_acc_no, forKey: "acc_no")
                self.defaults.set(self.str_ifsc, forKey: "ifsc")
                self.defaults.set(self.str_source, forKey: "source")
                self.defaults.set(self.str_purpose, forKey: "purpose")
                self.defaults.set(self.str_relation, forKey: "relation")
                self.defaults.set(self.str_serial_no, forKey: "serial_no")
                self.defaults.set(self.str_country, forKey: "ben_country_3_letter")
                
                self.defaults.set(self.ibanstrenterd, forKey: "ibanstrenterd")

                
                
                   timer?.invalidate()
                
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem2") as! RemittancePage2ViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
                
               }
            
            else
            {
                print("apinotcalingalredysavedcredit","apinotcallqqqcredit")
                print("invalidcreit","invalidcredit")
                
                self.view.makeToast(NSLocalizedString("no_data_available", comment: ""), duration: 3.0, position: .center)
                //self.alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("no_data_available", comment: ""), action: NSLocalizedString("ok", comment: ""))
                
            }
            
            
            
        }
        else
            
        {
            
            //for otp
            self.getToken(num: 7)
            //for no otp
           // self.getToken(num: 4)
            
            timer?.invalidate()
            
        if str_branch_code == ""
            {
            UserDefaults.standard.removeObject(forKey: "BRANCHNAMENEW")
            // self.citydropname = ""
           // UserDefaults.standard.set(self.citydropname, forKey: "beneficiaryCity1")
            }
            
        }
        
        
    }
    }
    @IBAction func sourceBtn(_ sender: Any) {
        
        
        if(countryBtn.titleLabel?.text == NSLocalizedString("country", comment: ""))
           {
            self.view.makeToast(NSLocalizedString("sel_country", comment: ""), duration: 3.0, position: .center)
            
              // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
           }
            
            
        
        else
        {
            
            self.codetypestr = "SOURCE"
            
            self.getToken(num: 8)
            
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
            self.view.makeToast(NSLocalizedString("sel_country", comment: ""), duration: 3.0, position: .center)
           // self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_country", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            
            self.codetypestr = "PURPOSE"
            self.getToken(num: 9)
            
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
        // AlertView.instance.showAlert(msg: NSLocalizedString("coming_soon", comment: ""), action: .info)
        
       // self.getTokenpickup(num: 1)
        
         timer?.invalidate()
        timer = nil
        //timer.fire()
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
        self.countryBtn.setTitle(NSLocalizedString("country", comment: ""), for: .normal)
        self.countryBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
        self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        self.genderbtn.setTitle(NSLocalizedString("GENDERR", comment: ""), for: .normal)
        self.genderbtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        self.nationalitybtn.setTitle(NSLocalizedString("nationalityy", comment: ""), for: .normal)
        self.nationalitybtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        
        self.citydrop.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
        self.citydrop.setTitleColor(UIColor.lightGray, for: .normal)
        
        
        self.address.text = ""
        self.city.text = ""
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
        self.accNoTop.constant = 0
        self.ifscTop.constant = 0
        self.ibanTop.constant = 0
        self.checkTop.constant = 10
        self.sortCodeTop.constant = 0
        self.swiftCodeTop.constant = 0
        self.routingCodeTop.constant = 0
        
        
        
        
        self.str_country = ""
        self.str_bank_code = ""
        self.str_branch_code = ""
        self.str_first_name = ""
        self.str_last_name = ""
        self.str_country_name = ""
        self.str_bank_name = ""
        self.str_branch_name = ""
        self.str_address = ""
        self.str_city = ""
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
        self.ibanstrenterd = ""
    }
    
    
     //self.clearBen()
     func clearBenforcountrychange()
     {
         
        self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
         self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
         self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
         self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        self.citydrop.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
        self.citydrop.setTitleColor(UIColor.lightGray, for: .normal)
        
          self.ifscCode.text = ""
         self.str_bank_code = ""
         self.str_branch_code = ""
         self.str_country = ""
        
        self.ibanstrenterd = ""
        
        self.firstNameTextField.text = ""
        self.lastNameTextField.text = ""
        self.middleNameTextField.text = ""
        self.accountNum.text = ""
        self.city.text = ""
        self.iban.text = ""
        //iban
        //city
        //accountno
        
        self.sourceOfFundBtn.setTitle(NSLocalizedString("source1", comment: ""), for: .normal)
        self.purposeBtn.setTitle(NSLocalizedString("purpose1", comment: ""), for: .normal)
      //  self.relationshipBtn.setTitle(NSLocalizedString("relationship1", comment: ""), for: .normal)
        
        
        
     }
     
     func clearBenforbankchange()
     {
         
         self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
         self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
          self.ifscCode.text = ""
         self.str_bank_code = ""
         self.str_branch_code = ""
        self.ibanstrenterd = ""
     }
    
//    func clearBenforcountrychange() {
//        self.selectReceiverBtn.setTitle(NSLocalizedString("sel_existing_rece", comment: ""), for: .normal)
//        self.firstNameTextField.text = ""
//        self.lastNameTextField.text = ""
//        self.middleNameTextField.text = ""
//        self.nationalitybtn.setTitle("COUNTRY", for: UIControl.State.normal)
//        self.nationalitybtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.genderbtn.setTitle("GENDER", for: UIControl.State.normal)
//        self.genderbtn.setTitleColor(UIColor.lightGray, for: .normal)
//        // self.countryBtn.setTitle(NSLocalizedString("country", comment: ""), for: .normal)
//        // self.countryBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
//        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.branchBtn.setTitle(NSLocalizedString("branch_name1", comment: ""), for: .normal)
//        self.branchBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        self.address.text = ""
//        self.city.text = ""
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
//        self.accNoTop.constant = 0
//        self.ifscTop.constant = 0
//        self.ibanTop.constant = 0
//        self.checkTop.constant = 10
//        self.sortCodeTop.constant = 0
//        self.swiftCodeTop.constant = 0
//        self.routingCodeTop.constant = 0
//
//
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
//        self.str_city = ""
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
    
    //cashpickupaction
    func validateRemittanceStatus(check:Int,accessToken:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
              print("appVersion",appVersion)
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"1.11","customerPhone":"IOS","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"ISREMITALLOWED","isExistOrValid":"0"]
        
        
        
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
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"1.11","customerPhone":"IOS","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"ISREMITALLOWED","isExistOrValid":"0"]
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
        self.olduserchkstr = "0"
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
                    self.getSource(access_token: token)
                }
                else if(num == 9)
                    {
                        self.getPurpose(access_token: token)
                    }
                else if(num == 10)
                    {
                        self.getCitynewapi(access_token: token)
                    }
                else if(num == 11)
                    {
                    self.updateBeneficiary(access_token: token)
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
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerUserID":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"mpin":defaults.string(forKey: "PIN")!,"serviceType":"CREDIT"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            let resultArray = myResult!["benelist"]
            print("resp",resultArray)
            for i in resultArray.arrayValue{
                let beneficiary = Beneficiary(beneficiaryNickName: i["beneficiaryNickName"].stringValue, beneficiarySerialNo: i["beneficiarySerialNo"].stringValue, beneficiaryBankName: i["beneficiaryBankName"].stringValue, beneficiaryAccountNo: i["beneficiaryAccountNo"].stringValue, beneficiaryAccountType: i["beneficiaryAccountType"].stringValue, beneficiaryBankCountryName: i["beneficiaryBankCountryName"].stringValue, beneficiaryAccountName: i["beneficiaryAccountName"].stringValue, beneficiaryIfscCode: i["beneficiaryIfscCode"].stringValue, beneficiaryBankBranchName: i["beneficiaryBankBranchName"].stringValue, beneficiaryBankCountryCode: i["beneficiaryBankCountryCode"].stringValue, beneficiaryMobile: i["beneficiaryMobile"].stringValue, beneficiaryEmail: i["beneficiaryEmail"].stringValue, beneficiaryCity: i["beneficiaryCity"].stringValue, beneficiaryAddress: i["beneficiaryAddress"].stringValue, beneficiaryIBAN: i["beneficiaryIBAN"].stringValue)
                self.beneficiaryList.append(beneficiary)
                self.tblBeneficiary.reloadData()
            }
            
        })
        
       // self.resetTimer()
    }
    func saveBeneficiary(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        
        
        print("middleee",str_middle_name)
        print("genderr",self.str_gender_name)
        print("nationaltyy",self.str_countrynationality)
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


        
       // if bankcitytypestr == "T"
        //{}
        
        
        
        let url = ge_api_url + "beneficiary/savebeneficiary"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO"),"customerIDNo":defaults.string(forKey: "USERID"),"beneficiaryAccountName":fullnamestr,"beneficiaryNickName":"","beneficiaryAccountNumber":self.str_acc_no,"beneficiaryBankName":self.str_bank_code,"beneficiaryIFSCCode":self.str_ifsc,"beneficiaryBankBranchName":self.str_branch_code,"beneficiaryAccountType":"SAVINGS","serviceType":"CREDIT","beneficiaryGender": str_gender,"beneficiaryNationality": self.str_countrynationality,"beneficiaryBankCountryCode":self.str_country,"beneficiaryMobile":self.str_mobile,"beneficiaryEmail":"","beneficiaryAddress":self.str_address,"beneficiaryCity":self.str_city,"beneficiaryIBAN":self.ibanstrenterd,"beneficiarySwiftCode":"","beneficiarySortCode":"","beneficiaryRoutingCode":"","beneficiaryFirstName":self.str_first_name,"beneficiaryMiddleName":self.str_middle_name,"beneficiaryLastName":str_last_name,"deviceType":"IOS","versionName":appVersion,"relationship":self.str_relation,"action":""]
        
        //,"serviceType":"CREDIT","beneficiaryMiddleName": "kl","beneficiaryGender": "male","beneficiaryNationality": "ZMB"
        print("urlbeneficiary/savebeneficiary",url)
        print("urlbeneficiary/savebeneficiaryparams",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            
            let respCode = myResult!["responseCode"]
            print("resp",respCode)
            print("response svavebenif",response)
            self.effectView.removeFromSuperview()
            
            
            
            if respCode == "S105"
            {
                
                
                UserDefaults.standard.removeObject(forKey: "benficiaryseioalnostored")
                self.str_benificiaryserialnostr = myResult!["generatedSerialNo"].stringValue
                UserDefaults.standard.set(self.str_benificiaryserialnostr, forKey: "benficiaryseioalnostored")
                //let generatedSerialNoCode = myResult!["generatedSerialNo"].stringValue
            }
            
            if self.str_branch_code == "" ||  self.str_branch_code.isEmpty
           {
            UserDefaults.standard.removeObject(forKey: "branch_code")
           }
            if self.str_bank_name == "" ||  self.str_bank_name.isEmpty
            {
            UserDefaults.standard.removeObject(forKey: "branch_name")
            }
            
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
                            self.defaults.set(self.str_city, forKey: "city")
                            self.defaults.set(self.str_mobile, forKey: "mobile")
                            self.defaults.set(self.str_acc_no, forKey: "acc_no")
                            self.defaults.set(self.str_ifsc, forKey: "ifsc")
                            self.defaults.set(self.str_source, forKey: "source")
                            self.defaults.set(self.str_purpose, forKey: "purpose")
                            self.defaults.set(self.str_relation, forKey: "relation")
                            self.defaults.set(self.str_serial_no, forKey: "serial_no")
                            self.defaults.set(self.str_country, forKey: "ben_country_3_letter")
                            
                            self.defaults.set(self.ibanstrenterd, forKey: "ibanstrenterd")
                
                            
                
                self.middlenamestrstored = self.str_middle_name
                print("middlenamestrstoredcredit ",self.middlenamestrstored)
                print("str_middle_namecredit ",self.str_middle_name)
                
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
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"beneficiaryAccountName":"","beneficiaryNickName":"","beneficiaryAccountNumber":self.str_acc_no,"beneficiaryBankName":"","beneficiaryIFSCCode":"","beneficiaryBankBranchName":"","beneficiaryAccountType":"","beneficiaryBankCountryCode":"","beneficiaryMobile":"","beneficiaryEmail":"","beneficiaryAddress":"","beneficiaryCity":"","beneficiaryIBAN":"","beneficiarySwiftCode":"","beneficiarySortCode":"","beneficiaryRoutingCode":"","beneficiaryFirstName":"","beneficiaryMiddleName":"","beneficiaryLastName":"","relationship":"","serviceType":"CREDIT","beneficiarySerialNo":self.str_serial_no,"action":"DELETE"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        //beneficiarySerialNo
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
    
    func updateBeneficiary(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "beneficiary/savebeneficiary"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"beneficiaryAccountName":"","beneficiaryNickName":"","beneficiaryAccountNumber":self.str_acc_no,"beneficiaryBankName":"","beneficiaryIFSCCode":"","beneficiaryBankBranchName":"","beneficiaryAccountType":"","beneficiaryBankCountryCode":"","beneficiaryMobile":"","beneficiaryEmail":"","beneficiaryAddress":"","beneficiaryCity":"","beneficiaryIBAN":"","beneficiarySwiftCode":"","beneficiarySortCode":"","beneficiaryRoutingCode":"","beneficiaryFirstName":"","beneficiaryMiddleName":"","beneficiaryLastName":"","relationship":"","serviceType":"CREDIT","beneficiarySerialNo":self.str_serial_no,"action":"UPDATE","beneficiaryGender": str_gender,"beneficiaryNationality": self.str_countrynationality]
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        //beneficiarySerialNo
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(respCode == "S2001")
            {
                //self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("ben_deleted", comment: ""), action: NSLocalizedString("ok", comment: ""))
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                
                self.getToken(num: 1)
                self.clearBen()
                self.scrollView.setContentOffset(.zero, animated: true)
                self.saveBtn.setTitle(NSLocalizedString("save_next", comment: ""), for: .normal)
            }
            
            else
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                self.getToken(num: 1)
                self.clearBen()
                self.scrollView.setContentOffset(.zero, animated: true)
               // self.saveBtn.setTitle(NSLocalizedString("save_next", comment: ""), for: .normal)
            }
            
        })
    }
    
    
    
    
    
    func viewBeneficiary(access_token:String,serial_no:String,accountNo:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "beneficiary/viewbeneficiary"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"password":defaults.string(forKey: "PASSW")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerRegNo":defaults.string(forKey: "REGNO")!,"mpin":defaults.string(forKey: "PIN")!,"beneficiarySerialNo":serial_no,"beneficiaryAccountNumber":accountNo,"serviceType":"CREDIT"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { [self] (response) in
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
                self.bankBtn.setTitle("\(myResult!["beneficiaryBankName1"].stringValue)", for: .normal)
                self.bankBtn.setTitleColor(UIColor.black, for: .normal)
                self.str_bank_code = myResult!["beneficiaryBankName"].stringValue
                self.branchBtn.setTitle("\(myResult!["beneficiaryBankBranchName1"].stringValue)", for: .normal)
                self.branchBtn.setTitleColor(UIColor.black, for: .normal)
                self.str_branch_code = myResult!["beneficiaryBankBranchName"].stringValue
                self.address.text = myResult!["beneficiaryAddress"].stringValue
                self.city.text = myResult!["beneficiaryCity"].stringValue
                self.mobileNumber.text = myResult!["beneficiaryMobile"].stringValue
                print("country... ",myResult!["countryName"].stringValue)
                self.middleNameTextField.text = myResult!["beneficiaryMiddleName"].stringValue
                self.genderbtn.setTitle("\(myResult!["beneficiaryGender"].stringValue)", for: .normal)
                self.genderbtn.setTitleColor(UIColor.black, for: .normal)
                self.nationalitybtn.setTitle("\(myResult!["beneficiaryNationality1"].stringValue)", for: .normal)
                self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                
                //
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
                //self.middlenamestrstored = myResult!["beneficiaryMiddleName"].stringValue
                
           
                //
                
                
                //self.cashPickupBtn.setTitle("\(myResult!["serviceType"].stringValue)", for: .normal)
                self.iban.text = myResult!["beneficiaryIBAN"].stringValue
                
                UserDefaults.standard.removeObject(forKey: "ibanstrenterd")
                self.ibanstrenterd = myResult!["beneficiaryIBAN"].stringValue
                //UserDefaults.standard.set(self.ibanstrenterdstored, forKey: "ibanstrenterd")
                self.defaults.set(self.ibanstrenterd, forKey: "ibanstrenterd")
                
                print("ibanviewbenstore",self.ibanstrenterdstored)
                
                self.BRANCHNAMENEW = myResult!["beneficiaryBankBranchName1"].stringValue
                
                
                UserDefaults.standard.removeObject(forKey: "BRANCHNAMENEW")
                self.BRANCHNAMENEW = myResult!["beneficiaryBankBranchName1"].stringValue
                UserDefaults.standard.set(self.BRANCHNAMENEW, forKey: "BRANCHNAMENEW")
                
                //
                self.CITYNAMENEW = myResult!["beneficiaryCity1"].stringValue
                
                UserDefaults.standard.removeObject(forKey: "CITYNAMENEW")
                self.CITYNAMENEW = myResult!["beneficiaryCity1"].stringValue
                UserDefaults.standard.set(self.CITYNAMENEW, forKey: "CITYNAMENEW")
                
                
                UserDefaults.standard.removeObject(forKey: "benficiaryseioalnostored")
                self.str_benificiaryserialnostr = myResult!["beneficiarySerialNo"].stringValue
                UserDefaults.standard.set(self.str_benificiaryserialnostr, forKey: "benficiaryseioalnostored")
                print("benficiaryseioalnostoredprint:\(self.str_benificiaryserialnostr)")
                
                
                
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
                //let servicetype = myResult!["serviceType"].stringValue
                 self.servicetypeviewben = myResult!["serviceType"].stringValue
                UserDefaults.standard.set(self.servicetypeviewben, forKey: "servicetypestoresel")
                
                //str_bank_citydropcode
                UserDefaults.standard.removeObject(forKey: "str_bank_citydropcode")
                self.str_bank_citydropcodeviewben = myResult!["beneficiaryCity"].stringValue
                UserDefaults.standard.set(self.str_bank_citydropcodeviewben, forKey: "str_bank_citydropcode")
                
                
                //removinghere cashpickup vale
                UserDefaults.standard.removeObject(forKey: "beneficiaryCity1")
                
                
                if(myResult!["countryName"].stringValue == "India")
                {
                    print("asdf22222")
                    self.accountNum.isHidden = false
                    self.ifscCode.isHidden = false
                    self.accNoTop.constant = 10
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
                    self.accNoTop.constant = 10
                    self.ifscTop.constant = 0
                    self.ibanTop.constant = 0
                    self.checkTop.constant = 10
                    self.sortCodeTop.constant = 0
                    self.swiftCodeTop.constant = 0
                    self.routingCodeTop.constant = 0
                    self.accountNum.text = myResult!["beneficiaryAccountNumber"].stringValue
                }
                
                self.olduserchkstr = "0"
                self.saveBtn.setTitle(NSLocalizedString("save_next", comment: ""), for: .normal)
                
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
                
                
                if myResult!["beneficiaryMiddleName"].stringValue.isEmpty
                {
                    print("printy",myResult!["beneficiaryMiddleName"].stringValue)
                    self.middleNameTextField.isHidden = true
                    self.middlenameconstrainttop.constant = 0
                    self.middlenamehieghtconstrain.constant = 0
                    
                    self.middlenameclickcheckstr = "0"
                }
                else
                {
                    self.middleNameTextField.isHidden = false
                    self.middlenameconstrainttop.constant = 10
                    self.middlenamehieghtconstrain.constant = 40
                    
                    self.middlenameclickcheckstr = "0"
                }
                
                
                if myResult!["beneficiaryLastName"].stringValue.isEmpty
                {
                    print("printy",myResult!["beneficiaryLastName"].stringValue)
                    self.lastNameTextField.isHidden = true
                    self.lastnameconstrainttop.constant = 0
                    self.lastnameheightconstraint.constant = 0
                }
                else
                {
                    self.lastNameTextField.isHidden = false
                    self.lastnameconstrainttop.constant = 10
                    self.lastnameheightconstraint.constant = 40
                }
                
                //                    if  myResult!["beneficiaryMiddleName"].stringValue.isEmpty
                //                    {
                //                    print("printy",myResult!["beneficiaryMiddleName"].stringValue)
                //                          self.middleNameTextField.isHidden = true
                //                        self.middlenamehieghtconstrain.constant = 0
                //                    }
                //                    else
                //                    {
                //                        self.middleNameTextField.isHidden = false
                //                        self.middlenamehieghtconstrain.constant = 40
                //                    }
                
                if myResult!["beneficiaryGender"].stringValue.isEmpty
                {
                    print("printy",myResult!["beneficiaryGender"].stringValue)
                    
                    self.genderbtn.isHidden = true
                    self.genderbtnconstrainttop.constant = 0
                    self.genderbtnhiehtconstraint.constant = 0
                    
//                    self.genderbtn.isHidden = false
//                    self.genderbtnconstrainttop.constant = 10
//                    self.genderbtnhiehtconstraint.constant = 40
//                    nationalitybtn.isEnabled = true
//                    genderbtn.isEnabled = true
                }
                else
                {
                   
                    
                    self.genderbtn.isHidden = false
                    self.genderbtnconstrainttop.constant = 10
                    self.genderbtnhiehtconstraint.constant = 40
                    
                    //                    self.genderbtn.isHidden = true
                    //                    self.genderbtnconstrainttop.constant = 0
                    //                    self.genderbtnhiehtconstraint.constant = 0
                    
                }
                
                
                if myResult!["beneficiaryNationality1"].stringValue.isEmpty
                {
                    self.nationalitybtn.isHidden = true
                    self.nationalitybtnconstrainttop.constant = 0
                    self.nationalitybtnhieghtconstraint.constant = 0
                    
                    
                }
                else
                {
                   
                    
                    self.nationalitybtn.isHidden = false
                    self.nationalitybtnconstrainttop.constant = 10
                    self.nationalitybtnhieghtconstraint.constant = 40
                    
                    //                    self.nationalitybtn.isHidden = true
                    //                    self.nationalitybtnconstrainttop.constant = 0
                    //                    self.nationalitybtnhieghtconstraint.constant = 0
                    
                }
                
                if myResult!["beneficiaryGender"].stringValue.isEmpty && myResult!["beneficiaryNationality1"].stringValue.isEmpty
                {
                    
                    self.olduserchkstr = "1"
                    
                    self.genderbtn.isHidden = false
                    self.genderbtnconstrainttop.constant = 10
                    self.genderbtnhiehtconstraint.constant = 40
                    
                    
                    
                    self.nationalitybtn.isHidden = false
                    self.nationalitybtnconstrainttop.constant = 10
                    self.nationalitybtnhieghtconstraint.constant = 40
                    
                    
                    nationalitybtn.isEnabled = true
                    genderbtn.isEnabled = true
                    
                    self.genderbtn.setTitle(NSLocalizedString("GENDERR", comment: ""), for: .normal)
                    self.genderbtn.setTitleColor(UIColor.lightGray, for: .normal)
                    
                    self.nationalitybtn.setTitle(NSLocalizedString("nationalityy", comment: ""), for: .normal)
                    self.nationalitybtn.setTitleColor(UIColor.lightGray, for: .normal)
                    
                    
                    self.saveBtn.setTitle(NSLocalizedString("update", comment: ""), for: .normal)
                    
                }
                
                
                if myResult!["beneficiaryBankName1"].stringValue.isEmpty
                {
                    print("printy",myResult!["beneficiaryBankName1"].stringValue)
                    //                        self.bankBtn.isHidden = true
                    //                        self.bankbtnslakviewconstrainttop.constant = 0
                    //                        self.bankntnheightconstraint.constant = 0
                    //
                    
                    self.bankBtn.isHidden = false
                    self.bankbtnslakviewconstrainttop.constant = 10
                    self.bankntnheightconstraint.constant = 40
                    self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
                    self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
                    
                }
                else
                {
                    self.bankBtn.isHidden = false
                    self.bankbtnslakviewconstrainttop.constant = 10
                    self.bankntnheightconstraint.constant = 40
                }
                if myResult!["beneficiaryBankBranchName1"].stringValue.isEmpty
                {
                    self.branchBtn.isHidden = true
                    self.branchbtnslakviiewconstrainttop.constant = 0
                    self.branchbtnheightconstaint.constant = 0
                    
                    UserDefaults.standard.removeObject(forKey: "str_branch_code")
                    //BRANCHNAMEREMOVE HERE
                    UserDefaults.standard.removeObject(forKey: "BRANCHNAMENEW")
                    
                }
                else
                {
                    self.branchBtn.isHidden = false
                    self.branchbtnslakviiewconstrainttop.constant = 10
                    self.branchbtnheightconstaint.constant = 40
                }
                
                if myResult!["beneficiaryAddress"].stringValue.isEmpty
                {
                    self.address.isHidden = true
                    self.addressconstrainttop.constant = 0
                    self.addressheightconstraint.constant = 0
                }
                else
                {
                    self.address.isHidden = false
                    self.addressconstrainttop.constant = 10
                    self.addressheightconstraint.constant = 40
                }
                if myResult!["beneficiaryMobile"].stringValue.isEmpty
                {
                    self.mobileNumber.isHidden = true
                    self.mobileconstrainttop.constant = 0
                    self.mobileheightconstraint.constant = 0
                }
                else
                {
                    self.mobileNumber.isHidden = false
                    self.mobileconstrainttop.constant = 10
                    self.mobileheightconstraint.constant = 40
                }
                
                if myResult!["beneficiaryCity1"].stringValue.isEmpty
                {
                    self.city.isHidden = true
                    self.cityconstrainttop.constant = 0
                    self.cityhieghtconstraint.constant = 0
                    
                UserDefaults.standard.removeObject(forKey: "city")
                }
                else
                {
                    self.city.isHidden = false
                    self.cityconstrainttop.constant = 10
                    self.cityhieghtconstraint.constant = 40
                    
                    
                    self.cityzero = myResult!["beneficiaryCity"].stringValue
                    if self.cityzero == "0"
                    {
                        UserDefaults.standard.removeObject(forKey: "city")
                    }
                    else
                    {
                        
                    }
                    
                    
                }
                
                // let ibansstr:String = myResult!["beneficiaryIBAN"].string!
                //|| ibansstr == "0"
            if myResult!["beneficiaryIBAN"].stringValue.isEmpty
                {
                    self.ibanglobstrcheckappearstr = "0"
                    self.iban.isHidden = true
                    self.ibanTop.constant = 0
                    
                    self.ibanstrenterd = ""
                    UserDefaults.standard.removeObject(forKey: "ibanstrenterd")
                    
                }
                else
                {
                    self.ibanglobstrcheckappearstr = "1"
                    self.iban.isHidden = false
                    self.ibanTop.constant = 10
                    
//                    ibanstrenterd
//                    ibanzero
                    
                }
                
                if myResult!["beneficiaryAccountNumber"].stringValue.isEmpty
                {
                    self.accountnoglobstrcheckappearstr = "0"
                    self.accountnboalertstrcheck = "1"
                    
                    self.accountNum.isHidden = true
                    self.accNoTop.constant = 0
                    
                    
                }
                else
                {
                    self.accountnboalertstrcheck = "0"
                    self.accountnoglobstrcheckappearstr = "1"
                    self.accountNum.isHidden = false
                    self.accNoTop.constant = 10
                    
                }
                
                
                
                self.citydrop.isHidden = true
                
                
                
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
                
                self.relationshipBtn.setTitleColor(UIColor.black, for: .normal)
                
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
        self.bankBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
        print("code",str_country)
        print("code1",self.searchBank.text!)
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/getbanks"
        let params:Parameters =  ["receiveContry":str_country,"searchText":searchText,"serviceType": "CREDIT","sendCountryCode":"QAT"]
        
        
        print("urlbank",url)
        print("paramsbank",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            for i in resultArray.arrayValue{
                let bank = Bank(bankAddress: i["requiredBranch"].stringValue, bankCode: i["bankCode"].stringValue, bankName: i["bankName"].stringValue, bankcitytype: i["cityType"].stringValue,Accountnolength: i["accountNumberLength"].stringValue,Mobnolength: i["recMobLength"].stringValue,ifscnolength: i["ifscLength"].stringValue,Minaccnolength: i["minAccountNumberLength"].stringValue)
                self.bankArray.append(bank)
                
                self.checkarrayaoccubank.append(i["bankName"].stringValue)
                self.checkarrayaoccubankstr.append(i["bankCode"].stringValue)
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
        let params:Parameters =  ["receiveContry":str_country,"bankCode":bankCode,"searchText":searchText,"serviceType":"CREDIT","cityCode":""]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerUserID":defaults.string(forKey: "USERID")!,"serviceType":"CREDIT"]
        
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
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerUserID":defaults.string(forKey: "USERID")!,"serviceType":"CREDIT","countryCode":keyword]
        
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
                let bankNamestr:String = myResult!["bankName"].string!
                let branchNamestr:String = myResult!["branchName"].string!
                let citystr:String = myResult!["city"].string!
                
                
                if firstnamestr == "1"
                {
                    print("firstnamestrequal1",firstnamestr)
                    
                    self.firstNameTextField.isHidden = false
                    self.firstnameheightconsraint.constant = 40
                    
                }
                else
                {
                    self.firstNameTextField.isHidden = true
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
                    self.genderbtnconstrainttop.constant = 10
                    self.genderbtnhiehtconstraint.constant = 40
                }
                else
                {
                    self.genderbtn.isHidden = true
                    self.genderbtnconstrainttop.constant = 0
                    self.genderbtnhiehtconstraint.constant = 0
                }
                
                if nationalitystr == "1"
                {
                    print("nationalitystr",nationalitystr)
                    self.nationalitybtn.isHidden = false
                    self.nationalitybtnconstrainttop.constant = 10
                    self.nationalitybtnhieghtconstraint.constant = 40
                    
                }
                else
                {
                    self.nationalitybtn.isHidden = true
                    self.nationalitybtnconstrainttop.constant = 0
                    self.nationalitybtnhieghtconstraint.constant = 0
                }
                
                
                if addressstr == "1"
                {
                    print("addressstr",addressstr)
                    self.address.isHidden = false
                    self.addressconstrainttop.constant = 10
                    self.addressheightconstraint.constant = 40
                }
                else
                {
                    self.address.isHidden = true
                    self.addressconstrainttop.constant = 0
                    self.addressheightconstraint.constant = 0
                }
                
                if mobileNostr == "1"
                {
                    print("mobileNostr",mobileNostr)
                    self.mobileNumber.isHidden = false
                    self.mobileconstrainttop.constant = 10
                    self.mobileheightconstraint.constant = 40
                }
                else
                {
                    self.mobileNumber.isHidden = true
                    self.mobileconstrainttop.constant = 0
                    self.mobileheightconstraint.constant = 0
                }
                
                if accountNostr == "1"
                {
                    print("accountNostr",accountNostr)
                    self.accountnboalertstrcheck = "0"
                    
                    self.accountNum.isHidden = false
                    
                    self.accNoTop.constant = 10
                    // self.ifscTop.constant = 10
                    self.iban.isHidden = true
                    self.ibanTop.constant = 0
                    
                    self.accountnoclickcheckstr = "1"
                    
                }
                    
                else
                {
                    self.accountnboalertstrcheck = "1"
                    self.accountNum.isHidden = true
                    self.accNoTop.constant = 0
                    //self.ifscTop.constant = 10
                    self.accountnoclickcheckstr = "0"
                }
                
                if ibanNostr == "1"
                {
                    self.ibanglobstrcheckappearstr = "1"
                    print("ibanNostr",ibanNostr)
                    self.iban.isHidden = false
                    self.ibanTop.constant = 10
                    
                    self.ibanclickcheckstr = "1"
                }
                else
                {
                    self.ibanglobstrcheckappearstr = "0"
                    self.iban.isHidden = true
                    self.ibanTop.constant = 0
                    
                    self.ibanclickcheckstr = "0"
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
                    self.bankbtnslakviewconstrainttop.constant = 10
                    self.bankntnheightconstraint.constant = 40
                }
                else
                {
                    self.bankBtn.isHidden = true
                    self.bankbtnslakviewconstrainttop.constant = 0
                    self.bankntnheightconstraint.constant = 0
                }
                
                
                
                if branchNamestr == "1"
                {
                    print("branchNamestr",branchNamestr)
                    //                    self.branchBtn.isHidden = false
                    //                    self.branchbtnslakviiewconstrainttop.constant = 10
                    //                    self.branchbtnheightconstaint.constant = 40
                    //
                    
                    
                }
                else
                {
                    //                    self.branchBtn.isHidden = true
                    //                    self.branchbtnslakviiewconstrainttop.constant = 0
                    //                    self.branchbtnheightconstaint.constant = 0
                }
                
                
                
                if citystr == "1"
                {
                    print("citystr",citystr)
                    // self.city.isHidden = false
                    //self.cityhieghtconstraint.constant = 40
                }
                    
                else
                {
                    //   self.city.isHidden = true
                    //  self.cityhieghtconstraint.constant = 0
                }
                
                
                
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
         let params:Parameters =  ["codeType":self.codetypestr,"serivceType": "CREDIT","receiveCountry":self.str_country]
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
          let params:Parameters =  ["codeType":self.codetypestr,"serivceType": "CREDIT","receiveCountry":self.str_country]
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
    
    
    
    
//
//    func getPurpose(country:String) {
//        self.activityIndicator(NSLocalizedString("loading", comment: ""))
//        self.purposeBtn.titleLabel?.text = NSLocalizedString("purpose1", comment: "")
//        self.purposeeArray.removeAll()
//        self.tblPurpose.reloadData()
//        let url = api_url + "purpose_new"
//        let params:Parameters = ["country":country]
//
//
//       // let url = ge_api_url + "shiftservice/showDescription"
//        //let params:Parameters =  ["codeType":self.codetypestr,"serviceType": "CREDIT","receiveCountry":self.str_country]
//         print("urlparams",url)
//         print("paramsparams",params)
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
    
    
    
    func getCitynewapi(access_token:String) {
        self.countryArray.removeAll()
        self.countryArraySearch.removeAll()
        self.tblCountry.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
      //  let url = api_url + "nationalities_listing"
       // let params:Parameters = ["lang":"en","keyword":keyword]
        
        let url = ge_api_url + "shiftservice/getCountryCities"
        let params:Parameters =  ["countryCode":self.str_country,"serviceType":"CREDIT"]
        print("citynewrurl",url)
        print("citynewrparams",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
               // let resultArray = myResult!["nationalities_listing"]
                
                let resultArray = myResult![]
               // self.nationalityFlagPath = myResult!["file_path"].stringValue
                for i in resultArray.arrayValue{
                    let nationality = Country(id: i["id"].stringValue, num_code: i["cityCode"].stringValue, alpha_2_code: i["cityCode"].stringValue, alpha_3_code: i["currencyCode"].stringValue, en_short_name: i["cityEnglishName"].stringValue, nationality: i["cityEnglishName"].stringValue)
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
    
    
    func getBankcitydrop(access_token:String) {
        let searchText = self.searchBank.text!.uppercased()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.CityArray.removeAll()
        self.tblCountry.reloadData()
       // self.bankBtn.setTitle(NSLocalizedString("city1", comment: ""), for: .normal)
       // self.bankBtn.setTitleColor(UIColor.lightGray, for: .normal)
        print("code",str_country)
        print("code1",self.searchBank.text!)
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "shiftservice/getCountryCities"
        let params:Parameters =  ["countryCode":self.str_country,"serviceType":self.servicetypestr]
        
        print("urlbanklist",url)
        print("paramsbanklist",params)
        
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            for i in resultArray.arrayValue{
                let city = City(ge_city_name: i["cityEnglishName"].stringValue, id: i["cityCode"].stringValue)
                self.CityArray.append(city)
            }
            self.tblCountry.reloadData()
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
        self.accNoTop.constant = 0
        self.ifscTop.constant = 0
        self.ibanTop.constant = 0
        self.checkTop.constant = 10
        self.sortCodeTop.constant = 0
        self.swiftCodeTop.constant = 0
        self.routingCodeTop.constant = 0
        
        
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
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
              
            return searchedArraybank.count
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
            
            if citydropriaselstr == "citydropriaselstr"
            {
                if(self.countrySearchFlag == 0)
                {
                    let country = countryArray[indexPath.row]
                    cell.countryLbl.text = country.en_short_name
                    let code:String = country.alpha_2_code.lowercased()
                    let url = nationalityFlagPath + code + ".png"
                   // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                   // cell.flagImg.kf.setImage(with: imgResource)
                    
                    cell.flagImg.isHidden = true
                    return cell
                }
                else{
                    let country = countryArraySearch[indexPath.row]
                    cell.countryLbl.text = country.en_short_name
                    let code:String = country.alpha_2_code.lowercased()
                    let url = nationalityFlagPath + code + ".png"
                   // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                    //cell.flagImg.kf.setImage(with: imgResource)
                    cell.flagImg.isHidden = true
                    return cell
                }
                
            }
            else
            {
                
                
                if countryselserchstr == "searchcliked"
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
                    
                    //for code getting
                    
                    
                    
                    ////
                   
                    cell.countryLbl.text = searchedArraycountry[indexPath.row]
                    //let code:String = country.alpha_2_code.lowercased()
                    let url = nationalityFlagPath + "code" + ".png"
                    //let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
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
                  //  let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
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
                   // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                    let imgResource = URL(string: url)
                    cell.flagImg.kf.setImage(with: imgResource)
                    cell.flagImg.isHidden = false

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
                    cell.flagImg.isHidden = false

                    return cell
                }
                
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
                city.isUserInteractionEnabled = true
                address.isUserInteractionEnabled = true
                bankBtn.isEnabled = true
                countryBtn.isEnabled = true
                branchBtn.isEnabled = true
                ifscCode.isUserInteractionEnabled = true
                accountNum.isUserInteractionEnabled = true
                middleNameTextField.isUserInteractionEnabled = true
                nationalitybtn.isEnabled = true
                genderbtn.isEnabled = true
                iban.isUserInteractionEnabled = true
                
                alreadysvaedcustomerstr = "0"
                
                genderclickcheckstr = "0"
                nationalityclickcheckstr = "0"
                
                self.olduserchkstr = "0"
                self.saveBtn.setTitle(NSLocalizedString("save_next", comment: ""), for: .normal)
                
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
                city.isUserInteractionEnabled = false
                address.isUserInteractionEnabled = false
                bankBtn.isEnabled = false
                countryBtn.isEnabled = false
                branchBtn.isEnabled = false
                ifscCode.isUserInteractionEnabled = false
                accountNum.isUserInteractionEnabled = false
                middleNameTextField.isUserInteractionEnabled = false
                nationalitybtn.isEnabled = false
                genderbtn.isEnabled = false
                iban.isUserInteractionEnabled = false
                
                
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
                    nationalityclickcheckstr = "1"
                    
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
                    
                    
                    
                    
                    
                    
                    print("str_countrynationalityfinaly",str_countrynationality)
                    countryView.isHidden = true
                    benView.isHidden = false
                    //  self.getPurpose(country: str_country)
                    // self.setAccountDetails(country: nat.en_short_name)
                    
                    // self.getCountrynewshowconfigapi(keyword:nat.alpha_3_code)
                    
                    if(nat.en_short_name != "India")
                    {
                        self.str_ifsc = ""
                    }
                }
                else{
                    
                    nationalityclickcheckstr = "1"
                    let nat = countryArraySearch[indexPath.row]
                   // self.nationalitybtn.setTitle("\(str)", for: .normal)
                    //self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                    // self.str_country = nat.alpha_3_code
                   // self.str_countrynationality = nat.alpha_3_code
                    
                    
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

                    print("str_countrynationalityfinalyyy",str_countrynationality)
                    countryView.isHidden = true
                    benView.isHidden = false
                    //  self.getPurpose(country: str_country)
                    //self.setAccountDetails(country: nat.en_short_name)
                    self.str_country_2_code = nat.alpha_2_code
                    // self.getCountrynewshowconfigapi(keyword:nat.alpha_3_code)
                    
                    if(nat.en_short_name != "India")
                    {
                        self.str_ifsc = ""
                    }
                }
                let bottomOffset = CGPoint(x: 0, y: 270)
                scrollView.setContentOffset(bottomOffset, animated: true)
            }
            
            if citydropriaselstr == "citydropriaselstr"
            {
                let str: String = cell.countryLbl.text!
                if(self.countrySearchFlag == 0)
                {
                    //nationalityclickcheckstr = "1"
                    
                    let nat = countryArray[indexPath.row]
                   // city.text = str
                    self.citydrop.setTitle("\(str)", for: .normal)
                    self.citydrop.setTitleColor(UIColor.black, for: .normal)
                    //self.nationalitybtn.setTitleColor(UIColor.black, for: .normal)
                    // self.str_country = nat.alpha_3_code
                    //self.str_countrynationality = nat.alpha_3_code
                    countryView.isHidden = true
                    benView.isHidden = false
                    //  self.getPurpose(country: str_country)
                    // self.setAccountDetails(country: nat.en_short_name)
                    self.citydropcodenew = nat.alpha_2_code
                    // self.getCountrynewshowconfigapi(keyword:nat.alpha_3_code)
                    print("citydropcodenew",citydropcodenew)
                
                }
                else{
                    
                   // nationalityclickcheckstr = "1"
                    let nat = countryArraySearch[indexPath.row]
                    //city.text = str
                    self.citydrop.setTitle("\(str)", for: .normal)
                    self.citydrop.setTitleColor(UIColor.black, for: .normal)
                    
                    // self.str_country = nat.alpha_3_code
                    countryView.isHidden = true
                    benView.isHidden = false
                    //  self.getPurpose(country: str_country)
                    //self.setAccountDetails(country: nat.en_short_name)
                    self.citydropcodenew = nat.alpha_2_code
                    print("citydropcodenew",citydropcodenew)
                    // self.getCountrynewshowconfigapi(keyword:nat.alpha_3_code)
                    
                }
                
            }
            
            
        }
        else if(tableView == tblPurpose)
        {
            let cell: LabelTableViewCell = self.tblPurpose.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            purposeBtn.setTitle("\(str)", for: .normal)
            str_purpose = str
            purpuseclickcheckstr = "1"
            animatePurpose(toogle: false)
            self.purposeBtn.setTitleColor(UIColor.black, for: .normal)
        }
        else if(tableView == tblBank)
        {
            
           
            
            let cell: LabelTableViewCell = self.tblBank.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            let bank = bankArray[indexPath.row]
//            self.str_bank_code = bank.bankCode
//            self.bankBtn.setTitle("\(str)", for: .normal)
//            self.bankBtn.setTitleColor(UIColor.black, for: .normal)
            self.benView.isHidden = false
            self.bankView.isHidden = true
                
            if bankselserchstr == "searchcliked"
            {
                let cell: LabelTableViewCell = self.tblBank.cellForRow(at: indexPath) as! LabelTableViewCell
                
                
                teststrclsbank = searchedArraybank[indexPath.row]
                                print("selectednamesearch",teststrclsbank)
                
                
                
                
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
                self.bankBtn.setTitle("\(teststrclsbank)", for: .normal)
                self.bankBtn.setTitleColor(UIColor.black, for: .normal)

                
              //last
                bankselserchstr = ""
            }
            else
            {
                UserDefaults.standard.removeObject(forKey: "str_bank_codeserviceprovidercode")
                self.str_bank_code = bank.bankCode
                self.bankBtn.setTitle("\(str)", for: .normal)
                self.bankBtn.setTitleColor(UIColor.black, for: .normal)

            }
                
                
            
            bankbranschshow = bank.bankAddress
            bankcitytypestr = bank.bankcitytype
            Accountnolengthstr = bank.Accountnolength
            minAccountnolengthstr = bank.Minaccnolength
            ifscnolengthstr = bank.ifscnolength
            
            print("bankbranschshowtext1",self.bankbranschshow)
            print("bankcitytypestrtext1",self.bankcitytypestr)
            print("Accountnolengthstr",self.Accountnolengthstr)
            print("minAccountnolengthstr",self.minAccountnolengthstr)
            print("ifscnolengthstr",self.ifscnolengthstr)
            
            
            //UserDefaults.standard.removeObject(forKey: "str_bank_codeserviceprovidercode")
           // self.str_bank_code = bank.bankCode
            print("str_bank_codefinal",self.str_bank_code)
            UserDefaults.standard.set(self.str_bank_code, forKey: "str_bank_codeserviceprovidercode")
           
            
            
            if bankbranschshow == "YES"
            {
                
                
                
                self.branchBtn.isHidden = false
                self.branchbtnslakviiewconstrainttop.constant = 10
                self.branchbtnheightconstaint.constant = 40
                
                self.city.isHidden = true
                cityconstrainttop.constant = 10
                cityhieghtconstraint.constant = 40
                self.citydrop.isHidden = true
                
                
                
                
                if bankcitytypestr == "D"
                {
                    self.citydrop.isHidden = false
                    self.city.isHidden = true
                    // bankfcitybtnconstrainttop.constant = 8
                    // self.bankntnheightconstraint.constant = 40
                    
                }
                else
                {
                    // self.city.isHidden = true
                    // bankfcitybtnconstrainttop.constant = 0
                    // self.bankntnheightconstraint.constant = 0
                    
                }
                
                if bankcitytypestr == "T"
                {
                    self.city.isHidden = false
                    self.citydrop.isHidden = true
                    //self.citydropconstrainttop.constant = 10
                    // self.Citydroptxtfiledhieghtconstraint.constant = 40
                }
                else
                {
                    //self.city.isHidden = true
                    //self.citydropconstrainttop.constant = 0
                    //self.Citydroptxtfiledhieghtconstraint.constant = 0
                }
                
                
                
            }
            //            else
            //            {
            //             self.branchBtn.isHidden = true
            //          self.branchbtnslakviiewconstrainttop.constant = 0
            //             self.branchbtnheightconstaint.constant = 0
            //
            //            }
            
            
            if bankbranschshow == "NO"
            {
                
                //new
                UserDefaults.standard.removeObject(forKey: "str_branch_code")
                UserDefaults.standard.removeObject(forKey: "str_bank_citydropcode")
                
                self.branchBtn.isHidden = true
                self.branchbtnslakviiewconstrainttop.constant = 0
                self.branchbtnheightconstaint.constant = 0
                
                self.city.isHidden = true
                cityhieghtconstraint.constant = 0
                cityconstrainttop.constant = 0
                self.citydrop.isHidden = true
                
            }
         ///
    
            
            let bottomOffset = CGPoint(x: 0, y: 300)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
        else if(tableView == tblBranch)
        {
            let cell: LabelTableViewCell = self.tblBranch.cellForRow(at: indexPath) as! LabelTableViewCell
            let str: String = cell.label.text!
            let branch = branchArray[indexPath.row]
            self.str_branch_code = branch.branchCode
            self.branchBtn.setTitle("\(str)", for: .normal)
            self.branchBtn.setTitleColor(UIColor.black, for: .normal)
            self.benView.isHidden = false
            self.branchView.isHidden = true
            
            //newsearch
            if branchselserchstr == "searchcliked"
            {
                let cell: LabelTableViewCell = self.tblBranch.cellForRow(at: indexPath) as! LabelTableViewCell
                
                
                teststrclsbranch = searchedArraybranch[indexPath.row]
                                print("selectednamesearch",teststrclsbranch)
                
                
                
                
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
                
              //last
                branchselserchstr = ""
            }
            else
            {
                UserDefaults.standard.removeObject(forKey: "str_branch_code")
                self.str_branch_code = branch.branchCode

            }
            print("str_branch_codefinal",self.str_branch_code)
            
            
            //UserDefaults.standard.removeObject(forKey: "str_branch_code")
           // self.str_branch_code = branch.branchCode
            UserDefaults.standard.set(self.str_branch_code, forKey: "str_branch_code")
            
            //self.BRANCHNAMENEW =
            UserDefaults.standard.removeObject(forKey: "BRANCHNAMENEW")
            UserDefaults.standard.set(str, forKey: "BRANCHNAMENEW")
            
            let bottomOffset = CGPoint(x: 0, y: 320)
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
    
//    @objc func textFieldShouldReturn(_ textField: UITextField)
//    {
//        resetTimer()
//    }
    
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
        resetTimer()
    }
}


extension String {

    func removeExtraSpacesremac() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }

}

extension String {

    func removeExtraSpacesaccountnumber() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: "", options: .regularExpression, range: nil)
    }

}
