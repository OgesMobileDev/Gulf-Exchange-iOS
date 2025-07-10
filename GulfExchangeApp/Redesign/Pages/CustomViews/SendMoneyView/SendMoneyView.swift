//
//  SendMoneyView.swift
//  GulfExchangeApp
//
//  Created by macbook on 12/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
protocol SendMoneyViewDelegate:AnyObject{
    func SendMoneyView(_ vc: SendMoneyView, action: SendMoneyPopupAction
    )
}

class SendMoneyView: UIView {
    weak var delegate: SendMoneyViewDelegate?
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var emptyBtn: UIButton!
    @IBOutlet weak var cashPickupImg: UIImageView!
    @IBOutlet weak var cashPickupView: UIView!
    @IBOutlet weak var cashPickupBtn: UIButton!
    
    @IBOutlet weak var bankTransferView: UIView!
    @IBOutlet weak var bankTransferImg: UIImageView!
    @IBOutlet weak var bankTransferBtn: UIButton!
    
    
    @IBOutlet weak var mobikeWalletView: UIView!
    @IBOutlet weak var mobikeWalletImg: UIImageView!
    @IBOutlet weak var mobikeWalletBtn: UIButton!
    
    @IBOutlet weak var popDownBtn: UIButton!
    @IBOutlet weak var popupBtnView: UIView!
    
    @IBOutlet var banktransferlabel: UILabel!
    
    @IBOutlet var cashpickuplabel: UILabel!
    
    @IBOutlet var mobilewallettransferlabel: UILabel!
    
    @IBOutlet var sendlabel: UILabel!
    
    
    func setView(baseView:UIView){
//        bgView.frame = baseView.frame
        cashPickupBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        bankTransferBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        mobikeWalletBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        emptyBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        popDownBtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        
        banktransferlabel.text = NSLocalizedString("BankTransfer", comment: "")
        cashpickuplabel.text = NSLocalizedString("cash_pickup", comment: "")
        mobilewallettransferlabel.text = NSLocalizedString("Mobile Wallet Transfer", comment: "")
        sendlabel.text = NSLocalizedString("Send", comment: "")
        
    }
    @IBAction func popDownBtnTapped(_ sender: Any) {
        self.removeFromSuperview()
       /* UIView.animate(withDuration: 0.3, animations: {
            self.bgView.alpha = 0.0
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.removeFromSuperview()
        }*/
        
    }
    @IBAction func cashPickupBtnTapped(_ sender: Any) {
        delegate?.SendMoneyView(self, action: .cashPickup)
        self.removeFromSuperview()
        
    }
    @IBAction func bankTransferBtnTapped(_ sender: Any) {
        delegate?.SendMoneyView(self, action: .bankTranfer)
        self.removeFromSuperview()
    }
    @IBAction func mobileWalletBtnTapped(_ sender: Any) {
        delegate?.SendMoneyView(self, action: .mobileWallet)
        self.removeFromSuperview()
    }
}

/*{
    "params": {
        "token": "8efddb90308b45689f1a5b7c04fa72c4",
        "category_id": 1,
        "x_for_employee_type": "both",
        "country_id": 123, 
        "x_online_store": true,
        "merchant name": "Example Merchant",
        "merchant type": "retail",
        "x_org Linked": true,
        "merchant_id": 456,
        "limit": 10,
        "offset": 0
    }
}
https://www.golalita.com/go/api/gulfexc/get_token/
{
    "params": {
        "login" : "abdullha123@gmail.com",
        "password":"abc123123",
        "device_id":"XXXXX",
        "device_token":"XXXXXX",
        "device_type":"IOS"
    }
}
*/
