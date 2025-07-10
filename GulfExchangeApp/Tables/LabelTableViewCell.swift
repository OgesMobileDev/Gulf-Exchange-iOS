//
//  LabelTableViewCell.swift
//  GulfExchangeApp
//
//  Created by test on 16/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
