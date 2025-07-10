//
//  TermsPopupUIView.swift
//  GulfExchangeApp
//
//  Created by macbook on 22/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
protocol TermsPopupUIViewDelegate:AnyObject{
    func TermsPopupUIView(_ vc: TermsPopupUIView, action: Bool
    )
}

class TermsPopupUIView: UIView {

    weak var delegate: TermsPopupUIViewDelegate?
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet var termstxtviewnew: UITextView!
    
    
    @IBOutlet var tremsandcondlabel: UILabel!
    
    var isSettings:Bool = false

    
    func setView(content: String){
        termstxtviewnew.isEditable = false
        termstxtviewnew.isSelectable = false
        ScreenShield.shared.protect(view: termstxtviewnew)
        bgBtn.setTitle("", for: .normal)
        if isSettings{
            configureButton(button: okBtn, title: "Done", size: 16, font: .medium)
        }else{
            configureButton(button: okBtn, title: NSLocalizedString("accept", comment: ""), size: 16, font: .medium)
        }
        

        tremsandcondlabel.text  = NSLocalizedString("terms_conditions1", comment: "")
        
        self.termstxtviewnew.attributedText = content.htmlToAttributedString
//        self.termstxtviewnew.font = UIFont(name: "OpenSans-Regular", size: 8)
        self.termstxtviewnew.font = UIFont(name: "Poppins-Regular", size: 10)
        self.termstxtviewnew.textColor = UIColor.rgba(139, 139, 139, 1)
        self.termstxtviewnew.showsVerticalScrollIndicator = false
//        self.termstxtviewnew.font = .systemFont(ofSize: 8)
    }
    
    @IBAction func close(_ sender: Any) {
        isSettings = false
        self.removeFromSuperview()
    }
    
    @IBAction func okTapped(_ sender: Any) {
        delegate?.TermsPopupUIView(self, action: true)
        isSettings = false
        self.removeFromSuperview()
    }

}
