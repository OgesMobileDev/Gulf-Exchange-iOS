//
//  Currency.swift
//  GulfExchangeApp
//
//  Created by test on 27/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class Currency {
    var currency_master_code:String
    var currency_master_country_id:String
    var currency_master_name_en:String
    var ge_countries_3_code:String
    var ge_countries_c_code:String
    var ge_countries_c_name:String
    
    init(currency_master_code:String,currency_master_country_id:String,currency_master_name_en:String,ge_countries_3_code:String,ge_countries_c_code:String,ge_countries_c_name:String) {
        self.currency_master_code = currency_master_code
        self.currency_master_country_id = currency_master_country_id
        self.currency_master_name_en = currency_master_name_en
        self.ge_countries_3_code = ge_countries_3_code
        self.ge_countries_c_code = ge_countries_c_code
        self.ge_countries_c_name = ge_countries_c_name
    }
}
