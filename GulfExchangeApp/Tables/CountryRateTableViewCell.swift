//
//  CountryRateTableViewCell.swift
//  GulfExchangeApp
//
//  Created by MACBOOK PRO on 10/09/22.
//  Copyright © 2022 Oges. All rights reserved.
//

import UIKit

class CountryRateTableViewCell: UITableViewCell {

    @IBOutlet var currencyName: UILabel!
    
    
    @IBOutlet var countryimageviewdop: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
