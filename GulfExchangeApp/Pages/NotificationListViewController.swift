//
//  NotificationListViewController.swift
//  GulfExchangeApp
//
//  Created by test on 27/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class NotificationListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tblNotification: UITableView!
    var notifyID:String = ""
    var notificationArray:[Notificationn] = []
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()
    
    
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
    var udid:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("notifications", comment: "")
        self.tblNotification.dataSource = self
                self.tblNotification.delegate = self
                self.tblNotification.estimatedRowHeight = 180.0
                self.tblNotification.rowHeight = UITableView.automaticDimension
                self.getToken(num: 1)
        
        
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
            func getToken(num:Int) {
                self.activityIndicator(NSLocalizedString("loading", comment: ""))
                let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
                
                let str_encode_val = auth_client_id + ":" + auth_client_secret
                let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
                let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
                
                NotificationListViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                    print("response",response)
                    self.effectView.removeFromSuperview()
                    switch response.result{
                    case .success:
                        let myresult = try? JSON(data: response.data!)
                        
                        let token:String = myresult!["access_token"].string!
                        print("token  ",token)
                        if(num == 1)
                        {
                            self.getNotifications(access_token: token)
                        }
                        else if(num == 2)
                        {
                            self.deleteNotificationFromList(notifyId: self.notifyID, access_token: token)
                        }
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
            func getNotifications(access_token:String) {
                self.notificationArray.removeAll()
                self.tblNotification.reloadData()
                self.activityIndicator(NSLocalizedString("loading", comment: ""))
                let dateTime:String = getCurrentDateTime()
                let url = ge_api_url + "utilityservice/listordeletenotification"
                let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"notificationID":"","messageReadFlag":"READ","actionType":"LIST"]
                let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
                
                NotificationListViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                    let myResult = try? JSON(data: response.data!)
                    self.effectView.removeFromSuperview()
                    print("resp",response)
                    let resultArray = myResult!["notificationList"]
                    for i in resultArray.arrayValue{
                        let notification = Notificationn(createdOn: i["createdOn"].stringValue, customerIDNo: i["customerIDNo"].stringValue, customerRegNo: i["customerRegNo"].stringValue, messageReadFlag: i["messageReadFlag"].stringValue, messageStatus: i["messageStatus"].stringValue, messageValidFrom: i["messageValidFrom"].stringValue, messageValidTo: i["messageValidTo"].stringValue, notifyDate: i["notifyDate"].stringValue, notifyID: i["notifyID"].stringValue, notifyMessage: i["notifyMessage"].stringValue, notifyStatus: i["notifyStatus"].stringValue, responseCode: i["responseCode"].stringValue, responseMessage: i["responseMessage"].stringValue)
                        self.notificationArray.append(notification)
                    }
                    self.tblNotification.reloadData()
                })
            }
            func deleteNotificationFromList(notifyId:String,access_token:String) {
                self.activityIndicator(NSLocalizedString("loading", comment: ""))
                let dateTime:String = getCurrentDateTime()
                let url = ge_api_url + "utilityservice/listordeletenotification"
                let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"notificationID":notifyId,"actionType":"DELETE"]
                let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
                
                NotificationListViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                    let myResult = try? JSON(data: response.data!)
                    self.effectView.removeFromSuperview()
                    print("resp",response)
                    
                    let respCode = myResult!["responseCode"]
                    
                    if(respCode == "S121")
                    {
                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("notification_deleted", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        self.getToken(num: 1)
                    }
                    else{
                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("notification_not_deleted", comment: ""), action: NSLocalizedString("ok", comment: ""))
                    }
                    
                })
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
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return notificationArray.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell") as! NotificationTableViewCell
                let notification = notificationArray[indexPath.row]
                cell.setNotification(notification: notification)
                cell.delegate = self
                return cell
            }
        }
        extension NotificationListViewController:NotificationDelegate{
            func deleteNotification(notifyId: String) {
                
                
                let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: NSLocalizedString("delete_notification", comment: ""), preferredStyle: .alert)
                       
                       alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
                           self.notifyID = notifyId
                           print("notify",self.notifyID)
                           self.getToken(num: 2)
                       }))
                       alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
                           
                       }))
                       self.present(alert, animated: true)
            }
            
            
        }
