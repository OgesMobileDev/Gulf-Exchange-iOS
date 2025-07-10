//
//  BeneficiaryListTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 30/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Kingfisher
import ScreenShield

class BeneficiaryListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var mobileTitleLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var countryTitleLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var arrowBtn: UIButton!
    @IBOutlet weak var bankWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bankBtn: UIButton!
    @IBOutlet weak var bankImg: UIImageView!
    @IBOutlet weak var bankLbl: UILabel!
    @IBOutlet weak var cashWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var cashImg: UIImageView!
    @IBOutlet weak var cashLbl: UILabel!
    @IBOutlet weak var walletWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var walletBtn: UIButton!
    @IBOutlet weak var walletImg: UIImageView!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var detailsBtn: UIButton!
    
    let defaults = UserDefaults.standard
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ScreenShield.shared.protect(view: userNameLbl)
        ScreenShield.shared.protect(view: mobileLbl)
        ScreenShield.shared.protect(view: mobileTitleLbl)
        ScreenShield.shared.protect(view: countryCodeLbl)
        ScreenShield.shared.protect(view: countryTitleLbl)
        ScreenShield.shared.protect(view: countryLbl)
        ScreenShield.shared.protect(view: countryImg)
        ScreenShield.shared.protect(view: bankLbl)
        ScreenShield.shared.protect(view: bankImg)
        ScreenShield.shared.protect(view: cashImg)
        ScreenShield.shared.protect(view: cashLbl)
        ScreenShield.shared.protect(view: walletBtn)
        ScreenShield.shared.protect(view: walletLbl)
        
        let width = UIScreen.main.bounds.width
        print("width - \(width)")
        let subViewWidth = (width - 32) / 3
        print("subViewWidth - \(subViewWidth)")
        bankWidthConstraint.constant = subViewWidth
        cashWidthConstraint.constant = subViewWidth
        walletWidthConstraint.constant = subViewWidth
        countryImg.contentMode = .scaleToFill
//        let udid = UIDevice.current.identifierForVendor!.uuidString
//        print(udid)
        detailsBtn.setTitle("", for: .normal)
        bankBtn.setTitle("", for: .normal)
        bankBtn.setTitle("", for: .disabled)
        cashBtn.setTitle("", for: .normal)
        cashBtn.setTitle("", for: .disabled)
        walletBtn.setTitle("", for: .normal)
        walletBtn.setTitle("", for: .disabled)
        arrowBtn.setTitle("", for: .normal)
        setDefaultView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func arrowBtnTapped(_ sender: Any) {
    }
    @IBAction func bankBtnTapped(_ sender: Any) {
    }
    @IBAction func cashBtnTapped(_ sender: Any) {
    }
    @IBAction func walletBtnTapped(_ sender: Any) {
    }
    func setDefaultView(){
        //    var selection1 = "0"
            var state: (bankImgName: String, bankLblColor: UIColor, bankBtnEnabled: Bool,
                        cashImgName: String, cashLblColor: UIColor, cashBtnEnabled: Bool,
                        walletImgName: String, walletLblColor: UIColor, walletBtnEnabled: Bool)
            // Define the default state for null or empty `selection1`
            let defaultState = ("u_bank", UIColor.rgba(199, 199, 199, 1), false,
                                "u_cash", UIColor.rgba(199, 199, 199, 1), false,
                                "u_wallet", UIColor.rgba(199, 199, 199, 1), false)
        state = defaultState
        bankImg.image = UIImage(named: state.bankImgName)
        bankLbl.textColor = state.bankLblColor
        bankBtn.isEnabled = state.bankBtnEnabled
        
        cashImg.image = UIImage(named: state.cashImgName)
        cashLbl.textColor = state.cashLblColor
        cashBtn.isEnabled = state.cashBtnEnabled
        
        walletImg.image = UIImage(named: state.walletImgName)
        walletLbl.textColor = state.walletLblColor
        walletBtn.isEnabled = state.walletBtnEnabled
    }
    func setView(data:CasmexListBeneficiary){
        if data.active == "Y"{
            arrowBtn.isHidden = false
        }else{
            arrowBtn.isHidden = true
        }
        self.profileView.subviews.forEach { $0.removeFromSuperview() }
        let selection = data.serviceCategory
        updateSelectionState(for: selection ?? "")
        if let fName = data.firstName{
            profileView.isHidden = false
            createAvatar(username: fName, view: profileView, font: 30)
            userNameLbl.text = fName
            
         
            
            
            
        }else{
            profileView.isHidden = true
            userNameLbl.text = "----"
        }
        mobileLbl.text = data.mobileNumber ?? "----"
        countryCodeLbl.text = data.currency ?? "--"
        countryLbl.text = data.receiveCountry ?? "----"
        loadCountryFlag(for: data.country ?? "", into: countryImg)
        
        countryTitleLbl.text = NSLocalizedString("countryT", comment: "")
        bankLbl.text = NSLocalizedString("BankTransfer", comment: "")
        cashLbl.text = NSLocalizedString("cash_pickup", comment: "")
        walletLbl.text = NSLocalizedString("Wallet Transfer", comment: "")
        mobileTitleLbl.text = NSLocalizedString("Mobile", comment: "")
        
    }
    func updateSelectionState(for selection1: String?) {
        // Define the state for valid values
        let states: [String: (bankImgName: String, bankLblColor: UIColor, bankBtnEnabled: Bool,
                              cashImgName: String, cashLblColor: UIColor, cashBtnEnabled: Bool,
                              walletImgName: String, walletLblColor: UIColor, walletBtnEnabled: Bool)] = [
            "0002": ("bank_transfer", .black, true, "u_cash", UIColor.rgba(199, 199, 199, 1), false, "u_wallet", UIColor.rgba(199, 199, 199, 1), false),
            "0001": ("u_bank", UIColor.rgba(199, 199, 199, 1), true, "cash_pickup", .black, false, "u_wallet", UIColor.rgba(199, 199, 199, 1), false),
            "0003": ("u_bank", UIColor.rgba(199, 199, 199, 1), true, "u_cash", UIColor.rgba(199, 199, 199, 1), false, "mobile_wallet_transfer", .black, false)
        ]
        let defaultState = ("u_bank", UIColor.rgba(199, 199, 199, 1), false,
                            "u_cash", UIColor.rgba(199, 199, 199, 1), false,
                            "u_wallet", UIColor.rgba(199, 199, 199, 1), false)
        // Determine which state to use
        let state: (bankImgName: String, bankLblColor: UIColor, bankBtnEnabled: Bool,
                    cashImgName: String, cashLblColor: UIColor, cashBtnEnabled: Bool,
                    walletImgName: String, walletLblColor: UIColor, walletBtnEnabled: Bool)
        
        if let selection = selection1, !selection.isEmpty {
            // Use the corresponding state if valid, otherwise fallback to "2"
            state = states[selection] ?? states["0003"]!
        } else {
            // Use the default state if selection1 is null or empty
            state = defaultState
        }
        
        // Update UI based on the determined state
        bankImg.image = UIImage(named: state.bankImgName)
        bankLbl.textColor = state.bankLblColor
        bankBtn.isEnabled = state.bankBtnEnabled
        
        cashImg.image = UIImage(named: state.cashImgName)
        cashLbl.textColor = state.cashLblColor
        cashBtn.isEnabled = state.cashBtnEnabled
        
        walletImg.image = UIImage(named: state.walletImgName)
        walletLbl.textColor = state.walletLblColor
        walletBtn.isEnabled = state.walletBtnEnabled
    }

}



