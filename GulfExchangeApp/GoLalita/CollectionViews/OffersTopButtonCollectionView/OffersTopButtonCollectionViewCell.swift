//
//  ProfileTopButtonCollectionViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 19/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class OffersTopButtonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var sectionBtn: UIButton!
    @IBOutlet weak var lblLeftConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(isSelected:Bool, data :OffersCollectionData){
        sectionBtn.setTitle("", for: .normal)
        titleLbl.text = data.title
        if isSelected{
            if data.imageS == ""{
                imgView.isHidden = true
                lblLeftConstraint.constant = 8
            }else{
                imgView.isHidden = false
                lblLeftConstraint.constant = 33
            }
            
            
            imgView.image = UIImage(named: data.imageS)
            buttonView.backgroundColor = UIColor.rgba(17, 18, 54, 1)
            buttonView.layer.borderWidth = 0
            buttonView.layer.borderColor = UIColor.rgba(231, 229, 229, 1).cgColor
            titleLbl.textColor = UIColor.white
        }else{
            if data.imageU == ""{
                imgView.isHidden = true
                lblLeftConstraint.constant = 8
            }else{
                imgView.isHidden = false
                lblLeftConstraint.constant = 33
            }
            imgView.image = UIImage(named: data.imageU)
            imgView.tintColor = UIColor.white
            buttonView.backgroundColor = UIColor.white
            buttonView.layer.borderWidth = 1
            buttonView.layer.borderColor = UIColor.rgba(231, 229, 229, 1).cgColor
            titleLbl.textColor = UIColor.rgba(128, 142, 168, 1)
        }
    }
}
