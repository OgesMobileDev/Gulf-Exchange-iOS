//
//  CurrencyConverterViewController.swift
//  GulfExchangeApp
//
//  Created by test on 23/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CurrencyConverterViewController: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    @IBOutlet weak var transferView: UIView!
    @IBOutlet weak var transferLbl: UILabel!
    @IBOutlet weak var enterAmountLbl: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var qatarTextField: UITextField!
    @IBOutlet weak var countryLbl: UITextField!
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var selectCountryBtn: UIButton!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var cAmountLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var qarToCurrencyLbl: UILabel!
    @IBOutlet weak var currencyToQarLbl: UILabel!
    @IBOutlet weak var tblCurrency: UITableView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    let defaults = UserDefaults.standard
    var currencyArray:[Currency] = []
    var usdStatus:Int = 0
    var receiveCountry:String = ""
    var receiveCurrency:String = ""
    
    var reciveamounntstr:String = ""
    
    var retailexchangeratestr:String = ""
    
    var lastbottomstr:String = ""
    
    var reciveamountstr:String = ""
    
    
    var udid:String!
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    

        //tst
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
        
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                            let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                            if appLang == "ar" || appLang == "ur" {
                               amountTextField.textAlignment = .right
                               qatarTextField.textAlignment = .right
                               countryLbl.textAlignment = .right
                            } else {
                               amountTextField.textAlignment = .left
                               qatarTextField.textAlignment = .left
                               countryLbl.textAlignment = .left
                            }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("currency_converter", comment: "")

        convertBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        transferView.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        convertBtn.layer.cornerRadius = 15
        self.amountTextField.delegate = self
        self.tblCurrency.dataSource = self
        self.tblCurrency.delegate = self
        setFont()
        setFontSize()
        self.getCurrency()
        
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
    @IBAction func convertBtn(_ sender: Any) {
        self.amountLbl.isHidden = true
        self.cAmountLbl.isHidden = true
        self.currencyLbl.isHidden = true
        self.qarToCurrencyLbl.isHidden = true
        self.currencyToQarLbl.isHidden = true
        guard let amount = amountTextField.text, amountTextField.text?.count != 0 else {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_amount", comment: ""), action: NSLocalizedString(NSLocalizedString("ok", comment: ""), comment: ""))
            return
        }
        let amountInt = Int(amount)
        if(amountInt == nil)
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_amount", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(self.countryLbl.text == "")
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_rec_currency", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        self.getToken()
    }
    @IBAction func selectCurrency(_ sender: Any) {
        self.view1.isHidden = true
        self.view2.isHidden = false
        self.usdStatus = 0
    }
    func setFont() {
        transferLbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        enterAmountLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        amountTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        fromLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        toLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        qatarTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        countryLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        convertBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        transferLbl.font = transferLbl.font.withSize(14)
        enterAmountLbl.font = enterAmountLbl.font.withSize(14)
        amountTextField.font = amountTextField.font?.withSize(14)
        fromLbl.font = fromLbl.font.withSize(14)
        toLbl.font = toLbl.font.withSize(14)
        qatarTextField.font = qatarTextField.font?.withSize(14)
        countryLbl.font = countryLbl.font?.withSize(14) 
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    func getToken() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        CurrencyConverterViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!

                print("token4  ",token)
                self.feelookup(amount: self.amountTextField.text!, receCountry: self.receiveCountry, receCurrency: self.receiveCurrency,  access_token: token)
                break
            case .failure:
                break
            }
        })
    }
    func feelookup(amount:String,receCountry:String,receCurrency:String,access_token:String) {

        self.amountLbl.isHidden = true
        self.cAmountLbl.isHidden = true
        self.currencyLbl.isHidden = true
        self.qarToCurrencyLbl.isHidden = true
        self.currencyToQarLbl.isHidden = true
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/feelookup"
        let params:Parameters =  ["agentId":agentId,"token":token_remi,"timeStamp":dateTime,"sendCountry":"QAT","sendCurrency":"QAR","receiveCountry":receCountry,"receiveCurrency":receCurrency,"deliveryOption":"ACCOUNT_DEPOSIT","providerId":"1","sendAmount":amount]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        CurrencyConverterViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["resposeCode"]
            print("respCode",respCode)
            if(respCode == "0")
            {
                self.amountLbl.isHidden = false
                self.cAmountLbl.isHidden = false
                self.currencyLbl.isHidden = false
                self.qarToCurrencyLbl.isHidden = false
                self.currencyToQarLbl.isHidden = false
                self.amountLbl.text = self.amountTextField.text! + " QAR = "
                let amount = myResult!["receiveAmount"].stringValue
                let amountDouble = Double(amount)
                let doubleStr12 = String(format: "%.5f", amountDouble as! CVarArg)
                let value = Double(doubleStr12)?.removeZerosFromEnd()
                
                //
                
                let reciveamountstrdecimal = myResult!["receiveAmount"].stringValue
                var reciveamountstrdecimalrate = Double(reciveamountstrdecimal)
                self.reciveamountstr = String(format: "%.2f", reciveamountstrdecimalrate as! CVarArg)
                print("reciveamountstr ",self.reciveamountstr)
                print("reciveamountstrold ",value)
                
                //
                self.cAmountLbl.text = self.reciveamountstr
               // self.cAmountLbl.text = value
                self.currencyLbl.text = myResult!["receiveCurrency"].stringValue
                let rateDouble = Double(myResult!["retailExchangeRate"].stringValue)
                let doubleStr1 = String(format: "%.5f", rateDouble as! CVarArg)
                let value1:String = (Double(doubleStr1)?.removeZerosFromEnd())!
                
                let retailExchangeRatedecimal = myResult!["retailExchangeRate"].stringValue
                var retailexchangeratestrdecimalrate = Double(retailExchangeRatedecimal)
                self.retailexchangeratestr = String(format: "%.2f", retailexchangeratestrdecimalrate as! CVarArg)
                print("retailexchangeratestr ",self.retailexchangeratestr)
                print("retailexchangeratestrold ",value1)
                
                
                self.qarToCurrencyLbl.text
                      = "1 QAR = " + self.retailexchangeratestr + " " + myResult!["receiveCurrency"].stringValue
                
              //self.qarToCurrencyLbl.text
                  //  = "1 QAR = " + value1 + " " + myResult!["receiveCurrency"].stringValue
                let sendAmountDouble = Double(self.amountTextField.text!)
                let receiveAmountDouble = Double(amount)
                var reversal = sendAmountDouble!/receiveAmountDouble!
                let doubleStr = String(format: "%.5f", reversal)
                let value3:String = (Double(doubleStr)?.removeZerosFromEnd())!
                //
                let lastbottomstrdecimal = value3
                var lastbottomstrdecimalrate = Double(lastbottomstrdecimal)
                self.lastbottomstr = String(format: "%.2f", lastbottomstrdecimalrate as! CVarArg)
                print("lastbottomstr ",self.lastbottomstr)
                print("lastbottomstrold ",value3)
                
                //
                
                self.currencyToQarLbl.text = "1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR"
              //  self.currencyToQarLbl.text = "1 " + myResult!["receiveCurrency"].stringValue + " = " + value3 + " QAR"
            }
            else
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("not_available", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
        })
    }
    func getCurrency() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "nationalities"
        let params:Parameters = ["lang":"en","keyword":""]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["nationalities_listing"]
                for i in resultArray.arrayValue{
                    
                    let currency = Currency(currency_master_code: i["currency_master_code"].stringValue, currency_master_country_id: i["currency_master_country_id"].stringValue, currency_master_name_en: i["currency_master_name_en"].stringValue, ge_countries_3_code: i["ge_countries_3_code"].stringValue, ge_countries_c_code: i["ge_countries_c_code"].stringValue, ge_countries_c_name: i["ge_countries_c_name"].stringValue)
                    
                    let currencyCode = i["currency_master_code"].stringValue
                    print("currencyCode",currencyCode)
                    if(currencyCode == "QAR" || currencyCode == "INR" || currencyCode == "PHP" || currencyCode == "NPR" || currencyCode == "IDR" || currencyCode == "BDT" || currencyCode == "LKR")
                    {
                        self.currencyArray.append(currency)
                    }
                    if(self.usdStatus == 0 && currencyCode == "USD" )
                    {
                        self.usdStatus = 1
                        self.currencyArray.append(currency)
                    }
                    
                }
                self.tblCurrency.reloadData()
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as! LabelTableViewCell
        let currency = currencyArray[indexPath.row]
        cell.label.text = currency.currency_master_name_en
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as! LabelTableViewCell
        let currency = currencyArray[indexPath.row]
        let currencyStr = currency.currency_master_name_en
        self.countryLbl.text = currencyStr
        self.view2.isHidden = true
        self.view1.isHidden = false
        self.receiveCountry = currency.ge_countries_3_code
        self.receiveCurrency = currency.currency_master_code
    }

}
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
