//
//  QuickAccess1CollectionViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 10/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
class QuickAccess1CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ScreenShield.shared.protect(view: titleLbl)
        ScreenShield.shared.protect(view: ImageView)
    }

    func setdata(image:String, title: String){
//        bgView.layer.cornerRadius = 10
//        bgView.layer.borderWidth = 1
//        bgView.layer.borderColor = UIColor.rgba(19, 56, 82, 0.1).cgColor
        button.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
        titleLbl.text = NSLocalizedString(title, comment: "")
        
        
        ImageView.image = UIImage(named: image)
    }
    func setSeeAllData(){
        bgView.layer.cornerRadius = 10
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.rgba(242, 242, 242, 1).cgColor
    }
}

