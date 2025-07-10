//
//  LogoutAlertPopupView.swift
//  GulfExchangeApp
//
//  Created by macbook on 23/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

protocol LogoutAlertPopupViewDelegate:AnyObject{
    func LogoutAlertPopupView(_ vc: LogoutAlertPopupView, isLogout: Bool
    )
}
class LogoutAlertPopupView: UIView {
    
    weak var delegate: LogoutAlertPopupViewDelegate?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var blockBtn: UIButton!
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var blockLbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ScreenShield.shared.protect(view: logoutLbl)
        ScreenShield.shared.protect(view: blockLbl)
    }
    
    func setView(isLogout:Bool){
        
        blockLbl.text = NSLocalizedString("blockQuestion", comment: "")
        cancelBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("cancel1", comment: ""), size: 12, font: .semiBold), for: .normal)
        logoutBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("logout", comment: ""), size: 12, font: .semiBold), for: .normal)
        blockBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("block", comment: ""), size: 12, font: .semiBold), for: .normal)
        logoutLbl.text = NSLocalizedString("want_to_logout", comment: "")
        if isLogout{
            cancelBtn.isHidden = false
            logoutBtn.isHidden = false
            blockBtn.isHidden = true
            blockLbl.isHidden = true
            logoutLbl.isHidden = false
            imageView.image = UIImage(named: "logout_alert")
        }else{
            cancelBtn.isHidden = true
            logoutBtn.isHidden = true
            blockBtn.isHidden = false
            blockLbl.isHidden = false
            logoutLbl.isHidden = true
            imageView.image = UIImage(named: "block_alert")
        }
        
        
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        delegate?.LogoutAlertPopupView(self, isLogout: true)
        self.removeFromSuperview()
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func blockBtnTapped(_ sender: Any) {
        delegate?.LogoutAlertPopupView(self, isLogout: false)
        self.removeFromSuperview()
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
}
