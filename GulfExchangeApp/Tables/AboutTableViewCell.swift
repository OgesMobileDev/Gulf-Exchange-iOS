//
//  AboutTableViewCell.swift
//  GulfExchangeApp
//
//  Created by test on 12/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
