//
//  RemittancePage6ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 24/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import ScreenShield
class RemittancePage6ViewController: UIViewController {
    @IBOutlet weak var remittanceLbl: UILabel!
    @IBOutlet weak var msgLbl1: UILabel!
    @IBOutlet weak var tickImg: UIImageView!
    @IBOutlet weak var msgLbl2: UILabel!
    @IBOutlet weak var msgLbl3: UILabel!
    @IBOutlet weak var refNoLbl: UILabel!
    @IBOutlet weak var msgLbl4: UILabel!
    @IBOutlet weak var mainMenuBtn: UIButton!
    @IBOutlet weak var msg1: UILabel!
    @IBOutlet weak var msg2: UILabel!
    @IBOutlet weak var msg3: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var trackingcodelabel: UILabel!
    
    @IBOutlet var trackingcodeResplabel: UILabel!
    
    @IBOutlet var trackingnolabelheightconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var trackingnoresponseheightconstraint: NSLayoutConstraint!
    let defaults = UserDefaults.standard
    var txnStatus:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        
        //trackingcodelabel.isHidden = true
        //trackingcodeResplabel.isHidden = true
        mainMenuBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        mainMenuBtn.layer.cornerRadius = 15
        setFont()
        setFontSize()
        txnStatus = defaults.string(forKey: "txnStatus")!
        if(txnStatus == "SUCCESS")
        {
            self.refNoLbl.text = defaults.string(forKey: "refNo")
            
            //tracking code check
            let userdefaultsbranchcode = UserDefaults.standard
            if let savedValue = userdefaultsbranchcode.string(forKey: "Trackingcode"){
                print("Here you will get saved value")
            
                trackingcodelabel.isHidden = false
                trackingcodeResplabel.isHidden = false
                trackingnolabelheightconstraint.constant = 20
                trackingnoresponseheightconstraint.constant = 30
                } else {
                    trackingcodelabel.isHidden = true
                    trackingcodeResplabel.isHidden = true
                trackingnolabelheightconstraint.constant = 0
                trackingnoresponseheightconstraint.constant = 0
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultsbranchcode.set("", forKey: "key")
            }
            
            self.trackingcodeResplabel.text = defaults.string(forKey: "Trackingcode")
            
            
            self.tickImg.image = UIImage(named: "green_tick")
            self.msgLbl1.text = NSLocalizedString("transaction_success", comment: "")
            self.msgLbl2.text = NSLocalizedString("transaction_success1", comment: "")
            self.msg1.isHidden = false
            self.msg2.isHidden = false
            self.msg3.isHidden = false
            //self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + "0 QAR"
            self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + " QAR"
            self.msg2.text = NSLocalizedString("date_transaction", comment: "") + ":" + self.getCurrentDateTime()
            self.msg3.text = NSLocalizedString("payment_status", comment: "")
        }
        else if(txnStatus == "SUCCESS_FAILED")
        {
            self.refNoLbl.text = defaults.string(forKey: "refNo")
            
            //tracking code check
            let userdefaultsbranchcode = UserDefaults.standard
            if let savedValue = userdefaultsbranchcode.string(forKey: "Trackingcode"){
                print("Here you will get saved value")
            
                trackingcodelabel.isHidden = false
                trackingcodeResplabel.isHidden = false
                trackingnolabelheightconstraint.constant = 20
                trackingnoresponseheightconstraint.constant = 30
                } else {
                    trackingcodelabel.isHidden = true
                    trackingcodeResplabel.isHidden = true
                trackingnolabelheightconstraint.constant = 0
                trackingnoresponseheightconstraint.constant = 0
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultsbranchcode.set("", forKey: "key")
            }
            
            self.trackingcodeResplabel.text = defaults.string(forKey: "Trackingcode")
            
            self.tickImg.image = UIImage(named: "error")
            self.msgLbl1.text = NSLocalizedString("transaction_failed", comment: "")
            self.msgLbl2.text = NSLocalizedString("payment_completed", comment: "")
            self.msg1.isHidden = false
            self.msg2.isHidden = false
            self.msg3.isHidden = false
            //self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + "0 QAR"
            self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + " QAR"
            self.msg2.text = NSLocalizedString("date_transaction", comment: "") + ":" + self.getCurrentDateTime()
            self.msg3.text = NSLocalizedString("payment_status", comment: "")
        }
        else if(txnStatus == "SUCCESS_INITIATED")
        {
            self.refNoLbl.text = defaults.string(forKey: "refNo")
            
            
            //tracking code check
            let userdefaultsbranchcode = UserDefaults.standard
            if let savedValue = userdefaultsbranchcode.string(forKey: "Trackingcode"){
                print("Here you will get saved value")
            
                trackingcodelabel.isHidden = false
                trackingcodeResplabel.isHidden = false
                trackingnolabelheightconstraint.constant = 20
                trackingnoresponseheightconstraint.constant = 30
                
                } else {
                    trackingcodelabel.isHidden = true
                    trackingcodeResplabel.isHidden = true
                trackingnolabelheightconstraint.constant = 0
                trackingnoresponseheightconstraint.constant = 0
                
            print("No value in Userdefault,Either you can save value here or perform other operation")
            userdefaultsbranchcode.set("", forKey: "key")
            }
            
            self.trackingcodeResplabel.text = defaults.string(forKey: "Trackingcode")
            
            
            self.tickImg.image = UIImage(named: "green_tick")
            self.msgLbl1.text = NSLocalizedString("transaction_initiated", comment: "")
            self.msgLbl2.text = NSLocalizedString("under_process", comment: "")
            self.msg1.isHidden = false
            self.msg2.isHidden = false
            self.msg3.isHidden = false
           // self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + "0 QAR"
            self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + " QAR"
            self.msg2.text = NSLocalizedString("date_transaction", comment: "") + ":" + self.getCurrentDateTime()
            self.msg3.text = NSLocalizedString("payment_status", comment: "")
        }
        else if(txnStatus == "FAILED")
        {
            self.refNoLbl.text = defaults.string(forKey: "refNo")
            self.trackingcodeResplabel.text = defaults.string(forKey: "Trackingcode")
            
            //tracking code check
             let userdefaultsbranchcode = UserDefaults.standard
             if let savedValue = userdefaultsbranchcode.string(forKey: "Trackingcode"){
                 print("Here you will get saved value")
             
                 trackingcodelabel.isHidden = false
                 trackingcodeResplabel.isHidden = false
                 trackingnolabelheightconstraint.constant = 20
                 trackingnoresponseheightconstraint.constant = 30
                 
                 } else {
                     trackingcodelabel.isHidden = true
                     trackingcodeResplabel.isHidden = true
                 trackingnolabelheightconstraint.constant = 0
                 trackingnoresponseheightconstraint.constant = 0
                 
             print("No value in Userdefault,Either you can save value here or perform other operation")
             userdefaultsbranchcode.set("", forKey: "key")
             }
            
            
            self.tickImg.image = UIImage(named: "error")
            self.msgLbl1.text = NSLocalizedString("transaction_failed", comment: "")
            self.msgLbl2.text = NSLocalizedString("transaction_failed1", comment: "")
            self.msg1.isHidden = false
            self.msg2.isHidden = false
            self.msg3.isHidden = false
           // self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + "0 QAR"
            self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + " QAR"
            self.msg2.text = NSLocalizedString("date_transaction", comment: "") + ":" + self.getCurrentDateTime()
            self.msg3.text = NSLocalizedString("payment_status1", comment: "")
        }
        else if(txnStatus == "CANCELED")
        {
            
            //tracking code check
             let userdefaultsbranchcode = UserDefaults.standard
             if let savedValue = userdefaultsbranchcode.string(forKey: "Trackingcode"){
                 print("Here you will get saved value")
             
                 trackingcodelabel.isHidden = false
                 trackingcodeResplabel.isHidden = false
                 trackingnolabelheightconstraint.constant = 20
                 trackingnoresponseheightconstraint.constant = 30
                 
                 } else {
                     trackingcodelabel.isHidden = true
                     trackingcodeResplabel.isHidden = true
                 trackingnolabelheightconstraint.constant = 0
                 trackingnoresponseheightconstraint.constant = 0
                 
             print("No value in Userdefault,Either you can save value here or perform other operation")
             userdefaultsbranchcode.set("", forKey: "key")
             }
            
            
            
            self.refNoLbl.isHidden = true
            self.msgLbl3.isHidden = true
            self.tickImg.image = UIImage(named: "error")
            self.msgLbl1.text = "Transaction Canceled!"
            self.msgLbl2.text = "Your transaction has been canceled."
            self.msg1.isHidden = true
            self.msg2.isHidden = true
            self.msg3.isHidden = true
    
        }
        else if(txnStatus == "HOLD")
        {
            
            //tracking code check
             let userdefaultsbranchcode = UserDefaults.standard
             if let savedValue = userdefaultsbranchcode.string(forKey: "Trackingcode"){
                 print("Here you will get saved value")
             
                 trackingcodelabel.isHidden = false
                 trackingcodeResplabel.isHidden = false
                 trackingnolabelheightconstraint.constant = 20
                 trackingnoresponseheightconstraint.constant = 30
                 
                 } else {
                     trackingcodelabel.isHidden = true
                     trackingcodeResplabel.isHidden = true
                 trackingnolabelheightconstraint.constant = 0
                 trackingnoresponseheightconstraint.constant = 0
                 
             print("No value in Userdefault,Either you can save value here or perform other operation")
             userdefaultsbranchcode.set("", forKey: "key")
             }
            
            
            self.refNoLbl.text = defaults.string(forKey: "refNo")
            self.tickImg.image = UIImage(named: "green_tick")
            self.msgLbl1.text = NSLocalizedString("transaction_initiated", comment: "")
            self.msgLbl2.text = NSLocalizedString("under_process", comment: "")
            self.msg1.isHidden = false
            self.msg2.isHidden = false
            self.msg3.isHidden = false
           // self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + "0 QAR"
            self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + " QAR"
            self.msg2.text = NSLocalizedString("date_transaction", comment: "") + self.getCurrentDateTime()
            self.msg3.text = NSLocalizedString("payment_status", comment: "")
        }
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(true)
               
               // Protect ScreenShot
//                      ScreenShield.shared.protect(view: self.mainView)
                      
                      // Protect Screen-Recording
                      ScreenShield.shared.protectFromScreenRecording()
              
           }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true

    }
    @IBAction func mainMenuBtn(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func setFont() {
        remittanceLbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        msgLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        msgLbl2.font = UIFont(name: "OpenSans-Regular", size: 14)
        msgLbl3.font = UIFont(name: "OpenSans-Regular", size: 14)
        refNoLbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        msgLbl4.font = UIFont(name: "OpenSans-Regular", size: 14)
        mainMenuBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        
    }
    func setFontSize() {
        remittanceLbl.font = remittanceLbl.font.withSize(18)
        msgLbl1.font = msgLbl1.font.withSize(14)
        msgLbl2.font = msgLbl2.font.withSize(14)
        msgLbl3.font = msgLbl3.font.withSize(14)
        refNoLbl.font = refNoLbl.font.withSize(16)
        msgLbl4.font = msgLbl4.font.withSize(14)
    }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    
}
