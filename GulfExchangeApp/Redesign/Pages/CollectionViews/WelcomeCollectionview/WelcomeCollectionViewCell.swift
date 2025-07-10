//
//  WelcomeCollectionViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 10/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagebtn: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(){
        ImageView.layer.cornerRadius = 10
        imagebtn.setAttributedTitle(buttonTitleSet(title: "", size: 14, font: .regular), for: .normal)
    }
}
