//
//  RemittancePage3ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 25/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield
class RemittancePage3ViewController: UIViewController {
    //label1,label3
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()

    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var reviewReqLbl: UILabel!
    @IBOutlet weak var firstnameLbl: UILabel!
    @IBOutlet weak var firstnameLbl1: UILabel!
    @IBOutlet weak var lastnameLbl: UILabel!
    @IBOutlet weak var lastnameLbl1: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressLbl1: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var cityLbl1: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var mobileLbl1: UILabel!
    @IBOutlet weak var bankLbl: UILabel!
    @IBOutlet weak var bankLbl1: UILabel!
    @IBOutlet weak var branchLbl: UILabel!
    @IBOutlet weak var branchLbl1: UILabel!
    @IBOutlet weak var acNoLbl: UILabel!
    @IBOutlet weak var acNoLbl1: UILabel!
    @IBOutlet weak var swiftLbl: UILabel!
    @IBOutlet weak var swiftLbl1: UILabel!
    @IBOutlet weak var relationLbl: UILabel!
    @IBOutlet weak var relationLbl1: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var amountLbl1: UILabel!
    @IBOutlet weak var amountLbl2: UILabel!
    @IBOutlet weak var amountLbl3: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var ifscStack: UIStackView!
    @IBOutlet var Accountnoibanstack: UIStackView!
    
    @IBOutlet var accountnoibanheightconstrain: NSLayoutConstraint!
    
    
    @IBOutlet var branchstackview: UIStackView!
    
    @IBOutlet var branchheightconstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet var cityslakview: UIStackView!
    
    @IBOutlet var cityslakviewheightconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var lastnameslakview: UIStackView!
    
    @IBOutlet var lastnameheightconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var addressstackview: UIStackView!
    
    
    @IBOutlet var addressstackheightconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var addressbottomview: UIView!
    
    
    @IBOutlet var mobilestackview: UIStackView!
    
    
    @IBOutlet var mobilestackheightconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var mobilebottomview: UIView!
    
    
    @IBOutlet var bankstackview: UIStackView!
    
    
    @IBOutlet var bankstckviewheightconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var bankstackbottomview: UIView!
    var servicetypestoredstr : String = ""
    
    var firstnamestrr : String = ""
    var middlenamestr : String = ""
    var lastnamestr : String = ""
    
    
    var accountnooribandispstr : String = ""
    
    var citycashpickupdisplaystr : String = ""
    
    var citycreditdisplaystr : String = ""
    
    
    let defaults = UserDefaults.standard
    var udid:String!
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("remittance", comment: "")
        confirmBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        confirmBtn.layer.cornerRadius = 15
        setFont()
        setFontSize()
        getValues()
        
        
        
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        //resetTimer()
    }
    override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(true)
               
               // Protect ScreenShot
                     // ScreenShield.shared.protect(view: self.mainStackView)
                      
                      // Protect Screen-Recording
                     // ScreenShield.shared.protectFromScreenRecording()
              
           }
    
    
    @objc func userIsInactive() {
        // Alert user
//        let alert = UIAlertController(title: "You have been inactive for 5 minutes. We're going to log you off for security reasons.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
//        //Log user off
//        }))
//        present(alert, animated: true)
        
        timer.invalidate()

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


        timer.invalidate()
        
        return
     }

    @objc func resetTimer() {
        print("Reset")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    func isValid(testStr:String) -> Bool {
        guard testStr.count > 0, testStr.count < 18 else { return false }

            let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
            return predicateTest.evaluate(with: testStr)
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
    @IBAction func confirmBtn(_ sender: Any) {
        
        //name validation
        
//              if (!isValid(testStr: self.firstnameLbl1.text!))
//              {
//                  let alert = UIAlertController(title: "Alert", message: "Please enter valid name", preferredStyle: UIAlertController.Style.alert)
//                  alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
//                  self.present(alert, animated: true, completion: nil)
//                  print("check name",self.firstnameLbl1.text)
//
//              }
//
//        if (!isValid(testStr: self.lastnameLbl1.text!))
//             {
//                 let alert = UIAlertController(title: "Alert", message: "Please enter valid last name", preferredStyle: UIAlertController.Style.alert)
//                 alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
//                 self.present(alert, animated: true, completion: nil)
//                 print("check name",self.lastnameLbl1.text)
//
//             }
        
        timer.invalidate()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem4") as! RemittancePage4ViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func setFont() {
        reviewReqLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        firstnameLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        firstnameLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        lastnameLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        lastnameLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        addressLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        addressLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        cityLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        cityLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        mobileLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        mobileLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        bankLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        bankLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        branchLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        branchLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        acNoLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        acNoLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        swiftLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        swiftLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        relationLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        relationLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        amountLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        amountLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        amountLbl2.font = UIFont(name: "OpenSans-Regular", size: 14)
        amountLbl3.font = UIFont(name: "OpenSans-Regular", size: 14)
        confirmBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        reviewReqLbl.font = reviewReqLbl.font.withSize(16)
        firstnameLbl.font = firstnameLbl.font.withSize(14)
        firstnameLbl1.font = firstnameLbl1.font.withSize(14)
        lastnameLbl.font = lastnameLbl.font.withSize(14)
        lastnameLbl1.font = lastnameLbl1.font.withSize(14)
        addressLbl.font = addressLbl.font.withSize(14)
        addressLbl1.font = addressLbl1.font.withSize(14)
        cityLbl.font = cityLbl.font.withSize(14)
        cityLbl1.font = cityLbl1.font.withSize(14)
        mobileLbl.font = mobileLbl.font.withSize(14)
        mobileLbl1.font = mobileLbl1.font.withSize(14)
        bankLbl.font = bankLbl.font.withSize(14)
        bankLbl1.font = bankLbl1.font.withSize(14)
        branchLbl.font = branchLbl.font.withSize(14)
        branchLbl1.font = branchLbl1.font.withSize(14)
        acNoLbl.font = acNoLbl.font.withSize(14)
        acNoLbl1.font = acNoLbl1.font.withSize(14)
        swiftLbl.font = swiftLbl.font.withSize(14)
        swiftLbl1.font = swiftLbl1.font.withSize(14)
        relationLbl.font = relationLbl.font.withSize(14)
        relationLbl1.font = relationLbl1.font.withSize(14)
        amountLbl.font = amountLbl.font.withSize(14)
        amountLbl1.font = amountLbl1.font.withSize(14)
        amountLbl2.font = amountLbl2.font.withSize(14)
        amountLbl3.font = amountLbl3.font.withSize(14)
    }
    func getValues() {
        
        self.lastnameslakview.isHidden = true
        lastnameheightconstraint.constant = 0
        
        firstnamestrr = defaults.string(forKey: "first_name")!
        lastnamestr = defaults.string(forKey: "last_name")!
        middlenamestr =  defaults.string(forKey: "middlenamestrstored")!
        
        self.firstnameLbl1.text = firstnamestrr + " " + middlenamestr + " " + lastnamestr
        //self.firstnameLbl1.text = defaults.string(forKey: "first_name")
        self.lastnameLbl1.text = defaults.string(forKey: "last_name")
       
        self.servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
        if servicetypestoredstr == "CASH"||servicetypestoredstr == "CASH_TO_MOBILE"
        {
            //one
            if(defaults.string(forKey: "address")! == "")
            {
               //is hidden
                self.addressstackheightconstraint.constant = 0
                self.addressstackview.isHidden = true
                self.addressbottomview.isHidden = true
                
            }
            else
            {
               //valueyes
                self.addressstackheightconstraint.constant = 50
                self.addressstackview.isHidden = false
                self.addressbottomview.isHidden = false
                
                self.addressLbl1.text = defaults.string(forKey: "address")
            }
            //
            //two
            if(defaults.string(forKey: "mobile")! == "")
            {
                //is hidden
                self.mobilestackheightconstraint.constant = 0
                self.mobilestackview.isHidden = true
                self.mobilebottomview.isHidden = true
            }
            else
            {
                //valueyes
                self.mobilestackheightconstraint.constant = 50
                self.mobilestackview.isHidden = false
                self.mobilebottomview.isHidden = false
                self.mobileLbl1.text = defaults.string(forKey: "mobile")
            }
            
            
        }
        else
        {
            self.addressLbl1.text = defaults.string(forKey: "address")
            //two
            self.mobileLbl1.text = defaults.string(forKey: "mobile")
        }
        
        //new for mobwallaccout
        if servicetypestoredstr == "CASH_TO_MOBILE"
        {
            if(defaults.string(forKey: "mobilewalletaccnostored")! == "")
            {
                //is hidden
                self.mobilestackheightconstraint.constant = 0
                self.mobilestackview.isHidden = true
                self.mobilebottomview.isHidden = true
            }
            else
            {
                //valueyes
                self.mobilestackheightconstraint.constant = 50
                self.mobilestackview.isHidden = false
                self.mobilebottomview.isHidden = false
                self.mobileLbl1.text = defaults.string(forKey: "mobilewalletaccnostored")
                
            }
        }
        
        
        
        
        self.servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
        print("servicetypestrstored",servicetypestoredstr)
        if servicetypestoredstr == "CASH"||servicetypestoredstr == "CASH_TO_MOBILE"
        {
            
            
          let userdefaultsservicetype = UserDefaults.standard
            if let savedValue = userdefaultsservicetype.string(forKey: "beneficiaryCity1"){
                print("Here you will get saved value")
              
                self.citycashpickupdisplaystr = defaults.string(forKey: "beneficiaryCity1")!
                print("citycashpickupdisplaystr",self.citycashpickupdisplaystr)
                if self.citycashpickupdisplaystr == ""
              {
                    self.cityslakview.isHidden = true
                    cityslakviewheightconstraint.constant = 0
              }
                else
                {
                
                self.cityslakview.isHidden = false
                cityslakviewheightconstraint.constant = 50
               self.cityLbl1.text = defaults.string(forKey: "beneficiaryCity1")
                }
                self.cityLbl1.text = defaults.string(forKey: "beneficiaryCity1")

                } else {
                    self.cityslakview.isHidden = true
                    cityslakviewheightconstraint.constant = 0
               
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultsservicetype.set("", forKey: "key")
            }
            
            
            
         
        }
        else
        {
              
            let userdefaultsservicetype = UserDefaults.standard
              if let savedValue = userdefaultsservicetype.string(forKey: "city"){
                  print("Here you will get saved value")
                
                self.citycreditdisplaystr = defaults.string(forKey: "city")!
                print("citycreditdisplaystr",self.citycreditdisplaystr)
                if self.citycreditdisplaystr == ""
                {
                    self.cityslakview.isHidden = true
                    cityslakviewheightconstraint.constant = 0
                }
                else
                {
                    self.cityslakview.isHidden = false
                    cityslakviewheightconstraint.constant = 50
                   //self.cityLbl1.text = defaults.string(forKey: "beneficiaryCity1")
                  
                  self.cityLbl1.text = defaults.string(forKey: "city")
                    
                }
                self.cityLbl1.text = defaults.string(forKey: "city")
        

                  } else {
                      self.cityslakview.isHidden = true
                      cityslakviewheightconstraint.constant = 0
                 
              print("No value in Userdefault,Either you can save value here or perform other operation")
              userdefaultsservicetype.set("", forKey: "key")
              }
            
            
            
            
         
        }
        
        
        
        
        
        self.servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
//       if(defaults.string(forKey: "serviceproviderBANKname") == "")||(defaults.string(forKey: "serviceproviderBANKname")! == "CASH")||(defaults.string(forKey: "serviceproviderBANKname")! == "CASH_TO_MOBILE")
        if servicetypestoredstr == "CASH"||servicetypestoredstr == "CASH_TO_MOBILE"
        {
            
            if defaults.object(forKey: "serviceproviderBANKname") == nil
            {
                print("No value in Userdefault serviceproviderBANKname")
                self.bankstackview.isHidden = true
                self.bankstckviewheightconstraint.constant = 0
                self.bankstackbottomview.isHidden = true
            }
            else
            {
                print("yes value in Userdefault serviceproviderBANKname")
            
            if(defaults.string(forKey: "serviceproviderBANKname")! == "")
            {
                //hide
                self.bankstackview.isHidden = true
                self.bankstckviewheightconstraint.constant = 0
                self.bankstackbottomview.isHidden = true
            }
            else
            {
                self.bankstackview.isHidden = false
                self.bankstckviewheightconstraint.constant = 50
                self.bankstackbottomview.isHidden = false
                self.bankLbl1.text = defaults.string(forKey: "serviceproviderBANKname")
            }
            }
        
            
            
        }
        //CASH CASH_TO_MOBILE  serviceproviderBANKname

        else
        {
        self.bankLbl1.text = defaults.string(forKey: "bank_name")
        }
       // self.bankLbl1.text = defaults.string(forKey: "bank_name")
//        if(defaults.string(forKey: "branch_name")! == "")||(defaults.string(forKey: "branch_name")! == "BRANCH NAME")
//        {
//            self.branchstackview.isHidden = true
//            branchheightconstraint.constant = 0
//        }
//        else
//        {
//            self.branchstackview.isHidden = false
//            branchheightconstraint.constant = 50
//        }
        
        if servicetypestoredstr == "CASH"||servicetypestoredstr == "CASH_TO_MOBILE"
        {
            self.branchLbl1.text = defaults.string(forKey: "serviceproviderBRANCHname")
            
            //
            let userdefaultsservicetype = UserDefaults.standard
            if let savedValue = userdefaultsservicetype.string(forKey: "serviceproviderBRANCHname"){
                print("Here you will get saved value")
              
                self.branchstackview.isHidden = false
                branchheightconstraint.constant = 50
                self.branchLbl1.text = defaults.string(forKey: "serviceproviderBRANCHname")

                } else {
                    self.branchstackview.isHidden = true
                    branchheightconstraint.constant = 0
               
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultsservicetype.set("", forKey: "key")
            }
            
           
            
        }
        else
        {
            //CREDIT A/T
        self.branchLbl1.text = defaults.string(forKey: "BRANCHNAMENEW")
            
            let userdefaultsservicetype = UserDefaults.standard
            if let savedValue = userdefaultsservicetype.string(forKey: "BRANCHNAMENEW"){
                print("Here you will get saved value")
              
                self.branchstackview.isHidden = false
                branchheightconstraint.constant = 50
                self.branchLbl1.text = defaults.string(forKey: "BRANCHNAMENEW")

                } else {
                    self.branchstackview.isHidden = true
                    branchheightconstraint.constant = 0
               
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultsservicetype.set("", forKey: "key")
            }
            
        }
        
        //accountno/iban
       if( defaults.string(forKey: "servicetypestoresel")! == "CREDIT")
       {
        print("CREDITSELECTED","CREDITSELECTED")
        
//        if(defaults.string(forKey: "acc_no")! == "")
//        {
//
//        }
        if(defaults.string(forKey: "acc_no")! == "")
        {
            
            self.acNoLbl1.text = ""
            
            
            
            if(defaults.string(forKey: "ibanstrenterd")! == "")
            {
                self.acNoLbl1.text = ""
            }
            else
            {
                self.acNoLbl1.text = defaults.string(forKey: "ibanstrenterd")
            }
            
            print("ibanvalueeeee",defaults.string(forKey: "ibanstrenterd"))
        }
        else
        {
            self.acNoLbl1.text = defaults.string(forKey: "acc_no")
        }
        
     
        
//        //self.acNoLbl1.text = defaults.string(forKey: "acc_no")
//        let userdefaultsaccountno = UserDefaults.standard
//          if let savedValue = userdefaultsaccountno.string(forKey: "acc_no"){
//              print("Here you will get saved value")
//            accountnooribandispstr = defaults.string(forKey: "acc_no")!
//            print("accountnooribandispstr",accountnooribandispstr)
//            self.acNoLbl1.text = accountnooribandispstr
//
//              } else {
//
//                accountnooribandispstr = ""
//                self.acNoLbl1.text = accountnooribandispstr
//
//          print("No1acc value in Userdefault,Either you can save value here or perform other operation")
//                userdefaultsaccountno.set("", forKey: "key")
//          }
//
//
//
//        let userdefaultiban = UserDefaults.standard
//          if let savedValue = userdefaultiban.string(forKey: "ibanstrenterd"){
//              print("Here you will get saved value")
//
//            accountnooribandispstr = defaults.string(forKey: "ibanstrenterd")!
//            print("accountnooribandispstritsiban",accountnooribandispstr)
//
//            self.acNoLbl1.text = accountnooribandispstr
//
//              } else {
//                accountnooribandispstr = ""
//                self.acNoLbl1.text = accountnooribandispstr
//
//          print("No1iban value in Userdefault,Either you can save value here or perform other operation")
//                userdefaultiban.set("", forKey: "key")
//          }
//
        
        
        
       }
        else
       {
        if(defaults.string(forKey: "acc_no")! == "")
        {
            self.Accountnoibanstack.isHidden = true
            accountnoibanheightconstrain.constant = 0
        }
        else
        {
            self.Accountnoibanstack.isHidden = false
            accountnoibanheightconstrain.constant = 50
            self.acNoLbl1.text = defaults.string(forKey: "acc_no")
        }
        
       }
        
        
        
        print("ifsc",defaults.string(forKey: "ifsc")!)
        if(defaults.string(forKey: "ifsc")! == "")
        {
            self.ifscStack.isHidden = true
        }
        else
        {
            self.ifscStack.isHidden = false
            self.swiftLbl1.text = defaults.string(forKey: "ifsc")
        }
        
        
        //new for accno hiddden in cashtomob
        if servicetypestoredstr == "CASH_TO_MOBILE"
        {
            self.Accountnoibanstack.isHidden = true
            accountnoibanheightconstrain.constant = 0
        }
        
        
        
        
        self.relationLbl1.text = defaults.string(forKey: "relation")
       // self.amountLbl1.text = defaults.string(forKey: "totalAmount")! + "0"
        //qar or forigncurrency
        self.amountLbl1.text = defaults.string(forKey: "totalAmount")!
       // self.amountLbl1.text = defaults.string(forKey: "totalAmount")!
        //3 is notqatar and amlabeL 1 is qatar
        //inr or forigncurrency
        self.amountLbl3.text = defaults.string(forKey: "amount2")
        let currency = defaults.string(forKey: "currency")
        self.amountLbl2.text = NSLocalizedString("amount1", comment: "") + "(" + currency! + ")"
        
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
