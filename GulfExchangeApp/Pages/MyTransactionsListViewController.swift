//
//  MyTransactionsListViewController.swift
//  GulfExchangeApp
//
//  Created by test on 23/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield
class MyTransactionsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,SetCalendar, UITextFieldDelegate {
    
    var timer = Timer()
    var timerGesture = UITapGestureRecognizer()

    
    @IBOutlet weak var mainView: UIView!
    
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var tblTransactions: UITableView!
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let objCustomCalendar :CustomCalendar = CustomCalendar()
    var dateField:Int = 0
    var fromDate:String = ""
    var toDate:String = ""
    let defaults = UserDefaults.standard
    var transactionList:[MyTransactions] = []
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tblTransactions.isHidden = false
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                                          let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                                          if appLang == "ar" || appLang == "ur" {
                                             fromDateTextField.textAlignment = .right
                                             toDateTextField.textAlignment = .right
                                             searchTextField.textAlignment = .right
                                          } else {
                                             fromDateTextField.textAlignment = .left
                                             toDateTextField.textAlignment = .left
                                             searchTextField.textAlignment = .left
                                          }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("my_transactions", comment: "")
        goBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        goBtn.layer.cornerRadius = 15
        self.tblTransactions.dataSource = self
        self.tblTransactions.delegate = self
        self.fromDateTextField.delegate = self
        self.toDateTextField.delegate = self
        setFont()
        setFontSize()
        self.fromDate = self.getCurrentDateTime4()
        self.toDate = self.getCurrentDateTime1()
        self.getToken()
        
        objCustomCalendar.calendarDelegate = self
        
        
        createToolbar()
        createToolbar1()
        //fromDateTextField.addTarget(self, action: #selector(MyTransactionsListViewController.textFieldDidChange(_:)), for: .touchDown)
       // toDateTextField.addTarget(self, action: #selector(MyTransactionsListViewController.textFieldDidChange(_:)), for: .touchDown)
        self.fromDateTextField.text = self.getCurrentDateTime3()
        self.toDateTextField.text = self.getCurrentDateTime2()
        
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        
        //resetTimer()
        

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(true)
               
               // Protect ScreenShot
//                      ScreenShield.shared.protect(view: self.mainView)
                      
                      // Protect Screen-Recording
                      ScreenShield.shared.protectFromScreenRecording()
              
           }
    @objc func doStuff() {
        // perform any action you wish to
        print("User inactive for more than 10 seconds .")
        
        timer.invalidate()
        
        self.defaults.set("", forKey: "USERID")
        self.defaults.set("", forKey: "PASSW")
        self.defaults.set("", forKey: "PIN")
        self.defaults.set("", forKey: "REGNO")

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
                self.navigationController?.pushViewController(nextViewController, animated: true)
        
        //callLogoutinactivestate()
        
       
     }
    
    @objc func resetTimer() {
        print("Reset")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
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

    
    
//     @objc func resetTimer() {
//        timer.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 1*60, target: self, selector: #selector(HomeViewController.doStuff), userInfo: nil, repeats: true)
//     }

    
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
    
    
    
    
    
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
           datePicker.preferredDatePickerStyle = .wheels
           datePicker.backgroundColor = UIColor.white
        }
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate))
        toolbar.setItems([done], animated: true)
        fromDateTextField.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        let today = Date()
       // datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -89, to: today)!
      
        datePicker.maximumDate = Date()
        fromDateTextField.inputView = datePicker
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
        toDateTextField.inputAccessoryView = toolbar
        datePicker1.datePickerMode = .date
        datePicker1.maximumDate = Date()
        toDateTextField.inputView = datePicker1
    }
    
    @objc func showdate()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        fromDateTextField.text = dateFormat.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func showdate1()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        toDateTextField.text = dateFormat.string(from: datePicker1.date)
        view.endEditing(true)
    }
    
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
      
        
        if(textField == fromDateTextField)
        {
            //self.dateField = 0
           // let midY = (self.view.frame.height / 2)-150
            //let midX = (self.view.frame.width / 2)-150
            
            //objCustomCalendar.ShowCalendar(xpos: Int(midX), ypos: Int(midY), targetController: self)
        }
        else if(textField == toDateTextField)
        {
            self.dateField = 1
            let midY = (self.view.frame.height / 2)-150
            let midX = (self.view.frame.width / 2)-150
            objCustomCalendar.ShowCalendar(xpos: Int(midX), ypos: Int(midY), targetController: self)
        }
    }
    @IBAction func searchBtn(_ sender: Any) {
        if(self.searchTextField.text?.count == 0)
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_ref_no", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.defaults.set(self.searchTextField.text!, forKey: "transactionRefNo")
            self.searchTextField.text = ""
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionDetails") as! TransactionDetailsViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    func alertMessage(title:String,msg:String,action:String){
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
            }))
            self.present(alert, animated: true)
        }
    func setFont() {
        fromDateLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        toDateLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        fromDateTextField.font = UIFont(name: "OpenSans-Regular", size: 12)
        toDateTextField.font = UIFont(name: "OpenSans-Regular", size: 12)
        goBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        searchTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
    }
    func setFontSize() {
        fromDateLbl.font = fromDateLbl.font.withSize(14)
        toDateLbl.font = toDateLbl.font.withSize(14)
        fromDateTextField.font = fromDateTextField.font?.withSize(14)
        toDateTextField.font = toDateTextField.font?.withSize(14)
    }
    @IBAction func goBtn(_ sender: Any) {
        self.fromDate = self.convertDateFormater(self.fromDateTextField.text!)
        self.toDate = self.convertDateFormater(self.toDateTextField.text!)
        print("from Date",fromDate)
        print("to date", toDate)
        self.getToken()
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)

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
                
                self.getTransactions(access_token: token, dateFrom: self.fromDate, dateTo: self.toDate)
                break
            case .failure:
                break
            }
        })
    }
    func getTransactions(access_token:String,dateFrom:String,dateTo:String) {
        self.transactionList.removeAll()
        self.tblTransactions.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        print("partner id  ",partnerId)
        print("token  ",token)
        print("date  ",dateTime)
        print("user id  ",defaults.string(forKey: "USERID")!)
        print("passw  ",defaults.string(forKey: "PASSW")!)
        print("pin  ",defaults.string(forKey: "PIN")!)
        print("date from  ",dateFrom)
        print("date to  ",dateTo)
        print("regno  ",defaults.string(forKey: "REGNO")!)
        let url = ge_api_url + "transaction/mytransaction"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"mobileno":"","noOfRecords":"","transactionDateFrom":dateFrom,"transactionDateTo":dateTo,"customerRegNo":defaults.string(forKey: "REGNO")!]
    
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        MyTransactionsListViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response list",response)
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            
            let resultArray = myResult!["transactionList"]
            
            for i in resultArray.arrayValue{
                let transaction = MyTransactions(transactionRefNo: i["transactionRefNo"].stringValue, gecoTransactionRefNo: i["gecoTransactionRefNo"].stringValue, partnerID: i["partnerID"].stringValue, sourceApplication: i["sourceApplication"].stringValue, deliveryOption: i["deliveryOption"].stringValue, customerRegNo: i["customerRegNo"].stringValue, customerIDNo: i["customerIDNo"].stringValue, mobileNo: i["mobileNo"].stringValue, transactionDate: i["transactionDate"].stringValue, payinCurrency: i["payinCurrency"].stringValue, payinAmount: i["payinAmount"].stringValue, payoutCurrency: i["payoutCurrency"].stringValue, payoutAmount: i["payoutAmount"].stringValue, exchangeRate: i["exchangeRate"].stringValue, commission: i["commission"].stringValue, charges: i["charges"].stringValue, tax: i["tax"].stringValue, totalPayinAmount: i["totalPayinAmount"].stringValue, beneficiaryAccountNo: i["beneficiaryAccountNo"].stringValue, purposeOfTxn: i["purposeOfTxn"].stringValue, sourceOfIncome: i["sourceOfIncome"].stringValue, paymentStatus: i["paymentStatus"].stringValue, paymentMode: i["paymentMode"].stringValue, paymentGatewayName: i["paymentGatewayName"].stringValue, paymentGatewayTxnRefID: i["paymentGatewayTxnRefID"].stringValue, txnStatus1: i["txnStatus1"].stringValue, txnStatus2: i["txnStatus2"].stringValue, remarks: i["remarks"].stringValue, createdOn: i["createdOn"].stringValue, createdBy: i["createdBy"].stringValue, beneficiaryName: i["beneficiaryName"].stringValue,
                                                 beneficiarySerialNo: i["beneficiarySerialNo"].stringValue)
                
                self.transactionList.append(transaction)
            }
            self.tblTransactions.reloadData()
            
           
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
    func getCurrentDateTime1() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    func getCurrentDateTime4() -> String {
       
     
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-" + "01"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
        
        
    }
    func getCurrentDateTime2() -> String {
        
        
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    func getCurrentDateTime3() -> String {
     
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM-yyyy"
        let formattedDate = "01-" + format.string(from: date)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTransactionCell") as! MyTransactionsTableViewCell
        let transaction = transactionList[indexPath.row]
        cell.refNoLbl.text = transaction.transactionRefNo
        cell.setMyTransaction(transaction: transaction)
        cell.delegate = self
        return cell
    }
    func PutDate(dateVal: String) {
        
       // tblTransactions.isHidden = false
        if(self.dateField == 0)
        {
            
            fromDateTextField.text = dateVal
        }
        else if(dateField == 1)
        {
            toDateTextField.text = dateVal
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
extension MyTransactionsListViewController:MyTransactionDelegate{
    func showDetails(transactionRefNo: String) {
        
        timer.invalidate()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.defaults.set(transactionRefNo, forKey: "transactionRefNo")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionDetails") as! TransactionDetailsViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
