//
//  GolalitaHomeCollectionViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 16/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class GolalitaHomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
//    func setData(data:HomeCollectionData){
////        imageView.image = UIImage(named: data.image)
//        titleLbl.text = data.title
//    }
    func setCategoryData(data:MerchantCategory?){
        urlToImg(urlString: data?.imageURL ?? "", to: imageView)
        titleLbl.text = data?.name
    }
    func setNewMerchantData(data:Merchant?){
        urlToImg(urlString: data?.merchantLogo ?? "", to: imageView)
        titleLbl.text = data?.merchantName
    }
    func setAllMerchantData(data:MerchantDetail?){
        urlToImg(urlString: data?.merchantLogo ?? "", to: imageView)
        titleLbl.text = data?.merchantName
    }

}
