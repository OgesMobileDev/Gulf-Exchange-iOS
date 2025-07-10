//
//  AllServicesViewController.swift
//  GulfExchangeApp
//
//  Created by macbook on 22/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Photos
import Toast_Swift
import ScreenShield

class AllServicesViewController: UIViewController {
    @IBOutlet weak var MainCollectionView: UICollectionView!
    
    @IBOutlet var baseView: UIView!
    var transferSelection:HomeValidationSelection = .none
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    
    let ErrorPopupView = Bundle.main.loadNibNamed("ErrorAlertPopupView", owner: HomePageViewController.self, options: nil)?.first as! ErrorAlertPopupView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MainCollectionView?.register(UINib.init(nibName: "QuickAccess1CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "QuickAccess1CollectionCell")
        MainCollectionView?.delegate = self
        MainCollectionView?.dataSource = self
        addNavbar()
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
    func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("Services", comment: "")
        var notificationIMg = "notification_y"
        if notificationCount{
            notificationIMg = "notification_y"
        }else{
            notificationIMg = "notification_n"
        }
        let notificationBtn = UIBarButtonItem(image: UIImage(named: notificationIMg), style: .done, target: self, action: #selector(notificationAction))
        let helpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItems  = [helpBtn, notificationBtn]
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func heplVCAction(){
        
//        if defaults.bool(forKey: "accessibilityenabled"){
//            SpeechHelper.shared.speak("help", languageCode: "en")
//        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HelpVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func notificationAction(){
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("notification", languageCode: "en")
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: NotificationListVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationListVC") as! NotificationListVC
        self.navigationController?.pushViewController(vc, animated: true)
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
    func navigateFromValidation(){
        switch transferSelection {
        case .bankTransfer:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
            vc.currentSelection = .bankTransfer
            self.navigationController?.pushViewController(vc, animated: true)
        case .cashPickup:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
            vc.currentSelection = .cashPickup
            self.navigationController?.pushViewController(vc, animated: true)
        case .mobileWallet:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
            vc.currentSelection = .mobileWallet
            self.navigationController?.pushViewController(vc, animated: true)
        case .benefDetails:
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: ManageBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageBeneficiaryVC") as! ManageBeneficiaryVC
            self.navigationController?.pushViewController(vc, animated: true)
        case .none:
            print("")
        }
    }
    func addErrorPopup(msg:String,subMsg:String){
        ErrorPopupView.setView(msg: msg, subMsg: subMsg)
        ErrorPopupView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        ErrorPopupView.alpha = 0.0
        view.addSubview(ErrorPopupView)
        UIView.animate(withDuration: 0.3, animations: {
            self.ErrorPopupView.alpha = 1.0
        })
        
    }
    //MARK: - Api Calls
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        print("tokenurl",url)
        //        self.olduserchkstr = "0"
        
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
                    self.validateRemittanceStatus(check: 1, accessToken: token)
                }
                else if(num == 2)
                {
                    
                }
                break
            case .failure:
                break
            }
            
        })
    }
    func validateRemittanceStatus(check:Int,accessToken:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        
        let appVersion = AppInfo.version
                     print("appVersion",appVersion)
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":appVersion,"customerPhone":"IOS","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"ISREMITALLOWED","isExistOrValid":"0"]
        
        print("paramsvalidationutility ",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
             print("respCoderespCoderespCode ",respCode)
            let respMsg = myResult!["responseMessage"].stringValue
            if(respCode == "S1111")
            {
                let CustomerCode = myResult!["casmexCustomerCode"].stringValue
//                    self.casmexCustomerCode = CustomerCode
                self.defaults.set(CustomerCode, forKey: "casmexCustomerCode")
                
                let sessionId = myResult!["casmexSessionId"].stringValue
//                    self.casmexSessionId = sessionId
                self.defaults.set(sessionId, forKey: "casmexSessionId")
                
                let token = myResult!["casmexToken"].stringValue
//                    self.casmexToken = token
                self.defaults.set(token, forKey: "casmexToken")
                
                if(check == 1)
                {
                    self.navigateFromValidation()
                }
                else if(check == 2)
                {
                    
                }
                else if(check == 3)
                {
                    
                }
            }
            else if(respCode == "S2222")
            {
                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                let okAction = UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .cancel){ (action:UIAlertAction) in
                       
                    let CustomerCode = myResult!["casmexCustomerCode"].stringValue
//                    self.casmexCustomerCode = CustomerCode
                    self.defaults.set(CustomerCode, forKey: "casmexCustomerCode")
                    
                    let sessionId = myResult!["casmexSessionId"].stringValue
//                    self.casmexSessionId = sessionId
                    self.defaults.set(sessionId, forKey: "casmexSessionId")
                    
                    let token = myResult!["casmexToken"].stringValue
//                    self.casmexToken = token
                    self.defaults.set(token, forKey: "casmexToken")
                    
                    self.navigateFromValidation()
                                    
                }
                        commonAlert.addAction(okAction)
                self.present(commonAlert, animated: true, completion: nil)
            }
            else if(respCode == "E9999")
            {
                   // AlertView.instance.showAlert(msg: respMsg, action: .attention)
                   // self.getPopupNotificationList()
                    self.getNewVersionalertList()
            }
            else if(respCode == "E7112")
            {
                self.addErrorPopup(msg: respMsg, subMsg: "")
                //original
//                AlertView.instance.showAlert(msg: respMsg, action: .attention)
                
//                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
//                let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
//
//                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                   // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                    let vc: ActualOccupationViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActualOccupationViewController") as! ActualOccupationViewController
//                    self.navigationController?.pushViewController(vc, animated: true)
//
//                }
//                        commonAlert.addAction(okAction)
//                self.present(commonAlert, animated: true, completion: nil)
               
            }
            
            else if(respCode == "E7002")
            {
                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                  
                    if let navigationController = self.navigationController {
                        // Check if ProfileVC exists in the navigation stack
                        if let tabController = navigationController.viewControllers.first(where: { $0 is CustomTabController }) as? CustomTabController {
                            tabController.selectedIndex = 2
                            tabController.profileSelection = 2
                            tabController.setTabSelections(currentIndex: 2)
                            navigationController.popToViewController(tabController, animated: true)
                        } else {
                            // If not in stack, push ProfileVC
                            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                            let storyboard = UIStoryboard(name: "Main10", bundle: nil)
                            if let nextViewController = storyboard.instantiateViewController(withIdentifier: "CustomTabController") as? CustomTabController {
                                nextViewController.profileSelection = 2
                                nextViewController.selectedIndex = 2
                                nextViewController.setTabSelections(currentIndex: 2)
                                navigationController.pushViewController(nextViewController, animated: true)
                            }
                        }
                    } else {
                        print("❌ Error: navigationController is nil. Ensure this view is inside a UINavigationController.")
                    }
                                    
                }
                        commonAlert.addAction(okAction)
                self.present(commonAlert, animated: true, completion: nil)
            }
            
            
            else if(respCode == "E7003")
            {
                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                  
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                   // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let vc: ActualOccupationViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActualOccupationViewController") as! ActualOccupationViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                }
                        commonAlert.addAction(okAction)
                self.present(commonAlert, animated: true, completion: nil)
            }
            
            else
            {
                self.addErrorPopup(msg: NSLocalizedString("u_r_not_allowed", comment: ""), subMsg: NSLocalizedString("contact_customer_care", comment: ""))
//                AlertView.instance.showAlert(msg: NSLocalizedString("u_r_not_allowed", comment: "") + NSLocalizedString("contact_customer_care", comment: ""), action: .attention)
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
    func getNewVersionalertList() {
       var notificMessageList1: [String] = []
       let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
             let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               self.activityIndicator(NSLocalizedString("loading", comment: ""))
               let url = api_url + "application_update_notification"
        let params:Parameters = ["lang": appLang,"device_type":"IOS"]
                 AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                   print("NEWVERRESPONSE",response)
                    self.effectView.removeFromSuperview()
                   switch response.result{
                   case .success:
                       guard let responseData = response.data else {
                           return
                       }
                       guard let myResult = try? JSON(data: responseData) else {
                           return
                       }
                       let popupListing1 = myResult["application_update_notification"]
                       if(popupListing1.count > 0) {
                           for popupObject in popupListing1.arrayValue {
                               let currentItemKey = "app_notf_desc_" + appLang
                               let currentItemEn = "app_notf_desc_en"
                               let desc = popupObject[currentItemKey].stringValue
                               let desc2 = popupObject[currentItemEn].stringValue
                               if(desc != "") {
                               let descString = desc
                               notificMessageList1.append(descString)
                                    print("descprint",descString)
//                                self.showPopupAlert(desc: descString)
                               } else if(desc2 != "") {
                               let desc2String = desc
                               notificMessageList1.append(desc2String)
                                   print("descprint2",desc2String)
//                                self.showPopupAlert(desc: desc2String)
                           }
                       }
                           
//                           let a = ["", "", ""]
//                           let b = notificMessageList
//                        if a == b {
//                             print("Nullcontentpopup",notificMessageList)
//                        }
                          // else
                        //{
                        
                
//                        let vc: WEBVIEWHomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
//
//
//                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                        
                        
                        
                        ///
                           if notificMessageList1.count > 0 {
                           self.showPopupAlertone(descArray: notificMessageList1)
                                 print("contentpopupNEWVER",notificMessageList1)


                               //
//                               print("NullcontentpopupNEWVER",self.oncecheckpopupstr)
                           }
                        ////
                        
                        
                          // }
                        print("contentpopupNEWVERout",notificMessageList1)
                           
                           
                       }
                   break
                   case .failure:
                       break
                   
                   }
                 })
       }
    func showPopupAlertone(descArray: [String]) {
        var arrayFilter = descArray
        if arrayFilter.count > 0 {
//        let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: arrayFilter[0], preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { action in
//            arrayFilter.remove(at: 0)
//            self.showPopupAlert(descArray: arrayFilter)
//        }))
//        self.present(alert, animated: true)
            
            //create view controller
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController")
//            //remove black screen in background
//            vc.modalPresentationStyle = .overCurrentContext
//            //add clear color background
//            vc.view.backgroundColor = UIColor.clear
//            //present modal
//            self.present(vc, animated: true, completion: nil)
            
            
//            let vc: WEBVIEWHomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
//            vc.descArray = descArray
//
//            self.navigationController?.pushViewController(vc, animated: true)
            
            let vc: WEBTEXTVViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBTEXTVViewController") as! WEBTEXTVViewController
            vc.descArray = descArray
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            
    
//            let popupone : WEBVIEWHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
//            self.presentOnRoot(with: popupone, descArray: arrayFilter)
        }
    }
}

extension AllServicesViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QuickAccessMainCollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MainCollectionView.dequeueReusableCell(withReuseIdentifier: "QuickAccess1CollectionCell", for: indexPath) as! QuickAccess1CollectionViewCell
        cell.setdata(image: QuickAccessMainCollectionData[indexPath.row].image, title: QuickAccessMainCollectionData[indexPath.row].title)
        cell.button.tag = indexPath.row
        cell.setSeeAllData()
        cell.button?.addTarget(self, action: #selector(quickAccessTapped), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = MainCollectionView.frame.width / 3
        return CGSize(width: width, height: 96)
//        return CGSize(width: 98, height: 96)
        
    }
    
    @objc func quickAccessTapped(sender: UIButton){
        
        switch sender.tag{
        case 0:
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("bank transfer", languageCode: "en")
            }
            
            transferSelection = .bankTransfer
            getToken(num: 1)
            print(" QuickAccess Tapped \(index)")
            
            
            
        case 1:
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("cash pickup", languageCode: "en")
            }
            
            transferSelection = .cashPickup
            getToken(num: 1)
            print(" QuickAccess Tapped \(index)")
        case 2:
            transferSelection = .mobileWallet
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("mobile wallet transfer", languageCode: "en")
            }
            
            getToken(num: 1)
            print(" QuickAccess Tapped \(index)")
        case 3:
            transferSelection = .benefDetails
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("beneficiaries", languageCode: "en")
            }
            
            getToken(num: 1)
        case 4:
            print(" QuickAccess Tapped \(sender.tag)")
            print(" QuickAccess Tapped \(index)")
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("track transaction", languageCode: "en")
            }
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: TransactionHistoryVC = UIStoryboard.init(name: "Main10", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransactionHistoryVC") as! TransactionHistoryVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("branches", languageCode: "en")
            }
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: BranchListVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "BranchListVC") as! BranchListVC
            self.navigationController?.pushViewController(vc, animated: true)
            print(" QuickAccess Tapped \(sender.tag)")
        case 6:
            print(" QuickAccess Tapped \(sender.tag)")
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("our partners", languageCode: "en")
            }
            
            self.view.makeToast(NSLocalizedString("Coming Soon", comment: ""), duration: 3.0, position: .center)
        case 7:
            print(" QuickAccess Tapped \(sender.tag)")
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("special offers", languageCode: "en")
            }
            
            self.view.makeToast(NSLocalizedString("Coming Soon", comment: ""), duration: 3.0, position: .center)
        case 8:
            print(" QuickAccess Tapped \(sender.tag)")
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("loyality points", languageCode: "en")
            }
            
            self.view.makeToast(NSLocalizedString("Coming Soon", comment: ""), duration: 3.0, position: .center)
        case 9:
            print(" QuickAccess Tapped \(sender.tag)")
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("Gold/FC Rate", languageCode: "en")
            }
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TransferPage1VC") as! TransferPage1VC
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
//            self.view.makeToast(NSLocalizedString("Coming Soon", comment: ""), duration: 3.0, position: .center)
        case 10:
//            self.view.makeToast(NSLocalizedString("Coming Soon", comment: ""), duration: 3.0, position: .center)
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("golalitha rewards", languageCode: "en")
            }
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainGolalita", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaHomeVC") as! GolalitaHomeVC
            self.navigationController?.pushViewController(nextViewController, animated: true)
            print(" QuickAccess Tapped change Golalita ")
        case 11:
            print(" QuickAccess Tapped \(sender.tag)")
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("rate calculater", languageCode: "en")
            }
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: RateCalculatorVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "RateCalculatorVC") as! RateCalculatorVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 12:
            print(" QuickAccess Tapped \(sender.tag)")
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("faq", languageCode: "en")
            }
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: FAQVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "FAQVC") as! FAQVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
   
}
