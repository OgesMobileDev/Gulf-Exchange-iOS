//
//  GenderSelectionPopupView.swift
//  GulfExchangeApp
//
//  Created by macbook on 25/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
protocol GenderSelectionPopupViewDelegate:AnyObject{
    func GenderSelectionPopupView(_ vc: GenderSelectionPopupView, isMale: Bool
    )
}

class GenderSelectionPopupView: UIView {

    weak var delegate: GenderSelectionPopupViewDelegate?
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var maleImgView: UIImageView!
    @IBOutlet weak var maleLbl: UILabel!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleImgView: UIImageView!
    @IBOutlet weak var femaleLbl: UILabel!
    @IBOutlet weak var femaleBtn: UIButton!
    var isMale:Bool = true
    
    func setView(){
        selectBtn.setAttributedTitle(buttonTitleSet(title: "Select", size: 10, font: .semiBold), for: .normal)
        maleBtn.setTitle("", for: .normal)
        femaleBtn.setTitle("", for: .normal)
        isMale = true
        
        if #available(iOS 13.0, *) {
            maleImgView.image = UIImage(systemName: "checkmark.square.fill")
            maleImgView.tintColor = UIColor.rgba(198, 23, 30, 1)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            femaleImgView.image = UIImage(systemName: "square")
            femaleImgView.tintColor = UIColor.rgba(198, 23, 30, 1)
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    @IBAction func bgBtnTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func selectBtnTapped(_ sender: UIButton) {
        delegate?.GenderSelectionPopupView(self, isMale: isMale)
        self.removeFromSuperview()
    }
    @IBAction func maleBtnTapped(_ sender: Any) {
        isMale = true
        
        if #available(iOS 13.0, *) {
            maleImgView.image = UIImage(systemName: "checkmark.square.fill")
            maleImgView.tintColor = UIColor.rgba(198, 23, 30, 1)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            femaleImgView.image = UIImage(systemName: "square")
            femaleImgView.tintColor = UIColor.rgba(198, 23, 30, 1)
        } else {
            // Fallback on earlier versions
        }
    }
    @IBAction func femaleBtnTapped(_ sender: Any) {
        isMale = false
        if #available(iOS 13.0, *) {
            femaleImgView.image = UIImage(systemName: "checkmark.square.fill")
            femaleImgView.tintColor = UIColor.rgba(198, 23, 30, 1)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            maleImgView.image = UIImage(systemName: "square")
            maleImgView.tintColor = UIColor.rgba(198, 23, 30, 1)
        } else {
            // Fallback on earlier versions
        }
    }
}
