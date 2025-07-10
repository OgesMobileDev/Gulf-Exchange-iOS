//
//  BranchesListTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 28/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

class BranchesListTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var branchNameLbl: UILabel!
    @IBOutlet weak var openLbl: UILabel!
    @IBOutlet weak var openImgView: UIImageView!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var timingLbl: UILabel!
    
    @IBOutlet weak var selectionBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var directionBtn: UIButton!
    @IBOutlet weak var callLbl: UILabel!
    @IBOutlet weak var callImg: UIImageView!
    @IBOutlet weak var directionLbl: UILabel!
    @IBOutlet weak var directionImg: UIImageView!
    
    var isSectionSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        callBtn.setTitle("", for: .normal)
        directionBtn.setTitle("", for: .normal)
        selectionBtn.setTitle("", for:  .normal)
        openLbl.isHidden = false
        openImgView.isHidden = false
        ScreenShield.shared.protect(view: self.branchNameLbl)
        ScreenShield.shared.protect(view: self.openLbl)
        ScreenShield.shared.protect(view: self.openImgView)
        ScreenShield.shared.protect(view: self.addressLbl)
        ScreenShield.shared.protect(view: self.timingLbl)
        ScreenShield.shared.protect(view: self.addressLbl)
        ScreenShield.shared.protect(view: self.addressLbl)
        ScreenShield.shared.protect(view: self.callLbl)
        ScreenShield.shared.protect(view: self.callImg)
        ScreenShield.shared.protect(view: self.directionLbl)
        ScreenShield.shared.protect(view: self.directionImg)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bgView.backgroundColor = UIColor.white // Reset background color
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setOpenStatus(isOpen:Bool){
        if isOpen{
            openLbl.text = "Open"
            openImgView.image = UIImage(named: "b_open")
        }else{
            openLbl.text = "Closed"
            openImgView.image = UIImage(named: "b_closed")
        }
    }
    
    func configureTitleLbl1(with htmlString: NSAttributedString, size: CGFloat, font: FontType) {
        let styledAttributedString = applyCustomFontToAttributedString(
            htmlString,
            size: size,
            font: font,
            color: UIColor.rgba(0, 0, 0, 1)
            
        )
        branchNameLbl.attributedText = styledAttributedString
    }
    func configureAddressLbl1(with htmlString: NSAttributedString, size: CGFloat, font: FontType) {
        let styledAttributedString = applyCustomFontToAttributedString(
            htmlString,
            size: size,
            font: font,
            color: UIColor.rgba(139, 139, 139, 1)
            
        )
        addressLbl.attributedText = styledAttributedString
    }
    func configureTimingLbl1(with htmlString: NSAttributedString, size: CGFloat, font: FontType) {
        let styledAttributedString = applyCustomFontToAttributedString(
            htmlString,
            size: size,
            font: font,
            color: UIColor.rgba(139, 139, 139, 1)
            
        )
        timingLbl.attributedText = styledAttributedString
    }
    
    
    
    
    
    func configureTitleLbl(with htmlString: String, size: CGFloat, font: FontType) {
        
        // Convert HTML to NSAttributedString
        if let htmlAttributedString = htmlString.htmlToAttributedStringWithRedURLs {
            // Apply custom font to the HTML attributed string
            let styledAttributedString = applyCustomFontToAttributedString(
                htmlAttributedString,
                size: size,
                font: font,
                color: UIColor.rgba(0, 0, 0, 1)
                
            )
            branchNameLbl.attributedText = styledAttributedString
        } else {
            branchNameLbl.text = "Invalid content"
        }
    }
    func configureAddressLbl(with htmlString: String, size: CGFloat, font: FontType) {
        
        // Convert HTML to NSAttributedString
        if let htmlAttributedString = htmlString.htmlToAttributedStringWithRedURLs {
            // Apply custom font to the HTML attributed string
            let styledAttributedString = applyCustomFontToAttributedString(
                htmlAttributedString,
                size: size,
                font: font,
                color: UIColor.rgba(139, 139, 139, 1)
                
            )
            addressLbl.attributedText = styledAttributedString
        } else {
            addressLbl.text = "Invalid content"
        }
    }
    func configureTimingLbl(with htmlString: String, size: CGFloat, font: FontType) {
        
        // Convert HTML to NSAttributedString
        if let htmlAttributedString = htmlString.htmlToAttributedStringWithRedURLs {
            // Apply custom font to the HTML attributed string
            let styledAttributedString = applyCustomFontToAttributedString(
                htmlAttributedString,
                size: size,
                font: font,
                color: UIColor.rgba(139, 139, 139, 1)
                
            )
            timingLbl.attributedText = styledAttributedString
        } else {
            timingLbl.text = "Invalid content"
        }
    }
    private func applyCustomFontToAttributedString(_ attributedString: NSAttributedString, size: CGFloat, font: FontType, color: UIColor) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
        
        // Enumerate through the existing attributes in the attributed string
        mutableAttributedString.enumerateAttributes(in: NSRange(location: 0, length: attributedString.length), options: []) { attributes, range, _ in
            
            // Preserve existing attributes (e.g., links) while adding custom font and color attributes
            var updatedAttributes = attributes
            
            // Create custom font using the createAttributedString function
            let customFontString = attributedString.attributedSubstring(from: range).string
            let customFont = createAttributedString(title: customFontString, size: size, font: font)
            
            // Add custom font and color to attributes
            updatedAttributes[.font] = customFont.attribute(.font, at: 0, effectiveRange: nil)
            updatedAttributes[.foregroundColor] = color  // Set the text color
            
            // Apply updated attributes to the mutable attributed string
            mutableAttributedString.setAttributes(updatedAttributes, range: range)
        }
        
        return mutableAttributedString
    }
    
}
