//
//  EditProfilePopupView.swift
//  GulfExchangeApp
//
//  Created by macbook on 05/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Kingfisher
import ScreenShield
protocol EditProfilePopupViewDelegate:AnyObject{
    func editProfilePopupView(_ vc: EditProfilePopupView,selection: EditProfileDropDownSelection, didSelectCountry country: CasmexNationality?)
       func editProfilePopupView(_ vc: EditProfilePopupView,selection: EditProfileDropDownSelection,  didSelectSecondCountry secondCountry: CasmexNationality?)
       func editProfilePopupView(_ vc: EditProfilePopupView,selection: EditProfileDropDownSelection,  didSelectZone zone: Zone?)
       func editProfilePopupView(_ vc: EditProfilePopupView,selection: EditProfileDropDownSelection,  didSelectOccupation occupation: City?)
       func editProfilePopupView(_ vc: EditProfilePopupView,selection: EditProfileDropDownSelection,  didSelectActualOccupation actualOccupation: City?)
    func editProfilePopupView(_ vc: EditProfilePopupView,selection: EditProfileDropDownSelection,  didSelectIdIssuer issuer: String?)
}

class EditProfilePopupView: UIView, UITableViewDelegate, UITableViewDataSource{
    weak var delegate: EditProfilePopupViewDelegate?
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var baseTableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var clearBtn: UIButton!
    
    var countryResArray:[CasmexNationality] = []
    var nationalityArray:[CasmexNationality] = []
    var zoneArray:[Zone] = []
    var secNationalityArray:[CasmexNationality] = []
    var occupationArray:[City] = []
    var actualOccArray:[City] = []
    var searchCountry:[CasmexNationality] = []
    var searchZone:[Zone] = []
    var searchOccupation:[City] = []
    var currentSelection:EditProfileDropDownSelection = .nationality
    var divCount = 0
    var viewHeight:CGFloat = 0
    var nationalityFlagPath:String = ""
    var idIssuerArray = ["Ministry of Interior","Ministry of Foreign Affairs"]
    let searchIdIssuerArray = ["Ministry of Interior","Ministry of Foreign Affairs"]
    override func awakeFromNib() {
        super.awakeFromNib()
        bgBtn.setTitle("", for: .normal)
//        ScreenShield.shared.protect(view: bgView)
        configureButton(button: clearBtn, title: "Clear", size: 12, font: .regular)
       
        self.baseTableView?.register(UINib.init(nibName: "EditProfileTableViewCell", bundle: .main), forCellReuseIdentifier: "EditProfileTableViewCell")
        baseTableView.delegate = self
        baseTableView.dataSource = self
        baseTableView.showsVerticalScrollIndicator = false
        searchTF.delegate = self
    }
    
    @IBAction func clearBtnTapped(_ sender: Any) {
        searchTF.text?.removeAll()
        nationalityArray = searchCountry
        zoneArray = searchZone
        secNationalityArray = searchCountry
        occupationArray = searchOccupation
        actualOccArray = searchOccupation
        baseTableView.reloadData()
    }
    func setupTableView() {
       
        
        
        // switch
        switch currentSelection {
        case .nationality:
            divCount = nationalityArray.count
        case .secondNationality:
            divCount = secNationalityArray.count
        case .zone:
            divCount = zoneArray.count
        case .occupation:
            divCount = occupationArray.count
        case .actualOcc:
            divCount = actualOccArray.count
        case .idIssuer:
            divCount = idIssuerArray.count
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
        case .nationality:
            delegate?.editProfilePopupView(self, selection: .nationality, didSelectCountry: nationalityArray[index])
        case .secondNationality:
            delegate?.editProfilePopupView(self, selection: .secondNationality, didSelectSecondCountry: secNationalityArray[index])
        case .zone:
            delegate?.editProfilePopupView(self, selection: .zone, didSelectZone: zoneArray[index])
        case .occupation:
            delegate?.editProfilePopupView(self, selection: .occupation, didSelectOccupation: occupationArray[index])
        case .actualOcc:
            delegate?.editProfilePopupView(self, selection: .actualOcc, didSelectActualOccupation: actualOccArray[index])
        case .idIssuer:
            delegate?.editProfilePopupView(self, selection: .idIssuer, didSelectIdIssuer: idIssuerArray[index])
        }
        
    }
    
    // UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentSelection {
        case .nationality:
            return nationalityArray.count
        case .secondNationality:
            return secNationalityArray.count
        case .zone:
            return zoneArray.count
        case .occupation:
            return occupationArray.count
        case .actualOcc:
            return actualOccArray.count
        case .idIssuer:
            return idIssuerArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell", for: indexPath) as! EditProfileTableViewCell
        switch currentSelection{
            
        case .nationality:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            let nationality = nationalityArray[indexPath.row]
            cell.itemLbl.text = nationality.description
            
//            let code:String = nationality.description.lowercased()
//            let url = nationalityFlagPath + code + ".png"
//            print(url)
//            let imgResource = URL(string: url)
//            cell.flagImgView.kf.setImage(with: imgResource)
            
        case .secondNationality:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            let nationality = secNationalityArray[indexPath.row]
            cell.itemLbl.text = nationality.description
            
//            let code:String = nationality.alpha_2_code.lowercased()
//            let url = nationalityFlagPath + code + ".png"
//            print(url)
//            let imgResource = URL(string: url)
//            cell.flagImgView.kf.setImage(with: imgResource)
        case .zone:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl?.text = zoneArray[indexPath.row].zone
        case .occupation:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = occupationArray[indexPath.row].ge_city_name
        case .actualOcc:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = actualOccArray[indexPath.row].ge_city_name
        case .idIssuer:
            cell.flagImgView.isHidden = true
            cell.leadingConstraint.constant = 20
            cell.itemLbl.text = idIssuerArray[indexPath.row]
        }
        return cell
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
extension EditProfilePopupView:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
           
           // Calculate the new text
           let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        switch currentSelection{
            
        case .nationality:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                nationalityArray = searchCountry
            } else {
                nationalityArray = searchCountry.filter { item in
                    if let countryName = item.description as? String{
                        return countryName.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .secondNationality:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                secNationalityArray = searchCountry
            } else {
                secNationalityArray = searchCountry.filter { item in
                    if let countryName = item.description as? String{
                        return countryName.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .zone:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                zoneArray = searchZone
            } else {
                zoneArray = searchZone.filter { item in
                    if let zoneName = item.zone as? String{
                        return zoneName.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .occupation:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                occupationArray = searchOccupation
            } else {
                occupationArray = searchOccupation.filter { item in
                    if let occupation = item.ge_city_name as? String{
                        return occupation.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .actualOcc:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                actualOccArray = searchOccupation
            } else {
                actualOccArray = searchOccupation.filter { item in
                    if let occupation = item.ge_city_name as? String{
                        return occupation.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        case .idIssuer:
            if updatedText.isEmpty {
                // If the text field is empty, reset the filtered branches
                idIssuerArray = searchIdIssuerArray
            } else {
                idIssuerArray = searchIdIssuerArray.filter { item in
                    if let occupation = item as? String{
                        return occupation.lowercased().contains(updatedText.lowercased())
                    }
                    return false
                }
            }
        }
        baseTableView.reloadData()
        return true
    }
}
