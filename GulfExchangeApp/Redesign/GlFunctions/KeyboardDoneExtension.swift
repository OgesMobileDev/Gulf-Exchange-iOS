//
//  KeyboardDoneExtension.swift
//  GulfExchangeApp
//
//  Created by mac on 10/09/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.autocorrectionType = .no
        self.spellCheckingType = .no
    }
}


/*
extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
}

extension UITextView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
}
*/
