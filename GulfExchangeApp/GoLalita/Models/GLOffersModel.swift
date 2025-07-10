//
//  GLOffersModel.swift
//  GulfExchangeApp
//
//  Created by macbook on 22/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation

struct GLAllOffers: Codable {
    let name: String?
    let imageURL: String?
    let lstPrice: Double?
    let defaultCode: String?
    let xPoint: Int?
    let maxQuantity: Int?
    let barcode: String?
    let description: String?
    let descriptionSale: String?
    let offerLabel: String?
    let merchantID: Int?
    let merchantName: String?
    let categoryID: Int?
    let categoryName: String?
    let startDate: String?
    let endDate: String?
    let minQuantity: Int?
    let discount: Int?
    let ribbon: String?
    let point: Int?
    let merchantLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
        case lstPrice = "lst_price"
        case defaultCode = "default_code"
        case xPoint = "x_point"
        case maxQuantity = "max_quantity"
        case barcode
        case description
        case descriptionSale = "description_sale"
        case offerLabel = "offer_label"
        case merchantID = "merchant_id"
        case merchantName = "merchant_name"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case startDate = "start_date"
        case endDate = "end_date"
        case minQuantity = "min_quantity"
        case discount
        case ribbon
        case point
        case merchantLogo = "merchant_logo"
    }
}
struct AllOffersResponse: Codable {
    let result: [OffersDetailsList]
}
struct OfferDetailsResponse: Codable {
    let result: [OffersDetails]
}


   
struct OffersDetailsList: Codable {
    let error:String?
    let id: Int?
    let name: String?
    let imageURL: String?
    let merchantLogo: String?
    let merchantID: Int?
    let merchantName: String?
    let xOfferType: String?
    
    
    enum CodingKeys: String, CodingKey {
        case error
        case id
        case name
        case imageURL = "image_url"
        case merchantLogo = "merchant_logo"
        case merchantID = "merchant_id"
        case merchantName = "merchant_name"
        case xOfferType = "x_offer_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        error = try? container.decode(String.self, forKey: .error)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        imageURL = try? container.decode(String.self, forKey: .imageURL)
        merchantID = try? container.decode(Int.self, forKey: .merchantID)
        merchantName = try? container.decode(String.self, forKey: .merchantName)
        merchantLogo = try? container.decode(String.self, forKey: .merchantLogo)
        
        if let stringValue = try? container.decode(String.self, forKey: .xOfferType) {
            xOfferType = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .xOfferType) {
            xOfferType = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .xOfferType) {
            xOfferType = String(intValue)
        } else {
            xOfferType = ""
        }
    }
}

struct Category: Codable {
    let id: Int?
    let name: String?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        id = try? container.decode(Int.self)
        name = try? container.decode(String.self)
    }
}

/*{
 "id": 31763,
 "name": "Double Occupancy With Breakfast Buffet",
 "image_url": "https://golalita.com/go/api/image/31763/image_512/product.template",
 "lst_price": 325.0,
 "default_code": false,
 "x_point": 0.0,
 "max_quantity": 0.0,
 "barcode": false,
 "description": false,
 "description_sale": "get Special Discount on your total bill on every bill . Please contact +974 4007 8333 for more information.",
 "offer_label": false,
 "merchant_id": 17068,
 "categ_id": [
 1,
 "All"
 ],
 "start_date": false,
 "end_date": false,
 "min_quantity": 0.0,
 "discount": 0.0,
 "ribbon": "15% Discout",
 "merchant_name": "Premier Inn Doha Education City Hotel",
 "category_id": 1,
 "category_name": "All",
 "disc_ribbon": false,
 "point": 0.0,
 "merchant_logo": "https://golalita.com/go/api/image/17068/image_1920/res.partner"
 },
 */
struct OffersDetail: Codable {
    let id: Int?
    let name: String?
    let imageURL: String?
    let lstPrice: Double?
    let defaultCode: String?
    let xPoint: Double?
    let maxQuantity: Double?
    let barcode: String?
    let description: String?
    let descriptionSale: String?
    let offerLabel: String?
    let merchantID: Int?
    let categID: [Category]?
    let startDate: String?
    let endDate: String?
    let minQuantity: Double?
    let discount: Double?
    let ribbon: String?
    let merchantName: String?
    let categoryID: Int?
    let categoryName: String?
    let discRibbon: String?
    let point: Double?
    let merchantLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
        case lstPrice = "lst_price"
        case defaultCode = "default_code"
        case xPoint = "x_point"
        case maxQuantity = "max_quantity"
        case barcode
        case description
        case descriptionSale = "description_sale"
        case offerLabel = "offer_label"
        case merchantID = "merchant_id"
        case categID = "categ_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case minQuantity = "min_quantity"
        case discount
        case ribbon
        case merchantName = "merchant_name"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case discRibbon = "disc_ribbon"
        case point
        case merchantLogo = "merchant_logo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        imageURL = try? container.decode(String.self, forKey: .imageURL)
        lstPrice = try? container.decode(Double.self, forKey: .lstPrice)
        
        // Handle defaultCode as String or Bool
        if let defaultCodeString = try? container.decode(String.self, forKey: .defaultCode) {
            defaultCode = defaultCodeString
        } else if let defaultCodeBool = try? container.decode(Bool.self, forKey: .defaultCode) {
            defaultCode = defaultCodeBool ? "true" : "false"
        } else {
            defaultCode = nil
        }
        
        xPoint = try? container.decode(Double.self, forKey: .xPoint)
        maxQuantity = try? container.decode(Double.self, forKey: .maxQuantity)
        
        // Handle barcode as String or Bool
        if let barcodeString = try? container.decode(String.self, forKey: .barcode) {
            barcode = barcodeString
        } else if let barcodeBool = try? container.decode(Bool.self, forKey: .barcode) {
            barcode = barcodeBool ? "true" : "false"
        } else {
            barcode = nil
        }
        
        // Handle description as String or Bool
        if let descriptionString = try? container.decode(String.self, forKey: .description) {
            description = descriptionString
        } else if let descriptionBool = try? container.decode(Bool.self, forKey: .description) {
            description = descriptionBool ? "true" : "false"
        } else {
            description = nil
        }
        
        descriptionSale = try? container.decode(String.self, forKey: .descriptionSale)
        
        // Handle offerLabel as String or Bool
        if let offerLabelString = try? container.decode(String.self, forKey: .offerLabel) {
            offerLabel = offerLabelString
        } else if let offerLabelBool = try? container.decode(Bool.self, forKey: .offerLabel) {
            offerLabel = offerLabelBool ? "true" : "false"
        } else {
            offerLabel = nil
        }
        
        merchantID = try? container.decode(Int.self, forKey: .merchantID)
        categID = try? container.decode([Category].self, forKey: .categID)
        
        // Handle startDate and endDate as String or Bool
        if let startDateString = try? container.decode(String.self, forKey: .startDate) {
            startDate = startDateString
        } else if let startDateBool = try? container.decode(Bool.self, forKey: .startDate) {
            startDate = startDateBool ? "true" : "false"
        } else {
            startDate = nil
        }
        
        if let endDateString = try? container.decode(String.self, forKey: .endDate) {
            endDate = endDateString
        } else if let endDateBool = try? container.decode(Bool.self, forKey: .endDate) {
            endDate = endDateBool ? "true" : "false"
        } else {
            endDate = nil
        }
        
        minQuantity = try? container.decode(Double.self, forKey: .minQuantity)
        discount = try? container.decode(Double.self, forKey: .discount)
        ribbon = try? container.decode(String.self, forKey: .ribbon)
        merchantName = try? container.decode(String.self, forKey: .merchantName)
        categoryID = try? container.decode(Int.self, forKey: .categoryID)
        categoryName = try? container.decode(String.self, forKey: .categoryName)
        
        // Handle discRibbon as String or Bool
        if let discRibbonString = try? container.decode(String.self, forKey: .discRibbon) {
            discRibbon = discRibbonString
        } else if let discRibbonBool = try? container.decode(Bool.self, forKey: .discRibbon) {
            discRibbon = discRibbonBool ? "true" : "false"
        } else {
            discRibbon = nil
        }
        
        point = try? container.decode(Double.self, forKey: .point)
        merchantLogo = try? container.decode(String.self, forKey: .merchantLogo)
    }
}
enum StringOrBool: Codable {
    case string(String)
    case bool(Bool)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else if let boolValue = try? container.decode(Bool.self) {
            self = .bool(boolValue)
        } else {
            throw DecodingError.typeMismatch(StringOrBool.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected string or bool"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .bool(let value):
            let boolAsString = value ? "true" : "false"
            try container.encode(boolAsString)
        }
    }
}


struct OffersDetails: Codable {
    let error:String?
    let id: Int?
    let xForEmployeeType: Bool?
    let name: String?
    let xOfferType: String?
    let imageUrl: String?
    let lstPrice: Double?
    let defaultCode: Bool?
    let xPoint: Double?
    let xOnlineStore: Bool?
    let maxQuantity: Double?
    let xOfferTypeDiscount: Double?
    let xOfferTypePromoCode: String?
    let xMerchantOnlineStore: String?
    let xBuyLink: String?
    let barcode: Bool?
    let description: String?
    let descriptionSale: String? // string or bool or int?
    let xDescriptionArabic: String?
    let offerLabel: Bool?
    let merchantID: Int?
    let categID: [Category]?
    let createDate: String?
    let startDate: String?
    let endDate: String?
    let minQuantity: Double?
    let discount: Double?
    let ribbon: String?
    let merchantName: String?
    let merchantRating: Int?
    let categoryID: Int?
    let categoryName: String?
    let discRibbon: Bool?
    let point: Double?
    let productMerchantIsBusinessHotel: Int?
    let merchantLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case error
        case id
        case xForEmployeeType = "x_for_employee_type"
        case name
        case xOfferType = "x_offer_type"
        case imageUrl = "image_url"
        case lstPrice = "lst_price"
        case defaultCode = "default_code"
        case xPoint = "x_point"
        case xOnlineStore = "x_online_store"
        case maxQuantity = "max_quantity"
        case xOfferTypeDiscount = "x_offer_type_discount"
        case xOfferTypePromoCode = "x_offer_type_promo_code"
        case xMerchantOnlineStore = "x_merchant_online_store"
        case xBuyLink = "x_buy_link"
        case barcode
        case description
        case descriptionSale = "description_sale"
        case xDescriptionArabic = "x_description_arabic"
        case offerLabel = "offer_label"
        case merchantID = "merchant_id"
        case categID = "categ_id"
        case createDate = "create_date"
        case startDate = "start_date"
        case endDate = "end_date"
        case minQuantity = "min_quantity"
        case discount
        case ribbon
        case merchantName = "merchant_name"
        case merchantRating = "merchant_rating"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case discRibbon = "disc_ribbon"
        case point
        case productMerchantIsBusinessHotel = "product_merchant_is_business_hotel"
        case merchantLogo = "merchant_logo"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        error = try? container.decode(String.self, forKey: .error)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        xForEmployeeType = try? container.decode(Bool.self, forKey: .xForEmployeeType)
        imageUrl = try? container.decode(String.self, forKey: .imageUrl)
        lstPrice = try? container.decode(Double.self, forKey: .lstPrice)
        defaultCode = try? container.decode(Bool.self, forKey: .defaultCode)
        xPoint = try? container.decode(Double.self, forKey: .xPoint)
        xOnlineStore = try? container.decode(Bool.self, forKey: .xOnlineStore)
        maxQuantity = try? container.decode(Double.self, forKey: .maxQuantity)
        xOfferTypeDiscount = try? container.decode(Double.self, forKey: .xOfferTypeDiscount)
        xMerchantOnlineStore = try? container.decode(String.self, forKey: .xMerchantOnlineStore)
        barcode = try? container.decode(Bool.self, forKey: .barcode)
        offerLabel = try? container.decode(Bool.self, forKey: .offerLabel)
        merchantID = try? container.decode(Int.self, forKey: .merchantID)
        categID = try? container.decode([Category].self, forKey: .categID)
        createDate = try? container.decode(String.self, forKey: .createDate)
        minQuantity = try? container.decode(Double.self, forKey: .minQuantity)
        discount = try? container.decode(Double.self, forKey: .discount)
        ribbon = try? container.decode(String.self, forKey: .ribbon)
        merchantName = try? container.decode(String.self, forKey: .merchantName)
        merchantRating = try? container.decode(Int.self, forKey: .merchantRating)
        categoryID = try? container.decode(Int.self, forKey: .categoryID)
        categoryName = try? container.decode(String.self, forKey: .categoryName)
        discRibbon = try? container.decode(Bool.self, forKey: .discRibbon)
        point = try? container.decode(Double.self, forKey: .point)
        productMerchantIsBusinessHotel = try? container.decode(Int.self, forKey: .productMerchantIsBusinessHotel)
        merchantLogo = try? container.decode(String.self, forKey: .merchantLogo)
        
        if let stringValue = try? container.decode(String.self, forKey: .xOfferType) {
            xOfferType = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .xOfferType) {
            xOfferType = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .xOfferType) {
            xOfferType = String(intValue)
        } else {
            xOfferType = ""
        }
        if let stringValue = try? container.decode(String.self, forKey: .xOfferTypePromoCode) {
            xOfferTypePromoCode = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .xOfferTypePromoCode) {
            xOfferTypePromoCode = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .xOfferTypePromoCode) {
            xOfferTypePromoCode = String(intValue)
        } else {
            xOfferTypePromoCode = ""
        }
        if let stringValue = try? container.decode(String.self, forKey: .xBuyLink) {
            xBuyLink = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .xBuyLink) {
            xBuyLink = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .xBuyLink) {
            xBuyLink = String(intValue)
        } else {
            xBuyLink = ""
        }
        if let stringValue = try? container.decode(String.self, forKey: .description) {
            description = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .description) {
            description = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .description) {
            description = String(intValue)
        } else {
            description = ""
        }
        if let stringValue = try? container.decode(String.self, forKey: .xDescriptionArabic) {
            xDescriptionArabic = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .xDescriptionArabic) {
            xDescriptionArabic = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .xDescriptionArabic) {
            xDescriptionArabic = String(intValue)
        } else {
            xDescriptionArabic = ""
        }
        if let stringValue = try? container.decode(String.self, forKey: .startDate) {
            startDate = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .startDate) {
            startDate = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .startDate) {
            startDate = String(intValue)
        } else {
            startDate = ""
        }
        if let stringValue = try? container.decode(String.self, forKey: .endDate) {
            endDate = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .endDate) {
            endDate = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .endDate) {
            endDate = String(intValue)
        } else {
            endDate = ""
        }
        if let stringValue = try? container.decode(String.self, forKey: .descriptionSale) {
            descriptionSale = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .descriptionSale) {
            descriptionSale = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .descriptionSale) {
            descriptionSale = String(intValue)
        } else if let unquotedStringValue = try? container.decode(AnyDecodable.self, forKey: .descriptionSale).value {
            descriptionSale = String(describing: unquotedStringValue)
        } else {
            descriptionSale = ""
        }
    }
}
struct AnyDecodable: Decodable {
    let value: Any
    
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            value = intValue
        } else if let boolValue = try? decoder.singleValueContainer().decode(Bool.self) {
            value = boolValue
        } else if let doubleValue = try? decoder.singleValueContainer().decode(Double.self) {
            value = doubleValue
        } else if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            value = stringValue
        } else {
            value = ""
        }
    }
}
