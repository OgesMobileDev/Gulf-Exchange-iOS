//
//  EditProfileTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 05/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

class EditProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var flagImgView: UIImageView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flagImgView.isHidden = true
        leadingConstraint.constant = 20
        ScreenShield.shared.protect(view: itemLbl)
        ScreenShield.shared.protect(view: flagImgView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
