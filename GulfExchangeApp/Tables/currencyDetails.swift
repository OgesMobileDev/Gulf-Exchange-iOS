//
//  currencyDetails.swift
//  
//
//  Created by MacBook Pro on 8/19/22.
//

import Foundation
import UIKit

class country: Codable
{
    var countryCode:String
    var countryName:String
    var currencyname:String
    var currencyCode:String
    var currencyCodetwolet:String
    
    init(countryCode:String,countryName:String,currencyname:String,currencyCode:String,currencyCodetwolet:String) {
        self.countryCode = countryCode
        self.countryName = countryName
        self.currencyname = currencyname
        self.currencyCode = currencyCode
        self.currencyCodetwolet = currencyCodetwolet
    }
}
