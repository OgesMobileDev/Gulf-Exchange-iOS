//
//  CurrencyRateViewController.swift
//  GulfExchangeApp
//
//  Created by test on 23/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class CurrencyRateViewController: UIViewController {
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var transferLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var flagImg: UIImageView!
    
    let defaults = UserDefaults.standard
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
        
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("currency_rate", comment: "")
        setFont()
        setFontSize()
        
        let code:String = defaults.string(forKey: "ge_countries_c_code")!.lowercased()
        let url = flag_url1 + code + ".png"
        print("url ",url)
       // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
        let imgResource = URL(string: url)
        self.flagImg.kf.setImage(with: imgResource)
        
        self.currencyLbl.text = defaults.string(forKey: "currency_master_name_en")!
        
        self.getToken()
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
        currencyLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        transferLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        rateLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
    }
    func setFontSize() {
        currencyLbl.font = currencyLbl.font.withSize(20)
        transferLbl.font = transferLbl.font.withSize(14)
        rateLbl.font = rateLbl.font.withSize(14)
    }
    func getToken() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
         
      //let url =  "https://78.100.141.203:8181/gecomobileapi/" + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        //testurl  https://gulfexchange.com.qa/storage/datafolder/flags/flags-medium/in.png
        
        print("urlss",url)
        
         let str_encode_val = auth_client_id + ":" + auth_client_secret
         let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
       // let encodedValue = "GulfExe:gulf".data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        CurrencyRateViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token  ",token)
                self.feelookup(receCountry: self.defaults.string(forKey: "ge_countries_3_code")!, receCurrency: self.defaults.string(forKey: "currency_master_code")!, access_token: token)
                break
            case .failure:
                break
            }
            
        })
    }
    func feelookup(receCountry:String,receCurrency:String,access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/feelookup"
        let params:Parameters =  ["agentId":agentId,"token":token_remi,"timeStamp":dateTime,"sendCountry":"QAT","sendCurrency":"QAR","receiveCountry":receCountry,"receiveCurrency":receCurrency,"deliveryOption":"ACCOUNT_DEPOSIT","providerId":"1","sendAmount":"1"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        CurrencyRateViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["resposeCode"]
            print("respCode",respCode)
            if(respCode == "0")
            {
                let rateStr = myResult!["retailExchangeRate"].stringValue
                print("rateStr",rateStr)
                if(rateStr.contains("."))
                {
                    let array = rateStr.components(separatedBy: ".")
                    let sub = array[1]
                    if(sub.count > 4)
                    {
                        let rateDouble = myResult!["retailExchangeRate"].doubleValue
                        let rate = String(format: "%.4f", rateDouble)
                        if(rate == "0.0" || rate == "")
                        {
                            self.rateLbl.text = "---"
                        }
                        else{
                            let text = "1 QAR = " + rate + " " + self.defaults.string(forKey: "currency_master_code")!
                            let range = (text as NSString).range(of: rate)

                            let attributedString = NSMutableAttributedString(string:text)
                            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: range)
                            
                            self.rateLbl.attributedText = attributedString
                            print("rateStr1",attributedString)
                        }
                    }
                    else{
                        let rate = myResult!["retailExchangeRate"].stringValue
                        if(rate == "0.0" || rate == "")
                        {
                            self.rateLbl.text = "---"
                        }
                        else{
                            let text = "1 QAR = " + rate + " " + self.defaults.string(forKey: "currency_master_code")!
                            let range = (text as NSString).range(of: rate)

                            let attributedString = NSMutableAttributedString(string:text)
                            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: range)
                            
                            self.rateLbl.attributedText = attributedString
                            print("rateStr1.2",attributedString)
                        }
                    }
                }
                else{
                    let text = "1 QAR = " + rateStr + " " + self.defaults.string(forKey: "currency_master_code")!
                    let range = (text as NSString).range(of: rateStr)

                    let attributedString = NSMutableAttributedString(string:text)
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: range)
                    
                    self.rateLbl.attributedText = attributedString
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
}
