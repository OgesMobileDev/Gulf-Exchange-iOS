//
//  Constants.swift
//  GulfExchangeApp
//
//  Created by macbook on 10/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit


var colorRed = UIColor.init(named: "color_dark_red")
var notificationCount:Bool = false

struct AppInfo { // change in live
    static let isTesting = true

    static var version: String {
        if isTesting {
            return "1.0"
//            return "1.37"
        } else {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        }
    }
}


enum SendMoneyPopupAction{
    case cashPickup
    case bankTranfer
    case mobileWallet
}
enum RateCalculator{
    case bankTransfer
    case cashPickup
    case mobileWallet
}
enum IsLoggedin{
    case yes
    case no
}
enum FontType{
    case regular
    case semiBold
    case medium
    case bold
}


struct CollectionImageData{
    var image: String
    var title:String
}

let QuickAccess1CollectionData:[CollectionImageData] = [CollectionImageData(image: "bank_transfer", title: NSLocalizedString("BankTransfer", comment: "")),
                                                        CollectionImageData(image: "cash_pickup", title: NSLocalizedString("cash_pickup", comment: "")),
                                                        CollectionImageData(image: "mobile_wallet_transfer", title: NSLocalizedString("Mobile Wallet Transfer", comment: ""))]

let QuickAccess2CollectionData:[CollectionImageData] = [CollectionImageData(image: "bank_transfer", title: "BankTransfer"),
                                                        CollectionImageData(image: "cash_pickup", title: "cash_pickup"),
                                                        CollectionImageData(image: "mobile_wallet_transfer", title: "Mobile Wallet Transfer"),
                                                        CollectionImageData(image: "beneficiaries", title: "Beneficiaries"),
                                                        CollectionImageData(image: "track_transactions", title: "track_transactions"),
                                                        CollectionImageData(image: "locate_branch", title: "Locate Branch")]

let QuickAccessMainCollectionData:[CollectionImageData] = [CollectionImageData(image: "bank_transfer", title: "BankTransfer"),
                                                        CollectionImageData(image: "cash_pickup", title: "cash_pickup"),
                                                        CollectionImageData(image: "mobile_wallet_transfer", title: "Mobile Wallet Transfer"),
                                                        CollectionImageData(image: "beneficiaries", title: "Beneficiaries"),
                                                        CollectionImageData(image: "track_transactions", title: "track_transactions"),
                                                        CollectionImageData(image: "locate_branch", title: "Locate Branch"),
                                                        CollectionImageData(image: "our_partners", title: "Our Partners"),
                                                        CollectionImageData(image: "special_offers", title: "Special Offers"),
                                                        CollectionImageData(image: "loyalty_points", title: "Loyalty Points"),
                                                        CollectionImageData(image: "gold_rate", title: "Gold Rate"),
                                                        CollectionImageData(image: "golalita_rewards", title: "Golalita Rewards"),
                                                        CollectionImageData(image: "rate_calculator", title: "Rate Calculater"),
                                                        CollectionImageData(image: "f_a_q", title: "faq")
]




let loginChangedNotification = Notification.Name("loginChangedNotification")
let languageChangedNotification = Notification.Name("languageChangedNotification")
let playerFinishNotification = Notification.Name("playerFinishNotification")
let transactionChangeNotification = Notification.Name("transactionChangeNotification")
let notificationChangeNotification = Notification.Name("notificationChangeNotification")
let IdUpdateNotification = Notification.Name("IdUpdateNotification")
/*
 func addNavbar(){
     if let backImage = UIImage(named: "back_arrow") {
         let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
             backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
         }
         let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
         self.navigationItem.leftBarButtonItem = backButton
     }
     self.navigationItem.title = "Forgot Password"
 }
 @objc func customBackButtonTapped() {
     self.navigationController?.popViewController(animated: true)
 }

 */
//MARK: - Variable Declaration
//MARK: - View LifeCycles
//MARK: - Button Actions
//MARK: - Functions
//MARK: - API Calls




