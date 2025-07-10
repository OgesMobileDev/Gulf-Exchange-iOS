//
//  languageTableViewCell.swift
//  GulfExchangeApp
//
//  Created by test on 09/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

class languageTableViewCell: UITableViewCell {
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var codeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectBtn.setImage(UIImage(named: ""), for: .normal)
        
    }
    func setLanguage(lang:Language)
    {
        self.langLbl.text = lang.name
        self.codeLbl.text = lang.code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
