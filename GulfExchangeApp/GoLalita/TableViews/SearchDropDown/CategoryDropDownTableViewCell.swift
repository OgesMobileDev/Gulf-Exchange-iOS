//
//  CategoryDropDownTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 20/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class CategoryDropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var selectionBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkBtn.setImage(UIImage(systemName: ""), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionBtn.isHidden = true
        // Configure the view for the selected state
        selectionBtn.setTitle("", for: .normal)
        checkBtn.setTitle("", for: .normal)
        checkBtn.setTitle("", for: .selected)
//        checkBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBtn.tintColor = UIColor.rgba(93, 182, 158, 1)
    }
    func setApiData(data: MerchantCategory?){
       
        titleLbl.text = data?.name ?? ""
        checkBtn.setImage(UIImage(systemName: ""), for: .normal)
        if data?.selected == true{
            print("\(data?.name  ?? "") - true")
            checkBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
//            checkBtn.isSelected = true
        }else{
            print("\(data?.name ?? "") - false")
            checkBtn.setImage(UIImage(systemName: "square"), for: .normal)
//            checkBtn.isSelected = false
        }
    }
    
}
