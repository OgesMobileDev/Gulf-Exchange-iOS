//
//  NotificationMessageModel.swift
//  GulfExchangeApp
//
//  Created by mac on 04/09/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation

//struct NotificationMessage: Codable {
//    let name: String?
//    let imageURL: String?
//    let lstPrice: Double?
//    let defaultCode: String?
//    let xPoint: Int?
//    let maxQuantity: Int?
//    let barcode: String?
//    let description: String?
//    let descriptionSale: String?
//    let offerLabel: String?
//    let merchantID: Int?
//    let merchantName: String?
//    let categoryID: Int?
//    let categoryName: String?
//    let startDate: String?
//    let endDate: String?
//    let minQuantity: Int?
//    let discount: Int?
//    let ribbon: String?
//    let point: Int?
//    let merchantLogo: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case name
//        case imageURL = "image_url"
//        case lstPrice = "lst_price"
//        case defaultCode = "default_code"
//        case xPoint = "x_point"
//        case maxQuantity = "max_quantity"
//        case barcode
//        case description
//        case descriptionSale = "description_sale"
//        case offerLabel = "offer_label"
//        case merchantID = "merchant_id"
//        case merchantName = "merchant_name"
//        case categoryID = "category_id"
//        case categoryName = "category_name"
//        case startDate = "start_date"
//        case endDate = "end_date"
//        case minQuantity = "min_quantity"
//        case discount
//        case ribbon
//        case point
//        case merchantLogo = "merchant_logo"
//    }
//}

// Root model
struct NotificationMessage: Codable {
    let jsonrpc: String
    let id: String?
    let result: [NotificationList]
}

struct NotificationList: Codable {
    let error:String?
    let description: String?
    let notification_id: Int?
    let banner: String?
    let html_description: String?
    let merchantName: String?
    let merchantID: Int?
    let date: String?
    let notification_type: String?
    let offer_image: String?
    
    
    let xOnlineStore: Bool?
    let xSequence: Int?
    let merchantLogo: String?
    let pdfAttached: Bool?
    enum CodingKeys: String, CodingKey {
        case error
        case merchantName = "merchant_name"
        case merchantID = "merchant_id"
        case xOnlineStore = "x_online_store"
        case xSequence = "x_sequence"
        case merchantLogo = "merchant_logo"
        case description
        case notification_id = "notification_id"
        case pdfAttached = "pdf_attached"
        case banner = "banner"
        case html_description = "html_description"
        case date = "date"
        case notification_type = "notification_type"
        case offer_image = "offer_image"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        error = try? container.decode(String.self, forKey: .error)
        merchantName = try? container.decode(String.self, forKey: .merchantName)
        merchantID = try? container.decode(Int.self, forKey: .merchantID)
        xOnlineStore = try? container.decode(Bool.self, forKey: .xOnlineStore)
        xSequence = try? container.decode(Int.self, forKey: .xSequence)
        merchantLogo = try? container.decode(String.self, forKey: .merchantLogo)
        description = try? container.decode(String.self, forKey: .description)
        notification_id = try? container.decode(Int.self, forKey: .notification_id)
        pdfAttached = try? container.decode(Bool.self, forKey: .pdfAttached)
        banner = try? container.decode(String.self, forKey: .banner)
        html_description = try? container.decode(String.self, forKey: .html_description)
        date = try? container.decode(String.self, forKey: .date)
        notification_type = try? container.decode(String.self, forKey: .notification_type)
        offer_image = try? container.decode(String.self, forKey: .offer_image)
        
    }
}

