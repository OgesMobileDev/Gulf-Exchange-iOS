//
//  MyTransactions.swift
//  GulfExchangeApp
//
//  Created by test on 23/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class MyTransactions {
    var transactionRefNo:String
    var gecoTransactionRefNo:String
    var partnerID:String
    var sourceApplication:String
    var deliveryOption:String
    var customerRegNo:String
    var customerIDNo:String
    var mobileNo:String
    var transactionDate:String
    var payinCurrency:String
    var payinAmount:String
    var payoutCurrency:String
    var payoutAmount:String
    var exchangeRate:String
    var commission:String
    var charges:String
    var tax:String
    var totalPayinAmount:String
    var beneficiaryAccountNo:String
    var purposeOfTxn:String
    var sourceOfIncome:String
    var paymentMode:String
    var paymentStatus:String
    var paymentGatewayName:String
    var paymentGatewayTxnRefID:String
    var txnStatus1:String
    var txnStatus2:String
    var remarks:String
    var createdOn:String
    var createdBy:String
    var beneficiaryName:String
    var beneficiarySerialNo:String
    
    init(transactionRefNo:String,gecoTransactionRefNo:String,partnerID:String,sourceApplication:String,deliveryOption:String,customerRegNo:String,customerIDNo:String,mobileNo:String,transactionDate:String,payinCurrency:String,payinAmount:String,payoutCurrency:String,payoutAmount:String,exchangeRate:String,commission:String,charges:String,tax:String,totalPayinAmount:String,beneficiaryAccountNo:String,purposeOfTxn:String,sourceOfIncome:String,paymentStatus:String,paymentMode:String,paymentGatewayName:String,paymentGatewayTxnRefID:String,txnStatus1:String,txnStatus2:String,remarks:String,createdOn:String,createdBy:String,beneficiaryName:String,beneficiarySerialNo:String) {
    
        self.transactionRefNo = transactionRefNo
        self.gecoTransactionRefNo = gecoTransactionRefNo
        self.partnerID = partnerID
        self.sourceApplication = sourceApplication
        self.deliveryOption = deliveryOption
        self.customerRegNo = customerRegNo
        self.customerIDNo = customerIDNo
        self.mobileNo = mobileNo
        self.transactionDate = transactionDate
        self.payinCurrency = payinCurrency
        self.payinAmount = payinAmount
        self.payoutCurrency = payoutCurrency
        self.payoutAmount = payoutAmount
        self.exchangeRate = exchangeRate
        self.commission = commission
        self.charges = charges
        self.tax = tax
        self.totalPayinAmount = totalPayinAmount
        self.beneficiaryAccountNo = beneficiaryAccountNo
        self.purposeOfTxn = purposeOfTxn
        self.sourceOfIncome = sourceOfIncome
        self.paymentMode = paymentMode
        self.paymentStatus = paymentStatus
        self.paymentGatewayName = paymentGatewayName
        self.paymentGatewayTxnRefID = paymentGatewayTxnRefID
        self.txnStatus1 = txnStatus1
        self.txnStatus2 = txnStatus2
        self.remarks = remarks
        self.createdOn = createdOn
        self.createdBy = createdBy
        self.beneficiaryName = beneficiaryName
        self.beneficiarySerialNo = beneficiarySerialNo
    }
}
