//
//  FAQVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 26/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import ScreenShield

class FAQVC: UIViewController{
    
    //MARK: - Variable Declaration
    
    @IBOutlet weak var tableView: UITableView!
    
    var faqArray:[FAQItem] = []
    var timerGesture = UITapGestureRecognizer()
    var timer = Timer()
    
    let defaults = UserDefaults.standard
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    //MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerTableViewCell")
        getfaqlist()
        addNavbar()
//        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
//        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
//        self.view.isUserInteractionEnabled = true
//        self.view.addGestureRecognizer(timerGesture)
        
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    //MARK: - Functions
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
        isLoggedIN = .no
        let data = ["isLoggedIN": isLoggedIN] as [String : Any]
        NotificationCenter.default.post(name: loginChangedNotification, object: nil, userInfo: data)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is HomePageViewController {
                    self.navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
        }else{
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewControllery
        //        //        self.navigationController?.pushViewController(nextViewController, animated: true)
        //                self.navigationController?.pushViewController(nextViewController, animated: true)
        //
        
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
        var notificationIMg = "notification_y"
        if notificationCount{
            notificationIMg = "notification_y"
        }else{
            notificationIMg = "notification_n"
        }
        let notificationBtn = UIBarButtonItem(image: UIImage(named: notificationIMg), style: .done, target: self, action: #selector(notificationAction))
        let helpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItems  = [helpBtn, notificationBtn]
        self.navigationItem.title = "FAQ"
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
    
    //MARK: - API Calls
    func getfaqlist() {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "faq_listing"
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        
        
        let params:Parameters = ["lang":"en"]
        
print("faqlisturl",url)
print("faqlistparams",params)
        
          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["faq_listing"]
                
                for i in resultArray.arrayValue{
                    let faqItem = FAQItem(id: i["id"].intValue, faqTitleEn: i["faq_title_en"].stringValue, faqDescEn: i["faq_desc_en"].stringValue)
                    self.faqArray.append(faqItem)
//                    if let htmlAttributedString = i["faq_desc_en"].stringValue.htmlToAttributedStringWithRedURLs {
//                        let faqItem = FAQItems(id: i["id"].intValue, faqTitleEn: i["faq_title_en"].stringValue, faqDescEn: htmlAttributedString)
//                        self.faqArray.append(faqItem)
//                    }else{
//                        print("Failed to decode JSON ")
//                    }
                    
                     
                }

                self.tableView.reloadData()
                break
            case .failure:
                break
            }
          })
    }
    
    
    
}
extension FAQVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return faqArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqArray[section].isExpanded ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let faqItem = faqArray[indexPath.section]
        
        if indexPath.row == 0 {
            // Title Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
            cell.titleLabel.text = faqItem.faqTitleEn
            cell.setExpanded(faqItem.isExpanded)
            return cell
        } else {
            // Answer Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as! AnswerTableViewCell
//            cell.setData(with: faqItem.faqDescEn, size: 12, font: .regular)
            cell.configure(with: faqItem.faqDescEn, size: 12, font: .regular)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // Toggle the expanded state for the selected FAQ item
            faqArray[indexPath.section].isExpanded.toggle()
            
            // Reload the section to show/hide the answer cell
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


struct FAQResponse: Codable {
    let faqListing: [FAQItem]
    
    enum CodingKeys: String, CodingKey {
        case faqListing = "faq_listing"
    }
}

struct FAQItem: Codable {
    let id: Int
    let faqTitleEn: String
    let faqDescEn: String
    var isExpanded: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case faqTitleEn = "faq_title_en"
        case faqDescEn = "faq_desc_en"
        case isExpanded
    }
}

// test

struct FAQItems {
    let id: Int
    let faqTitleEn: String
    let faqDescEn: NSAttributedString
    var isExpanded: Bool = false  // Track whether the answer cell is expanded
}
