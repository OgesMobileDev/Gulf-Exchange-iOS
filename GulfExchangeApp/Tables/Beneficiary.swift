//
//  Beneficiary.swift
//  GulfExchangeApp
//
//  Created by test on 15/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class Beneficiary {
    var beneficiaryNickName:String
    var beneficiarySerialNo:String
    var beneficiaryBankName:String
    var beneficiaryAccountNo:String
    var beneficiaryAccountType:String
    var beneficiaryBankCountryName:String
    var beneficiaryAccountName:String
    var beneficiaryIfscCode:String
    var beneficiaryBankBranchName:String
    var beneficiaryBankCountryCode:String
    var beneficiaryMobile:String
    var beneficiaryEmail:String
    var beneficiaryCity:String
    var beneficiaryAddress:String
    var beneficiaryIBAN:String
    
    init(beneficiaryNickName:String,beneficiarySerialNo:String,beneficiaryBankName:String,beneficiaryAccountNo:String,beneficiaryAccountType:String,beneficiaryBankCountryName:String,beneficiaryAccountName:String,beneficiaryIfscCode:String,beneficiaryBankBranchName:String,beneficiaryBankCountryCode:String,beneficiaryMobile:String,beneficiaryEmail:String,beneficiaryCity:String,beneficiaryAddress:String,beneficiaryIBAN:String) {
        self.beneficiaryNickName = beneficiaryNickName
        self.beneficiarySerialNo = beneficiarySerialNo
        self.beneficiaryBankName = beneficiaryBankName
        self.beneficiaryAccountNo = beneficiaryAccountNo
        self.beneficiaryAccountType = beneficiaryAccountType
        self.beneficiaryBankCountryName = beneficiaryBankCountryName
        self.beneficiaryAccountName = beneficiaryAccountName
        self.beneficiaryIfscCode = beneficiaryIfscCode
        self.beneficiaryBankBranchName = beneficiaryBankBranchName
        self.beneficiaryBankCountryCode = beneficiaryBankCountryCode
        self.beneficiaryMobile = beneficiaryMobile
        self.beneficiaryEmail = beneficiaryEmail
        self.beneficiaryCity = beneficiaryCity
        self.beneficiaryAddress = beneficiaryAddress
        self.beneficiaryIBAN = beneficiaryIBAN
    }
}
