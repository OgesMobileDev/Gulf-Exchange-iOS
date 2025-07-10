//
//  SuccessTransactionPopupView.swift
//  GulfExchangeApp
//
//  Created by macbook on 04/12/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
enum TransactionStatus{
    case failiure
    case success
    case none
}
protocol TransactionResultPopupViewDelegate:AnyObject{
    func TransactionResultPopupView(_ vc: TransactionResultPopupView, action: TransactionStatus
    )
}
class TransactionResultPopupView: UIView {
    
    weak var delegate:TransactionResultPopupViewDelegate?
    
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var resultImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var transactionIDLbl1: UILabel!
    @IBOutlet weak var transactionIDLbl: UILabel!
    @IBOutlet weak var dateLbl1: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var paymentLbl1: UILabel!
    @IBOutlet weak var paymentLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    let defaults = UserDefaults.standard
    var txnStatus:String = ""
    var paymentType:String = "----"
    var transactionStatus:TransactionStatus = .none
    override func awakeFromNib() {
        super.awakeFromNib()
        ScreenShield.shared.protect(view: titleLbl)
        ScreenShield.shared.protect(view: transactionIDLbl)
        ScreenShield.shared.protect(view: dateLbl)
        ScreenShield.shared.protect(view: paymentLbl)
        ScreenShield.shared.protect(view: transactionIDLbl1)
        ScreenShield.shared.protect(view: dateLbl1)
        ScreenShield.shared.protect(view: paymentLbl1)
    }
    
    func setView(){
        bgBtn.setTitle("", for: .normal)
        txnStatus = defaults.string(forKey: "txnStatus")!
        paymentLbl.text = paymentType
        if(txnStatus == "SUCCESS")
        {
            self.transactionIDLbl.text = defaults.string(forKey: "refNo")
            self.resultImg.image = UIImage(named: "transaction_success")
            self.titleLbl.text = NSLocalizedString("transaction_success", comment: "")
            self.dateLbl1.text = NSLocalizedString("date_transaction", comment: "") + ":"
            self.dateLbl.text =  self.getCurrentDateTime()
            self.transactionStatus = .success
            /*
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
            }*/
            
//            self.trackingcodeResplabel.text = defaults.string(forKey: "Trackingcode")
            
            
            
//            self.msgLbl2.text = NSLocalizedString("transaction_success1", comment: "")
//            self.msg1.isHidden = false
//            self.msg2.isHidden = false
//            self.msg3.isHidden = false
            //self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + "0 QAR"
//            self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + " QAR"
            //            self.msg3.text = NSLocalizedString("payment_status", comment: "")
           

        }
        else if(txnStatus == "SUCCESS_FAILED")
        {
            self.transactionIDLbl.text = defaults.string(forKey: "refNo")
            self.resultImg.image = UIImage(named: "transaction_failure")
            self.titleLbl.text = NSLocalizedString("transaction_failed", comment: "")
            self.dateLbl1.text = NSLocalizedString("date_transaction", comment: "") + ":"
            self.dateLbl.text =  self.getCurrentDateTime()
            self.transactionStatus = .failiure
            //tracking code check
            /*
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
            */
            
            
//            self.msgLbl2.text = NSLocalizedString("payment_completed", comment: "")
//            self.msg1.isHidden = false
//            self.msg2.isHidden = false
//            self.msg3.isHidden = false
            //self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + "0 QAR"
//            self.msg1.text = NSLocalizedString("transaction_amount", comment: "") + ":" + defaults.string(forKey: "totalAmount")! + " QAR"
//            self.msg2.text = NSLocalizedString("date_transaction", comment: "") + ":" + self.getCurrentDateTime()
//            self.msg3.text = NSLocalizedString("payment_status", comment: "")
          
        }
        else if(txnStatus == "SUCCESS_INITIATED")
        {
            self.transactionIDLbl.text = defaults.string(forKey: "refNo")
            self.titleLbl.text = NSLocalizedString("transaction_initiated", comment: "")
            self.resultImg.image = UIImage(named: "transaction_success")
            self.dateLbl1.text = NSLocalizedString("date_transaction", comment: "") + ":"
            self.dateLbl.text =  self.getCurrentDateTime()
            self.transactionStatus = .success
            /*
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
             */
            
        }
        else if(txnStatus == "FAILED")
        {
            self.transactionIDLbl.text = defaults.string(forKey: "refNo")
            self.transactionStatus = .failiure
            self.titleLbl.text = NSLocalizedString("transaction_failed", comment: "")
            self.resultImg.image = UIImage(named: "transaction_failure")
            self.dateLbl1.text = NSLocalizedString("date_transaction", comment: "") + ":"
            self.dateLbl.text =  self.getCurrentDateTime()
            /*
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
        */
          
        }
        else if(txnStatus == "CANCELED")
        {
            self.transactionIDLbl.text = defaults.string(forKey: "refNo")
            self.transactionStatus = .failiure
            self.resultImg.image = UIImage(named: "transaction_failure")
            self.titleLbl.text = "Transaction Canceled!"
            self.dateLbl1.text = NSLocalizedString("date_transaction", comment: "") + ":"
            self.dateLbl.text =  self.getCurrentDateTime()
            /*
            
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
            */
            
    
        }
        else if(txnStatus == "HOLD")
        {
            self.transactionIDLbl.text = defaults.string(forKey: "refNo")
            self.transactionStatus = .success
            self.resultImg.image = UIImage(named: "transaction_success")
            self.titleLbl.text = NSLocalizedString("transaction_initiated", comment: "")
            self.dateLbl1.text = NSLocalizedString("date_transaction", comment: "") + ":"
            self.dateLbl.text =  self.getCurrentDateTime()
            /*
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
            */
            
        }
    }
    
    @IBAction func bgBtnTapped(_ sender: Any) {
    }
    @IBAction func doneBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("done", languageCode: "en")
        }
        
        delegate?.TransactionResultPopupView(self, action: transactionStatus)
        self.removeFromSuperview()
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
