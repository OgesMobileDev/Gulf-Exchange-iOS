//
//  Bank.swift
//  GulfExchangeApp
//
//  Created by test on 18/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class Bank{
    var bankAddress:String
    var bankCode:String
    var bankName:String
    var bankcitytype:String
    var Accountnolength:String
    var Mobnolength:String
    var Minaccnolength:String
    var ifscnolength:String
    
    init(bankAddress:String,bankCode:String,bankName:String,bankcitytype:String,Accountnolength:String,Mobnolength:String,ifscnolength:String,Minaccnolength:String) {
        self.bankAddress = bankAddress
        self.bankCode = bankCode
        self.bankName = bankName
        self.bankcitytype = bankcitytype
        self.Accountnolength = Accountnolength
        self.Mobnolength = Mobnolength
        self.Minaccnolength = Minaccnolength
        self.ifscnolength = ifscnolength
    }
}
