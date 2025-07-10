//
//  MyTransactionsTableViewCell.swift
//  GulfExchangeApp
//
//  Created by test on 23/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
protocol MyTransactionDelegate {
    func showDetails(transactionRefNo:String)
}

class MyTransactionsTableViewCell: UITableViewCell {

    @IBOutlet weak var refNoLbl: UILabel!
    @IBOutlet weak var showDetailsBtn: UIButton!
    
    var transactions:MyTransactions!
    var delegate: MyTransactionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setMyTransaction(transaction:MyTransactions) {
        transactions = transaction
    }
    @IBAction func showDetailsBtn(_ sender: Any) {
        delegate?.showDetails(transactionRefNo: transactions.transactionRefNo)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
