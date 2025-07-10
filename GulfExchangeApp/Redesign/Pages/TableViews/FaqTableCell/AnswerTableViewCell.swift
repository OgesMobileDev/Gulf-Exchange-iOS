////
////  AnswerTableViewCell.swift
////  GulfExchangeApp
////
////  Created by macbook on 26/10/2024.
////  Copyright © 2024 Oges. All rights reserved.
////
//
//import UIKit
//
//class AnswerTableViewCell: UITableViewCell {
//    //    let answerLabel = UILabel()
//    
//    
//    @IBOutlet weak var answerTextView: UITextView!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
//    func configure(with htmlString: String) {
//        // Convert HTML to attributed string
//        configureLabel(label: <#T##UILabel#>, text: <#T##String#>, size: <#T##CGFloat#>, font: <#T##FontType#>)
//        let font = UIFont.systemFont(ofSize: 16)   // Customize the font and size
//        let color = UIColor.darkGray               // Customize the color
//        
//        // Use the updated htmlToAttributedString with custom font and color
//        answerTextView.attributedText = htmlString.htmlToAttributedString2(font: font, color: color)
//        //            if let attributedString = htmlString.htmlToAttributedString2 {
//        //                answerTextView.attributedText = attributedString
//        //            } else {
//        //                answerTextView.text = "Invalid content"
//        //            }
//    }
//}

//
//
//extension String {
//    func htmlToAttributedString2(font: UIFont, color: UIColor) -> NSAttributedString? {
//        guard let data = data(using: .utf8) else { return nil }
//        
//        do {
//            let attributedString = try NSMutableAttributedString(
//                data: data,
//                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
//                documentAttributes: nil
//            )
//            
//            // Apply custom font and color to the entire attributed string
//            let fullRange = NSRange(location: 0, length: attributedString.length)
//            attributedString.addAttributes([
//                .font: font,
//                .foregroundColor: color
//            ], range: fullRange)
//            
//            return attributedString
//        } catch {
//            print("Error converting HTML to attributed string:", error)
//            return nil
//        }
//    }
//}



import UIKit
import ScreenShield

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var answerTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure text view
        ScreenShield.shared.protect(view: answerTextView)
        answerTextView.isEditable = false
        answerTextView.isSelectable = true
        answerTextView.dataDetectorTypes = [.link]
    }
    
    func configure(with htmlString: String, size: CGFloat, font: FontType) {
        
        // Convert HTML to NSAttributedString
        if let htmlAttributedString = htmlString.htmlToAttributedStringWithRedURLs {
            // Apply custom font to the HTML attributed string
            let styledAttributedString = applyCustomFontToAttributedString(
                htmlAttributedString,
                size: size,
                font: font,
                color: UIColor.rgba(79, 93, 100, 1)
                
            )
            answerTextView.attributedText = styledAttributedString
        } else {
            answerTextView.text = "Invalid content"
        }
        answerTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        answerTextView.textContainer.lineFragmentPadding = 0
    }
    // Helper method to apply custom font to an attributed string
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

   /* private func applyCustomFontToAttributedString(_ attributedString: NSAttributedString, size: CGFloat, font: FontType) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
        
        // Enumerate through the existing attributes in the attributed string
        mutableAttributedString.enumerateAttributes(in: NSRange(location: 0, length: attributedString.length), options: []) { attributes, range, _ in
            
            // Preserve existing attributes (e.g., links) while adding custom font attributes
            var updatedAttributes = attributes
            
            // Create custom font using the createAttributedString function
            let customFontString = attributedString.attributedSubstring(from: range).string
            let customFont = createAttributedString(title: customFontString, size: size, font: font)
            
            // Add custom font to attributes
            updatedAttributes[.font] = customFont.attribute(.font, at: 0, effectiveRange: nil)
            
            // Apply updated attributes to the mutable attributed string
            mutableAttributedString.setAttributes(updatedAttributes, range: range)
        }
        
        return mutableAttributedString
    }*/
}
import UIKit

extension String {
    var htmlToAttributedStringWithRedURLs: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        do {
            let attributedString = try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
            
            // Create a mutable copy to modify the attributes
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            
            // Enumerate through the attributed string to find URLs
            mutableAttributedString.enumerateAttribute(.link, in: NSRange(location: 0, length: mutableAttributedString.length), options: []) { value, range, _ in
                if let _ = value as? URL {
                    // Change the text color to red for URLs
                    mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.rgba(221, 118, 118, 1), range: range)
                }
            }
            
            return mutableAttributedString
        } catch {
            print("Error converting HTML to attributed string:", error)
            return nil
        }
    }
}
