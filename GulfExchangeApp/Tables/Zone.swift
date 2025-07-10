//
//  Zone.swift
//  GulfExchangeApp
//
//  Created by test on 16/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class Zone {
    var id:String
    var municipality:String
    var zone:String
    
    init(id:String,municipality:String,zone:String) {
        self.id = id
        self.municipality = municipality
        self.zone = zone
    }
}
