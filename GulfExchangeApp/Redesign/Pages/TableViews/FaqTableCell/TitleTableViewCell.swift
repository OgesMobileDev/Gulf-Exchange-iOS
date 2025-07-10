//
//  TitleTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 26/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

class TitleTableViewCell: UITableViewCell {
//    let titleLabel = UILabel()

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var arrowImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ScreenShield.shared.protect(view: self.titleLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setExpanded(_ expanded: Bool) {
        arrowImgView.image = UIImage(named: expanded ? "faq_up" : "faq_down")
        hideView.isHidden = !expanded
        }
    
}
