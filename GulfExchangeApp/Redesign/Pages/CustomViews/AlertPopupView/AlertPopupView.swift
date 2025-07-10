//
//  AlertPopupView.swift
//  GulfExchangeApp
//
//  Created by macbook on 13/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
protocol AlertPopupViewDelegate:AnyObject{
    func AlertPopupView(_ vc: AlertPopupView, action: Bool
    )
}

class AlertPopupView: UIView {
    weak var delegate:AlertPopupViewDelegate?
    @IBOutlet weak var bgView: UIView!
    
    
    @IBOutlet weak var okBtn: UIButton!
    
    
    @IBOutlet var titlelabel: UILabel!
    
    @IBOutlet var subtitlelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ScreenShield.shared.protect(view: titlelabel)
    }
    func setView(){
        okBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("Continue", comment: ""), size: 10, font: .semiBold), for: .normal)
        
        titlelabel.text = NSLocalizedString("Login successful!", comment: "")
        subtitlelabel.text = NSLocalizedString("Welcome Back", comment: "")
        
    }

    @IBAction func okBtnTapped(_ sender: Any) {
        
        delegate?.AlertPopupView(self, action: true)
    }
}
