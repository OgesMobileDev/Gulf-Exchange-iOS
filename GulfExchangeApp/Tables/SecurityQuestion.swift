//
//  SecurityQuestion.swift
//  GulfExchangeApp
//
//  Created by test on 16/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class SecurityQuestion {
    var id:String
    var security_question_en:String
    
    init(id:String,security_question_en:String) {
        self.id = id
        self.security_question_en = security_question_en
    }
}
