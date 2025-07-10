//
//  CategorySelectionCollectionViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 20/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class CategorySelectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var selectionLbl: UILabel!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var defaultLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultLbl.text = "Categories . . ."
    }
    func setdata(data:MerchantCategory){
        defaultLbl.isHidden = true
        selectionView.isHidden = false
        selectionLbl.text = data.name
    }
    
    
    func setDefaultData(){
        selectionView.isHidden = true
        defaultLbl.isHidden = false
    }
}
