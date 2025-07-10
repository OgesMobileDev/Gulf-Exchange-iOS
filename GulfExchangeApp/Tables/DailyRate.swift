//
//  DailyRate.swift
//  GulfExchangeApp
//
//  Created by test on 09/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class DailyRate {
    var currency_master_name_en:String
    var currency_master_code:String
    var ge_countries_c_code:String
    var ge_countries_3_code:String
    var trasferrate:String
    var buyrate:String
    var sellrate:String
    
    init(currency_master_name_en:String,currency_master_code:String,ge_countries_c_code:String,ge_countries_3_code:String,trasferrate:String,buyrate:String,sellrate:String) {
        self.currency_master_name_en = currency_master_name_en
        self.currency_master_code = currency_master_code
        self.ge_countries_c_code = ge_countries_c_code
        self.ge_countries_3_code = ge_countries_3_code
        self.trasferrate = trasferrate
         self.buyrate = buyrate
         self.sellrate = sellrate
        
    }
}
