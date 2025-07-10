//
//  BeneficiaryTableViewCell.swift
//  GulfExchangeApp
//
//  Created by test on 16/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

class BeneficiaryTableViewCell: UITableViewCell {
    @IBOutlet weak var beneficiaryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setBeneficiary(beneficiary:Beneficiary) {
        self.beneficiaryLbl.text = beneficiary.beneficiaryAccountName
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
