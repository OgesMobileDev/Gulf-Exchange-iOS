//
//  Beneficiary.swift
//  GulfExchangeApp
//
//  Created by macbook on 21/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation

struct CasmexListBeneficiary: Codable {
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let receiveCountry: String?
    let receiveCurrency: String?
    let deliveryOption: String?
    let dob: String?
    let nationality: String?
    let mobileNumber: String?
    let address: String?
    let address1: String?
    let address2: String?
    let beneficiaryCode: String?
    let country: String?
    let gender: String?
    let currency: String?
    let customerCode: String?
    let relationship: String?
    let relationshipDesc: String?
    let serviceCategory: String?
    let city: String?
    let zipCode: String?
    let accountNumber: String?
    let bankCode: String?
    let bankName: String?
    let branchCode: String?
    let branchName: String?
    let idType: String?
    let idNumber: String?
    let relationshipToSender: String?
    let placeOfBirth: String?
    let serviceProviderName:String?
    let serviceProviderCode:String?
    let active:String?
    let other1: String?
    let other2: String?
    let other3: String?
    let other4: String?
    let other5: String?
}
struct CasmexRecentBeneficiary:Codable{
    let beneficiaryName:String?
    let beneficiaryCode:String?
}
struct CasmexBank:Codable{
    let bankCode:String
    let bankName:String
}
struct CasmexCountry:Codable{
    let countryCode:String
    let countryName:String
}
struct CasmexCurrency:Codable{
//    let responseCode:String?
//    let responseMessage:String?
//    let countrycode:String?
    let currencyCode:String
    let currencyName:String
}
struct CasmexBranch:Codable {
    let branchCode: String
    let branchName: String
    let address: String
    let email: String
    let phone: String
    let bicDetails: [CasmexBICDetail]
}

struct CasmexBICDetail:Codable {
    let bicType: String
    let bicValue: String
}


struct CasmexNationalityResponse: Codable {
    let error: String?
    let data: [CasmexNationality]
}

struct CasmexNationality: Codable {
    let id: String
    let description: String
}
struct CasmexRelation: Codable {
    let id: String
    let description: String
}
struct CasmexServiceProvider:Codable{
    let serviceProviderCode:String
    let serviceProviderName:String
    let serviceProviderType:String
}
struct CasmexRateCalcCountry:Codable{
    let countryCode:String
    let countryName:String
    let currencyCode:String
    let currencyName:String
}
struct CasmexRateDetails:Codable{
    let statusCode:String
    let statusMessage:String
    let fcyAmount:String
    let lcyAmount:String
    let mulRate:String
    let divRate:String
    let charge:String
    let vat:String
}
struct CasmexPurposeSource:Codable{
    let responseCode:String?
    let responseMessage:String?
    let messageDetail:String?
    let description:String?
    let id:String?
}
struct CasmexTransferRate:Codable{
    let receiveAmount:String?
    let localAmount:String?
    let divRate:String?
    let charge:String?
    let priceOrderCode:String?
//    let retailExchangeRate:Double?
//    let baseExchangeRateSpecified:Bool?
//    let mulRate:Double?
//    let statusCode:String?
//    let statusMessage:String?
    enum CodingKeys: String, CodingKey {
        case receiveAmount
        case localAmount
        case divRate
        case charge
        case priceOrderCode
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let receiveAmountString = try? container.decode(String.self, forKey: .receiveAmount) {
            receiveAmount = receiveAmountString
        } else if let openTillInt = try? container.decode(Int.self, forKey: .receiveAmount) {
            receiveAmount = "\(openTillInt)"
        } else if let openTillDouble = try? container.decode(Double.self, forKey: .receiveAmount) {
            receiveAmount = "\(openTillDouble)"
        } else {
            receiveAmount = nil
        }

        if let openTillString = try? container.decode(String.self, forKey: .localAmount) {
            localAmount = openTillString
        } else if let openTillInt = try? container.decode(Int.self, forKey: .localAmount) {
            localAmount = "\(openTillInt)"
        } else if let openTillDouble = try? container.decode(Double.self, forKey: .localAmount) {
            localAmount = "\(openTillDouble)"
        } else  {
            localAmount = nil
        }

        if let openTillString = try? container.decode(String.self, forKey: .divRate) {
            divRate = openTillString
        } else if let openTillInt = try? container.decode(Int.self, forKey: .divRate) {
            divRate = "\(openTillInt)"
        } else  if let openTillDouble = try? container.decode(Double.self, forKey: .divRate) {
            divRate = "\(openTillDouble)"
        } else {
            divRate = nil
        }

        if let openTillString = try? container.decode(String.self, forKey: .charge) {
            charge = openTillString
        } else if let openTillInt = try? container.decode(Int.self, forKey: .charge) {
            charge = "\(openTillInt)"
        } else  if let openTillDouble = try? container.decode(Double.self, forKey: .charge) {
            charge = "\(openTillDouble)"
        } else {
            charge = nil
        }
        
        if let openTillString = try? container.decode(String.self, forKey: .priceOrderCode) {
            priceOrderCode = openTillString
        } else if let openTillInt = try? container.decode(Int.self, forKey: .priceOrderCode) {
            priceOrderCode = "\(openTillInt)"
        } else if let openTillDouble = try? container.decode(Double.self, forKey: .priceOrderCode) {
            priceOrderCode = "\(openTillDouble)"
        } else  {
            priceOrderCode = nil
        }
    }
}

struct CasmexTransactionDetails: Decodable {
    let responseCode: String?
    let responseMessage: String?
    let messageDetail: String?
    let customerCode: String?
    let customerFullName: String?
    let customerIdType: String?
    let customerIdNo: String?
    let customerPhone: String?
    let customerMobile: String?
    let customerAddress: String?
    let customerNationality: String?
    let transactionRefNo: String?
    let beneficiaryAccountName: String?
    let beneficiaryBankCountryCode: String?
    let beneficiaryBankCode: String?
    let beneficiaryBankBranchCode: String?
    let beneficiaryAccountNo: String?
    let beneficiaryBankEng: String?
    let beneficiaryBranchEng: String?
    let serviceType: String?
    let beneficiaryAddress: String?
    let transactionDate: String?
    let payoutCurrency: String?
    let payoutAmount: String?
    let exchangeRate: String?
    let commission: String?
    let totalPayinAmount: String?
    let purposeOfTxn: String?
    let sourceOfIncome: String?
    let payinAmount: String?
    let payinCurrency: String?
    let passportNo: String?
    let profession: String?
    let actualProfession: String?
    let serviceProviderName: String?
    let agentName: String?
    let ifscCode: String?
    let clientRefNo: String?
}
