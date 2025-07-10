//
//  MerchantModel.swift
//  GulfExchangeApp
//
//  Created by macbook on 24/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation

struct CountryListResponse: Codable {
    let result: [CountryList]
}
struct CountryList: Codable {
    let error:String?
    let id: Int
    let name: String
    let code: String
}

struct MerchantCategoryResponse: Codable {
    let result: [MerchantCategory]
}
struct MerchantCategory: Codable {
    let error:String?
    let id: Int
    let name: String
    let imageURL: String
    let imageURL2: String
    var selected: Bool = false
    enum CodingKeys: String, CodingKey {
        case error
        case id
        case name
        case imageURL = "image_url"
        case imageURL2 = "x_image_url_2"
    }
}


// Root model
struct NewMerchantResponse: Codable {
    let jsonrpc: String
    let id: String?
    let result: [Merchant]
}

struct Merchant: Codable {
    let error:String?
    let banners: [Banner]?
    let category: String?
    let categoryID: Int?
    let categoryLogo: String?
    let companyContractURL: String?
    let companyRegistrationURL: String?
    let countryID: Int?
    let countryName: String?
    let merchantName: String?
    let merchantID: Int?
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
        case category
        case categoryID = "category_id"
        case countryID = "country_id"
        case countryName = "country_name"
        case categoryLogo = "category_logo"
        case banners
        case pdfAttached = "pdf_attached"
        case companyContractURL = "company_contract_url"
        case companyRegistrationURL = "company_registartion_url"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        error = try? container.decode(String.self, forKey: .error)
        merchantName = try? container.decode(String.self, forKey: .merchantName)
        merchantID = try? container.decode(Int.self, forKey: .merchantID)
        xOnlineStore = try? container.decode(Bool.self, forKey: .xOnlineStore)
        xSequence = try? container.decode(Int.self, forKey: .xSequence)
        merchantLogo = try? container.decode(String.self, forKey: .merchantLogo)
        category = try? container.decode(String.self, forKey: .category)
        categoryID = try? container.decode(Int.self, forKey: .categoryID)
        categoryLogo = try? container.decode(String.self, forKey: .categoryLogo)
        banners = try? container.decode([Banner].self, forKey: .banners)
        pdfAttached = try? container.decode(Bool.self, forKey: .pdfAttached)
        companyContractURL = try? container.decode(String.self, forKey: .companyContractURL)
        companyRegistrationURL = try? container.decode(String.self, forKey: .companyRegistrationURL)
        // Handle inconsistent types for countryID and countryName
        if let countryIDString = try? container.decode(String.self, forKey: .countryID) {
            countryID = Int(countryIDString) ?? nil
        } else {
            countryID = try? container.decode(Int.self, forKey: .countryID)
        }
        
        if let countryNameString = try? container.decode(String.self, forKey: .countryName) {
            countryName = countryNameString
        } else if let countryNameBool = try? container.decode(Bool.self, forKey: .countryName) {
            countryName = countryNameBool ? "Unknown" : nil
        } else {
            countryName = nil
        }
        
    }
}
struct Banner: Codable {
    let id: Int?
//    let name: String?
//    let merchantRating: String?
//    let xSequence: Int?
    let bannerImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id
//        case name
//        case merchantRating = "merchant_rating"
//        case xSequence = "x_sequence"
        case bannerImage = "banner_image"
    }
}
struct AllMerchantResponse: Codable {
    let jsonrpc: String
    let id: String?
    let result: [MerchantDetail]
}
struct MerchantDetailsResponse: Codable {
    let jsonrpc: String?
    let id: String?
    let result: MerchantDetail
}

struct MerchantDetail: Codable {
    let error:String?
    let merchantName: String?
    let xForEmployeeType: String?
    let isBusinessHotel: Bool?
    let xMoiShow: Bool?
    let xHaveBranch: Bool?
    let xHaveOffers: Bool?
    var acceptGoLoyaltyPoint: Bool?
    let openFrom: String?
    let openTill: String?
    let xKts: Bool?
    let merchantID: Int?
    let xOrgLinked: Bool?
    let xOnlineStore: Bool?
    let xSequence: Int?
    let barcode: String?
    let partnerLatitude: Double?
    let partnerLongitude: Double?
    let ribbonText: String?
    let ribbonColor: String?
    let ribbonPosition: String?
    let rating: String?
    let mapBanner: String?
    let merchantLogo: String?
    let category: String?
    let categoryID: Int?
    let countryID: Int?
    let countryName: String?
    let categoryLogo: String?
    let banners: [Banner]?
    let pdfAttached: Bool?
    let companyContractURL: String?
    let companyRegistrationURL: String?

    enum CodingKeys: String, CodingKey {
        case error
        case merchantName = "merchant_name"
        case xForEmployeeType = "x_for_employee_type"
        case isBusinessHotel = "is_business_hotel"
        case xMoiShow = "x_moi_show"
        case xHaveBranch = "x_have_branch"
        case xHaveOffers = "x_have_offers"
        case acceptGoLoyaltyPoint = "accept_go_loyalty_point"
        case openFrom = "open_from"
        case openTill = "open_till"
        case xKts = "x_kts"
        case merchantID = "merchant_id"
        case xOrgLinked = "x_org_linked"
        case xOnlineStore = "x_online_store"
        case xSequence = "x_sequence"
        case barcode
        case partnerLatitude = "partner_latitude"
        case partnerLongitude = "partner_longitude"
        case ribbonText = "ribbon_text"
        case ribbonColor = "ribbon_color"
        case ribbonPosition = "ribbon_position"
        case rating
        case mapBanner = "map_banner"
        case merchantLogo = "merchant_logo"
        case category
        case categoryID = "category_id"
        case countryID = "country_id"
        case countryName = "country_name"
        case categoryLogo = "category_logo"
        case banners
        case pdfAttached = "pdf_attached"
        case companyContractURL = "company_contract_url"
        case companyRegistrationURL = "company_registartion_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        error = try? container.decode(String.self, forKey: .error)
        merchantName = try? container.decode(String.self, forKey: .merchantName)
        xForEmployeeType = try? container.decode(String.self, forKey: .xForEmployeeType)
        isBusinessHotel = try? container.decode(Bool.self, forKey: .isBusinessHotel)
        xMoiShow = try? container.decode(Bool.self, forKey: .xMoiShow)
        xHaveBranch = try? container.decode(Bool.self, forKey: .xHaveBranch)
        xHaveOffers = try? container.decode(Bool.self, forKey: .xHaveOffers)
        acceptGoLoyaltyPoint = try? container.decode(Bool.self, forKey: .acceptGoLoyaltyPoint)
//        openFrom = try? container.decode(Bool.self, forKey: .openFrom)
        if let openFromString = try? container.decode(String.self, forKey: .openFrom) {
                   openFrom = openFromString
               } else if let openFromInt = try? container.decode(Int.self, forKey: .openFrom) {
                   openFrom = "\(openFromInt)"
               } else {
                   openFrom = nil
               }

               // Custom handling for openTill
               if let openTillString = try? container.decode(String.self, forKey: .openTill) {
                   openTill = openTillString
               } else if let openTillInt = try? container.decode(Int.self, forKey: .openTill) {
                   openTill = "\(openTillInt)"
               } else {
                   openTill = nil
               }

//        if let countryNameString = try? container.decode(String.self, forKey: .countryName) {
//                    openTill = countryNameString
//                } else if let countryNameBool = try? container.decode(Bool.self, forKey: .countryName) {
//                    openTill = countryNameBool ? "Unknown" : nil
//                } else {
//                    openTill = nil
//                }
//        openTill = try? container.decode(Bool.self, forKey: .openTill)
        xKts = try? container.decode(Bool.self, forKey: .xKts)
        merchantID = try? container.decode(Int.self, forKey: .merchantID)
        xOrgLinked = try? container.decode(Bool.self, forKey: .xOrgLinked)
        xOnlineStore = try? container.decode(Bool.self, forKey: .xOnlineStore)
        xSequence = try? container.decode(Int.self, forKey: .xSequence)
        barcode = try? container.decode(String.self, forKey: .barcode)
        partnerLatitude = try? container.decode(Double.self, forKey: .partnerLatitude)
        partnerLongitude = try? container.decode(Double.self, forKey: .partnerLongitude)
        ribbonText = try? container.decode(String.self, forKey: .ribbonText)
        ribbonColor = try? container.decode(String.self, forKey: .ribbonColor)
        ribbonPosition = try? container.decode(String.self, forKey: .ribbonPosition)
        rating = try? container.decode(String.self, forKey: .rating)
        mapBanner = try? container.decode(String.self, forKey: .mapBanner)
        merchantLogo = try? container.decode(String.self, forKey: .merchantLogo)
        category = try? container.decode(String.self, forKey: .category)
        categoryID = try? container.decode(Int.self, forKey: .categoryID)
        
        // Handle inconsistent types for countryID and countryName
        if let countryIDString = try? container.decode(String.self, forKey: .countryID) {
            countryID = Int(countryIDString) ?? nil
        } else {
            countryID = try? container.decode(Int.self, forKey: .countryID)
        }
        
        if let countryNameString = try? container.decode(String.self, forKey: .countryName) {
            countryName = countryNameString
        } else if let countryNameBool = try? container.decode(Bool.self, forKey: .countryName) {
            countryName = countryNameBool ? "Unknown" : nil
        } else {
            countryName = nil
        }
        
        categoryLogo = try? container.decode(String.self, forKey: .categoryLogo)
        banners = try? container.decode([Banner].self, forKey: .banners)
        pdfAttached = try? container.decode(Bool.self, forKey: .pdfAttached)
        companyContractURL = try? container.decode(String.self, forKey: .companyContractURL)
        companyRegistrationURL = try? container.decode(String.self, forKey: .companyRegistrationURL)
    }
}

//barcode = 32/*86300000002;*/
//category = "Global hotels";
//"category_id" = 76;
//"category_logo" = "https://golalita.com/go/api/image/76/image_icon/partner.category";
//"company_contract_url" = "https://golalita.com/web/binary/contract_download_pdf/32863";
//"company_registartion_url" = "https://golalita.com/web/binary/registration_download_pdf/32863";
//"country_id" = 48;
//"country_name" = China;
//"is_business_hotel" = 0;
//"map_banner" = "https://golalita.com/go/api/image/32863/map_banner/res.partner";
//"merchant_id" = 32863;
//"merchant_logo" = "https://golalita.com/go/api/image/32863/image_512/res.partner";
//"merchant_name" = "The Ritz-Carlton Chengdu";
/*"open_from" = 24hrs;
"open_till" = 0;
"partner_latitude" = "30.66404";
"partner_longitude" = "104.06955";
"pdf_attached" = 1;
rating = 4;
"ribbon_color" = "#1cc3a3";
"ribbon_position" = right;
"ribbon_text" = "Special Rate";
"x_for_employee_type" = both;
"x_have_branch" = 0;
"x_have_offers" = 0;
"x_kts" = 0;
"x_moi_show" = 1;
"x_online_store" = 0;
"x_org_linked" = 0;
"x_sequence" = 0;
*/
//In api responses, for some scenarios, the response is like


//"accept_go_loyalty_point" = 0;
//banners =             (
//);
//barcode = 9050000000006;
//category = 0;
//"category_id" = 0;
//"category_logo" = "https://golalita.com/go/api/image/False/image_icon/partner.category";
//"company_contract_url" = "https://golalita.com/web/binary/contract_download_pdf/905";
//"company_registartion_url" = "https://golalita.com/web/binary/registration_download_pdf/905";
//"country_id" = 186;
//"country_name" = Qatar;
//"is_business_hotel" = 0;
//"map_banner" = "https://golalita.com/go/api/image/905/map_banner/res.partner";
//"merchant_id" = 905;
//"merchant_logo" = "https://golalita.com/go/api/image/905/image_512/res.partner";
//"merchant_name" = "Ideal Diet";
//"open_from" = 0;
//"open_till" = 0;
//"partner_latitude" = "25.55221";
//"partner_longitude" = "51.25693";
//"pdf_attached" = 1;
//rating = 5;
//"ribbon_color" = "#1cc3a3";
//"ribbon_position" = right;
//"ribbon_text" = "Special Discount";
//"x_for_employee_type" = both;
//"x_have_branch" = 0;
//"x_have_offers" = 0;
//"x_kts" = 0;
//"x_moi_show" = 1;
//"x_online_store" = 0;
//"x_org_linked" = 0;
//"x_sequence" = 0;

/*struct MerchantDetail: Codable {
    let merchantName: String?
//    let xForEmployeeType: String?
//    let isBusinessHotel: Bool?
//    let xMoiShow: Bool?
//    let xHaveBranch: Bool?
//    let xHaveOffers: Bool?
//    var acceptGoLoyaltyPoint: Bool?
//    let openFrom: String? // Changed to String to handle different formats
//    let openTill: String? // Changed to String to handle different formats
//    let xKts: Bool?
    let merchantID: Int?
//    let xOrgLinked: Bool?
//    let xOnlineStore: Bool?
//    let xSequence: Int?
//    let barcode: String?
//    let partnerLatitude: String? // Changed to String to handle different formats
//    let partnerLongitude: String?
//    let ribbonText: String?
    let ribbonColor: String?
//    let ribbonPosition: String?
//    let rating: String?
    let mapBanner: String?
    let merchantLogo: String?
    let category: String?
    let categoryID: Int?
    let countryID: Int?
    let countryName: String?
    let categoryLogo: String?
    let banners: [Banner]?
//    let pdfAttached: Bool?
    let companyContractURL: String?
    let companyRegistrationURL: String?

    enum CodingKeys: String, CodingKey {
        case merchantName = "merchant_name"
//        case xForEmployeeType = "x_for_employee_type"
//        case isBusinessHotel = "is_business_hotel"
//        case xMoiShow = "x_moi_show"
//        case xHaveBranch = "x_have_branch"
//        case xHaveOffers = "x_have_offers"
//        case acceptGoLoyaltyPoint = "accept_go_loyalty_point"
//        case openFrom = "open_from"
//        case openTill = "open_till"
//        case xKts = "x_kts"
        case merchantID = "merchant_id"
//        case xOrgLinked = "x_org_linked"
//        case xOnlineStore = "x_online_store"
//        case xSequence = "x_sequence"
//        case barcode
//        case partnerLatitude = "partner_latitude"
//        case partnerLongitude = "partner_longitude"
//        case ribbonText = "ribbon_text"
        case ribbonColor = "ribbon_color"
//        case ribbonPosition = "ribbon_position"
//        case rating
        case mapBanner = "map_banner"
        case merchantLogo = "merchant_logo"
        case category
        case categoryID = "category_id"
        case countryID = "country_id"
        case countryName = "country_name"
        case categoryLogo = "category_logo"
        case banners
//        case pdfAttached = "pdf_attached"
        case companyContractURL = "company_contract_url"
        case companyRegistrationURL = "company_registartion_url"
    }

    // Custom initializer to handle various data types and formats
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        merchantName = try? container.decode(String.self, forKey: .merchantName)
//        xForEmployeeType = try? container.decode(String.self, forKey: .xForEmployeeType)
//        if let countryNameString = try? container.decode(String.self, forKey: .countryName) {
//            xForEmployeeType = countryNameString
//        } else if let countryNameBool = try? container.decode(Bool.self, forKey: .countryName) {
//            xForEmployeeType = countryNameBool ? "Unknown" : nil
//        } else {
//            xForEmployeeType = nil
//        }
        // Handle both Int and Bool for isBusinessHotel
//        if let intValue = try? container.decode(Int.self, forKey: .isBusinessHotel) {
//            isBusinessHotel = intValue == 1
//        } else {
//            isBusinessHotel = try? container.decode(Bool.self, forKey: .isBusinessHotel)
//        }
//
//        // Handle both Int and Bool for xMoiShow
//        if let intValue = try? container.decode(Int.self, forKey: .xMoiShow) {
//            xMoiShow = intValue == 1
//        } else {
//            xMoiShow = try? container.decode(Bool.self, forKey: .xMoiShow)
//        }
//
//        // Handle both Int and Bool for xHaveBranch
//        if let intValue = try? container.decode(Int.self, forKey: .xHaveBranch) {
//            xHaveBranch = intValue == 1
//        } else {
//            xHaveBranch = try? container.decode(Bool.self, forKey: .xHaveBranch)
//        }
//
//        // Handle both Int and Bool for xHaveOffers
//        if let intValue = try? container.decode(Int.self, forKey: .xHaveOffers) {
//            xHaveOffers = intValue == 1
//        } else {
//            xHaveOffers = try? container.decode(Bool.self, forKey: .xHaveOffers)
//        }
//
//        // Handle both Int and Bool for acceptGoLoyaltyPoint
//        if let intValue = try? container.decode(Int.self, forKey: .acceptGoLoyaltyPoint) {
//            acceptGoLoyaltyPoint = intValue == 1
//        } else {
//            acceptGoLoyaltyPoint = try? container.decode(Bool.self, forKey: .acceptGoLoyaltyPoint)
//        }
//
//        // Handle openFrom and openTill with different formats
//        if let countryNameString = try? container.decode(String.self, forKey: .countryName) {
//            openFrom = countryNameString
//        } else if let countryNameBool = try? container.decode(Bool.self, forKey: .countryName) {
//            openFrom = countryNameBool ? "Unknown" : nil
//        } else {
//            openFrom = nil
//        }
//        
//        if let countryNameString = try? container.decode(String.self, forKey: .countryName) {
//            openTill = countryNameString
//        } else if let countryNameBool = try? container.decode(Bool.self, forKey: .countryName) {
//            openTill = countryNameBool ? "Unknown" : nil
//        } else {
//            openTill = nil
//        }
////        openFrom = try? container.decode(String.self, forKey: .openFrom)
////        openTill = try? container.decode(String.self, forKey: .openTill)
//
//        // Handle both Int and Bool for xKts
//        if let intValue = try? container.decode(Int.self, forKey: .xKts) {
//            xKts = intValue == 1
//        } else {
//            xKts = try? container.decode(Bool.self, forKey: .xKts)
//        }
        merchantID = try? container.decode(Int.self, forKey: .merchantID)
//
//        // Handle both Int and Bool for xOrgLinked
//        if let intValue = try? container.decode(Int.self, forKey: .xOrgLinked) {
//            xOrgLinked = intValue == 1
//        } else {
//            xOrgLinked = try? container.decode(Bool.self, forKey: .xOrgLinked)
//        }
//
//        // Handle both Int and Bool for xOnlineStore
//        if let intValue = try? container.decode(Int.self, forKey: .xOnlineStore) {
//            xOnlineStore = intValue == 1
//        } else {
//            xOnlineStore = try? container.decode(Bool.self, forKey: .xOnlineStore)
//        }
//
//        xSequence = try? container.decode(Int.self, forKey: .xSequence)
//
//        // Handle barcode with different types
//        if let intValue = try? container.decode(Int.self, forKey: .barcode) {
//            barcode = String(intValue)
//        } else {
//            barcode = try? container.decode(String.self, forKey: .barcode)
//        }
//
//        // Handle partnerLatitude with different types
//        if let doubleValue = try? container.decode(Double.self, forKey: .partnerLatitude) {
//            partnerLatitude = String(doubleValue)
//        } else {
//            partnerLatitude = try? container.decode(String.self, forKey: .partnerLatitude)
//        }
//        if let doubleValue = try? container.decode(Double.self, forKey: .partnerLongitude) {
//            partnerLongitude = String(doubleValue)
//        } else {
//            partnerLongitude = try? container.decode(String.self, forKey: .partnerLongitude)
//        }
//        
//        ribbonText = try? container.decode(String.self, forKey: .ribbonText)
        ribbonColor = try? container.decode(String.self, forKey: .ribbonColor)
//        ribbonPosition = try? container.decode(String.self, forKey: .ribbonPosition)
        
        // Handle rating with different types
//        if let intValue = try? container.decode(Int.self, forKey: .rating) {
//            rating = String(intValue)
//        } else {
//            rating = try? container.decode(String.self, forKey: .rating)
//        }

        mapBanner = try? container.decode(String.self, forKey: .mapBanner)
        merchantLogo = try? container.decode(String.self, forKey: .merchantLogo)
        category = try? container.decode(String.self, forKey: .category)
        categoryID = try? container.decode(Int.self, forKey: .categoryID)
        if let countryIDString = try? container.decode(String.self, forKey: .countryID) {
            countryID = Int(countryIDString) ?? nil
        } else {
            countryID = try? container.decode(Int.self, forKey: .countryID)
        }
        
        if let countryNameString = try? container.decode(String.self, forKey: .countryName) {
            countryName = countryNameString
        } else if let countryNameBool = try? container.decode(Bool.self, forKey: .countryName) {
            countryName = countryNameBool ? "Unknown" : nil
        } else {
            countryName = nil
        }
        categoryLogo = try? container.decode(String.self, forKey: .categoryLogo)
        banners = try? container.decode([Banner].self, forKey: .banners)

        // Handle pdfAttached with different types
//        if let intValue = try? container.decode(Int.self, forKey: .pdfAttached) {
//            pdfAttached = intValue == 1
//        } else {
//            pdfAttached = try? container.decode(Bool.self, forKey: .pdfAttached)
//        }

        companyContractURL = try? container.decode(String.self, forKey: .companyContractURL)
        companyRegistrationURL = try? container.decode(String.self, forKey: .companyRegistrationURL)
    }
}
*/


struct MerchantDetails: Codable {
    let merchantName: String?
    let xForEmployeeType: String?
    let isBusinessHotel: String?
    let xMoiShow: String?
    let xHaveBranch: String?
    let xHaveOffers: String?
    var acceptGoLoyaltyPoint: String?
    let openFrom: String?
    let openTill: String?
    let xKts: String?
    let merchantID: Int?
    let xOrgLinked: String?
    let xOnlineStore: String?
    let xSequence: String?
    let barcode: String?
    let partnerLatitude: String?
    let partnerLongitude: String?
    let ribbonText: String?
    let ribbonColor: String?
    let ribbonPosition: String?
    let rating: String?
    let mapBanner: String?
    let merchantLogo: String?
    let category: String?
    let categoryID: String?
    let countryID: String?
    let countryName: String?
    let categoryLogo: String?
    let banners: [Banner]?
    let pdfAttached: String?
    let companyContractURL: String?
    let companyRegistrationURL: String?

    enum CodingKeys: String, CodingKey {
        case merchantName = "merchant_name"
        case xForEmployeeType = "x_for_employee_type"
        case isBusinessHotel = "is_business_hotel"
        case xMoiShow = "x_moi_show"
        case xHaveBranch = "x_have_branch"
        case xHaveOffers = "x_have_offers"
        case acceptGoLoyaltyPoint = "accept_go_loyalty_point"
        case openFrom = "open_from"
        case openTill = "open_till"
        case xKts = "x_kts"
        case merchantID = "merchant_id"
        case xOrgLinked = "x_org_linked"
        case xOnlineStore = "x_online_store"
        case xSequence = "x_sequence"
        case barcode
        case partnerLatitude = "partner_latitude"
        case partnerLongitude = "partner_longitude"
        case ribbonText = "ribbon_text"
        case ribbonColor = "ribbon_color"
        case ribbonPosition = "ribbon_position"
        case rating
        case mapBanner = "map_banner"
        case merchantLogo = "merchant_logo"
        case category
        case categoryID = "category_id"
        case countryID = "country_id"
        case countryName = "country_name"
        case categoryLogo = "category_logo"
        case banners
        case pdfAttached = "pdf_attached"
        case companyContractURL = "company_contract_url"
        case companyRegistrationURL = "company_registartion_url"
    }

    // Custom initializer to handle different formats and convert to strings
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        merchantName = try? container.decode(String.self, forKey: .merchantName)
        xForEmployeeType = try? container.decode(String.self, forKey: .xForEmployeeType)
        
        // Decode fields as String and then handle conversion if needed
        isBusinessHotel = (try? container.decode(String.self, forKey: .isBusinessHotel))?.lowercased()
        xMoiShow = (try? container.decode(String.self, forKey: .xMoiShow))?.lowercased()
        xHaveBranch = (try? container.decode(String.self, forKey: .xHaveBranch))?.lowercased()
        xHaveOffers = (try? container.decode(String.self, forKey: .xHaveOffers))?.lowercased()
        acceptGoLoyaltyPoint = (try? container.decode(String.self, forKey: .acceptGoLoyaltyPoint))?.lowercased()
        
        openFrom = try? container.decode(String.self, forKey: .openFrom)
        openTill = try? container.decode(String.self, forKey: .openTill)
        xKts = (try? container.decode(String.self, forKey: .xKts))?.lowercased()
        merchantID = try? container.decode(Int.self, forKey: .merchantID)
//        merchantID = (try? container.decode(Int.self, forKey: .merchantID)).map { String($0) }
        xOrgLinked = (try? container.decode(String.self, forKey: .xOrgLinked))?.lowercased()
        xOnlineStore = (try? container.decode(String.self, forKey: .xOnlineStore))?.lowercased()
        xSequence = (try? container.decode(String.self, forKey: .xSequence))?.lowercased()
        
        barcode = try? container.decode(String.self, forKey: .barcode)
        partnerLatitude = try? container.decode(String.self, forKey: .partnerLatitude)
        partnerLongitude = try? container.decode(String.self, forKey: .partnerLongitude)
        ribbonText = try? container.decode(String.self, forKey: .ribbonText)
        ribbonColor = try? container.decode(String.self, forKey: .ribbonColor)
        ribbonPosition = try? container.decode(String.self, forKey: .ribbonPosition)
        
        rating = (try? container.decode(Int.self, forKey: .rating)).map { String($0) } ?? (try? container.decode(String.self, forKey: .rating))
        
        mapBanner = try? container.decode(String.self, forKey: .mapBanner)
        merchantLogo = try? container.decode(String.self, forKey: .merchantLogo)
        category = try? container.decode(String.self, forKey: .category)
        categoryID = (try? container.decode(Int.self, forKey: .categoryID)).map { String($0) }
        countryID = (try? container.decode(Int.self, forKey: .countryID)).map { String($0) }
        countryName = try? container.decode(String.self, forKey: .countryName)
        categoryLogo = try? container.decode(String.self, forKey: .categoryLogo)
        banners = try? container.decode([Banner].self, forKey: .banners)
        
        pdfAttached = (try? container.decode(String.self, forKey: .pdfAttached))?.lowercased()
        companyContractURL = try? container.decode(String.self, forKey: .companyContractURL)
        companyRegistrationURL = try? container.decode(String.self, forKey: .companyRegistrationURL)
    }
}
//let merchantBannerImage:[Banner] =[Banner(id: 90, name: "asdad", merchantRating: <#T##String?#>, xSequence: <#T##Int?#>, bannerImage: <#T##String?#>),
//                                   Banner(id: 2, name: "asdad", merchantRating: <#T##String?#>, xSequence: <#T##Int?#>, bannerImage: <#T##String?#>),
//                                   Banner(id: 23, name: "asdad", merchantRating: <#T##String?#>, xSequence: <#T##Int?#>, bannerImage: <#T##String?#>),
//                                   Banner(id: 4, name: "asdad", merchantRating: <#T##String?#>, xSequence: <#T##Int?#>, bannerImage: <#T##String?#>)]
//
//
//
//banners =             (
//                    {
//        "banner_image" = "https://golalita.com/go/api/image/19106/image_1920/merchant.banner";
//        id = 19106;
//        "merchant_rating" = 4;
//        name = "Zoh Lifestyle Deck - RIXOS GULF HOTEL DOHA";
//        "x_sequence" = 0;
//    },
//                    {
//        "banner_image" = "https://golalita.com/go/api/image/19107/image_1920/merchant.banner";
//        id = 19107;
//        "merchant_rating" = 4;
//        name = 0;
//        "x_sequence" = 0;
//    },
//                    {
//        "banner_image" = "https://golalita.com/go/api/image/19108/image_1920/merchant.banner";
//        id = 19108;
//        "merchant_rating" = 4;
//        name = 0;
//        "x_sequence" = 0;
//    }
//);
//banners =             (
//                    {
//        "banner_image" = "https://golalita.com/go/api/image/19174/image_1920/merchant.banner";
//        id = 19174;
//        "merchant_rating" = 4;
//        name = "Autograph Collection Bankside Hotel";
//        "x_sequence" = 0;
//    }
//);
