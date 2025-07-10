//
//  ManageBeneficiaryVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Toast_Swift
import ScreenShield
enum TransferSelection{
    case bankTransfer
    case cashPickup
    case mobileWallet
    case none
}

class ManageBeneficiaryVC: UIViewController, TranferSelectionPopupViewDelegate {
    
    
    
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var recentCollectionView: UICollectionView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var recentTitleLbl: UILabel!
    @IBOutlet weak var addBenfBtn: UIButton!
    @IBOutlet weak var addBenfLbl: UILabel!
    @IBOutlet weak var addBenfWidth: NSLayoutConstraint!
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var defaults = UserDefaults.standard
    var recentBeneficiaryList:[CasmexRecentBeneficiary] = []
    var beneficiaryList:[CasmexListBeneficiary] = []
    var searchBeneficiaryList:[CasmexListBeneficiary] = []
    var currentSelection:TransferSelection = .none
    
    var casmexCustomerCode:String = ""
    var casmexSessionId:String = ""
    var casmexToken:String = ""
    
    let popUpView = Bundle.main.loadNibNamed("TranferSelectionPopupView", owner: self, options: nil)?.first as! TranferSelectionPopupView
    //test
    static let AlamoFireManager: Alamofire.Session = {
        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator(),
                                                      "ws.gulfexchange.com.qa": DisabledEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    //production
    //          static let AlamoFireManager: Alamofire.Session = {
    //        //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
    //                let configuration = URLSessionConfiguration.af.default
    //                return Session(configuration: configuration)
    //        //        return Session(configuration: configuration, serverTrustManager: manager)
    //            }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        clearBtn.setTitle("", for: .normal)
        addBenfBtn.setTitle("", for: .normal)
        let width = UIScreen.main.bounds.width
        print("width - \(width)")
        let subViewWidth = (width - 30) / 5
        print("subViewWidth - \(subViewWidth)")
        addBenfWidth.constant = subViewWidth
        self.listTableView?.register(UINib.init(nibName: "BeneficiaryListTableViewCell", bundle: .main), forCellReuseIdentifier: "BeneficiaryListTableViewCell")
        listTableView?.delegate = self
        listTableView?.dataSource = self
        listTableView.allowsSelection = false
        listTableView.showsVerticalScrollIndicator = false
        self.recentCollectionView?.register(UINib.init(nibName: "RecentBeneficiaryCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "RecentBeneficiaryCollectionViewCell")
        recentCollectionView?.delegate = self
        recentCollectionView?.dataSource = self
        popUpView.delegate = self
        searchTF.delegate = self
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
        ScreenShield.shared.protectFromScreenRecording()
    }
    
   
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recentTitleoLblTapped(_:)))
        recentTitleLbl.isUserInteractionEnabled = true
        recentTitleLbl.addGestureRecognizer(tapGesture)
        
//        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(idDetailLblTapped(_:)))
//        idDetailLbl.isUserInteractionEnabled = true
//        idDetailLbl.addGestureRecognizer(tapGesture1)
//        
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(mobileLblTapped(_:)))
//        mobileLbl1.isUserInteractionEnabled = true
//        mobileLbl1.addGestureRecognizer(tapGesture2)
//        
//        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(emailLblTapped(_:)))
//        emailLbl1.isUserInteractionEnabled = true
//        emailLbl1.addGestureRecognizer(tapGesture3)
    }
    
    @objc func recentTitleoLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("recent", languageCode: "en")
            }
        }
    }
    @objc func idDetailLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("identification details", languageCode: "en")
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
    
    @IBAction func clearBtnTapped(_ sender: Any) {
        searchTF.resignFirstResponder()
    }
    @IBAction func addBenfBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("add", languageCode: "en")
        }
        
        addPopup()
    }
    //MARK: - Functions
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
    func addPopup(){
        popUpView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpView.alpha = 0.0
        view.addSubview(popUpView)
        print("TranferSelectionPopupView")
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.alpha = 1.0
        })
    }
    func TranferSelectionPopupView(_ vc: TranferSelectionPopupView, selection: TransferSelection) {
        print("selected")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: AddBeneficiaryVC = UIStoryboard.init(name: "TestDummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddBeneficiaryVC") as! AddBeneficiaryVC
        vc.currentSelection = selection
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        var notificationIMg = "notification_y"
        if notificationCount{
            notificationIMg = "notification_y"
        }else{
            notificationIMg = "notification_n"
        }
        let notificationBtn = UIBarButtonItem(image: UIImage(named: notificationIMg), style: .done, target: self, action: #selector(notificationAction))
        let helpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItems  = [helpBtn, notificationBtn]
        self.navigationItem.title = "Beneficiaries"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func heplVCAction(){
        
//        if defaults.bool(forKey: "accessibilityenabled"){
//            SpeechHelper.shared.speak("help", languageCode: "en")
//        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HelpVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func notificationAction(){
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("notification", languageCode: "en")
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: NotificationListVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationListVC") as! NotificationListVC
        self.navigationController?.pushViewController(vc, animated: true)
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
                    let dispatchGroup = DispatchGroup()
                    
                    dispatchGroup.enter()
                    self.activityIndicator(NSLocalizedString("loading", comment: ""))
                        self.getBeneficiary(access_token: token) {
                            dispatchGroup.leave() // Signal that the first API call is done
                        }

                        // Start the second API call
                        dispatchGroup.enter()
                        self.getRecentBeneficiary(access_token: token) {
                            dispatchGroup.leave() // Signal that the second API call is done
                        }

                        // Notify when both calls are complete
                        dispatchGroup.notify(queue: .main) {
                            print("Both API calls are completed!")
                            // Perform any actions that need to wait for both API calls to complete
                            self.effectView.removeFromSuperview()
                        }
//                    self.getBeneficiary(access_token: token)
//                    self.getRecentBeneficiary(access_token: token)
                }
                else if(num == 2)
                {
                    //                    self.getBank(access_token: token)
                }
                else if(num == 3)
                {
                    //                    self.getBranch(access_token: token, bankCode: self.str_bank_code)
                }
                else if(num == 4)
                {
                    //                    self.saveBeneficiary(access_token: token)
                }
                else if(num == 5)
                {
                    //                    self.viewBeneficiary(access_token: token, serial_no: self.str_serial_no, accountNo: self.str_ben_account)
                }
                else if(num == 6)
                {
                    //                    self.deleteBeneficiary(access_token: token)
                }
                
                else if(num == 7)
                {
                    //                    self.viewCustomer(access_token: token)
                }
                else if(num == 8)
                {
                    //                    self.getSource(access_token: token)
                }
                else if(num == 9)
                {
                    //                        self.getPurpose(access_token: token)
                }
                else if(num == 10)
                {
                    //                        self.getCitynewapi(access_token: token)
                }
                else if(num == 11)
                {
                    //                    self.updateBeneficiary(access_token: token)
                }
                break
            case .failure:
                break
            }
            
        })
    }
    
    func getBeneficiary(access_token:String, completion: @escaping () -> Void) {
//        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.beneficiaryList.removeAll()
        let url = ge_api_url_new + "beneficiary/listbeneficiary"
        let params:Parameters =  [
            "customerIDNo":defaults.string(forKey: "USERID")!,
            "beneficiaryCode":"",
            "casmexCustomerCode":self.casmexCustomerCode,
            "casmexSessionId":self.casmexSessionId,
            "casmexToken":self.casmexToken
        ]
        print("getBeneficiary params\(params)")
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            print("getBeneficiary response \(response)")
            switch response.result{
            case .success:
                if let responseData = response.data {
                    do {
                        let myResult = try JSON(data: responseData)
//                        self.effectView.removeFromSuperview()
                        
                        print("myResult - \(myResult)")
                        
                        // Extract the inner array
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
                                self.beneficiaryList.append(beneficiary)
                                self.searchBeneficiaryList.append(beneficiary)
                            }
                            
                            // Reload the table view
                            
                            self.listTableView.reloadData()
    //                        print("beneficiaryList - \n \(self.beneficiaryList)")
                        } else {
                            print("Error: Unable to extract the inner array from the response.")
                        }
                    } catch {
                        print("Error parsing response data: \(error.localizedDescription)")
                    }
                }
                completion()

            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                completion()
                break
            }

            
        })
        
        // self.resetTimer()
    }
    func getRecentBeneficiary(access_token:String, completion: @escaping () -> Void){
//        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.beneficiaryList.removeAll()
        let url = ge_api_url_new + "beneficiary/recentbeneficiary"
        let params:Parameters =  [
            "customerIDNo":defaults.string(forKey: "USERID")!,
            "casmexCustomerCode":self.casmexCustomerCode,
            "casmexSessionId":self.casmexSessionId,
            "casmexToken":self.casmexToken
        ]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            print("getRecentBeneficiary response \(response)")
            switch response.result{
            case .success:
                
                if let responseData = response.data {
                    do {
                        let myResult = try JSON(data: responseData)
    //                    self.effectView.removeFromSuperview()
                        
                        print("getRecentBeneficiary response - \(myResult)")
                        
                        // Extract the inner array
                         let resultArray = myResult["data"]
                            for i in resultArray.arrayValue{
                                let beneficiary = CasmexRecentBeneficiary(beneficiaryName: i["beneficiaryName"].stringValue, beneficiaryCode: i["beneficiaryCode"].stringValue)
                                // Append to beneficiary list
                                self.recentBeneficiaryList.append(beneficiary)
                            }
                            self.recentCollectionView.reloadData()
    //                    }
    //                    else {
    //                        print("Error: Unable to extract the inner array from the response.")
    //                    }
                    } catch {
                        print("Error parsing response data: \(error.localizedDescription)")
                    }
                }
                completion()
            case .failure:
                completion()
                break
            }

        })
        
    }
    
    func extractJSONFromResponse(_ responseString: String) -> String? {
        // Find the content inside the success wrapper
        if let range = responseString.range(of: "success(") {
            let extracted = responseString[range.upperBound...] // Extract substring after "success("
            let trimmed = extracted.trimmingCharacters(in: CharacterSet(charactersIn: ")")) // Trim closing parenthesis
            return String(trimmed) // Convert Substring to String
        }
        return nil
    }
}

extension ManageBeneficiaryVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
           
           // Calculate the new text
           let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
           
           // Filter the arrSearchBranch array
           if updatedText.isEmpty {
               // If the text field is empty, reset the filtered branches
               beneficiaryList = searchBeneficiaryList
           } else {
               beneficiaryList = searchBeneficiaryList.filter { beneficiary in
                   if let beneficiaryName = beneficiary.firstName {
                       return beneficiaryName.lowercased().contains(updatedText.lowercased())
                   }
                   return false
               }
           }
           
           // Reload your table view or update the UI as needed to show filteredBranches
        listTableView.reloadData()
        return true // Allow the text field to update
    }
}


extension ManageBeneficiaryVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
                return beneficiaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeneficiaryListTableViewCell", for: indexPath) as! BeneficiaryListTableViewCell
                let beneficiary = beneficiaryList[indexPath.row]
                cell.setView(data: beneficiary)
        cell.detailsBtn.addTarget(self, action: #selector(detailsBtnTapped), for: .touchUpInside)
        cell.detailsBtn.tag = indexPath.row
        cell.bankBtn.addTarget(self, action: #selector(bankBtnTapped), for: .touchUpInside)
        cell.bankBtn.tag = indexPath.row
        cell.cashBtn.addTarget(self, action: #selector(cashBtnTapped), for: .touchUpInside)
        cell.cashBtn.tag = indexPath.row
        cell.walletBtn.addTarget(self, action: #selector(walletBtnTapped), for: .touchUpInside)
        cell.walletBtn.tag = indexPath.row
//        cell.setView()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    @objc func detailsBtnTapped(sender: UIButton){
        print("detailsBtnTapped\(sender.tag)")
        if beneficiaryList[sender.tag].active == "Y"{
            
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak(beneficiaryList[sender.tag].firstName ?? "", languageCode: "en")
            }
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BeneficiaryInfoVC") as! BeneficiaryInfoVC
            nextViewController.beneficiaryCode = beneficiaryList[sender.tag].beneficiaryCode ?? "*"
            nextViewController.isSendAgain = false
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else{
            showAlert(title: "ERROR", message: "The selected beneficiary is not authorirized for remittance")
        }
        
    }
    @objc func bankBtnTapped(sender: UIButton){
        
        
        print("bankBtnTapped\(sender.tag)")
    }
    @objc func cashBtnTapped(sender: UIButton){
        print("cashBtnTapped\(sender.tag)")
    }
    @objc func walletBtnTapped(sender: UIButton){
        print("walletBtnTapped\(sender.tag)")
    }
}
extension ManageBeneficiaryVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentBeneficiaryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recentCollectionView.dequeueReusableCell(withReuseIdentifier: "RecentBeneficiaryCollectionViewCell", for: indexPath) as! RecentBeneficiaryCollectionViewCell
    
        cell.setView(data: recentBeneficiaryList[indexPath.item])
            cell.selectionBtn.addTarget(self, action: #selector(recentBenfTapped), for: .touchUpInside)
        cell.selectionBtn.tag = indexPath.item
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let subViewWidth = (width - 30) / 5
        return CGSize(width: subViewWidth, height: 80)
    }
    @objc func recentBenfTapped(sender: UIButton){
        print("sendBtnTapped\(sender.tag)")
//        if defaults.bool(forKey: "accessibilityenabled"){
//            SpeechHelper.shared.speak(beneficiaryList[sender.tag].firstName ?? "", languageCode: "en")
//        }
        
        if sender.tag < beneficiaryList.count {
            if defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak(beneficiaryList[sender.tag].firstName ?? "", languageCode: "en")
            }
        } else {
            print("Error: sender.tag out of bounds")
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BeneficiaryInfoVC") as! BeneficiaryInfoVC
        nextViewController.beneficiaryCode = recentBeneficiaryList[sender.tag].beneficiaryCode ?? "*"
        nextViewController.isSendAgain = false
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}



