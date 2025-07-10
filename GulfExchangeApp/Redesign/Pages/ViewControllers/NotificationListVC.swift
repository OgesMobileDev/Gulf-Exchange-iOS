//
//  NotificationListVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield

class NotificationListVC: UIViewController {

    //MARK: - Variable Declaration
    
    @IBOutlet weak var baseTableVIew: UITableView!
    
    @IBOutlet var titlenotlabl: UILabel!
    
    @IBOutlet var subtitlenotlabel: UILabel!
    
    var notifyID:String = ""
    var notificationArray:[Notificationn] = []
    var timer = Timer()
    var timerGesture = UITapGestureRecognizer()
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    var udid:String!
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        if notificationArray.isEmpty{
            baseTableVIew.isHidden = true
        }
        
        setView()
        
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        let data = ["notificationRead": false] as [String : Bool]
        NotificationCenter.default.post(name: notificationChangeNotification, object: nil, userInfo: data)
        addNavbar()
        self.baseTableVIew?.register(UINib.init(nibName: "NotificationListTableCell", bundle: .main), forCellReuseIdentifier: "NotificationListTableCell")
        baseTableVIew?.delegate = self
        baseTableVIew?.dataSource = self
        baseTableVIew.showsVerticalScrollIndicator = false
        self.getToken(num: 1)
//timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
//timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
//    self.view.isUserInteractionEnabled = true
//    self.view.addGestureRecognizer(timerGesture)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.shared.fetchToken { token in
            if let token = token {
                // Call login session update
                APIManager.shared.updateSession(sessionType: "1", accessToken: token) { responseCode in
                    if responseCode == "S222" {
                        print("Session Valid")
                    } else {
                        self.handleSessionError()
                    }
                }
            } else {
                print("Failed to fetch token")
            }
        }
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    
    func setView()
    {
        
        titlenotlabl.text = (NSLocalizedString("You have no notifications", comment: ""))
        subtitlenotlabel.text = (NSLocalizedString("Your notifications will appear here when they arrive.", comment: ""))
        
    }
    
    
    func handleSessionError() {
        //        if !defaults.string(forKey: "biometricenabled") == "biometricenabled"{
        //
        //        }
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
        self.defaults.set("logoutbiometrc", forKey: "logoutbiometrc")
                UserDefaults.standard.set(false, forKey: "isLoggedIN")
        //        UserDefaults.standard.removeObject(forKey: "biometricenabled")
                
                if let navigationController = self.navigationController {
                    for controller in navigationController.viewControllers {
                        if let tabController = controller as? MainLoginViewController {
                            navigationController.popToViewController(tabController, animated: true)
                            return
                        }
                    }
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
    }
    
    //MARK: - Functions
    
    @objc func userIsInactive() {
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
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("notifications", comment: "")
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
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
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    
    //MARK: - API Calls

    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
    func getNotifications(access_token:String) {
        self.notificationArray.removeAll()
        if notificationArray.isEmpty{
            baseTableVIew.isHidden = true
        }
        self.baseTableVIew.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/listordeletenotification"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"notificationID":"","messageReadFlag":"READ","actionType":"LIST"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            print("resp",response)
            let resultArray = myResult!["notificationList"]
            for i in resultArray.arrayValue{
                let notification = Notificationn(createdOn: i["createdOn"].stringValue, customerIDNo: i["customerIDNo"].stringValue, customerRegNo: i["customerRegNo"].stringValue, messageReadFlag: i["messageReadFlag"].stringValue, messageStatus: i["messageStatus"].stringValue, messageValidFrom: i["messageValidFrom"].stringValue, messageValidTo: i["messageValidTo"].stringValue, notifyDate: i["notifyDate"].stringValue, notifyID: i["notifyID"].stringValue, notifyMessage: i["notifyMessage"].stringValue, notifyStatus: i["notifyStatus"].stringValue, responseCode: i["responseCode"].stringValue, responseMessage: i["responseMessage"].stringValue)
                self.notificationArray.append(notification)
            }
            if self.notificationArray.isEmpty{
                self.baseTableVIew.isHidden = true
            }else{
                self.baseTableVIew.isHidden = false
            }
            self.baseTableVIew.reloadData()
        })
    }
    func deleteNotificationFromList(notifyId:String,access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/listordeletenotification"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"notificationID":notifyId,"actionType":"DELETE"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
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
}
extension NotificationListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListTableCell", for: indexPath) as! NotificationListTableCell
        let notification = notificationArray[indexPath.row]
        cell.setNotification(notification: notification)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let notification = notificationArray[indexPath.row]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main11", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationDetailsVC") as! NotificationDetailsVC
        nextViewController.notification = notification
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
/*
 if indexPath.row == 0{
     cell.setTimeData(timeString: "2024-10-29 14:15:45")
 }else if indexPath.row == 1{
     cell.setTimeData(timeString: "2024-10-28 14:15:45")
 }else if indexPath.row == 2{
     cell.setTimeData(timeString: "2024-10-26 14:15:45")
 }else if indexPath.row == 3{
     cell.setTimeData(timeString: "2024-09-28 14:15:45")
 }else if indexPath.row == 4{
     cell.setTimeData(timeString: "2024-08-28 14:15:45")
 }
 */
