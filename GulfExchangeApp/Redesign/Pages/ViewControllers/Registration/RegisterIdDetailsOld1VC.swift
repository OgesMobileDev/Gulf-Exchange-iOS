//
//  RegisterIdDetailsOld1VC.swift
//  GulfExchangeApp
//
//  Created by macbook on 08/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Toast_Swift
import ScreenShield

class RegisterIdDetailsOld1VC: UIViewController, RegistrationPopupViewDelegate {
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectCountry country: CasmexNationality?) {
        print("nil")
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectSecondCountry secondCountry: CasmexNationality?) {
        print("nil")
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectZone zone: Zone?) {
        print("nil")
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectOccupation occupation: CasmexNationality?) {
        print("nil")
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectActualOccupation actualOccupation: CasmexNationality?) {
        print("nil")
    }
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectIdType type: String?) {
        print("nil")
    }
    
    @IBOutlet weak var idDetailLbl: UILabel!
    @IBOutlet weak var mobNumTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var idExpTF: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var idTypeTF: UITextField!
    @IBOutlet weak var idTypeBtn: UIButton!
    @IBOutlet weak var idTypeView: UIView!
    
    @IBOutlet weak var mobNumView: UIView!
    @IBOutlet weak var idNumView: UIView!
    @IBOutlet weak var idExpView: UIView!
//    ouitlets
    
    
    var str_idType:String = ""
    var str_id_issuer:String = ""
    var str_id_no:String = ""
    var str_id_exp_date:String = ""
    var qidexpdatestr:String = ""
    var expdatestr:String = ""
    
    let datePicker = UIDatePicker()
    let defaults = UserDefaults.standard
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var idImageFrontData: Data?
    var idImageBackData: Data?
    var idImageSelfieVideoData: Data?
    
    // idTypeData
    var currentDropdownSelection:RegistrationDropDownSelection = .idIssuer
    let popUpView1 = Bundle.main.loadNibNamed("RegistrationPopupView", owner: RegisterIdDetails1VC.self, options: nil)?.first as! RegistrationPopupView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        setView()
        mobNumTF.keyboardType = .phonePad
        numberTF.keyboardType = .numberPad
        popUpView1.delegate = self
        mobNumTF.delegate = self
        idTypeTF.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        ScreenShield.shared.protect(view: self.idDetailLbl)
        ScreenShield.shared.protect(view: self.mobNumTF)
        ScreenShield.shared.protect(view: self.numberTF)
        ScreenShield.shared.protect(view: self.idExpTF)
        ScreenShield.shared.protect(view: self.idTypeTF)
        ScreenShield.shared.protectFromScreenRecording()
    }
    @IBAction func idTypeBtnTapped(_ sender: Any) {
        currentDropdownSelection = .idIssuer
        addPopUp()
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        validateFields()
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails2VC") as! RegisterIdDetails2VC
//                self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Popups
    
    func addPopUp(){
        popUpView1.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpView1.alpha = 0.0
        popUpView1.currentSelection = self.currentDropdownSelection
        popUpView1.searchTF.text?.removeAll()
        popUpView1.setupTableView()
        popUpView1.baseTableView.reloadData()
        view.addSubview(popUpView1)
        print("PopUpView")
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView1.alpha = 1.0
        })
    }
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectIdIssuer issuer: String?) {
        idTypeTF.text = issuer
    }
    
    //MARK: Functions
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "Identity Details"
    }
    @objc func customBackButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is MainLoginViewController {
                    self.navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
        }else{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    func setView(){
        idTypeBtn.setTitle("", for: .normal)
        configureButton(button: nextBtn, title: NSLocalizedString("next", comment: ""), size: 16, font: .medium)
        configureButton(button: cancelBtn, title: NSLocalizedString("cancel1", comment: ""), size: 16, font: .medium)
        idDetailLbl.text = NSLocalizedString("identification_details", comment: "")
        mobNumTF.placeholder = NSLocalizedString("mobile_no", comment: "")
        numberTF.placeholder = NSLocalizedString("id_number", comment: "")
        idExpTF.placeholder = NSLocalizedString("id_exp_date", comment: "")
        idTypeTF.placeholder = NSLocalizedString("id_issuer", comment: "")
        if let idExp = defaults.string(forKey: "id_exp_date"){
            idExpTF.text = idExp
            idExpTF.isUserInteractionEnabled = false
        }
        if let idNum = defaults.string(forKey: "id_no"){
            numberTF.text = idNum
            numberTF.isUserInteractionEnabled = false
        }
        
    }
    
    func activityIndicator(_ title: String) {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    func showCommonAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: NSLocalizedString("gulf_exchange", comment: ""),
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel) { _ in
            completion?()
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToast(message: String, font: UIFont) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let maxWidthPercentage: CGFloat = 0.8
        let maxTitleSize = CGSize(width: view.bounds.size.width * maxWidthPercentage, height: view.bounds.size.height * maxWidthPercentage)
        var titleSize = toastLabel.sizeThatFits(maxTitleSize)
        titleSize.width += 20
        titleSize.height += 10
        toastLabel.frame = CGRect(x: view.frame.size.width / 2 - titleSize.width / 2, y: view.frame.size.height - 50, width: titleSize.width, height: titleSize.height)
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
//    func convertDateFormatterdob(_ date: String) -> String {
//        let dateFormatter = DateFormatter()
//
//        // First, set the date format to match the input format ("12/May/1998")
//        dateFormatter.dateFormat = "dd/MMM/yyyy"
//
//        // Convert the string to a Date object
//        if let dateObj = dateFormatter.date(from: date) {
//
//            // Now, change the date format to the desired output format ("dd-MM-yyyy")
//            dateFormatter.dateFormat = "dd-MM-yyyy"
//
//            // Return the formatted date string
//            return dateFormatter.string(from: dateObj)
//        } else {
//            // Handle invalid date format or nil if conversion fails
//            return "Invalid Date"
//        }
//    }
//
    func validateFields(){
        
        //new
        if numberTF.text?.isEmpty == true
        {
            // timer.invalidate()
            self.idNumView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.idNumView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
            }
        }
        else
        {
            
            self.idNumView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
        }
        
        
        guard let idNum = numberTF.text,numberTF.text?.count != 0 else
        {
            self.view.makeToast(NSLocalizedString("enter_id_number", comment: ""), duration: 3.0, position: .center)
            
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_number", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        let count = numberTF.text?.count
        if(count != 11)
        {
            
            
            self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
            
            self.idNumView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.idNumView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
            }
            
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        else
        {
            self.idNumView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
            
        }
        
        var charSetidNum = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2 = idNum
        
        if let strvalue = string2.rangeOfCharacter(from: charSetidNum)
        {
            print("true")
            
            self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if (!validate (value: self.numberTF.text!))
        {
            self.view.makeToast(NSLocalizedString("enter_valid_qid", comment: ""), duration: 3.0, position: .center)
            //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        guard let idExp = idExpTF.text,idExpTF.text?.count != 0 else
        //guard let idExp = idExpTF.text,idExpTF.text?.count != 0,expdatestr == "" else
        {
            self.view.makeToast(NSLocalizedString("enter_id_exp_date", comment: ""), duration: 3.0, position: .center)
           
            self.idExpView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.idExpView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
            }
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_number", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        //  guard let idExp = idExpTF.text,idExpTF.text?.count != 0,expdatestr == "" else
        // {
        //new
        if idExpTF.text?.isEmpty == true
        {
            // timer.invalidate()
            self.idExpView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.idExpView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
            }
            self.view.makeToast(NSLocalizedString("enter_id_exp_date", comment: ""), duration: 3.0, position: .center)
            return
        }
        else
        {
            self.idExpView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
            
            
        }
        
        if idExpTF.text?.isEmpty == true
        {
            
        }
        else
        {
            
            let currentDate = Date() // Current date
            let expiryDateString = idExpTF.text // Format: "dd-MM-yyyy"

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"

            guard let expiryDate = dateFormatter.date(from: expiryDateString!) else {
                self.idExpView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.idExpView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
                }
                self.view.makeToast("Invalid date format.", duration: 3.0, position: .center)
                return
            }

            // Calculate the date 90 days before today
            let calendar = Calendar.current
            guard let ninetyDaysBefore = calendar.date(byAdding: .day, value: -90, to: currentDate) else {
                return
            }

            // Compare expiryDate with ninetyDaysBefore
            if expiryDate < ninetyDaysBefore {
                // Expiry date is older than 90 days before today
                self.idExpView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    self.idExpView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
                }
                self.view.makeToast(NSLocalizedString("Enter a valid expiry date.", comment: "Enter a valid expiry date."), duration: 3.0, position: .center)
                print("The expiry date is before 90 days from today.")
                return
            } else {
                // Expiry date is valid (within 90 days or in the future)
                print("The expiry date is valid.")
            }

            
            //newwocr
            
            // Hardcoded expiry date (for example)
//            let currentDate = Date()
//            let expiryDateString = idExpTF.text // Format: "yyyy-MM-dd"
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy"
//            let expiryDate = dateFormatter.date(from: expiryDateString!)!
//
//            // Compare dates
//            let calendar = Calendar.current
//            let comparison = calendar.compare(currentDate, to: expiryDate, toGranularity: .day)
//
//            // Check expiry status
//            if comparison == .orderedDescending {
//                self.view.makeToast(NSLocalizedString("Enter valid expiry date", comment: ""), duration: 3.0, position: .center)
//                return
//                print("The expiry date has passed.old")
//            } else if comparison == .orderedAscending {
//                print("The product is still valid.")
//            } else {
//                print("Today is the expiry date.")
//            }
            
        }
        
        
        
        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_exp_date", comment: ""), action: NSLocalizedString("ok", comment: ""))
        
        //}
        self.expdatestr = idExp
        
        self.str_id_no = idNum
        //self.str_idType = idTypeBtn.titleLabel?.text as! String
        self.str_idType = "QID"
        //                if(idIssuerBtn.titleLabel?.text == "Ministry of Interior")
        //                {
        //                    self.str_id_issuer = "QATAR MOI"
        //                }
        //                else
        //                {
        //                    self.str_id_issuer = "QATAR MOFA"
        //                }
        self.str_id_exp_date = idExp
        
        // idType
        
        if(idTypeTF.text == nil || idTypeTF.text == "")
        {
            self.view.makeToast(NSLocalizedString("sel_id_issuer", comment: ""), duration: 3.0, position: .center)
            self.idTypeView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.idTypeView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
            }
            return
        }else{
            self.idTypeView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
        }
        
        //new for mob
        var strmobile = mobNumTF.text
        strmobile = strmobile!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(strmobile)
        // "this is the answer"
        print("strmobile",strmobile)
        mobNumTF.text =  strmobile
        print("mobNumTF.text",mobNumTF.text)
        
        //extra space trim
        //extraspace remove
        let startingStringmobile = mobNumTF.text!
        let processedStringmobile = startingStringmobile.removeExtraSpacesregisternumbernospace()
        print("processedStringmobile:\(processedStringmobile)")
        mobNumTF.text = processedStringmobile
        
        //new
        if mobNumTF.text?.isEmpty == true
        {
            // timer.invalidate()
            self.mobNumView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                self.mobNumView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
            }
        }
        else
        {
            self.mobNumView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
        }
        
        
        
        guard let mobile = mobNumTF.text,mobNumTF.text?.count != 0 else
        {
            self.view.makeToast(NSLocalizedString("enter_mobile", comment: ""), duration: 3.0, position: .center)
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_mobile", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        if(mobile.count != 8)
        {
            self.view.makeToast(NSLocalizedString("enter_valid_mob", comment: ""), duration: 3.0, position: .center)
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_mob", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        var charSetMOBNo = CharacterSet.init(charactersIn: "@#$%+_.&'()*,/:;<=>?[]^`{|}~)(")
        var string2MOBNo = mobile
        
        if let strvalue = string2MOBNo.rangeOfCharacter(from: charSetMOBNo)
        {
            print("true")
            //                let alert = UIAlertController(title: "Alert", message: "Please enter valid account number", preferredStyle: UIAlertController.Style.alert)
            //                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            //                self.present(alert, animated: true, completion: nil)
            //                print("check name",self.accountNum.text)
            
            self.view.makeToast(NSLocalizedString("enter_valid_mob", comment: ""), duration: 3.0, position: .center)
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        
        if (!validate (value: self.mobNumTF.text!))
        {
            self.view.makeToast(NSLocalizedString("enter_valid_mob", comment: ""), duration: 3.0, position: .center)
            
            // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("Please enter valid mobile number", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
            
        }
        self.str_idType = "QID"
        let mobNum = mobNumTF.text
        self.defaults.set(mobNum, forKey: "regCustNum")
        self.defaults.set(self.str_idType, forKey: "id_type")
        self.defaults.set(self.str_id_no, forKey: "id_no")
        self.defaults.set(self.str_id_exp_date, forKey: "id_exp_date")
        
        if(idTypeTF.text == "Ministry of Interior")
        {
            self.str_id_issuer = "QATAR MOI"
        }
        else
        {
            self.str_id_issuer = "QATAR MOFA"
        }
        defaults.set(str_id_issuer, forKey: "id_issuer")
        //newbranchcust
//        self.getToken(num: 4)
        self.getToken(num: 1)
        
        
        //}
        
    }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    
    func ensureCorrectDateFormat() {
        // Desired date formatter
        let desiredDateFormatter = DateFormatter()
        desiredDateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Check if the current date string is in the desired format
        if desiredDateFormatter.date(from: expdatestr) != nil {
            // Date is already in the correct format
            print("Date is already in the correct format: \(expdatestr)")
        } else {
            // Convert to the correct format
            let originalDateFormatter = DateFormatter()
            originalDateFormatter.dateFormat = "dd-MM-yyyy"
            
            if let date = originalDateFormatter.date(from: expdatestr) {
                // Convert to desired format
                let desiredDateString = desiredDateFormatter.string(from: date)
                self.expdatestr = desiredDateString
                print("Converted date: \(desiredDateString)") // Output: Converted date: 2024-09-06
            } else {
                print("Invalid original date format")
            }
        }
    }
    
    // MARK: phone no Validation :
    func validate(value: String) -> Bool {
        //let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let PHONE_REGEX = "^[0-9]{0,15}$"
        //let PHONE_REGEX = "[a-zA-z]"
        
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    //MARK: - Api Calls
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        //        let str_encode_val = auth_client_id + ":" + auth_client_secret
        //        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        //        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("tokenResp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("accresss toceke\(token)")
                if(num == 1)
                {
//                    self.idValidation(access_token: token)
                    self.branchcustapi(access_token: token)
                }
                else if(num == 3)
                {
                    //                    self.validateEmailMobile(accessToken: token)
                }
                else if(num == 4)
                {
                    self.branchcustapi(access_token: token)
                }
                break
            case .failure:
                break
            }
        })
    }
    
    func branchcustapi(access_token:String){
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        ensureCorrectDateFormat()
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print("appVersion",appVersion)
        let url = ge_api_url_new + "customer/getBranchCustomer"
        //        let params:Parameters =  ["idNumber":self.str_id_no,"idExpiryDate":self.expdatestr,"mobileNumber":"974" + mobiletxtfdfpage.text!,"partnerId":partnerId,"token":token,"requestTime":dateTime,"deviceType":"IOS","versionName":appVersion]
        
        let params:Parameters =  ["idNumber":self.str_id_no,"mobileNumber":"974" + mobNumTF.text!]
        
        //"2022-09-15"
        
        print("urlbranchcustLIST",url)
        print("paramsbranchcustLIST",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        print("headersuuu",headers)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { [self] (response) in
            let myResult = try? JSON(data: response.data!)
            print("responsebranchcustLIST",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            print("responsecodebranchcusAPI",respCode)
            switch response.result{
            case .success:
                if(respCode == "200")
                {
    //                defaults.removeObject(forKey: "name_en")
    //                defaults.removeObject(forKey: "name_ar")
                    defaults.removeObject(forKey: "email")
//                    defaults.removeObject(forKey: "dob")
                    defaults.removeObject(forKey: "gender")
                    defaults.removeObject(forKey: "nationality")
                    defaults.removeObject(forKey: "dualNationality")
                    defaults.removeObject(forKey: "home_addr")
                    defaults.removeObject(forKey: "employer")
                    defaults.removeObject(forKey: "income")
                    defaults.removeObject(forKey: "work_addr")
                    defaults.removeObject(forKey: "occupation")
                    defaults.removeObject(forKey: "str_actualoccupation")
//                    defaults.removeObject(forKey: "id_issuer")
                    
//                    if myResult!["customerFullName"].stringValue.isEmpty{}
//                    else
//                    {
//                        let fName =  myResult!["customerFullName"].stringValue
//    //                    defaults.set(fName, forKey: "name_en")
//                    }
                    if myResult!["customerFullNameArabic"].stringValue.isEmpty{}
                    else
                    {
                        let fArName =  myResult!["customerFullNameArabic"].stringValue
    //                    defaults.set(fArName, forKey: "name_ar")
                    }
                    if myResult!["email"].stringValue.isEmpty{}
                    else
                    {
                        let email =  myResult!["email"].stringValue
                        defaults.set(email, forKey: "email")
                    }
//                    if myResult!["customerDOB"].stringValue.isEmpty{}
//                    else
//                    {
//                        let dob =  self.convertDateFormatterdob(myResult!["customerDOB"].stringValue)
//                        defaults.set(dob, forKey: "dob")
//                    }
                    if myResult!["gender"].stringValue.isEmpty{}
                    else
                    {
                        let gender =  myResult!["gender"].stringValue
                        defaults.set(gender, forKey: "gender")
                    }
                    if myResult!["nationalityDesc"].stringValue.isEmpty ||  myResult!["nationalityDesc"].stringValue == " "{}
                    else
                    {
                        let nationalityDesc =  myResult!["nationalityDesc"].stringValue
                        defaults.set(nationalityDesc, forKey: "nationality")
                    }
                    
                    //dual nationality
                    if myResult!["dualNationalityDesc"].stringValue.isEmpty || myResult!["dualNationalityDesc"].stringValue == " "{}
                    else
                    {
                        let dualNationalityDesc = myResult!["dualNationalityDesc"].stringValue
                        defaults.set(dualNationalityDesc, forKey: "dualNationality")
                    }
                    if let customerAddress = myResult?["customerAddress"].stringValue,
                       customerAddress.range(of: "^[0-9]+$", options: .regularExpression) != nil {
                        let home_addr =  myResult!["home_addr"].stringValue
                        defaults.set(home_addr, forKey: "home_addr")
                    } else {
                        print("Error: customerAddress is not a valid number.")
                    }
                    if myResult!["employerName"].stringValue.isEmpty ||  myResult!["employerName"].stringValue == " "{}
                    else
                    {
                        let employer =  myResult!["employerName"].stringValue
                        defaults.set(employer, forKey: "employer")
                    }
                    
                    if myResult!["expectedIncome"].stringValue.isEmpty ||  myResult!["expectedIncome"].stringValue == " " {}
                    else
                    {
                        let income = myResult!["expectedIncome"].stringValue
                        if income == "0" || income == "0.0"{}
                        else
                        {
                            defaults.set(income, forKey: "income")
                        }
                    }
                    
                    if myResult!["workingAddress1"].stringValue.isEmpty ||  myResult!["workingAddress1"].stringValue == " "{}
                    else
                    {
                        let workingAddress1 =  myResult!["workingAddress1"].stringValue
                        defaults.set(workingAddress1, forKey: "work_addr")
                    }
                    
                    
                    if myResult!["occupationDesc"].stringValue.isEmpty ||  myResult!["occupationDesc"].stringValue == " "{}
                    else
                    {
                        let occupationDesc =  myResult!["occupationDesc"].stringValue
                        defaults.set(occupationDesc, forKey: "occupation")
                    }
                    
                    if myResult!["actualOccupationDesc"].stringValue.isEmpty ||  myResult!["actualOccupationDesc"].stringValue == " "{}
                    else
                    {
                        let actualOccupationDesc =  myResult!["actualOccupationDesc"].stringValue
                        defaults.set(actualOccupationDesc, forKey: "str_actualoccupation")
                    }
                    /*
                    if myResult!["customerIDIssuedBy"].stringValue.isEmpty
                    {
                        defaults.set("-", forKey: "id_issuer")
                    }
                    else
                    {
                        let checkstr = myResult!["customerIDIssuedBy"].stringValue
                        
                        if checkstr == "MOI"
                        {
                            defaults.set("QATAR MOI", forKey: "id_issuer")
                        }
                        if checkstr == "MOFA"
                        {
                            defaults.set("QATAR MOFA", forKey: "id_issuer")
                        }
                        
                        if checkstr != "MOI" && checkstr != "MOFA"
                        {
                            defaults.set("-", forKey: "id_issuer")
                        }
                    }
                    */
                    
    //                self.getToken(num: 1)
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails2VC") as! RegisterIdDetails2VC
                    nextViewController.idImageBackData = self.idImageBackData
                    nextViewController.idImageFrontData = self.idImageFrontData
                    nextViewController.idImageSelfieVideoData = self.idImageSelfieVideoData
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                else
                {
                    
                    let respMsg = myResult!["responseMessage"].stringValue
                    showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: respMsg)
                    /*showCommonAlert(message: respMsg) {
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        if let viewControllers = self.navigationController?.viewControllers {
                            for viewController in viewControllers {
                                if viewController is MainLoginViewController {
                                    self.navigationController?.popToViewController(viewController, animated: true)
                                    break
                                }
                            }
                        }else{
                            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                    }*/
                   
                }
            case .failure:
                
                showAlert(title: NSLocalizedString("gulf_exchange", comment: ""), message: "Error loading data. Please try again.")
                /*showCommonAlert(message: "Error loading data. Please try again.") {
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    if let viewControllers = self.navigationController?.viewControllers {
                        for viewController in viewControllers {
                            if viewController is MainLoginViewController {
                                self.navigationController?.popToViewController(viewController, animated: true)
                                break
                            }
                        }
                    }else{
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                }*/
            
            }
            /*
            if(respCode == "E2004")
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(respCode == "E2005")
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            if(respCode == "EC2300")
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                return
            }
            if(respCode == "EC2100")
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
                return
            }
            */
            
        })
    }
    
    func idValidation(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":str_id_no,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1999-01-01","validationMethod":"BRANCHCUSTOMER","isExistOrValid":"1"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        print("idValidation params",params)
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("idValidation response",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            if(respCode == "S9001"){
                // success
                self.getToken(num: 4)
            }else if(respCode == "E2004")
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            
                return
//         old       self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("id_exists", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
            else{
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            
                return
//                self.getToken(num: 4)
//                // move to next page
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails2VC") as! RegisterIdDetails2VC
//                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        })
    }
}
extension RegisterIdDetailsOld1VC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == idTypeTF {
            currentDropdownSelection = .idIssuer
            addPopUp()
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == mobNumTF)
        {
            let maxLength = 8
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return Bool()
    }
}

