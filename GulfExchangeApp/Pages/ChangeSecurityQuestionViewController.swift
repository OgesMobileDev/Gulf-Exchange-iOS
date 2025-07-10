//
//  ChangeSecurityQuestionViewController.swift
//  GulfExchangeApp
//
//  Created by test on 03/08/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChangeSecurityQuestionViewController: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var secBtn: UIButton!
    @IBOutlet weak var ansTextField: UITextField!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var pinTextfield: UITextField!
    @IBOutlet weak var passwTextfield: UITextField!
    @IBOutlet weak var pinEyeBtn: UIButton!
    @IBOutlet weak var passwEyeBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var secQuesView: UIView!
    @IBOutlet weak var secQuesWhiteView: UIView!
    @IBOutlet weak var tblSecQues: UITableView!
    
    var passwEyeClick = true
    var pinEyeClick = true
    let defaults = UserDefaults.standard
    var question:String = ""
    var answer:String = ""
    var secQuesArray:[SecurityQuestion] = []
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var udid:String!
    
    
        //test
        static let AlamoFireManager: Alamofire.Session = {
            let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
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
                                ansTextField.textAlignment = .right
                               pinTextfield.textAlignment = .right
                               passwTextfield.textAlignment = .right
                             } else {
                                ansTextField.textAlignment = .left
                               pinTextfield.textAlignment = .left
                               passwTextfield.textAlignment = .left
                             }
        saveBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        saveBtn.layer.cornerRadius = 15
        
        setFont()
        setFontSize()
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("change_security_settings", comment: "")
        
        pinTextfield.delegate = self
        passwTextfield.delegate = self
        tblSecQues.dataSource = self
        tblSecQues.delegate = self
        
        
        secBtn.layer.cornerRadius = 5
        secBtn.layer.borderWidth = 0.8
        secBtn.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
        
        self.getSecQues()
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setFont() {
        lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        secBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        ansTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        lbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        pinTextfield.font = UIFont(name: "OpenSans-Regular", size: 14)
        passwTextfield.font = UIFont(name: "OpenSans-Regular", size: 14)
        saveBtn.titleLabel?.font = UIFont(name: "OpenSans-bold", size: 14)
        
    }
    func setFontSize() {
        lbl.font = lbl.font.withSize(14)
        secBtn.titleLabel?.font = secBtn.titleLabel?.font.withSize(14)
        lbl1.font = lbl1.font.withSize(14)
    }
    @IBAction func secBtn(_ sender: Any) {
        secQuesView.isHidden = false
    }
    @IBAction func saveBtn(_ sender: Any) {
        if(secBtn.titleLabel?.text == NSLocalizedString("security_question", comment: ""))
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("sel_sec_que", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        guard let ans = ansTextField.text,ansTextField.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_answer", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        guard let pin = pinTextfield.text,pinTextfield.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_pin", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(pin.count != 4)
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("pin_must", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(pin != defaults.string(forKey: "PIN"))
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("current_pin_invalid", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        guard let passw = passwTextfield.text,passwTextfield.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(passw != defaults.string(forKey: "PASSW"))
        {
            
                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("error_check_current_password", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
        
        }
        self.question = secBtn.titleLabel?.text as! String
        self.answer = ansTextField.text!
        print(question)
        print(answer)
        self.getToken()
    }
    @IBAction func pinEyeBtn(_ sender: Any) {
        if(pinEyeClick == true) {
            pinTextfield.isSecureTextEntry = false
            pinEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            pinTextfield.isSecureTextEntry = true
            pinEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        pinEyeClick = !pinEyeClick
    }
    @IBAction func passwEyeBtn(_ sender: Any) {
        if(passwEyeClick == true) {
            passwTextfield.isSecureTextEntry = false
            passwEyeBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
        } else {
            passwTextfield.isSecureTextEntry = true
            passwEyeBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
        }

        passwEyeClick = !passwEyeClick
    }
    func alertMessage(title:String,msg:String,action:String){
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
            }))
            self.present(alert, animated: true)
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == pinTextfield)
        {
            let maxLength = 4
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if(textField == passwTextfield)
        {
            let maxLength = 16
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return Bool()
    }
    func getToken() {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        LoginViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                self.changeSecurityQues(access_token: token)
                break
            case .failure:
                break
            }
        })
    }
    func changeSecurityQues(access_token:String) {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/resetsecurityquestion"
        let params:Parameters = ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":self.defaults.string(forKey: "USERID")!,"customerPassword":self.defaults.string(forKey: "PASSW")!,"securityQuestion1":self.question,"securityAnswer1":self.answer]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        ChangeSecurityQuestionViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let responseCode = myResult!["responseCode"]
            print("resp",response)
            let respMsg = myResult!["responseMessage"].stringValue
            self.effectView.removeFromSuperview()
            if(responseCode == "S116")
            {
                self.secBtn.setTitleColor(UIColor.lightGray, for: .normal)
                self.secBtn.setTitle("Security Question", for: .normal)
                self.ansTextField.text = ""
                self.pinTextfield.text = ""
                self.passwTextfield.text = ""
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("security_question_reset_success", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
            else{
                
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
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
    func getSecQues() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "security_questions_listing"
        let params:Parameters = ["lang":"en"]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["security_questions_listing"]
                for i in resultArray.arrayValue{
                    let secQues = SecurityQuestion(id: i["id"].stringValue, security_question_en: i["security_question_en"].stringValue)
                    self.secQuesArray.append(secQues)
                }
                self.tblSecQues.reloadData()
              break
            case .failure:
                break
            }
          })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secQuesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secQuesCell1") as! LabelTableViewCell
        let secQues = secQuesArray[indexPath.row]
        cell.label.text = secQues.security_question_en
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell: LabelTableViewCell = self.tblSecQues.cellForRow(at: indexPath) as! LabelTableViewCell
                   let str: String = cell.label.text!
                   secBtn.setTitle("\(str)", for: .normal)
                   secBtn.intrinsicContentSize
                    self.secBtn.setTitleColor(UIColor.black, for: .normal)
                   secQuesView.isHidden = true
    }
}

