//
//  CurrencyRateListViewController.swift
//  GulfExchangeApp
//
//  Created by test on 09/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class CurrencyRateListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    
 var transferratetwodig:String = ""
    
    
    @IBOutlet weak var tblCurrencyRateList: UITableView!
    @IBOutlet var searchTextField: UITextField!
    
    var currencyRateArray:[DailyRate] = []
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    var udid:String!
    override func viewDidLoad() {
        
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
      //  self.tblCurrencyRateList.separatorColor = [UIColor, clearColor];
        self.tblCurrencyRateList.separatorStyle = UITableViewCell.SeparatorStyle.none
        
         //UIView.appearance().semanticContentAttribute = .forcecenter
        //self.UIView.view.appearance().center

        if UIDevice.current.model.hasPrefix("iPad") {
            print("iPadisss")
        } else {
            print("iPhone or iPod Touch isss")
        }
        
        
        iPhoneScreenSizes()
        
        
        super.viewDidLoad()
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            //searchTextField.textAlignment = .right
        } else {
           // searchTextField.textAlignment = .left
        }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("currency_rate", comment: "")
        tblCurrencyRateList.dataSource = self
        tblCurrencyRateList.delegate = self
      //  searchTextField.delegate = self
        getCurrencyRateList(access_token: "")
        
        tblCurrencyRateList.tableFooterView = UIView()

    }
    
    
    func iPhoneScreenSizes() {
            let height = UIScreen.main.bounds.size.height
            switch height {
            case 480.0:
                print("iPhone 3,4")
            case 568.0:
                print("iPhone 5 | iPod touch(7th gen)")
            case 667.0:
                print("iPhone 6 | iPhone SE(2nd gen) | iPhone 8")
            case 736.0:
                print("iPhone 6+ | iPhone 8+")
            case 812.0:
                print("iPhone X | iPhone XS | iPhone 11 Pro")
            case 896.0:
                print("iPhone XR | iPhone XS Max | iPhone 11 | iPhone 11 Pro Max")
            default:
                print("not an iPhone")
            }
        
        if height > 1400
        {
            print("its tab")
        }
        
        
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
       // searchTextField.text = ""
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
    //MARK:- Button Action
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func searchAct(_ sender: Any) {
        getCurrencyRateList(access_token: self.searchTextField.text!)
    }
    //MARK:- Userdefind functions
    func textFieldDidEndEditing(_ textField: UITextField) {
        getCurrencyRateList(access_token: self.searchTextField.text!)
    }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        print("tokenurl",url)
        
        
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
                    self.getCurrencyRateList(access_token: token)
                }
                
                break
            case .failure:
                break
            }
            
        })
    }
    
    
    func getCurrencyRateList(access_token:String) {
        self.currencyRateArray.removeAll()
        self.tblCurrencyRateList.reloadData()
        self.tblCurrencyRateList.isHidden = true
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "shiftservice/showRateBoard"
        
         let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        let dateTime:String = getCurrentDateTime()
        
        let params:Parameters = ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO"),"customerUserID":defaults.string(forKey: "USERID")]
        
        print("url  ",url)
        print("params  ",params)
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            //print("resp",response)
            
       
            print("response  ",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                self.tblCurrencyRateList.isHidden = false
                let myresult = try? JSON(data: response.data!)
                //let resultArray = myresult!["daily_rates_listing"]
                let resultArray = myresult![]
                for i in resultArray.arrayValue{
                    
                    let dailyRate = DailyRate(currency_master_name_en: i["currencyname"].stringValue, currency_master_code: i["currency_master_code"].stringValue, ge_countries_c_code: i["countryBannerCode"].stringValue, ge_countries_3_code: i["countryCode"].stringValue,trasferrate: i["transactionRate"].stringValue,buyrate: i["buyRate"].stringValue,sellrate: i["sellRate"].stringValue)
                    var currency = dailyRate.ge_countries_c_code
                    if(currency == "IN" || currency == "LK" || currency == "BD" || currency == "ID" || currency == "NP" || currency == "PH")
                    {
                        
                    }
                    self.currencyRateArray.append(dailyRate)
                    
                    
               
                    
                    //ge_countries_c_code=countryBannerCode
                    //currency_master_name_en = currencyname
                    //currency_master_code = currencycode illa
                    // ge_countries_3_code = countryCode
                    
                }
                self.tblCurrencyRateList.reloadData()
                break
            case .failure:
                break
                
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyRateArray.count
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            print("iPad")
        }else{
            print("not iPad")
        }
   
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyRateCell") as! CurrencyRateTableViewCell
        tableView.allowsSelection = false
        
        
        
        let dailyRate = currencyRateArray[indexPath.row]
        cell.setCurrencyRate(dailyRate: dailyRate)
        
        let code:String = dailyRate.ge_countries_c_code.lowercased()
        let url = flag_url1 + code + ".png"
        print("url ",url)
        //let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
        let imgResource = URL(string: url)
        cell.flagImg.kf.setImage(with: imgResource)
        //cell.seePriceBtn.layer.borderColor = UIColor.red.cgColor
        
       // cell.transferlabel.center = self.view.center
        
  
        
       // cell.delegate = self
        return cell
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
//extension CurrencyRateListViewController:CurrencyRateDelegate{
//    func seePrice(currency_master_code: String, currency_master_name_en: String, ge_countries_3_code: String, ge_countries_c_code: String) {
//        let currency = currency_master_name_en
//
//
//        self.defaults.set(currency_master_code, forKey: "currency_master_code")
//        self.defaults.set(currency_master_name_en, forKey: "currency_master_name_en")
//        self.defaults.set(ge_countries_3_code, forKey: "ge_countries_3_code")
//        self.defaults.set(ge_countries_c_code, forKey: "ge_countries_c_code")
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rate") as! CurrencyRateViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
//    }
//
//
//}

