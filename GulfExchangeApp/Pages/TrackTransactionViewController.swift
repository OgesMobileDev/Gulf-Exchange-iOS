//
//  TrackTransactionViewController.swift
//  GulfExchangeApp
//
//  Created by test on 31/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TrackTransactionViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var ttNoLbl: UILabel!
    @IBOutlet weak var ttNoLbl1: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateLbl1: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var toLbl1: UILabel!
    @IBOutlet weak var status1: UILabel!
    @IBOutlet weak var status2: UILabel!
    @IBOutlet weak var status3: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    var transactionRefNo:String = ""
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()
    
    
        //test
        //var transactionRefNo:String = ""
        static let AlamoFireManager: Alamofire.Session = {
            let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator(),
                                                          "ws.gulfexchange.com.qa": DisabledEvaluator()])
            let configuration = URLSessionConfiguration.af.default
            return Session(configuration: configuration, serverTrustManager: manager)
        }()
        
        //production
           // var transactionRefNo:String = ""
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
    var udid:String!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        searchTextField.delegate = self
        
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                            let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                            if appLang == "ar" || appLang == "ur" {
                               searchTextField.textAlignment = .right
                            } else {
                               searchTextField.textAlignment = .left
                            }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("track_transactions", comment: "")
        let check = isKeyPresentInUserDefaults(key: "trackFrom")
        if(check)
        {
            let from = defaults.string(forKey: "trackFrom")
            if(from != "")
            {
                self.transactionRefNo = defaults.string(forKey: "transactionRefNo")!
                print("transRefNo ",transactionRefNo)
                self.getToken()
            }
        }
        
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)
       
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
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        print("txtfd touch")
        resetTimer()
    }
    
    
    @IBAction func searchBtn(_ sender: Any) {
        if(searchTextField.text?.count == 0)
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_ref_no", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else
        {
            self.transactionRefNo = self.searchTextField.text!
            self.getToken()
        }
    }
    func getToken() {
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
            
            let str_encode_val = auth_client_id + ":" + auth_client_secret
            let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
            let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
            
            TrackTransactionViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                print("response",response)
                self.effectView.removeFromSuperview()
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)
                    
                    let token:String = myresult!["access_token"].string!
                    print("token  ",token)
                    self.getTransactionInfo(access_token: token)
                    break
                case .failure:
                    break
                }
                
            })
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
        func getTransactionInfo(access_token:String) {
            self.ttNoLbl1.isHidden = true
            self.dateLbl1.isHidden = true
            self.toLbl1.isHidden = true
            self.status1.isHidden = true
            self.status2.isHidden = true
            self.status3.isHidden = true
            self.ttNoLbl.isHidden = true
            self.dateLbl.isHidden = true
            self.toLbl.isHidden = true
            self.lbl1.isHidden = true
            self.lbl2.isHidden = true
            self.lbl3.isHidden = true
            self.img1.isHidden = true
            self.view1.isHidden = true
            self.img2.isHidden = true
            self.view2.isHidden = true
            self.img3.isHidden = true
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            let dateTime:String = getCurrentDateTime()
            let url = ge_api_url + "transaction/viewtransaction"
            let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"transactionRefNo":self.transactionRefNo]
            let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
            
            TrackTransactionViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                let myResult = try? JSON(data: response.data!)
                self.effectView.removeFromSuperview()
                print("resp",response)
                let respCode = myResult!["responseCode"]
                self.defaults.set("", forKey: "trackFrom")
                if(respCode == "S114")
                {
                    self.ttNoLbl1.isHidden = false
                    self.dateLbl1.isHidden = false
                    self.toLbl1.isHidden = false
                    self.status1.isHidden = false
                    self.status2.isHidden = false
                    self.status3.isHidden = false
                    self.ttNoLbl.isHidden = false
                    self.dateLbl.isHidden = false
                    self.toLbl.isHidden = false
                    self.lbl1.isHidden = false
                    self.lbl2.isHidden = false
                    self.lbl3.isHidden = false
                    self.img1.isHidden = false
                    self.view1.isHidden = false
                    self.img2.isHidden = false
                    self.view2.isHidden = false
                    self.img3.isHidden = false
                    let benAccNo = myResult!["beneficiaryAccountNo"].stringValue
                    if(benAccNo != nil || benAccNo != "")
                    {
                        self.ttNoLbl1.text = self.transactionRefNo
                    }
                    else{
                        self.ttNoLbl1.text = "-"
                    }
                    self.toLbl1.text = myResult!["beneficiaryAccountName"].stringValue
                    let date = myResult!["transactionDate"].stringValue
                    if(date != "")
                    {
                        self.dateLbl1.text = self.convertDateFormater(date)
                        self.status1.text = "Transaction initiated on (" + self.convertDateFormater(date) + ")"
                    }
                    else
                    {
                        self.dateLbl1.text = "-"
                        self.status1.text = "-"
                        
                    }
                    let statusStr2 = myResult!["paymentStatus"].stringValue
                    if(statusStr2 == "-" || statusStr2 == "INITIATED")
                    {
                        self.status2.text = "Processing"
                    }
                    else if(statusStr2 ==  "PAYMENT FAILED")
                    {
                        self.status2.text = "Payment failed (" + self.convertDateFormater(date) + ")"
                    }
                    else{
                        let str = String.capitalizingFirstLetter(statusStr2)
                        self.status2.text = str()
                    }
                    let statusStr3 = myResult!["txnStatus1"].stringValue
                    if(statusStr3 != "")
                    {
                        self.status3.text = statusStr3
                    }
                    else
                    {
                        self.status3.text = "-"
                    }
                    
                }
                else
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg:NSLocalizedString("no_data_available", comment: "") , action: NSLocalizedString("ok", comment: ""))
                }
            })
        }
        func convertDateFormater(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return  dateFormatter.string(from: date!)

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
    }
//    extension String {
//        func capitalizingFirstLetter() -> String {
//          return prefix(1).uppercased() + self.lowercased().dropFirst()
//        }
//
//        mutating func capitalizeFirstLetter() {
//          self = self.capitalizingFirstLetter()
//        }
//    }
