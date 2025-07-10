//
//  TransactionDetailsViewController.swift
//  GulfExchangeApp
//
//  Created by test on 26/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield

class TransactionDetailsViewController: UIViewController {
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
    @IBOutlet weak var relationLbl: UILabel!
    @IBOutlet weak var relationLbl1: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var amountLbl1: UILabel!
    @IBOutlet weak var commissionLbl: UILabel!
    @IBOutlet weak var commissionLbl1: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var totalAmountLbl1: UILabel!
    @IBOutlet weak var amountLbl2: UILabel!
    @IBOutlet weak var amountLbl3: UILabel!
    @IBOutlet weak var trackBtn: UIButton!
    @IBOutlet weak var view1: UIView!
    
    
    @IBOutlet weak var mianStackView: UIStackView!
    var timer = Timer()
    
    @IBOutlet var trackingcodelbl: UILabel!
    
    @IBOutlet var trackingcodelabelone: UILabel!
    
    
    @IBOutlet var trackcodeslakview: UIStackView!
    
    
    @IBOutlet var cityhieghtconstraint: NSLayoutConstraint!
    
    @IBOutlet var cityslakview: UIStackView!
    
    @IBOutlet var citybotomlineview: UIView!
    
    
    @IBOutlet var branchslakview: UIStackView!
    
    @IBOutlet var branchhieghtconstraint: NSLayoutConstraint!
    
    @IBOutlet var branchbottomview: UIView!
    
    
    @IBOutlet var acccountnoslakview: UIStackView!
    
    @IBOutlet var accountnoheightconstraint: NSLayoutConstraint!
    
    @IBOutlet var accountnobotomview: UIView!
    
    
    
    @IBOutlet var mobileslackview: UIStackView!
    
    @IBOutlet var mobileheightconstraint: NSLayoutConstraint!
    
    @IBOutlet var mobilebottomview: UIView!
    
    
    @IBOutlet var bankstackview: UIStackView!
    
    @IBOutlet var bankheightconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var bankbottomview: UIView!
    
    
    
    @IBOutlet var addressstackview: UIStackView!
    
    @IBOutlet var addressheightconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var addressbottomview: UIView!
    
    
    
    let defaults = UserDefaults.standard
    var transRefNo:String = ""
    var totalstr:String = ""
    var totalpayoutstr:String = ""
    var commisionstr:String = ""
    
    var payinstr:String = ""
    
    var accoribanzero:String = ""
    
    var udid:String!
    
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
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer.invalidate()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("transaction_details", comment: "")
        trackBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        trackBtn.layer.cornerRadius = 15
        setFont()
        setFontSize()
        self.transRefNo = defaults.string(forKey: "transactionRefNo")!
        print("Ref No :",transRefNo)
        
        self.getToken()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(true)
               
               // Protect ScreenShot
                      ScreenShield.shared.protect(view: self.mianStackView)
                      
                      // Protect Screen-Recording
                      ScreenShield.shared.protectFromScreenRecording()
              
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
    func setFont() {
        
        trackingcodelbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        trackingcodelabelone.font = UIFont(name: "OpenSans-Regular", size: 14)
        
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
        relationLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        relationLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        amountLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        amountLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        commissionLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        commissionLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        totalAmountLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        totalAmountLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        amountLbl2.font = UIFont(name: "OpenSans-Regular", size: 14)
        amountLbl3.font = UIFont(name: "OpenSans-Regular", size: 14)
        trackBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    
    func setFontSize() {
        
        trackingcodelbl.font =  trackingcodelbl.font.withSize(14)
        trackingcodelabelone.font = trackingcodelabelone.font.withSize(14)
        
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
        relationLbl.font = relationLbl.font.withSize(14)
        relationLbl1.font = relationLbl1.font.withSize(14)
        amountLbl.font = amountLbl.font.withSize(14)
        amountLbl1.font = amountLbl1.font.withSize(14)
        commissionLbl.font = commissionLbl.font.withSize(14)
        commissionLbl1.font = commissionLbl1.font.withSize(14)
        totalAmountLbl.font = totalAmountLbl.font.withSize(14)
        totalAmountLbl1.font = totalAmountLbl1.font.withSize(14)
        amountLbl2.font = amountLbl2.font.withSize(14)
        amountLbl3.font = amountLbl3.font.withSize(14)
        
    }
    func getToken() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        MyTransactionsListViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                self.getTransactionDetails(access_token: token)
                break
            case .failure:
                break
            }
        })
    }
    func getTransactionDetails(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "transaction/viewtransaction"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"transactionRefNo":self.transRefNo]
    
        print("params viewtransaction response list",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        MyTransactionsListViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response list",response)
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            if(respCode == "E114")
            {
                self.alertMessage(title: "Gulf Exchange", msg: NSLocalizedString("no_data_available", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.view1.isHidden = true
            }
            else{
                self.view1.isHidden = false
                self.firstnameLbl1.text = myResult!["transactionRefNo"].stringValue
                self.lastnameLbl1.text = myResult!["beneficiaryAccountName"].stringValue
                
                
                if myResult!["beneficiaryAddress"].stringValue.isEmpty
                {
                    self.addressheightconstraint.constant = 0
                    self.addressstackview.isHidden = true
                    self.addressbottomview.isHidden = true
                }
                else
                {
                    self.addressheightconstraint.constant = 40
                    self.addressstackview.isHidden = false
                    self.addressbottomview.isHidden = false
                    self.addressLbl1.text = myResult!["beneficiaryAddress"].stringValue
                }
                
                if myResult!["beneficiaryCity"].stringValue.isEmpty
                {
                    self.cityhieghtconstraint.constant = 0
                    self.cityslakview.isHidden = true
                    self.citybotomlineview.isHidden = true
                    
                }
                else
                {
                    self.cityhieghtconstraint.constant = 40
                    self.cityslakview.isHidden = false
                    self.citybotomlineview.isHidden = false
                    
                    
                   self.cityLbl1.text = myResult!["beneficiaryCity"].stringValue
                }
                
                
                
               
                
                
                if myResult!["mobileNo"].stringValue.isEmpty
                {
                    self.mobileheightconstraint.constant = 0
                    self.mobileslackview.isHidden = true
                    self.mobilebottomview.isHidden = true
                }
                else
                {
                    self.mobileheightconstraint.constant = 40
                    self.mobileslackview.isHidden = false
                    self.mobilebottomview.isHidden = false
                    
                    self.mobileLbl1.text = myResult!["mobileNo"].stringValue
                }
                
                if myResult!["beneficiaryBank"].stringValue.isEmpty
                {
                    self.bankheightconstraint.constant = 0
                    self.bankstackview.isHidden = true
                    self.bankbottomview.isHidden = true
                }
                else
                {
                    self.bankheightconstraint.constant = 40
                    self.bankstackview.isHidden = false
                    self.bankbottomview.isHidden = false

                    self.bankLbl1.text = myResult!["beneficiaryBank"].stringValue
                }
                
                if myResult!["beneficiaryBankBranch"].stringValue.isEmpty
                {
                    self.branchhieghtconstraint.constant = 0
                    self.branchslakview.isHidden = true
                    self.branchbottomview.isHidden = true
                    
                }
                else
                {
                  self.branchhieghtconstraint.constant = 40
                    self.branchslakview.isHidden = false
                    self.branchbottomview.isHidden = false
                    
                  self.branchLbl1.text = myResult!["beneficiaryBankBranch"].stringValue
                }
                //self.branchLbl1.text = myResult!["beneficiaryBankBranch"].stringValue
                if myResult!["beneficiaryAccountNo"].stringValue.isEmpty
                {
                    self.accountnoheightconstraint.constant = 0
                    self.acccountnoslakview.isHidden = true
                    self.accountnobotomview.isHidden = true
                    
//                    if myResult!["beneficiaryAccountNo"].stringValue.isEmpty
//                    {
//
//                    }
                    
                    
                    
                    
                }
                else
                {
                    self.accountnoheightconstraint.constant = 40
                    self.acccountnoslakview.isHidden = false
                    self.accountnobotomview.isHidden = false
                    
                   self.acNoLbl1.text = myResult!["beneficiaryAccountNo"].stringValue
                    
                    
                    self.accoribanzero = myResult!["beneficiaryAccountNo"].stringValue
                    if self.accoribanzero == "0"
                    {
                        self.accountnoheightconstraint.constant = 0
                        self.acccountnoslakview.isHidden = true
                        self.accountnobotomview.isHidden = true
                       
                    }
                    else
                    {
                        
                    }
                    
                }
                
                
                self.relationLbl1.text = myResult!["customerRelationship"].stringValue
                self.amountLbl.text = NSLocalizedString("amount1_sm", comment: "") + "(" + myResult!["payinCurrency"].stringValue + ")"
                
                //
                let payinstrdecimal = myResult!["payinAmount"].stringValue
                var payinstrdecimalstrdecimalrate = Double(payinstrdecimal)
                self.payinstr = String(format: "%.2f", payinstrdecimalstrdecimalrate as! CVarArg)
                print("payinstr ",self.payinstr)
                self.amountLbl1.text = self.payinstr
                
                //self.amountLbl1.text = myResult!["payinAmount"].stringValue + ""
                self.amountLbl2.text = NSLocalizedString("amount1_sm", comment: "") + "(" + myResult!["payoutCurrency"].stringValue + ")"
                
                //
                let commisionstrdecimal = myResult!["commission"].stringValue
                var commisionstrdecimalrate = Double(commisionstrdecimal)
                self.commisionstr = String(format: "%.2f", commisionstrdecimalrate as! CVarArg)
                print("commisionstr ",self.commisionstr)
               
                self.commissionLbl1.text = self.commisionstr
                
                //self.commissionLbl1.text = myResult!["commission"].stringValue + ""
                self.totalAmountLbl.text = NSLocalizedString("total_amount_sm", comment: "") + "(" + myResult!["payinCurrency"].stringValue + ")"
                
                //new
                
                let totalstrdecimal = myResult!["totalPayinAmount"].stringValue
                var totalstrdecimalrate = Double(totalstrdecimal)
                self.totalstr = String(format: "%.2f", totalstrdecimalrate as! CVarArg)
                print("totalstr ",self.totalstr)
                self.totalAmountLbl1.text = self.totalstr
                //self.totalAmountLbl1.text = myResult!["totalPayinAmount"].stringValue + ""
                //
                let totalpayoutstrdecimal = myResult!["payoutAmount"].stringValue
                var totalpayoutstrdecimalrate = Double(totalpayoutstrdecimal)
                self.totalpayoutstr = String(format: "%.2f", totalpayoutstrdecimalrate as! CVarArg)
                print("totalpayoutstr ",self.totalpayoutstr)
                
                self.amountLbl3.text = self.totalpayoutstr
                
                //lastamount
                //self.amountLbl3.text = myResult!["payoutAmount"].stringValue
                
                if myResult!["remittanceTrackingCode"].stringValue.isEmpty
                {
                    self.trackcodeslakview.isHidden = true
                }
                else
                {
                    self.trackcodeslakview.isHidden = false
                  self.trackingcodelabelone.text = myResult!["remittanceTrackingCode"].stringValue
                }
                
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
    @IBAction func trackBtn(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.defaults.set("track", forKey: "trackFrom")
        let vc: TrackTransactionViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "track") as! TrackTransactionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
