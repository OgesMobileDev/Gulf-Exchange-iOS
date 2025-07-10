//
//  HelpVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import MessageUI
import ScreenShield

class HelpVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var branchBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var whatsappBtn: UIButton!
    @IBOutlet weak var supportBtn: UIButton!
    
    
    @IBOutlet var findthenearestbranchlabel: UILabel!
    
    @IBOutlet var ifyouwouldliketovistuslabel: UILabel!
    
    @IBOutlet var emailuslabel: UILabel!
    
    
    @IBOutlet var customercarelabel: UILabel!
    
    
    @IBOutlet var letswhatsapplabel: UILabel!
    
    @IBOutlet var getquickresoponselabel: UILabel!
    
    
    
    @IBOutlet var gulfexchangecompanylabel: UILabel!
    @IBOutlet var customersupportlabel: UILabel!
    
    
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        
        subTitle.isHidden = true
        branchBtn.setTitle("", for: .normal)
        emailBtn.setTitle("", for: .normal)
        whatsappBtn.setTitle("", for: .normal)
        supportBtn.setTitle("", for: .normal)
        
        setView()
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("help", languageCode: "en")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loggedIn = (UserDefaults.standard.object(forKey: "isLoggedIN") as? Bool) ?? false
        if loggedIn == true{
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
        }
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    
    func setView()
    {
//       // branchBtn.setTitle(NSLocalizedString("sending_amount", comment: ""), for: .normal)
//        emailBtn.setTitle("", for: .normal)
//        whatsappBtn.setTitle("", for: .normal)
//        supportBtn.setTitle("", for: .normal)
        
        
        
        
        //customer_support
        
        findthenearestbranchlabel.text = NSLocalizedString("Find the nearest branch", comment: "")
        
        
        ifyouwouldliketovistuslabel.text = NSLocalizedString("If you would like to visit us, please locate the nearest branch", comment: "")
        emailuslabel.text = NSLocalizedString("Email us on", comment: "")
        customercarelabel.text = NSLocalizedString("customercare@gulfexchange.com.qa", comment: "")
        letswhatsapplabel.text = NSLocalizedString("Let’s Whatsapp", comment: "")
        
        customersupportlabel.text = NSLocalizedString("customer_support", comment: "")
        
        gulfexchangecompanylabel.text = NSLocalizedString("Gulf Exchange Company", comment: "") + "   " +  NSLocalizedString("Ali Bin Abdullah St, Old Al Ghanim", comment: "")
        
        
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
    @IBAction func branchBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("find the nearest branch", languageCode: "en")
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: BranchListVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "BranchListVC") as! BranchListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func emailBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("email us on", languageCode: "en")
        }
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["customercare@gulfexchange.com.qa"])
            mail.setMessageBody("<p> </p>", isHTML: true)
            
            present(mail, animated: true)
        } else if let emailUrl = createEmailUrl(to: "online@gulfexchange.com.qa") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(emailUrl)
            } else {
                UIApplication.shared.openURL(emailUrl)
            }
        }
    }
    @IBAction func whatsappBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("lets whatsapp ", languageCode: "en")
        }
        
        let phoneNumber = "+97444383222"
//        "+97444383293"
        
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            // WhatsApp is not installed
        }
    }
    @IBAction func supportBtnTapped(_ sender: Any) {
        
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("customer support ", languageCode: "en")
        }
        makePhoneCall()
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
        self.navigationItem.rightBarButtonItem  = notificationBtn
        self.navigationItem.title = NSLocalizedString("help", comment: "")
        
//        self.navigationItem.title = NSLocalizedString("customer_support", comment: "")
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func notificationAction(){
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("notification", languageCode: "en")
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: NotificationListVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationListVC") as! NotificationListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func makePhoneCall() {
        let number = "+97444383222"
        self.callPhoneNumber(number)
        
//        // Step 1: Define the phone numbers
//        let phoneNumbers = ["+97433365187", "+97455907270"]
//        
//        // Step 2: Create an alert to let the user choose a number
//        let alert = UIAlertController(title: "Choose Number", message: "Select a phone number to call", preferredStyle: .actionSheet)
//        
//        // Step 3: Add an action for each phone number
//        for number in phoneNumbers {
//            alert.addAction(UIAlertAction(title: number, style: .default, handler: { _ in
//                self.callPhoneNumber(number)
//            }))
//        }
//        
//        // Step 4: Add a cancel option
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        
//        // Step 5: Present the alert
//        if let topController = UIApplication.shared.windows.first?.rootViewController {
//            topController.present(alert, animated: true, completion: nil)
//        }
    }
    
    // Function to initiate the phone call
    func callPhoneNumber(_ phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // Show an alert if the device cannot make calls
            let alert = UIAlertController(title: "Error", message: "Your device cannot make calls.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            if let topController = UIApplication.shared.windows.first?.rootViewController {
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func createEmailUrl(to: String) -> URL? {
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)")
        let defaultUrl = URL(string: "mailto:\(to)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
