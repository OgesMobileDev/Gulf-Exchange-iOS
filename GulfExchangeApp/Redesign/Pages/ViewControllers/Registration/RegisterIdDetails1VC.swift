//
//  RegisterIdDetails1.swift
//  GulfExchangeApp
//
//  Created by macbook on 02/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Toast_Swift
import ScreenShield

enum RegistrationDropDownSelection{
    case QID
    case idIssuer
    case nationality
    case secondNationality
    case zone
    case occupation
    case actualOcc
}
class RegisterIdDetails1VC: UIViewController, RegistrationPopupViewDelegate {
   
    
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
    
    
    
    @IBOutlet weak var idDetailLbl: UILabel!
    @IBOutlet weak var qidTF: UITextField!
    @IBOutlet weak var qidBtn: UIButton!
    @IBOutlet weak var idTypeTF: UITextField!
    @IBOutlet weak var idTypeBtn: UIButton!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var idExpTF: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var qidView: UIView!
    @IBOutlet weak var idTypeView: UIView!
    @IBOutlet weak var idNumView: UIView!
    @IBOutlet weak var idExpView: UIView!
//    outlet
    var currentDropdownSelection:RegistrationDropDownSelection = .QID
    var str_idType:String = ""
    var str_id_issuer:String = ""
    var str_id_no:String = ""
    var str_id_exp_date:String = ""
    var qidexpdatestr:String = ""
    
    let datePicker = UIDatePicker()
    let defaults = UserDefaults.standard
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var idImageFrontData: Data?
    var idImageBackData: Data?
    var idImageSelfieVideoData: Data?
    
    let popUpView1 = Bundle.main.loadNibNamed("RegistrationPopupView", owner: RegisterIdDetails1VC.self, options: nil)?.first as! RegistrationPopupView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView1.delegate = self
        qidTF.delegate = self
        idTypeTF.delegate = self
        numberTF.delegate = self
        qidTF.text = "QID"
        numberTF.keyboardType = .numberPad
        addNavbar()
        setView()
        createToolbar()
    }
    override func viewWillAppear(_ animated: Bool) {
        ScreenShield.shared.protect(view: self.idDetailLbl)
        ScreenShield.shared.protect(view: self.qidTF)
        ScreenShield.shared.protect(view: self.idTypeTF)
        ScreenShield.shared.protect(view: self.numberTF)
        ScreenShield.shared.protect(view: self.idExpTF)
        ScreenShield.shared.protectFromScreenRecording()
    }
    @IBAction func qidBtnTapped(_ sender: Any) {
        currentDropdownSelection = .QID
        addPopUp()
    }
    @IBAction func idTypeBtnTapped(_ sender: Any) {
        currentDropdownSelection = .idIssuer
        addPopUp()
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        if let navigationController = self.navigationController {
            for controller in navigationController.viewControllers {
                if let tabController = controller as? MainLoginViewController {
                    navigationController.popToViewController(tabController, animated: true)
                    return
                }
            }
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        validateFields()
        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails2VC") as! RegisterIdDetails2VC
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        
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
    
    func RegistrationPopupView(_ vc: RegistrationPopupView, selection: RegistrationDropDownSelection, didSelectIdType type: String?) {
        qidTF.text = type
    }
    
    //MARK: - Functions
    
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
        numberTF.keyboardType = .phonePad
        qidBtn.setTitle("", for: .normal)
        idTypeBtn.setTitle("", for: .normal)
        configureButton(button: nextBtn, title: NSLocalizedString("next", comment: ""), size: 16, font: .medium)
        configureButton(button: cancelBtn, title: NSLocalizedString("cancel1", comment: ""), size: 16, font: .medium)
        idDetailLbl.text = NSLocalizedString("identification_details", comment: "")
        qidTF.placeholder = NSLocalizedString("id_type", comment: "")
        idTypeTF.placeholder = NSLocalizedString("id_issuer", comment: "")
        
        numberTF.placeholder = NSLocalizedString("id_number", comment: "")
        idExpTF.placeholder = NSLocalizedString("id_exp_date", comment: "")
        if let idExp = defaults.string(forKey: "id_exp_date"){
            idExpTF.text = idExp
            idExpTF.isUserInteractionEnabled = false
        }
        if let idNum = defaults.string(forKey: "id_no"){
            numberTF.text = idNum
            numberTF.isUserInteractionEnabled = false
        }
        
    }
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
           datePicker.preferredDatePickerStyle = .wheels
           datePicker.backgroundColor = UIColor.white
        }
        
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate))
        toolbar.setItems([done], animated: true)
        idExpTF.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        let today = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -89, to: today)!
        idExpTF.inputView = datePicker
    }
    @objc func showdate()
    {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd-MM-yyyy"
            idExpTF.text = dateFormat.string(from: datePicker.date)
             
    //        let dateFormat = DateFormatter()
    //        dateFormat.dateFormat = "yyyy-MM-dd"
    //        self.qidexpdatestr = dateFormat.string(from: datePicker.date)
    //
    //
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let showDate = inputFormatter.string(from: datePicker.date)
//            self.qidexpdatestr = inputFormatter.string(from: datePicker.date)
            //inputFormatter.dateFormat = "yyyy-MM-dd"
           // let resultString = inputFormatter.string(from: showDate)
//            print(self.qidexpdatestr)
            
            
            view.endEditing(true)
        }
    
    func validateFields(){
        
                if(qidTF.text == nil || qidTF.text == "")
                {
                    
                    self.view.makeToast(NSLocalizedString("sel_id_type", comment: ""), duration: 3.0, position: .center)
                    return
                    
                }
                else if(idTypeTF.text == nil || idTypeTF.text == "")
                {
                    self.view.makeToast(NSLocalizedString("sel_id_issuer", comment: ""), duration: 3.0, position: .center)
                    return
                }
                else
                {
                    
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
                        self.numberTF.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
                    }
                    
                    
                    
                    guard let idNum = numberTF.text,numberTF.text?.count != 0 else
                    {
                        self.view.makeToast(NSLocalizedString("enter_id_number", comment: ""), duration: 3.0, position: .center)
                        
                        
                        
                        
                        
                        
                        
                        
                        //  alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_number", comment: ""), action: NSLocalizedString("ok", comment: ""))
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
                        
                        // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_qid", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
                        
                    }
                    
                    
                    
                    guard let idExp = idExpTF.text,idExpTF.text?.count != 0 else
                    {
                        
                        
                        //new
                        if idExpTF.text?.isEmpty == true
                        {
                            // timer.invalidate()
                            self.idExpView.layer.borderColor = UIColor.rgba(198, 23, 30, 1).cgColor
                            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                                self.idExpView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
                            }
                        }
                        else
                        {
                            
                            self.idExpView.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
                            
                            
                            
                            
                            
                        }
                        
                        self.view.makeToast(NSLocalizedString("enter_id_exp_date", comment: ""), duration: 3.0, position: .center)
                        
                        // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_id_exp_date", comment: ""), action: NSLocalizedString("ok", comment: ""))
                        return
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
                            self.view.makeToast(NSLocalizedString("Enter a valid expiry date.", comment: "Enter a valid expiry date."), duration: 3.0, position: .center)
                            print("The expiry date is before 90 days from today.")
                            return
                        } else {
                            // Expiry date is valid (within 90 days or in the future)
                            print("The expiry date is valid.")
                        }

        //                //newwocr
        //
        //                // Hardcoded expiry date (for example)
        //                let currentDate = Date()
        //                let expiryDateString = idExpTF.text // Format: "yyyy-MM-dd"
        //                let dateFormatter = DateFormatter()
        //                dateFormatter.dateFormat = "dd-MM-yyyy"
        //                let expiryDate = dateFormatter.date(from: expiryDateString!)!
        //
        //                // Compare dates
        //                let calendar = Calendar.current
        //                let comparison = calendar.compare(currentDate, to: expiryDate, toGranularity: .day)
        //
        //                // Check expiry status
        //                if comparison == .orderedDescending {
        //                    self.view.makeToast(NSLocalizedString("Enter valid expiry date", comment: ""), duration: 3.0, position: .center)
        //                    return
        //                    print("The expiry date has passed.old")
        //                } else if comparison == .orderedAscending {
        //                    print("The product is still valid.")
        //                } else {
        //                    print("Today is the expiry date.")
        //                }
                        
                    }
                    
                    
                    
                    
                    self.str_id_no = idNum
                    self.str_idType = qidTF.text ?? ""
                    if(idTypeTF.text == "Ministry of Interior")
                    {
                        self.str_id_issuer = "QATAR MOI"
                    }
                    else
                    {
                        self.str_id_issuer = "QATAR MOFA"
                    }
                    self.str_id_exp_date = idExp
                    
                    defaults.set(self.str_id_issuer, forKey: "id_issuer")
                    defaults.set(self.str_id_exp_date, forKey: "id_exp_date")
                    defaults.set(self.str_idType, forKey: "id_type")
                    defaults.set(self.str_id_no, forKey: "id_no")
                    
                    print("str_id_issuer",str_id_issuer)
                    print("str_id_exp_date",str_id_exp_date)
                    print("str_idType",str_idType)
                    //newQID
                    // getTokenGECOQID()
                    
                    self.getToken(num: 1)
        //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        //            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails2VC") as! RegisterIdDetails2VC
        //            self.navigationController?.pushViewController(nextViewController, animated: true)
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
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
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
    
    //MARK: - API Calls
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
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
                if(num == 1)
                {
                    self.idValidation(access_token: token)
                }
                break
            case .failure:
                break
            }
        })
    }
    
    func idValidation(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":str_id_no,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"","customerPhone":"","beneficiaryAccountNo":"","iban":"","customerDOB":"1999-01-01","validationMethod":"CUSTOMERIDNO","isExistOrValid":"1"]
        
        print("idvalidate validate",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("response id validate",response)
            
            
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            
            
//            //new
//            if(respCode == "S9001")
//            {
//               // timer.invalidate()
//                self.idNumTextField.layer.borderColor = UIColor.red.cgColor
//                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (Timer) in
//                    self.idNumTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
//                }
//            }
//            else
//            {
//
//            self.idNumTextField.layer.borderWidth = 0.8
//            self.idNumTextField.layer.borderColor = UIColor(red: 0.70, green: 0.69, blue: 0.67, alpha: 1.00).cgColor
//            }

            
            if(respCode == "S9001")
            {
                //This ID Number is existing in our system
//                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("id_exists", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                return
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails2VC") as! RegisterIdDetails2VC
                nextViewController.idImageFrontData = self.idImageFrontData
                nextViewController.idImageBackData = self.idImageBackData
                nextViewController.idImageSelfieVideoData = self.idImageSelfieVideoData
                self.navigationController?.pushViewController(nextViewController, animated: true)
            } else
            
            if(respCode == "E2004")
            {
                // you are already a branch customer
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            
                return
            }
            else{
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            
                return
               // new customer
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails2VC") as! RegisterIdDetails2VC
//                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
        })
    }
    
    
}

extension RegisterIdDetails1VC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == qidTF {
            currentDropdownSelection = .QID
            addPopUp()
            return false
        }
        if textField == idTypeTF {
            currentDropdownSelection = .idIssuer
            addPopUp()
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == numberTF)
        {
            let maxLength = 11
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return Bool()
    }
}
