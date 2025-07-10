//
//  CountryTableViewCell.swift
//  GulfExchangeApp
//
//  Created by test on 16/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCountry(country:CasmexNationality) {
        self.countryLbl.text = country.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
