//
//  APIUrls.swift
//  GulfExchangeApp
//
//  Created by macbook on 28/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation

let GLBaseUrl = "https://www.golalita.com/go/api/"
let GLGetToken = GLBaseUrl + "gulfexc/get_token"
let GLGetCategory = GLBaseUrl + "partner.category/search"
let GLGetProfile = GLBaseUrl + "gulfexc/profile/data"
let GLGetNewMerchants = GLBaseUrl + "gulfexc/category/new/merchant/lists"
let GLGetAllMerchants = GLBaseUrl + "gulfexc/category/merchant/lists"
let GLGetOffers = GLBaseUrl + "gulfexc/offers/v2"
let GLB1G1Redeem = GLBaseUrl + "merchant/redeem/v2"
let GLGetAllOffers = GLBaseUrl + "gulfexc/merchant/offers"
let GLNotificationlist = GLBaseUrl + "gulfexc/notification/message/list"
let GLCountryList = GLBaseUrl + "res.country/search"
let GLCheckEmail = GLBaseUrl + "user/email/check"
let GLRegisterUser = "https://www.golalita.com/organisation/employee/registration/v2/gulf/exchange"




// MARK: - Arabic testing

/*private func isValidArabic(_ text: String) -> Bool {
    let arabicRegex = "^[\\u0600-\\u06FF\\s]+$" // Arabic Unicode range
    let predicate = NSPredicate(format: "SELF MATCHES %@", arabicRegex)
    return predicate.evaluate(with: text)
}
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
}
    
    else if(textField == passwTextField)
    {
        
        // Combine existing text with the new input
        let currentText = passwTextField.text!
                guard let stringRange = Range(range, in: currentText) else { return false }
                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
                
        
        if updatedText.isEmpty {
                  return true
              }
        
                // Validate Arabic characters
                if !isValidArabic(updatedText) {
                    showAlert(title: "", message: "Please enter valid Arabic characters.")
                    return false // Prevent change
                }

                return true // Allow change
        
        
        let maxLength = 16
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        
        
        

    }
*/
