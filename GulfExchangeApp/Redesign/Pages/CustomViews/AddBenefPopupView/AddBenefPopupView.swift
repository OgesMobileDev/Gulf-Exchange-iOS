//
//  AddBenefPopupView.swift
//  GulfExchangeApp
//
//  Created by macbook on 20/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
/*
 case country
 case currency
 case nationality
 case relation
 case service
 case bank
 case branch
 */
protocol AddBenefPopupViewDelegate:AnyObject{
    func AddBenefPopupView(_ vc: AddBenefPopupView,cdidSelectCountry country: CasmexCountry?)
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectCurrency currency: CasmexCurrency?)
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectNationality nationality: CasmexNationality?)
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectrRelation relation: CasmexRelation?)
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectService service: CasmexServiceProvider?)
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectBank bank: CasmexBank?)
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectBranch branch: CasmexBranch?)
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectSource source: CasmexPurposeSource?)
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectPurpose purpose: CasmexPurposeSource?)
    func AddBenefPopupView(_ vc: AddBenefPopupView, didSelectBic purpose: CasmexBICDetail?)
}
class AddBenefPopupView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: AddBenefPopupViewDelegate?
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var baseTableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var clearBtn: UIButton!
    
   
    var nationalityArray:[CasmexNationality] = []
    var bankArray:[CasmexBank] = []
    var countryArray:[CasmexCountry] = []
    var currencyArray:[CasmexCurrency] = []
    var branchArray:[CasmexBranch] = []
    var relationArray:[CasmexRelation] = []
    var serviceProviderArray:[CasmexServiceProvider] = []
    var sourceArray:[CasmexPurposeSource] = []
    var purposeArray:[CasmexPurposeSource] = []
    var bicArray: [CasmexBICDetail] = []
    
    var searchRelation:[CasmexRelation] = []
    var searchBank:[CasmexBank] = []
    var searchCountry:[CasmexCountry] = []
    var searchCurrency:[CasmexCurrency] = []
    var searchBranch:[CasmexBranch] = []
    var searchNationality:[CasmexNationality] = []
    var searchService:[CasmexServiceProvider] = []
    var searchSource:[CasmexPurposeSource] = []
    var searchPurpose:[CasmexPurposeSource] = []
    var searchBic: [CasmexBICDetail] = []
   
    
    
    var currentSelection:AddBenfDropDownSelection = .country
    var divCount = 0
    var viewHeight:CGFloat = 0
    var nationalityFlagPath:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.clipsToBounds = true
        bgBtn.setTitle("", for: .normal)
        
//        ScreenShield.shared.protect(view: sear)
        
        configureButton(button: clearBtn, title: "Clear", size: 12, font: .regular)
        
        self.baseTableView?.register(UINib.init(nibName: "EditProfileTableViewCell", bundle: .main), forCellReuseIdentifier: "EditProfileTableViewCell")
        baseTableView.delegate = self
        baseTableView.dataSource = self
        baseTableView.showsVerticalScrollIndicator = false
        searchTF.delegate = self
    }
    
    
    @IBAction func clearBtnTapped(_ sender: Any) {
        searchTF.text?.removeAll()
        serviceProviderArray = searchService
        bankArray = searchBank
        countryArray = searchCountry
        currencyArray = searchCurrency
        branchArray = searchBranch
        nationalityArray = searchNationality
        relationArray = searchRelation
        sourceArray = searchSource
        purposeArray = searchPurpose
        baseTableView.reloadData()
    }
    func setupTableView() {
        
        switch currentSelection {
        case .country:
            divCount = countryArray.count
        case .currency:
            divCount = currencyArray.count
        case .nationality:
            divCount = nationalityArray.count
        case .relation:
            divCount = relationArray.count
        case .service:
            divCount = serviceProviderArray.count
        case .bank:
            divCount = bankArray.count
        case .branch:
            divCount = branchArray.count
        case .source:
            divCount = sourceArray.count
        case .purpose:
            divCount = purposeArray.count
        case .bic:
            divCount = bicArray.count
        }
        if divCount > 7{
            viewHeight = 490
        }else{
            viewHeight = CGFloat(divCount * 60 + 70)
        }
        heightConstraint.constant = viewHeight
        baseTableView.reloadData()
    }
    @IBAction func bgBtnTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    func sendSelection(index: Int){
        switch currentSelection {
        case .country:
            delegate?.AddBenefPopupView(self, cdidSelectCountry: countryArray[index])
        case .currency:
            delegate?.AddBenefPopupView(self, didSelectCurrency: currencyArray[index])
        case .nationality:
            delegate?.AddBenefPopupView(self, didSelectNationality: nationalityArray[index])
        case .relation:
            delegate?.AddBenefPopupView(self, didSelectrRelation: relationArray[index])
        case .service:
            delegate?.AddBenefPopupView(self, didSelectService:serviceProviderArray[index])
        case .bank:
            delegate?.AddBenefPopupView(self, didSelectBank: bankArray[index])
        case .branch:
            delegate?.AddBenefPopupView(self, didSelectBranch: branchArray[index])
        case .source:
            delegate?.AddBenefPopupView(self, didSelectSource: sourceArray[index])
        case .purpose:
            delegate?.AddBenefPopupView(self, didSelectPurpose: purposeArray[index])
        case .bic:
            delegate?.AddBenefPopupView(self, didSelectBic: bicArray[index])
        }
    }
    
    // UITableViewDataSource Methods
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch currentSelection {
        case .country:
            return countryArray.count
        case .currency:
            return currencyArray.count
        case .nationality:
            return nationalityArray.count
        case .relation:
            return relationArray.count
        case .service:
            return serviceProviderArray.count
        case .bank:
            return bankArray.count
        case .branch:
            return branchArray.count
        case .source:
            return sourceArray.count
        case .purpose:
            return purposeArray.count
        case .bic:
            return bicArray.count
        }
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell", for: indexPath) as! EditProfileTableViewCell
        switch currentSelection {
        case .country:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = countryArray[indexPath.row].countryName
        case .currency:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = currencyArray[indexPath.row].currencyName
        case .nationality:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = nationalityArray[indexPath.row].description
        case .relation:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = relationArray[indexPath.row].description
        case .service:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = serviceProviderArray[indexPath.row].serviceProviderName
        case .bank:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = bankArray[indexPath.row].bankName
        case .branch:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = branchArray[indexPath.row].branchName
        case .source:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = sourceArray[indexPath.row].description
        case .purpose:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = purposeArray[indexPath.row].description
        case .bic:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = ("\(bicArray[indexPath.row].bicType ?? "") - \(bicArray[indexPath.row].bicValue ?? "")")
        }
        return cell
        /*switch currentSelection{
         
         case .nationality:
         cell.flagImgView.isHidden = false
         cell.leadingConstraint.constant = 55
         let nationality = nationalityArray[indexPath.row]
         cell.itemLbl.text = nationality.en_short_name
         
         let code:String = nationality.alpha_2_code.lowercased()
         let url = nationalityFlagPath + code + ".png"
         print(url)
         let imgResource = URL(string: url)
         cell.flagImgView.kf.setImage(with: imgResource)
        
         }*/
        
    }
    
    // UITableViewDelegate Methods (optional)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row)")
        sendSelection(index: indexPath.row)
        self.removeFromSuperview()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
extension AddBenefPopupView:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        // Calculate the new text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        switch currentSelection {
        case .country:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                countryArray = searchCountry
            } else {
                countryArray = searchCountry.filter { item in
                    if let country = item.countryName as? String{
                        return country.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .currency:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                currencyArray = searchCurrency
            } else {
                currencyArray = searchCurrency.filter { item in
                    if let currencyName = item.currencyName as? String{
                        return currencyName.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .nationality:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                nationalityArray = searchNationality
            } else {
                nationalityArray = searchNationality.filter { item in
                    if let description = item.description as? String{
                        return description.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .relation:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                relationArray = searchRelation
            } else {
                relationArray = searchRelation.filter { item in
                    if let description = item.description as? String{
                        return description.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .service:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                serviceProviderArray = searchService
            } else {
                serviceProviderArray = searchService.filter { item in
                    if let serviceProviderName = item.serviceProviderName as? String{
                        return serviceProviderName.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
            
        case .bank:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                bankArray = searchBank
            } else {
                bankArray = searchBank.filter { item in
                    if let bankName = item.bankName as? String{
                        return bankName.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .branch:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                branchArray = searchBranch
            } else {
                branchArray = searchBranch.filter { item in
                    if let branchName = item.branchName as? String{
                        return branchName.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .source:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                sourceArray = searchSource
            } else {
                sourceArray = searchSource.filter { item in
                    if let source = item.description as? String{
                        return source.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .purpose:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                purposeArray = searchPurpose
            } else {
                purposeArray = searchPurpose.filter { item in
                    if let branchName = item.description as? String{
                        return branchName.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .bic:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                bicArray = searchBic
            } else {
                bicArray = searchBic.filter { item in
                    if let branchName = item.bicType as? String{
                        return branchName.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        }
        baseTableView.reloadData()
        return true
    }
}

