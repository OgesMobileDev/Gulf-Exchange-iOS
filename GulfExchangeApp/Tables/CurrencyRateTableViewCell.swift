//
//  CurrencyRateTableViewCell.swift
//  GulfExchangeApp
//
//  Created by test on 09/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

protocol CurrencyRateDelegate {
    func seePrice(currency_master_code:String,currency_master_name_en:String,ge_countries_3_code:String,ge_countries_c_code:String)
}

class CurrencyRateTableViewCell: UITableViewCell {
    
    
    var transferratetwodig:String = ""
    var buyratetwodig:String = ""
    var sellratetwodig:String = ""
    
    @IBOutlet var contrynamewidthconstraint: NSLayoutConstraint!
    
    @IBOutlet var transferwidthconstraint: NSLayoutConstraint!
    
    @IBOutlet var buyratewidthconstraint: NSLayoutConstraint!
    
    @IBOutlet var seepricewidthconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var currencynamelabel: UILabel!
    
    @IBOutlet var transferlabel: UILabel!
    
    @IBOutlet var buylabel: UILabel!
    
    
    @IBOutlet var selllabel: UILabel!
    
    
    
    @IBOutlet var currencynamebtn: UIButton!
    
    @IBOutlet var transferbtn: UIButton!
    
    
    @IBOutlet var buyratebtn: UIButton!
    
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var seePriceBtn: UIButton!
    var dailyRates:DailyRate!
    var delegate: CurrencyRateDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCurrencyRate(dailyRate:DailyRate) {
        dailyRates = dailyRate
       // self.currencyLbl.text = dailyRate.currency_master_name_en
       // self.currencyLbl.text = ""
        
        //1
        if dailyRate.trasferrate == ""||dailyRate.trasferrate == "null"||dailyRate.trasferrate == "<null>"
        {
         self.transferratetwodig = "0.0"
        }
        else
        {
            let receiveAmount = dailyRate.trasferrate
            var rec_amount = Double(receiveAmount)
            self.transferratetwodig = String(format: "%.2f", rec_amount as! CVarArg)
            print("pay out transferratetwodig ",self.transferratetwodig)
        }
        
        if dailyRate.buyrate == ""||dailyRate.buyrate == "null"||dailyRate.buyrate == "<null>"
        {
           self.buyratetwodig = "0.0"
        }
        else
        {
            //2
               let receiveAmount1 = dailyRate.buyrate
               var rec_amount1 = Double(receiveAmount1)
               self.buyratetwodig = String(format: "%.2f", rec_amount1 as! CVarArg)
               print("pay out buyratetwodig ",self.buyratetwodig)
        }
        
        if dailyRate.sellrate == ""||dailyRate.sellrate == "null"||dailyRate.sellrate == "<null>"
        {
         self.sellratetwodig = "0.0"
        }
        else
        {
            //3
            let receiveAmount2 = dailyRate.sellrate
            var rec_amount2 = Double(receiveAmount2)
            self.sellratetwodig = String(format: "%.2f", rec_amount2 as! CVarArg)
            print("pay out sellratetwodig ",self.sellratetwodig)
        }
   
        

        
        self.currencynamelabel.text = dailyRate.currency_master_name_en
        self.transferlabel.text = self.transferratetwodig
        self.buylabel.text = self.buyratetwodig
        self.selllabel.text = self.sellratetwodig
        
       
    }
//    @IBAction func seePriceBtn(_ sender: Any) {
//        delegate?.seePrice(currency_master_code: dailyRates.currency_master_code, currency_master_name_en: dailyRates.currency_master_name_en, ge_countries_3_code: dailyRates.ge_countries_3_code, ge_countries_c_code: dailyRates.ge_countries_c_code)
//    }
}
