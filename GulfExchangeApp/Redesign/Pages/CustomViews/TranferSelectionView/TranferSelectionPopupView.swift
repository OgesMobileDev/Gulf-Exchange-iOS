//
//  TranferSelectionPopupView.swift
//  GulfExchangeApp
//
//  Created by macbook on 20/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

protocol TranferSelectionPopupViewDelegate:AnyObject{
    func TranferSelectionPopupView(_ vc: TranferSelectionPopupView,selection: TransferSelection)
}

class TranferSelectionPopupView: UIView {
    weak var delegate: TranferSelectionPopupViewDelegate?
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var bankLbl: UILabel!
    @IBOutlet weak var bankBtn: UIButton!
    @IBOutlet weak var cashLbl: UILabel!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var walletBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgBtn.setTitle("", for: .normal)
        ScreenShield.shared.protect(view: bankLbl)
        ScreenShield.shared.protect(view: bankBtn)
        ScreenShield.shared.protect(view: cashBtn)
        ScreenShield.shared.protect(view: cashLbl)
        ScreenShield.shared.protect(view: walletBtn)
        ScreenShield.shared.protect(view: walletLbl)
        configureButton(button: closeBtn, title: "Close", size: 12, font: .medium)
        bgBtn.setTitle("", for: .normal)
        bankBtn.setTitle("", for: .normal)
        cashBtn.setTitle("", for: .normal)
        walletBtn.setTitle("", for: .normal)
    }
    @IBAction func bgBtnTapped(_ sender: Any) {
        self.removeFromSuperview()
    }

    @IBAction func bankBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("bank transfer", languageCode: "en")
        }
        delegate?.TranferSelectionPopupView(self, selection: .bankTransfer)
        self.removeFromSuperview()
    }
    @IBAction func cashBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("cash pickup", languageCode: "en")
        }
        
        delegate?.TranferSelectionPopupView(self, selection: .cashPickup)
        self.removeFromSuperview()
    }
    @IBAction func walletBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("wallet transfer", languageCode: "en")
        }
        
        delegate?.TranferSelectionPopupView(self, selection: .mobileWallet)
        self.removeFromSuperview()
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("close", languageCode: "en")
        }
        
        self.removeFromSuperview()
    }
}
