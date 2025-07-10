
import UIKit
import Alamofire
import SwiftyJSON
import WebKit

class RemittancePage5ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()

    
    var webView:WKWebView!
    override func loadView() {
        
        webView = WKWebView()
        webView?.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
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
    
    let defaults = UserDefaults.standard
    var customerFirstName:String = ""
    var customerMiddleName:String = ""
    var customerLastName:String = ""
    var customerAddress:String = ""
    var customerPhone:String = ""
    var customerZipCode:String = ""
    var customerDOB:String = ""
    var customerCountryOfBirth:String = ""
    var customerBirthPlace:String = ""
    var customerGender:String = ""
    var customerNationality:String = ""
    var customerOccupation:String = ""
    var customerEmail:String = ""
    var customerIDNo:String = ""
    var customerIDType:String = ""
    var customerIDExpiryDate:String = ""
    var customerIDIssuedBy:String = ""
    var customerIDIssuedCountry:String = ""
    var customerCity:String = ""
    var customerCountry:String = ""
    var customerMobile:String = ""
    var customerNameArabic:String = ""
    var customerEmployerName:String = ""
    var customerExpectedIncome:String = ""
    var customermZone:String = ""
    var customerWorkingAddress1:String = ""
    
    
    var txnRefNo:String = ""
    var con_id:String = ""
    var status:String = ""
    var message:String = ""
    var cardNo:String = ""
    var cardHolder:String = ""
    var cardExpDate:String = ""
    var total_amount:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        timer.invalidate()
        timer.invalidate()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        self.getToken(num: 1)
        
        txnRefNo = defaults.string(forKey: "refNo")!
        total_amount = defaults.string(forKey: "totalAmount")!
        
        let url = URL(string: payment_gateway_url + "payment/secure_hash_generation.php?TRefNo=" + self.txnRefNo + "&TPayAm=" + self.total_amount + "&type=1")
        //check test
        print("urlwebview  ",url)
        
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true

    }
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
//            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "Payment"
    }
    @objc func customBackButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            //urlStr is what you want
            print("url  ",urlStr)
            let success_url = payment_gateway_url + "payment/mobile_app_payment_success.php?"
            let failure_url = payment_gateway_url + "payment/mobile_app_payment_failure.php?"
            let cancel_url = payment_gateway_url + "payment/mobile_app_payment_cancel.php?"
            if(urlStr.contains("success"))
            {
                let removed = urlStr.replacingOccurrences(of: success_url, with: "")
                    print("removed",removed)
                    
                    let array = removed.components(separatedBy: "&")
                    let cardStr = array[0]
                    let cardExpStr = array[1]
                    let conIdStr = array[2]
                
                    print("a ",cardStr)
                    print("b ",cardExpStr)
                    print("c ",conIdStr)
                    
                self.cardNo = cardStr.replacingOccurrences(of: "CardNo=", with: "")
                self.cardExpDate = cardExpStr.replacingOccurrences(of: "CardExDate=", with: "")
                self.con_id = conIdStr.replacingOccurrences(of: "Con_ID=", with: "")
                    
                    print("a ",cardNo)
                    print("b ",cardExpDate)
                    print("c ",con_id)
                
                self.status = "SUCCESS"
                self.message = "Payment processed successfully"
                
                self.getToken(num: 2)
            }
            else if(urlStr.contains("failure"))
            {
                let removed = urlStr.replacingOccurrences(of: failure_url, with: "")
                    print("removed",removed)
                    
                    let array = removed.components(separatedBy: "&")
                    let cardStr = array[0]
                    let cardExpStr = array[1]
                    let conIdStr = array[2]
                
                    print("a ",cardStr)
                    print("b ",cardExpStr)
                    print("c ",conIdStr)
                    
                self.cardNo = cardStr.replacingOccurrences(of: "CardNo=", with: "")
                self.cardExpDate = cardExpStr.replacingOccurrences(of: "CardExDate=", with: "")
                self.con_id = conIdStr.replacingOccurrences(of: "Con_ID=", with: "")
                    
                    print("a ",cardNo)
                    print("b ",cardExpDate)
                    print("c ",con_id)
                self.status = "FAILED"
                self.message = "Payment failed"
                
                self.getToken(num: 2)
            }
            else if(urlStr.contains("cancel"))
            {
                if(urlStr.contains("Con_ID="))
                {
                    let removed = urlStr.replacingOccurrences(of: cancel_url, with: "")
                        print("removed",removed)
                        
                        let array = removed.components(separatedBy: "&")
                        let cardStr = array[0]
                        let cardExpStr = array[1]
                        let conIdStr = array[2]
                    
                        print("a ",cardStr)
                        print("b ",cardExpStr)
                        print("c ",conIdStr)
                        
                    self.cardNo = cardStr.replacingOccurrences(of: "CardNo=", with: "")
                    self.cardExpDate = cardExpStr.replacingOccurrences(of: "CardExDate=", with: "")
                    self.con_id = conIdStr.replacingOccurrences(of: "Con_ID=", with: "")
                        
                        print("a ",cardNo)
                        print("b ",cardExpDate)
                        print("c ",con_id)
                }
                self.status = "CANCELED"
                self.message = "Payment canceled"
                self.getToken(num: 2)
            }
        }

        decisionHandler(.allow)
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        if let popoverPresentationController = alert.popoverPresentationController {
                   popoverPresentationController.sourceView = self.view
                   popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
               }
        self.present(alert, animated: true)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler()
        }))
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
        }
        self.present(alertController, animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler(true)
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        if let popoverPresentationController = alertController.popoverPresentationController {
                          popoverPresentationController.sourceView = self.view
                          popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                      }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {

        let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.text = defaultText
        }

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }

        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in

            completionHandler(nil)

        }))
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        timer.invalidate()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
    }
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        RemittancePage5ViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                if(num == 1)
                {
                    self.viewCustomer(access_token: token)
                }
                else if(num == 2)
                {
                    self.updatePaymentGateway(access_token: token)
                }
                else if(num == 3)
                {
                    self.processRemittance(access_token: token)
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
        let url = ge_api_url_new + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        RemittancePage5ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"].stringValue
            let responseMessage = myResult!["responseMessage"].stringValue
            self.customerAddress = myResult!["customerAddress"].stringValue
            self.customerBirthPlace = myResult!["customerBirthPlace"].stringValue
            self.customerCity = myResult!["customerCity"].stringValue
            self.customerCountry = myResult!["customerCountry"].stringValue
            self.customerCountryOfBirth = myResult!["customerCountryOfBirth"].stringValue
            self.customerDOB = myResult!["customerDOB"].stringValue
            self.customerFirstName = myResult!["customerFirstName"].stringValue
            self.customerIDExpiryDate = myResult!["customerIDExpiryDate"].stringValue
            self.customerIDIssuedBy = myResult!["customerIDIssuedBy"].stringValue
            self.customerIDIssuedCountry = myResult!["customerIDIssuedCountry"].stringValue
            self.customerIDNo = myResult!["customerIDNo"].stringValue
            self.customerIDType = myResult!["customerIDType"].stringValue
            self.customerLastName = myResult!["customerLastName"].stringValue
            self.customerMiddleName = myResult!["customerMiddleName"].stringValue
            self.customerMobile = myResult!["customerMobile"].stringValue
            self.customerNationality = myResult!["customerNationality"].stringValue
            self.customerNameArabic = myResult!["customerNameArabic"].stringValue
            self.customerPhone = myResult!["customerPhone"].stringValue
            self.customerZipCode = myResult!["customerZipCode"].stringValue
            self.customerEmail = myResult!["email"].stringValue
            self.customerEmployerName = myResult!["employerName"].stringValue
            self.customerExpectedIncome = myResult!["expectedIncome"].stringValue
            self.customerGender = myResult!["gender"].stringValue
            self.customermZone = myResult!["mZone"].stringValue
            self.customerOccupation = myResult!["occupation"].stringValue
            self.customerWorkingAddress1 = myResult!["workingAddress1"].stringValue
            
            
        })
    }
    func updatePaymentGateway(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let dateTime1:String = getCurrentDateTime1()
        let url = ge_api_url_new + "utilityservice/updatepaymentgatewaystatus"
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
               print("appVersion",appVersion)
        
        UserDefaults.standard.removeObject(forKey: "Trackingcode")
        
        
        let params:Parameters =  [
            "partnerId":partnerId,
            "token":token,
            "requestTime":dateTime,
            "customerID":defaults.string(forKey: "USERID")!,
            "customerPassword":defaults.string(forKey: "PASSW")!,
            "mpin":defaults.string(forKey: "PIN")!,
            "txnRefNo":self.txnRefNo,
            "payReqID":"",
            "payMerchantID":"3857011131",
            "bankID":"QPAYPG01",
            "requestType":"PAYMENT_INITIATED",
            "refundOrderID":"",
            "paymetDesc":self.con_id,
            "pgTxnDate":dateTime1,
            "respStatus":self.status,
            "respMSG":self.message,
            "respOrigionalStatus":self.status,
            "respOrigionalMessage":self.message,
            "confirmationID":self.con_id,
            "origionalConfID":self.con_id,
            "txnCCY":"QAR",
            "txnAmount":defaults.string(forKey: "totalAmount")!,
            "origionalReversalStatus":"",
            "cardNO":self.cardNo,
            "cardHolderName":self.cardHolder,
            "deviceType":"IOS",
            "versionName":appVersion,
            "cardExpiryeDate":self.cardExpDate,
            "approvalCode":""
        ]
          print("urlupdatepaymentapi ",url)
        print("paramsupdatepaymentapi ",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        RemittancePage5ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("updatetestrespp ",response)
            self.effectView.removeFromSuperview()
             let respCode = myResult!["responseCode"]
            if(respCode == "9995") || (respCode == "1000")
            {
                let Trackingcode = myResult!["responseMessage"].stringValue
                self.defaults.set(Trackingcode, forKey: "Trackingcode")
                print("Trackingcode ",Trackingcode)
                print("updatetest ",response)
                
            }
            
            
            if(respCode == "S113" && self.status == "SUCCESS")
            {
                self.getToken(num: 3)
            }
            
            
            else if(respCode != "S113" && self.status == "SUCCESS")
            {
                self.sendEmail(paymentMsg: "Transaction initiated", processStatus: "I000")
                
                self.defaults.set("SUCCESS_INITIATED", forKey: "txnStatus")
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem6") as! RemittancePage6ViewController
//                self.navigationController?.pushViewController(nextViewController, animated: true)
                
                let data = ["transactionComplete": true] as [String : Bool]
                NotificationCenter.default.post(name: transactionChangeNotification, object: nil, userInfo: data)
                self.navigationController?.popViewController(animated: true)

            }
            else
            {
                self.sendEmail(paymentMsg: "Transaction Failed", processStatus: "E000")
                self.defaults.set("FAILED", forKey: "txnStatus")
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem6") as! RemittancePage6ViewController
//                self.navigationController?.pushViewController(nextViewController, animated: true)
                let data = ["transactionComplete": true] as [String : Bool]
                NotificationCenter.default.post(name: transactionChangeNotification, object: nil, userInfo: data)
                self.navigationController?.popViewController(animated: true)
            }
            
            
        })
    }
    func processRemittance(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "remittance/processremittance"
        let params:Parameters =  ["agentID":agentId,
                                  "token":token_remi,
                                  "timeStamp":dateTime,
                                  "idExpiryDate":self.customerIDExpiryDate,
                                  "transactionId":self.txnRefNo,
                                  "deliveryOption":"ACCOUNT_DEPOSIT",
                                  "providerId":providerId,
                                  "sendAmount":defaults.string(forKey: "amount1")!,
                                  "quotedExchangeRate":defaults.string(forKey: "retailExchangeRate")!,
                                  "senderFirstName":self.customerFirstName,
                                  "senderMiddleName":"",
                                  "senderLastName":self.customerLastName,
                                  "senderAddress":self.customerAddress,
                                  "senderPhone":self.customerMobile,
                                  "senderZipCode":self.customerZipCode,
                                  "senderDob":self.customerDOB,
                                  "senderId":defaults.string(forKey: "USERID")!,
                                  "senderIDType":self.customerIDType,
                                  "senderNationality":self.customerNationality,
                                  "sendCountry":self.customerCountry,
                                  "senderCob":"QAT",
                                  "sendCurrency":"QAR",
                                  "receiverFirstName":defaults.string(forKey: "first_name")!,
                                  "receiverMiddleName":"",
                                  "receiverLastName":defaults.string(forKey: "last_name")!,
                                  "receiverAddress":defaults.string(forKey: "address")!,
                                  "receiverPhone":defaults.string(forKey: "mobile")!,
                                  "receiverZipCode":"",
                                  "receiverDob":"",
                                  "receiverId":"",
                                  "receiverIDType":"",
                                  "receiverNationality":"",
                                  "receiverCountry":defaults.string(forKey: "country_name")!,
                                  "receiverCob":defaults.string(forKey: "country_code")!,
                                  "receiveCurrency":defaults.string(forKey: "currency")!,
                                  "receiverBankID":defaults.string(forKey: "bank_code")!,
                                  "receiverBranchCode":defaults.string(forKey: "branch_code")!,
                                  "receiverAccountNumber":defaults.string(forKey: "acc_no")!,
                                  "purposeOfRemittance":defaults.string(forKey: "purpose")!,
                                  "remarks":"","sourceOfFunds":defaults.string(forKey: "source")!,
                                  "relationshipToSender":defaults.string(forKey: "relation")!,
                                  "placeOfBirth":""]
        
        print("processremitanceparams123",params)
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        RemittancePage5ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("process Remi",response)
            self.effectView.removeFromSuperview()
             let respCode = myResult!["resposeCode"]
            
            if(respCode == "EJ1005" || respCode == "EJ1002" || respCode.stringValue.contains("E"))
            {
                self.sendEmail(paymentMsg: "Transaction Failed", processStatus: "E000")
                self.defaults.set("SUCCESS_FAILED", forKey: "txnStatus")
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem6") as! RemittancePage6ViewController
//                self.navigationController?.pushViewController(nextViewController, animated: true)
                let data = ["transactionComplete": true] as [String : Bool]
                NotificationCenter.default.post(name: transactionChangeNotification, object: nil, userInfo: data)
                self.navigationController?.popViewController(animated: true)
            }
            else{
                self.sendEmail(paymentMsg: "Transaction Success", processStatus: "S000")
                self.defaults.set("SUCCESS", forKey: "txnStatus")
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem6") as! RemittancePage6ViewController
//                self.navigationController?.pushViewController(nextViewController, animated: true)
                let data = ["transactionComplete": true] as [String : Bool]
                NotificationCenter.default.post(name: transactionChangeNotification, object: nil, userInfo: data)
                self.navigationController?.popViewController(animated: true)
            }
            
        })
    }
    func sendEmail(paymentMsg:String,processStatus:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "payment_mail"
        let params:Parameters = ["response_amount":defaults.string(forKey: "totalAmount")!,"response_pun":self.txnRefNo,"response_ezconnect_response_date":"1234","senderFirstName":self.customerFirstName,"payment_message":paymentMsg,"processremittance_status":processStatus,"senderemail":self.customerEmail]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("resp",response)
            self.effectView.removeFromSuperview()
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
