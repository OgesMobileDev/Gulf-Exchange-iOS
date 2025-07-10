//
//  BeneficiaryInfoVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 25/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Toast_Swift
import ScreenShield

class BeneficiaryInfoVC: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dropArrowImg: UIImageView!
    @IBOutlet weak var prfofileImgBaseView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var benfTransferBtn: UIButton!
    
    
    @IBOutlet weak var reciveLbl: UILabel!
    @IBOutlet weak var serviceTypeImg: UIImageView!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var branchNameLbl: UILabel!
    @IBOutlet weak var accNoLbl: UILabel!
    @IBOutlet weak var branchCodeLbl: UILabel!
    
    @IBOutlet weak var bankNameLbl1: UILabel!
    @IBOutlet weak var branchNameLbl1: UILabel!
    @IBOutlet weak var accNoLbl1: UILabel!
    @IBOutlet weak var branchCodeLbl1: UILabel!
    
    
    @IBOutlet weak var expandViewHeight: NSLayoutConstraint!
    @IBOutlet weak var expandView: UIView!
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    var expandToggle:Bool = false
    var beneficiaryDetail:[CasmexListBeneficiary] = []
    var beneficiaryCode:String = ""
    var isSendAgain:Bool = false
    var sendTransactionDetails:MyTransactions?
    
    var casmexCustomerCode:String = ""
    var casmexSessionId:String = ""
    var casmexToken:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        dropDownBtn.setTitle("", for: .normal)
        benfTransferBtn.setTitle("", for: .normal)
        setView()
        self.casmexToken = defaults.string(forKey: "casmexToken") ?? ""
        self.casmexSessionId = defaults.string(forKey: "casmexSessionId") ?? ""
        self.casmexCustomerCode = defaults.string(forKey: "casmexCustomerCode") ?? ""
        setTxtToSpeech()
        
        getToken(num: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.shared.fetchToken { token in
            if let token = token {
                // Call login session update
                APIManager.shared.updateSession(sessionType: "1", accessToken: token) { responseCode in
                    if responseCode == "S222" {
                        print("Session Valid")
                    } else {
                        self.handleSessionError()
                    }
                }
            } else {
                print("Failed to fetch token")
            }
        }
        ScreenShield.shared.protect(view: titleLbl)
        ScreenShield.shared.protect(view: nameLbl)
        ScreenShield.shared.protect(view: reciveLbl)
        ScreenShield.shared.protect(view: bankNameLbl)
        ScreenShield.shared.protect(view: accNoLbl)
        ScreenShield.shared.protect(view: branchCodeLbl)
        ScreenShield.shared.protect(view: bankNameLbl1)
        ScreenShield.shared.protect(view: branchNameLbl1)
        ScreenShield.shared.protect(view: accNoLbl1)
        ScreenShield.shared.protect(view: branchCodeLbl1)
        ScreenShield.shared.protectFromScreenRecording()
        
       
    }
    
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(benificiaryinformationLblTapped(_:)))
        titleLbl.isUserInteractionEnabled = true
        titleLbl.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(receiveoptionLblTapped(_:)))
        reciveLbl.isUserInteractionEnabled = true
        reciveLbl.addGestureRecognizer(tapGesture1)
//
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(mobileLblTapped(_:)))
//        mobileLbl1.isUserInteractionEnabled = true
//        mobileLbl1.addGestureRecognizer(tapGesture2)
//
//        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(emailLblTapped(_:)))
//        emailLbl1.isUserInteractionEnabled = true
//        emailLbl1.addGestureRecognizer(tapGesture3)
    }
    
    @objc func benificiaryinformationLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("benificiary information", languageCode: "en")
            }
        }
    }
    @objc func receiveoptionLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("receive option", languageCode: "en")
            }
        }
        
    }
    
    @objc func mobileLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("mobile number", languageCode: "en")
            }
        }
    }
    
    @objc func emailLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("email", languageCode: "en")
            }
        }
    }
    
    
    func handleSessionError() {
        //        if !defaults.string(forKey: "biometricenabled") == "biometricenabled"{
        //
        //        }
                if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
                {
                    
                }
                else
                {
                self.defaults.set("", forKey: "USERID")
                self.defaults.set("", forKey: "PASSW")
                self.defaults.set("", forKey: "PIN")
                self.defaults.set("", forKey: "REGNO")
                }
        self.defaults.set("logoutbiometrc", forKey: "logoutbiometrc")
                UserDefaults.standard.set(false, forKey: "isLoggedIN")
        //        UserDefaults.standard.removeObject(forKey: "biometricenabled")
                
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
    
    @IBAction func dropDownBtnTapped(_ sender: Any) {
        expandToggle.toggle()
        if expandToggle{
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak(nameLbl.text ?? "", languageCode: "en")
            }
            
            dropArrowImg.image = UIImage(named: "faq_up")
            expandView.isHidden = false
            expandViewHeight.constant = 340
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()
            }
        }else{
            dropArrowImg.image = UIImage(named: "faq_down")
            expandViewHeight.constant = 110
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.expandView.isHidden = true
            }
        }
    }
    @IBAction func benfTransferBtnTapped(_ sender: Any) {
        if isSendAgain{
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: TransferPage1VC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransferPage1VC") as! TransferPage1VC
            vc.benefDetails = beneficiaryDetail[0]
            vc.sendTransactionDetails = self.sendTransactionDetails
            vc.isSendAgain = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: TransferPage1VC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransferPage1VC") as! TransferPage1VC
            vc.benefDetails = beneficiaryDetail[0]
            vc.isSendAgain = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
       
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        
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
        self.navigationItem.title = "Manage All Beneficiaries"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
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
    
    func setView(){
        dropDownBtn.isUserInteractionEnabled = false
        dropArrowImg.image = UIImage(named: "faq_down")
        expandViewHeight.constant = 110
        expandView.isHidden = true
        configureButton(button: deleteBtn, title: "Disable Beneficiary", size: 14, font: .medium)
        
    
        titleLbl.text = NSLocalizedString("beneficiaryInformation", comment: "")
       // bankNameLbl1.text = NSLocalizedString("Bank", comment: "")
        branchNameLbl1.text = NSLocalizedString("Branch", comment: "")
        branchCodeLbl1.text = NSLocalizedString("Branch Code", comment: "")
        
    }
    func setApiData(){
        if !beneficiaryDetail.isEmpty{
            let beneficiary = beneficiaryDetail[0]
            nameLbl.text = "\(beneficiary.firstName ?? "") \(beneficiary.lastName ?? "")"
           
            profileImg.isHidden = true
            createAvatar(username: beneficiary.firstName ?? "", view: prfofileImgBaseView, font: 30)
            loadCountryFlag(for: beneficiary.country ?? "", into: countryImg)
            
            switch beneficiary.serviceCategory{
            case "0002":
                serviceTypeImg.image = UIImage(named: "bank_transfer")
                bankNameLbl1.text = NSLocalizedString("Bank", comment: "")
                accNoLbl1.text =  NSLocalizedString("Account No.", comment: "")
                branchNameLbl1.isHidden = false
                branchCodeLbl1.isHidden = false
                branchNameLbl.isHidden = false
                branchCodeLbl.isHidden = false
                bankNameLbl.text = beneficiary.bankName
                branchNameLbl.text = beneficiary.branchName
                accNoLbl.text = beneficiary.accountNumber
                branchCodeLbl.text = beneficiary.branchCode
            case "0001":
                serviceTypeImg.image = UIImage(named: "cash_pickup")
                bankNameLbl1.text = NSLocalizedString("SERVICEPROVIDER", comment: "")
                accNoLbl1.text = NSLocalizedString("mob_no1", comment: "")
                branchNameLbl1.isHidden = true
                branchCodeLbl1.isHidden = true
                branchNameLbl.isHidden = true
                branchCodeLbl.isHidden = true
                bankNameLbl.text = beneficiary.serviceCategory
                accNoLbl.text = beneficiary.mobileNumber
            case "0003":
                serviceTypeImg.image = UIImage(named: "mobile_wallet_transfer")
                bankNameLbl1.text = NSLocalizedString("SERVICEPROVIDER", comment: "")
                accNoLbl1.text = NSLocalizedString("mob_no1", comment: "")
                branchNameLbl1.isHidden = true
                branchCodeLbl1.isHidden = true
                branchNameLbl.isHidden = true
                branchCodeLbl.isHidden = true
                bankNameLbl.text = beneficiary.serviceProviderName
                accNoLbl.text = beneficiary.mobileNumber
            default:
                serviceTypeImg.image = UIImage(named: "mobile_wallet_transfer")
                bankNameLbl1.text = NSLocalizedString("SERVICEPROVIDER", comment: "")
                accNoLbl1.text = NSLocalizedString("mob_no1", comment: "")
                branchNameLbl1.isHidden = true
                branchCodeLbl1.isHidden = true
                branchNameLbl.isHidden = true
                branchCodeLbl.isHidden = true
                bankNameLbl.text = beneficiary.serviceProviderName
                accNoLbl.text = beneficiary.mobileNumber
            }
            dropDownBtn.isUserInteractionEnabled = true
        }
    }
    
    //MARK: - API Calls
    
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        print("tokenurl",url)
        //        self.olduserchkstr = "0"
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token  ",token)
                if(num == 1)
                {
                    self.getBeneficiary(access_token: token)
                }
                    else if (num == 2)
                {
                    // delete beneficiary
                }
                
                break
            case .failure:
                break
            }
            
        })
    }
    func getBeneficiary(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.beneficiaryDetail.removeAll()
        let url = ge_api_url_new + "beneficiary/listbeneficiary"
        let params:Parameters =  [
            "customerIDNo":defaults.string(forKey: "USERID")!,
            "beneficiaryCode": beneficiaryCode,
            "casmexCustomerCode":self.casmexCustomerCode,
            "casmexSessionId":self.casmexSessionId,
            "casmexToken":self.casmexToken
        ]
        print("getBeneficiary params", params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            print("getBeneficiary response \(response)")
           
            if let responseData = response.data {
                do {
                    let myResult = try JSON(data: responseData)
                    self.effectView.removeFromSuperview()
                    
                    print("myResult - \(myResult)")
                    
                    // Extract the inner array
//                    if let resultArray = myResult[].array {
                    if let resultArray = myResult.arrayValue.first?.arrayValue {
                        for i in resultArray {
                            let beneficiary = CasmexListBeneficiary(
                                firstName: i["firstName"].stringValue,
                                middleName: i["middleName"].stringValue,
                                lastName: i["lastName"].stringValue,
                                receiveCountry: i["receiveCountry"].stringValue,
                                receiveCurrency: i["receiveCurrency"].stringValue,
                                deliveryOption: i["deliveryOption"].stringValue,
                                dob: i["dob"].stringValue,
                                nationality: i["nationality"].stringValue,
                                mobileNumber: i["mobileNumber"].stringValue,
                                address: i["address"].stringValue,
                                address1: i["address1"].stringValue,
                                address2: i["address2"].stringValue,
                                beneficiaryCode: i["beneficiaryCode"].stringValue,
                                country: i["country"].stringValue,
                                gender: i["gender"].stringValue,
                                currency: i["currency"].stringValue,
                                customerCode: i["customerCode"].stringValue,
                                relationship: i["relationship"].stringValue,
                                relationshipDesc: i["relationshipDesc"].stringValue,
                                serviceCategory: i["serviceCategory"].stringValue,
                                city: i["city"].stringValue,
                                zipCode: i["zipCode"].stringValue,
                                accountNumber: i["accountNumber"].stringValue,
                                bankCode: i["bankCode"].stringValue,
                                bankName: i["bankName"].stringValue,
                                branchCode: i["branchCode"].stringValue,
                                branchName: i["branchName"].stringValue,
                                idType: i["idType"].stringValue,
                                idNumber: i["idNumber"].stringValue,
                                relationshipToSender: i["relationshipToSender"].stringValue,
                                placeOfBirth: i["placeOfBirth"].stringValue,
                                serviceProviderName:  i["serviceProviderName"].stringValue,
                                serviceProviderCode:  i["serviceProviderCode"].stringValue,
                                active: i["active"].stringValue,
                                other1: i["other1"].stringValue,
                                other2: i["other2"].stringValue,
                                other3: i["other3"].stringValue,
                                other4: i["other4"].stringValue,
                                other5: i["other5"].stringValue)
                            
                            // Append to beneficiary list
                            self.beneficiaryDetail.append(beneficiary)
                        }
                        
                        // Reload the table view
                        self.setApiData()
//                        print("beneficiaryList - \n \(self.beneficiaryList)")
                    } else {
                        print("Error: Unable to extract the inner array from the response.")
                    }
                } catch {
                    print("Error parsing response data: \(error.localizedDescription)")
                }
            }
        })
        
        // self.resetTimer()
    }
    /*func deleteBeneficiary(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "beneficiary/savebeneficiary"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"beneficiaryAccountName":"","beneficiaryNickName":"","beneficiaryAccountNumber":self.str_acc_no,"beneficiaryBankName":"","beneficiaryIFSCCode":"","beneficiaryBankBranchName":"","beneficiaryAccountType":"","beneficiaryBankCountryCode":"","beneficiaryMobile":"","beneficiaryEmail":"","beneficiaryAddress":"","beneficiaryCity":"","beneficiaryIBAN":"","beneficiarySwiftCode":"","beneficiarySortCode":"","beneficiaryRoutingCode":"","beneficiaryFirstName":"","beneficiaryMiddleName":"","beneficiaryLastName":"","relationship":"","serviceType":"CREDIT","beneficiarySerialNo":self.str_serial_no,"action":"DELETE"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        //beneficiarySerialNo
        
        RemittancePage1ViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
            print("resp",response)
            self.effectView.removeFromSuperview()
            if(respCode == "S2001")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("ben_deleted", comment: ""), action: NSLocalizedString("ok", comment: ""))
                self.getToken(num: 1)
                self.clearBen()
                self.scrollView.setContentOffset(.zero, animated: true)
                
            }
            
            else
            {
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))
            }
            
        })
    }*/
}


