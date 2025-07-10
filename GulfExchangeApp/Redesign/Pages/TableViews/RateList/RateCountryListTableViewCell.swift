//
//  RateCountryListTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 25/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class RateCountryListTableViewCell: UITableViewCell {
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(code:String){
        loadCountryFlag(for: code , into:countryImg)
        countryImg.contentMode = .scaleAspectFill
    }
}
