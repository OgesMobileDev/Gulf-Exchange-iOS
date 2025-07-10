//
//  OffersBaseTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 19/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class OffersBaseTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var baseImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        viewBtn.setTitle("", for: .normal)
        // Configure the view for the selected state
    }
    func setData(data:OffersDetailsList?){
        urlToImg(urlString: data?.imageURL ?? "", to: baseImgView)
        urlToImg(urlString: data?.merchantLogo ?? "", to: profileImg)
        titleLbl.text = data?.merchantName
    }
}
