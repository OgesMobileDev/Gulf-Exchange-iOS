//
//  RecentBeneficiaryCollectionViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 30/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield


class RecentBeneficiaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectionBtn: UIButton!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var userNameLbl: UILabel!
    var isAddbenf:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        ScreenShield.shared.protect(view: userNameLbl)
        selectionBtn.setTitle("", for: .normal)
        profileImgView.isHidden = true
    }
    @IBAction func selectionBtnTapped(_ sender: Any) {
    }
    
    func setView(data:CasmexRecentBeneficiary){
        
        imageBgView.subviews.forEach { $0.removeFromSuperview() }
        let randomWord = generateRandomWord()
        
        createAvatar(username: data.beneficiaryName ?? "-", view: imageBgView, font: 30)
        userNameLbl.text = data.beneficiaryName ?? "----"
    }
   
    func generateRandomWord() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((0..<4).map { _ in letters.randomElement()! })
    }
    // Example usage
   
}

