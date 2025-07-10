//
//  Help1ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 23/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import MessageUI

class Help1ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var callCustomerCareLbl: UILabel!
    @IBOutlet weak var num1Lbl: UILabel!
    @IBOutlet weak var num2Lbl: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var emailUsLbl: UILabel!
    @IBOutlet weak var mailIdLbl: UILabel!
    @IBOutlet weak var sendEmailBtn: UIButton!
    @IBOutlet weak var num1Btn: UIButton!
    @IBOutlet weak var num2Btn: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    var timer = Timer()

    
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer.invalidate()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        callBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        callBtn.layer.cornerRadius = 15
        sendEmailBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        sendEmailBtn.layer.cornerRadius = 15
        self.title = NSLocalizedString("help", comment: "")
        setFont()
        setFontSize()
    }
    @IBAction func callBtn(_ sender: Any) {
        if(num == 0)
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("select_phone_number", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            if(num == 1)
            {
//                if let url = URL(string: "tel://\(num1Lbl.text!)"),
//                UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }
                print("num1",num1Lbl.text!)
                if let url = URL(string: "tel://\(44383293)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            else if( num == 2)
            {
//                if let url = URL(string: "tel://\(num2Lbl.text!)"),
//                UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }
                print("num2",num2Lbl.text!)
                if let url = URL(string: "tel://\(44383294)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        }
    }
    @IBAction func sendEmailBtn(_ sender: Any) {
        sendEmail()
    }
    @IBAction func num1Btn(_ sender: Any) {
        num = 1
        view1.backgroundColor = UIColor(red: 0.82, green: 0.83, blue: 0.84, alpha: 1.00)
        view2.backgroundColor = nil
        
    }
    @IBAction func num2Btn(_ sender: Any) {
        num = 2
        view2.backgroundColor = UIColor(red: 0.82, green: 0.83, blue: 0.84, alpha: 1.00)
        view1.backgroundColor = nil
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    func setFont() {
        callCustomerCareLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        num1Lbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        num2Lbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        callBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        emailUsLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        mailIdLbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        sendEmailBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        callCustomerCareLbl.font = callCustomerCareLbl.font.withSize(14)
        num1Lbl.font = num1Lbl.font.withSize(18)
        num2Lbl.font = num2Lbl.font.withSize(18)
        emailUsLbl.font = emailUsLbl.font.withSize(14)
        mailIdLbl.font = mailIdLbl.font.withSize(14)
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["online@gulfexchange.com.qa"])
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
