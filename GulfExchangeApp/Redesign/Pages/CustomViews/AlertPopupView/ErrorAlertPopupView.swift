//
//  ErrorAlertPopupView.swift
//  GulfExchangeApp
//
//  Created by macbook on 07/12/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
protocol ErrorAlertPopupViewDelegate:AnyObject{
    func ErrorAlertPopupView(_ vc: ErrorAlertPopupView, action: Bool
    )
}
class ErrorAlertPopupView: UIView {
   
    weak var delegate:ErrorAlertPopupViewDelegate?
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var subDecLbl: UILabel!
    @IBOutlet weak var tryAgainBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        ScreenShield.shared.protect(view: descriptionLbl)
        ScreenShield.shared.protect(view: subDecLbl)
    }
    
    func setView(msg:String,subMsg:String){
        tryAgainBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("ok", comment: "OK"), size: 12, font: .semiBold), for: .normal)
        descriptionLbl.text = msg
//        if subMsg != ""{
//            subDecLbl.text = subMsg
//        }else{
//            subDecLbl.text = "Please try again to complete the request"
//        }
        
    }
    
    @IBAction func tryAgainBtnTapped(_ sender: Any) {
//        delegate?.ErrorAlertPopupView(self, action: true)
        self.removeFromSuperview()
    }
    
}
