//
//  merchantBannerCollectionViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class merchantBannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data:Banner?){
        urlToImg(urlString: data?.bannerImage ?? "", to: imageView)
    }
}
