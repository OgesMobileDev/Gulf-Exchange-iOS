//
//  TransferReciptVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 14/12/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Toast_Swift
import ScreenShield
import QuickLook

class TransferReciptVC: UIViewController, QLPreviewControllerDataSource{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var referanceNoLbl1: UILabel!
    @IBOutlet weak var referanceNoLbl: UILabel!
    @IBOutlet weak var dateLbl1: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var collectionRefLbl1: UILabel!
    @IBOutlet weak var collectionRefLbl: UILabel!
    @IBOutlet weak var paindInAmntLbl1: UILabel!
    @IBOutlet weak var paindInAmntLbl: UILabel!
    
    @IBOutlet weak var senderInfoLbl: UILabel!
    @IBOutlet weak var senderNameLbl1: UILabel!
    @IBOutlet weak var senderNameLbl: UILabel!
    @IBOutlet weak var senderIdLbl1: UILabel!
    @IBOutlet weak var senderIdLbl: UILabel!
    @IBOutlet weak var senderExpiryLbl1: UILabel!
    @IBOutlet weak var senderExpiryLbl: UILabel!
    @IBOutlet weak var senderPhoneLbl1: UILabel!
    @IBOutlet weak var senderPhoneLbl: UILabel!
    @IBOutlet weak var senderDOBLbl1: UILabel!
    @IBOutlet weak var senderDOBLbl: UILabel!
    @IBOutlet weak var senderEmployerLbl1: UILabel!
    @IBOutlet weak var senderEmployerLbl: UILabel!
    @IBOutlet weak var senderOccupationLbl1: UILabel!
    @IBOutlet weak var senderOccupationLbl: UILabel!
    @IBOutlet weak var senderNationalityLbl1: UILabel!
    @IBOutlet weak var senderNationalityLbl: UILabel!
    
    @IBOutlet weak var beneficiaryInfoLbl: UILabel!
    @IBOutlet weak var benfNameLbl1: UILabel!
    @IBOutlet weak var benfNameLbl: UILabel!
    @IBOutlet weak var benfCountryLbl1: UILabel!
    @IBOutlet weak var benfCountryLbl: UILabel!
    @IBOutlet weak var benfContactLbl: UILabel!
    @IBOutlet weak var benfContactLbl1: UILabel!
    @IBOutlet weak var benfRecvTypeLbl: UILabel!
    @IBOutlet weak var benfRecvTypeLbl1: UILabel!
    @IBOutlet weak var benfColletionPointLbl: UILabel!
    @IBOutlet weak var benfColletionPointLbl1: UILabel!
    @IBOutlet weak var benfBranchLbl1: UILabel!
    @IBOutlet weak var benfBranchLbl: UILabel!
    @IBOutlet weak var benfSourceLbl1: UILabel!
    @IBOutlet weak var benfSourceLbl: UILabel!
    @IBOutlet weak var benfPurposeLbl1: UILabel!
    @IBOutlet weak var benfPurposeLbl: UILabel!
    @IBOutlet weak var benfRelationLbl1: UILabel!
    @IBOutlet weak var benfRelationLbl: UILabel!
    @IBOutlet weak var benfDestinationLbl1: UILabel!
    @IBOutlet weak var benfDestinationLbl: UILabel!
    
    @IBOutlet weak var transferInfoLbl: UILabel!
    @IBOutlet weak var reciveAmntLbl: UILabel!
    @IBOutlet weak var reciveAmntLbl1: UILabel!
    @IBOutlet weak var exchangeRateLbl: UILabel!
    @IBOutlet weak var exchangeRateLbl1: UILabel!
    @IBOutlet weak var serviceFeeLbl: UILabel!
    @IBOutlet weak var serviceFeeLbl1: UILabel!
    @IBOutlet weak var totalAmntLbl: UILabel!
    @IBOutlet weak var totalAmntLbl1: UILabel!
    @IBOutlet weak var disclaimerLbl: UILabel!
    @IBOutlet weak var disclaimerDetailsLbl: UILabel!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var downloadLbl: UILabel!
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    var transactionDetails:CasmexTransactionDetails?
    var transactionRefNo:String = ""
    var pdfURL: URL = URL(fileURLWithPath: "")
    var downloadedPDFURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        downloadBtn.setTitle("", for: .normal)
        transactionRefNo = defaults.string(forKey: "refNo") ?? ""
        
        setTxtToSpeech()
        setView()
        
        getToken()
        // Do any additional setup after loading the view.
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
        ScreenShield.shared.protect(view: self.titleLbl)
        ScreenShield.shared.protect(view: self.referanceNoLbl1)
        ScreenShield.shared.protect(view: self.referanceNoLbl)
        ScreenShield.shared.protect(view: self.dateLbl1)
        ScreenShield.shared.protect(view: self.dateLbl)
        ScreenShield.shared.protect(view: self.collectionRefLbl1)
        ScreenShield.shared.protect(view: self.collectionRefLbl)
        ScreenShield.shared.protect(view: self.paindInAmntLbl1)
        ScreenShield.shared.protect(view: self.paindInAmntLbl)
        ScreenShield.shared.protect(view: self.senderInfoLbl)
        ScreenShield.shared.protect(view: self.senderNameLbl1)
        ScreenShield.shared.protect(view: self.senderNameLbl)
        ScreenShield.shared.protect(view: self.senderIdLbl1)
        ScreenShield.shared.protect(view: self.senderIdLbl)
        ScreenShield.shared.protect(view: self.senderExpiryLbl1)
        ScreenShield.shared.protect(view: self.senderExpiryLbl)
        ScreenShield.shared.protect(view: self.senderPhoneLbl1)
        ScreenShield.shared.protect(view: self.senderPhoneLbl)
        ScreenShield.shared.protect(view: self.senderDOBLbl1)
        ScreenShield.shared.protect(view: self.senderDOBLbl)
        ScreenShield.shared.protect(view: self.senderEmployerLbl1)
        ScreenShield.shared.protect(view: self.senderEmployerLbl)
        ScreenShield.shared.protect(view: self.senderOccupationLbl1)
        ScreenShield.shared.protect(view: self.senderOccupationLbl)
        ScreenShield.shared.protect(view: self.senderNationalityLbl1)
        ScreenShield.shared.protect(view: self.senderNationalityLbl)
        ScreenShield.shared.protect(view: self.beneficiaryInfoLbl)
        ScreenShield.shared.protect(view: self.benfNameLbl1)
        ScreenShield.shared.protect(view: self.benfNameLbl)
        ScreenShield.shared.protect(view: self.benfCountryLbl1)
        ScreenShield.shared.protect(view: self.benfCountryLbl)
        ScreenShield.shared.protect(view: self.benfContactLbl)
        ScreenShield.shared.protect(view: self.benfContactLbl1)
        ScreenShield.shared.protect(view: self.benfRecvTypeLbl)
        ScreenShield.shared.protect(view: self.benfRecvTypeLbl1)
        ScreenShield.shared.protect(view: self.benfColletionPointLbl)
        ScreenShield.shared.protect(view: self.benfColletionPointLbl1)
        ScreenShield.shared.protect(view: self.benfBranchLbl1)
        ScreenShield.shared.protect(view: self.benfBranchLbl)
        ScreenShield.shared.protect(view: self.benfSourceLbl1)
        ScreenShield.shared.protect(view: self.benfSourceLbl)
        ScreenShield.shared.protect(view: self.benfPurposeLbl1)
        ScreenShield.shared.protect(view: self.benfPurposeLbl)
        ScreenShield.shared.protect(view: self.benfRelationLbl1)
        ScreenShield.shared.protect(view: self.benfRelationLbl)
        ScreenShield.shared.protect(view: self.benfDestinationLbl1)
        ScreenShield.shared.protect(view: self.benfDestinationLbl)
        ScreenShield.shared.protect(view: self.transferInfoLbl)
        ScreenShield.shared.protect(view: self.reciveAmntLbl)
        ScreenShield.shared.protect(view: self.reciveAmntLbl1)
        ScreenShield.shared.protect(view: self.exchangeRateLbl)
        ScreenShield.shared.protect(view: self.exchangeRateLbl1)
        ScreenShield.shared.protect(view: self.serviceFeeLbl)
        ScreenShield.shared.protect(view: self.serviceFeeLbl1)
        ScreenShield.shared.protect(view: self.totalAmntLbl)
        ScreenShield.shared.protect(view: self.totalAmntLbl1)
        ScreenShield.shared.protect(view: self.disclaimerLbl)
        ScreenShield.shared.protect(view: self.disclaimerDetailsLbl)
        ScreenShield.shared.protect(view: self.downloadLbl)
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    func setView(){
        referanceNoLbl.text = NSLocalizedString("paymentReferenceNumber", comment: "")
        titleLbl.text = NSLocalizedString("transferDetails", comment: "")
        dateLbl1.text = NSLocalizedString("date&Time", comment: "")
        collectionRefLbl1.text = NSLocalizedString("collectionRef", comment: "")
        paindInAmntLbl1.text = NSLocalizedString("paidAmount", comment: "")
        
        senderInfoLbl.text = NSLocalizedString("senderInformation", comment: "")
        senderNameLbl1.text = NSLocalizedString("name", comment: "")
        
        senderIdLbl1.text = NSLocalizedString("id_no", comment: "")
        senderEmployerLbl1.text = NSLocalizedString("employer", comment: "")
        senderOccupationLbl1.text = NSLocalizedString("occupation", comment: "")
        senderNationalityLbl1.text = NSLocalizedString("nationality", comment: "")
        beneficiaryInfoLbl.text = NSLocalizedString("beneficiaryInformation", comment: "")
        benfNameLbl1.text = NSLocalizedString("name", comment: "")
        benfCountryLbl1.text = NSLocalizedString("countryT", comment: "")
        benfContactLbl1.text = NSLocalizedString("contact", comment: "")
        benfRecvTypeLbl1.text = NSLocalizedString("receiveType", comment: "")
        benfColletionPointLbl1.text = NSLocalizedString("collectionPoint", comment: "")
        benfPurposeLbl1.text = NSLocalizedString("Purpose", comment: "")
        benfRelationLbl1.text = NSLocalizedString("relationship1_sm", comment: "")
        
        benfSourceLbl1.text = NSLocalizedString("Source", comment: "")
        downloadLbl.text = NSLocalizedString("Download Receipt", comment: "")
        
        
    }
    
    //
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TitleoLblTapped(_:)))
        titleLbl.isUserInteractionEnabled = true
        titleLbl.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(senderInfoLblTapped(_:)))
        senderInfoLbl.isUserInteractionEnabled = true
        senderInfoLbl.addGestureRecognizer(tapGesture1)

        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(beneficiaryInfoLblTapped(_:)))
        beneficiaryInfoLbl.isUserInteractionEnabled = true
        beneficiaryInfoLbl.addGestureRecognizer(tapGesture2)

        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(transferInfoLblTapped(_:)))
        transferInfoLbl.isUserInteractionEnabled = true
        transferInfoLbl.addGestureRecognizer(tapGesture3)
    }
    
    @objc func TitleoLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("transfer details", languageCode: "en")
            }
        }
    }
    @objc func senderInfoLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("sender information", languageCode: "en")
            }
        }
        
    }
    
    @objc func beneficiaryInfoLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("beneficiary Information", languageCode: "en")
            }
        }
    }
    
    @objc func transferInfoLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("transfer Information", languageCode: "en")
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
    @IBAction func downloadBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("download", languageCode: "en")
        }
        
        self.downloadAndOpenPDF()
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
        self.navigationItem.title = "Recipt"
    }
    @objc func customBackButtonTapped() {
        if let navigationController = self.navigationController {
            for controller in navigationController.viewControllers {
                if let tabController = controller as? CustomTabController {
                    navigationController.popToViewController(tabController, animated: true)
                    return
                }
            }
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
            self.navigationController?.pushViewController(nextViewController, animated: true)
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
    func downloadAndOpenPDF() {
           let baseURL = "https://gulfexchange.com.qa/en/view-transfer-details-pdf/"
           let urlString = "\(baseURL)\(transactionRefNo)"
        print("urlString",urlString)
           let fileName = "GulfExchange-\(transactionRefNo).pdf"

           downloadPDF(from: urlString, fileName: fileName) { [weak self] savedURL, error in
               guard let self = self else { return }
               
               if let savedURL = savedURL {
                   print("PDF successfully downloaded at: \(savedURL)")
                   self.downloadedPDFURL = savedURL
                   
                   // Open the downloaded PDF
                   DispatchQueue.main.async {
                       self.openPDF(savedURL: savedURL)
                   }
               } else if let error = error {
                   print("Failed to download PDF: \(error.localizedDescription)")
               }
           }
       }

    func downloadPDF(from urlString: String, fileName: String, completion: @escaping (URL?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 400, userInfo: nil))
            return
        }

        let session = URLSession(configuration: .default)
        let task = session.downloadTask(with: url) { tempURL, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let tempURL = tempURL else {
                completion(nil, NSError(domain: "File not found", code: 404, userInfo: nil))
                return
            }

            do {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let folderURL = documentsDirectory.appendingPathComponent("GulfExchange")
                
                // Create the GulfExchange folder if it doesn't exist
                if !FileManager.default.fileExists(atPath: folderURL.path) {
                    try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
                }

                var fileURL = folderURL.appendingPathComponent(fileName)

                if FileManager.default.fileExists(atPath: fileURL.path) {
                    // File already exists, show alert to the user
                    DispatchQueue.main.async {
                        self.showFileExistsAlert(fileURL: fileURL, tempURL: tempURL, completion: completion)
                    }
                    return
                }

                try FileManager.default.moveItem(at: tempURL, to: fileURL)
                completion(fileURL, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func showFileExistsAlert(fileURL: URL, tempURL: URL, completion: @escaping (URL?, Error?) -> Void) {
        let alertController = UIAlertController(
            title: "File Already Exists",
            message: "The file '\(fileURL.lastPathComponent)' already exists. What would you like to do?",
            preferredStyle: .alert
        )
        
        // Option 1: Replace
        alertController.addAction(UIAlertAction(title: "Replace", style: .destructive) { _ in
            do {
                try FileManager.default.removeItem(at: fileURL)
                try FileManager.default.moveItem(at: tempURL, to: fileURL)
                completion(fileURL, nil)
            } catch {
                completion(nil, error)
            }
        })
        
        // Option 2: Rename
        alertController.addAction(UIAlertAction(title: "Rename", style: .default) { _ in
            let renamedURL = self.generateUniqueFileURL(baseURL: fileURL)
            
            do {
                try FileManager.default.moveItem(at: tempURL, to: renamedURL)
                completion(renamedURL, nil)
            } catch {
                completion(nil, error)
            }
        })
        
        // Option 3: Cancel
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(nil, NSError(domain: "Download Cancelled", code: 0, userInfo: nil))
        })
        
        // Present the alert
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }

    func generateUniqueFileURL(baseURL: URL) -> URL {
        var fileURL = baseURL
        var counter = 1
        
        let fileExtension = baseURL.pathExtension
        var fileName = baseURL.deletingPathExtension().lastPathComponent
        
        while FileManager.default.fileExists(atPath: fileURL.path) {
            fileName = "\(baseURL.deletingPathExtension().lastPathComponent)(\(counter))"
            fileURL = baseURL.deletingLastPathComponent().appendingPathComponent(fileName).appendingPathExtension(fileExtension)
            counter += 1
        }
        
        return fileURL
    }


       func openPDF(savedURL: URL) {
           let quickLookController = QLPreviewController()
           quickLookController.dataSource = self
           self.present(quickLookController, animated: true)
       }
        
       // MARK: - QLPreviewControllerDataSource

       func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
           return downloadedPDFURL == nil ? 0 : 1
       }

       func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
           return downloadedPDFURL! as QLPreviewItem
       }
    //MARK: - API Calls
    
    func getToken() {
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
                self.getTransactionDetails(access_token: token)
                break
            case .failure:
                break
            }
            
        })
    }
    func getTransactionDetails(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        self.transactionDetails = nil
        let url = ge_api_url_new + "utilityservice/getTransactionDetails"
        let params:Parameters =  [
//            "transactionRefNo": transactionRefNo
            "transactionRefNo": "100014042500001"
        ]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            if(respCode == "S104")
            {
               /* self.collectionRefLbl
                self.senderExpiryLbl
                self.senderDOBLbl
                self.senderEmployerLbl
                self.benfContactLbl
                self.benfRelationLbl
                self.benfDestinationLbl
                self.serviceAmntLbl*/
//              self.  .text =  myResult!["messageDetail"].stringValue
//              self.  .text =  myResult!["customerCode"].stringValue
//              self.  .text =  myResult!["customerIdType"].stringValue
//              self.  .text =  myResult!["customerMobile"].stringValue
//              self.  .text =  myResult!["customerAddress"].stringValue
//              self.  .text =  myResult!["beneficiaryBankCode"].stringValue
//              self.  .text =  myResult!["beneficiaryBankBranchCode"].stringValue
//              self.  .text =  myResult!["beneficiaryAccountNo"].stringValue 
                
                //                .text =  myResult!["passportNo"].stringValue
                //              self.  .text =  myResult!["beneficiaryAddress"].stringValue
                //              self.  .text =  myResult!["payoutCurrency"].stringValue
                //                self.serviceFeeLbl.text =  myResult!["commission"].stringValue
//                .text =  myResult!["actualProfession"].stringValue
//                .text =  myResult!["serviceProviderName"].stringValue
//                .text =  myResult!["agentName"].stringValue
//                .text =  myResult!["ifscCode"].stringValue
//                .text =  myResult!["clientRefNo"].stringValue
                self.senderNameLbl.text =  myResult!["customerFullName"].stringValue
//                self.collectionRefLbl.text =  myResult!["clientRefNo"].stringValue
                self.senderIdLbl.text =  myResult!["customerIdNo"].stringValue
                self.senderPhoneLbl.text =  myResult!["customerPhone"].stringValue
                self.senderNationalityLbl.text =  myResult!["customerNationality"].stringValue
                self.referanceNoLbl.text =  myResult!["transactionRefNo"].stringValue
                self.benfNameLbl.text =  myResult!["beneficiaryAccountName"].stringValue
                self.benfCountryLbl.text =  myResult!["beneficiaryBankCountryCode"].stringValue

                self.benfColletionPointLbl.text =  myResult!["beneficiaryBankEng"].stringValue
                self.benfBranchLbl.text =  myResult!["beneficiaryBranchEng"].stringValue
                self.benfRecvTypeLbl.text =  myResult!["serviceType"].stringValue

                self.dateLbl.text =  myResult!["transactionDate"].stringValue

                self.reciveAmntLbl.text =  myResult!["payoutCurrency"].stringValue + " " + myResult!["payoutAmount"].stringValue
                self.exchangeRateLbl.text =  myResult!["exchangeRate"].stringValue
                
                self.paindInAmntLbl.text =  myResult!["payinCurrency"].stringValue + "" + myResult!["totalPayinAmount"].stringValue
                self.benfPurposeLbl.text =  myResult!["purposeOfTxn"].stringValue
                self.benfSourceLbl.text =  myResult!["sourceOfIncome"].stringValue
                self.totalAmntLbl.text =   myResult!["payinCurrency"].stringValue + "" + myResult!["payinAmount"].stringValue

                self.senderOccupationLbl.text =  myResult!["profession"].stringValue
               
                self.senderExpiryLbl.text = myResult!["senderExpiryDate"].stringValue
                self.senderDOBLbl.text = myResult!["senderDOB"].stringValue
                self.senderEmployerLbl.text = myResult!["senderEmployer"].stringValue
                self.benfRelationLbl.text = myResult!["benfRelation"].stringValue
                self.benfContactLbl1.text = myResult!["benfMobile"].stringValue
                self.serviceFeeLbl.text = myResult!["serviceFee"].stringValue
               
            }else{
                let respMsg = myResult!["responseMessage"].stringValue
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg, action: NSLocalizedString("ok", comment: ""))

            }
                
        })
        
        
        // self.resetTimer()
    }
    
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
//        let imageView = UIImageView(frame: CGRect(x: 220, y: 20, width: 40, height: 40))
//        imageView.image = UIImage(named: "attention")
//
//        alert.view.addSubview(imageView)
        self.present(alert, animated: true)
    }
    
}
