//
//  CardsModel.swift
//  GulfExchangeApp
//
//  Created by macbook on 26/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation
import Foundation

struct UserProfileModelResponse: Codable {
    let result: UserProfileModel
}

struct UserProfileModel: Codable {
    let error:String?
    let xUserExpiry: String?
    let mainMember: Bool?
    let profile: Profile?
    let members: [Member]?
    let walletDesign: String?

    enum CodingKeys: String, CodingKey {
        case error
        case xUserExpiry = "x_user_expiry"
        case mainMember = "main_member"
        case profile, members
        case walletDesign = "wallet_design"
    }
}

struct Profile: Codable {
    let name: String?
    let createDate: String?
    let phone: String?
    let partnerID: Int?
    let email: String?
    let barcode: String?
    let address: String?
    let employeeType: Bool?
    let organisation: String?
    let organisationLogo: String?
    let photo: String?
    let availablePoints: Int?
    let totalPointsEarn: Int?
    let totalPointsUsed: Int?
    let totalSaving: Int?
    let whatsappEnabled: Bool?
    let whatsappTitle: Bool?
    let whatsappNumber: Bool?
    let whatsappxPrefillMessage: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case createDate = "create_date"
        case phone
        case partnerID = "partner_id"
        case email
        case barcode
        case address
        case employeeType = "employee_type"
        case organisation
        case organisationLogo = "organisation_logo"
        case photo
        case availablePoints = "available_points"
        case totalPointsEarn = "total_points_earn"
        case totalPointsUsed = "total_points_used"
        case totalSaving = "total_saving"
        case whatsappEnabled = "whatsapp_enabled"
        case whatsappTitle = "whatsapp_title"
        case whatsappNumber = "whatsapp_number"
        case whatsappxPrefillMessage = "whatsappx_prefill_message"
    }
}

struct Member: Codable {
    // Define member properties if needed
}

struct UserProfileResponse: Codable {
    let result: UserProfileToken
}

struct UserProfileToken: Codable {
    let error:String?
    let barcode: String
    let email: String
    let employer: String
    let employerIcon: String
    let familyHeadID: Int
    let icon: String
    let id: Int
    let loginID: String
    let memberType: Bool
    let name: String
    let pausedNotification: Bool
    let phone: String
    let token: String
    let trackingPartnerID: Int

    enum CodingKeys: String, CodingKey {
        case error
        case barcode
        case email
        case employer
        case employerIcon = "employer_icon"
        case familyHeadID = "family_head_id"
        case icon
        case id
        case loginID = "login_id"
        case memberType = "member_type"
        case name
        case pausedNotification = "paused_notification"
        case phone
        case token
        case trackingPartnerID = "tracking_partner_id"
    }
}


