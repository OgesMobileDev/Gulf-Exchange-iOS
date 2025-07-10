//
//  LanguageResponse.swift
//  GulfExchangeApp
//
//  Created by test on 06/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
struct LanguageSuccessResult: Codable {
    var lanuage_listing : LanguageResponseResult?
}
struct LanguageResponseResult : Codable {
    var name:String?
    var code:String?
    var id:String?
    
    init(name:String?,code:String?,id:String?) {
        self.name = name
        self.code = code
        self.id = id
    }
}
