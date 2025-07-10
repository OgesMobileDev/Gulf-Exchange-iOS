//
//  Country.swift
//  GulfExchangeApp
//
//  Created by test on 16/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class Country{
    var id:String
    var num_code:String
    var alpha_2_code:String
    var alpha_3_code:String
    var en_short_name:String
    var nationality:String
    
    init(id:String,num_code:String,alpha_2_code:String,alpha_3_code:String,en_short_name:String,nationality:String) {
        self.id = id
        self.num_code = num_code
        self.alpha_2_code = alpha_2_code
        self.alpha_3_code = alpha_3_code
        self.en_short_name = en_short_name
        self.nationality = nationality
    }
}
