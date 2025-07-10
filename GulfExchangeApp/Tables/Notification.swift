//
//  Notification.swift
//  GulfExchangeApp
//
//  Created by test on 31/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class Notificationn {
    var createdOn:String
    var customerIDNo:String
    var customerRegNo:String
    var messageReadFlag:String
    var messageStatus:String
    var messageValidFrom:String
    var messageValidTo:String
    var notifyDate:String
    var notifyID:String
    var notifyMessage:String
    var notifyStatus:String
    var responseCode:String
    var responseMessage:String
    
    init(createdOn:String,customerIDNo:String,customerRegNo:String,messageReadFlag:String,messageStatus:String,messageValidFrom:String,messageValidTo:String,notifyDate:String,notifyID:String,notifyMessage:String,notifyStatus:String,responseCode:String,responseMessage:String) {
        self.createdOn = createdOn
        self.customerIDNo = customerIDNo
        self.customerRegNo = customerRegNo
        self.messageReadFlag = messageReadFlag
        self.messageStatus = messageStatus
        self.messageValidFrom = messageValidFrom
        self.messageValidTo = messageValidTo
        self.notifyDate = notifyDate
        self.notifyID = notifyID
        self.notifyMessage = notifyMessage
        self.notifyStatus = notifyStatus
        self.responseCode = responseCode
        self.responseMessage = responseMessage
    }
}
