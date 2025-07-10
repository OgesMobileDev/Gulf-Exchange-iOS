//
//  ReviewTransactionPopupUIView.swift
//  GulfExchangeApp
//
//  Created by macbook on 02/12/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
protocol ReviewTransactionPopupUIViewDelegate:AnyObject{
    func ReviewTransactionPopupUIView(_ vc: ReviewTransactionPopupUIView, action: Bool
    )
}
class ReviewTransactionPopupUIView: UIView {
    weak var delegate:ReviewTransactionPopupUIViewDelegate?
    @IBOutlet weak var screenshotView: UIView!
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var transactionAmntLbl1: UILabel!
    @IBOutlet weak var transactionAmntLbl: UILabel!
    @IBOutlet weak var serviceFeeLbl1: UILabel!
    @IBOutlet weak var serviceFeeLbl: UILabel!
    @IBOutlet weak var promotionLbl1: UILabel!
    @IBOutlet weak var promotionLbl: UILabel!
    @IBOutlet weak var amntToPayQALbl1: UILabel!
    @IBOutlet weak var amntToPayQALbl: UILabel!
    @IBOutlet weak var amntToPayLbl1: UILabel!
    @IBOutlet weak var amntToPayLbl: UILabel!
    @IBOutlet weak var transferBtn: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ScreenShield.shared.protect(view: transactionAmntLbl1)
        ScreenShield.shared.protect(view: serviceFeeLbl1)
        ScreenShield.shared.protect(view: promotionLbl1)
        ScreenShield.shared.protect(view: amntToPayQALbl1)
        ScreenShield.shared.protect(view: amntToPayLbl1)
        ScreenShield.shared.protect(view: titleLbl)
        ScreenShield.shared.protect(view: transactionAmntLbl)
        ScreenShield.shared.protect(view: serviceFeeLbl)
        ScreenShield.shared.protect(view: promotionLbl)
        ScreenShield.shared.protect(view: amntToPayQALbl)
        ScreenShield.shared.protect(view: amntToPayLbl)
        
       
    }
    
    func setView(data:CasmexTransferRate,sendCurrency:String,total:Double){
        bgBtn.setTitle("", for: .normal)
        ScreenShield.shared.protect(view: screenshotView)
        transactionAmntLbl.text = "QAR \(data.localAmount ?? "0").00"
        serviceFeeLbl.text = "QAR \(data.charge ?? "0").00"
        promotionLbl.text = "QAR 00.00"
        amntToPayQALbl.text = "QAR \(total)0"
        amntToPayLbl.text = "\(sendCurrency) \(data.receiveAmount ?? "0").00"
        
        setTxtToSpeech()
        setView()
        
    }
    
    func setView()
    {
        titleLbl.text = NSLocalizedString("transferDetails", comment: "")
        
        self.transferBtn.setTitle(NSLocalizedString("transfer", comment: ""), for: .normal)
        
    }
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLblTapped(_:)))
        titleLbl.isUserInteractionEnabled = true
        titleLbl.addGestureRecognizer(tapGesture)
    }
    
    @objc func titleLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("transfer details", languageCode: "en")
            }
        }
    }
    
    
    @IBAction func bgBtnTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func transferBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("transfer", languageCode: "en")
        }
        
        delegate?.ReviewTransactionPopupUIView(self, action: true)
        self.removeFromSuperview()
    }
}
