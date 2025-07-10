//
//  Branch.swift
//  GulfExchangeApp
//
//  Created by test on 18/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class Branch{
    var bankCode:String
    var brAddress:String
    var branchCode:String
    var branchName:String
    var ifsccode:String
    var receiveContry:String
    
    init(bankCode:String,brAddress:String,branchCode:String,branchName:String,ifsccode:String,receiveContry:String) {
        self.bankCode = bankCode
        self.brAddress = brAddress
        self.branchCode = branchCode
        self.branchName = branchName
        self.ifsccode = ifsccode
        self.receiveContry = receiveContry
    }
}
