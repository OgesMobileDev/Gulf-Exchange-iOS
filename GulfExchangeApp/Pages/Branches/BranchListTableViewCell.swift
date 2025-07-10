//
//  BranchListTableViewCell.swift
//  GulfExchangeApp
//
//  Created by Philip on 27/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
//protocol HierarchyTableViewCellDelegate {
//   func didTapOnMoreButton(cell:BranchListTableViewCell)
//}
class BranchListTableViewCell: UITableViewCell {
  
//    var delegate:HierarchyTableViewCellDelegate!

    @IBOutlet var branchTitle: UILabel!
    @IBOutlet var branchLocation: UILabel!
    @IBOutlet var downArrowBtn: UIButton!
    @IBOutlet var mapBtn: UIButton!
    @IBOutlet var workingTime: UILabel!
    @IBOutlet var bottomConstFmWorkingLbl: NSLayoutConstraint!
    @IBOutlet var bottomConToVw: NSLayoutConstraint!
    @IBOutlet var timeBtmCostToBotm: NSLayoutConstraint!
    @IBOutlet var viewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//
//    @IBAction func actionViewButtonTapped(_ sender: Any) {
//        delegate.didTapOnMoreButton(cell: self)
//    }
}
