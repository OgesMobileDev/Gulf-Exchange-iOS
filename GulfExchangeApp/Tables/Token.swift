//
//  Token.swift
//  GulfExchangeApp
//
//  Created by test on 13/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class Token {
    var access_token:String
    var expires_in:String
    var refresh_token:String
    var scope:String
    var token_type:String
    
    
    init(access_token:String, expires_in:String,refresh_token:String,scope:String,token_type:String) {
        self.access_token = access_token
        self.expires_in = expires_in
        self.refresh_token = refresh_token
        self.scope = scope
        self.token_type = token_type
    }
}
