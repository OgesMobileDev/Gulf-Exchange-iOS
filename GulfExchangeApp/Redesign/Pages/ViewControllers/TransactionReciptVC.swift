//
//  TransactionReciptVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield
import QuickLook

class TransactionReciptVC: UIViewController, QLPreviewControllerDataSource {
    
    var downloadedPDFURL: URL?
    
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
    @IBOutlet weak var transferInfoLbl: UILabel!
    @IBOutlet weak var reciveAmntLbl: UILabel!
    @IBOutlet weak var reciveAmntLbl1: UILabel!
    @IBOutlet weak var exchangeRateLbl: UILabel!
    @IBOutlet weak var exchangeRateLbl1: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareLbl: UILabel!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var downloadLbl: UILabel!
    
    let defaults = UserDefaults.standard
    var timer = Timer()
    var transRefNo:String = ""
    var totalstr:String = ""
    var totalpayoutstr:String = ""
    var commisionstr:String = ""
    var payinstr:String = ""
    var accoribanzero:String = ""
    var udid:String!
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var userName:String = ""
    var transactionRefNo:String = ""
    var pdfURL: URL = URL(fileURLWithPath: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer.invalidate()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        addNavbar()
        setView()
        shareBtn.setTitle("", for: .normal)
        downloadBtn.setTitle("", for: .normal)
        
        self.getToken()
        self.transRefNo = defaults.string(forKey: "transactionRefNo")!
        self.userName = defaults.string(forKey: "GLUserName") ?? ""
        
        setTxtToSpeech()
        
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
        ScreenShield.shared.protect(view: referanceNoLbl1)
        ScreenShield.shared.protect(view: referanceNoLbl)
        ScreenShield.shared.protect(view: dateLbl1)
        ScreenShield.shared.protect(view: dateLbl)
        ScreenShield.shared.protect(view: collectionRefLbl1)
        ScreenShield.shared.protect(view: collectionRefLbl)
        ScreenShield.shared.protect(view: paindInAmntLbl1)
        ScreenShield.shared.protect(view: paindInAmntLbl)
        ScreenShield.shared.protect(view: senderInfoLbl)
        ScreenShield.shared.protect(view: senderNameLbl1)
        ScreenShield.shared.protect(view: senderNameLbl)
        ScreenShield.shared.protect(view: senderIdLbl1)
        ScreenShield.shared.protect(view: senderIdLbl)
        ScreenShield.shared.protect(view: beneficiaryInfoLbl)
        ScreenShield.shared.protect(view: benfNameLbl1)
        ScreenShield.shared.protect(view: benfNameLbl)
        ScreenShield.shared.protect(view: benfCountryLbl1)
        ScreenShield.shared.protect(view: benfCountryLbl)
        ScreenShield.shared.protect(view: benfContactLbl)
        ScreenShield.shared.protect(view: benfContactLbl1)
        ScreenShield.shared.protect(view: benfRecvTypeLbl)
        ScreenShield.shared.protect(view: benfRecvTypeLbl1)
        ScreenShield.shared.protect(view: benfColletionPointLbl)
        ScreenShield.shared.protect(view: benfColletionPointLbl1)
        ScreenShield.shared.protect(view: transferInfoLbl)
        ScreenShield.shared.protect(view: reciveAmntLbl)
        ScreenShield.shared.protect(view: reciveAmntLbl1)
        ScreenShield.shared.protect(view: exchangeRateLbl)
        ScreenShield.shared.protect(view: exchangeRateLbl1)
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    
    
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
    
    
    @IBAction func shareBtnTapped(_ sender: Any) {
//        pdfHandler.sharePdf(transactionRefNo: transactionRefNo)
//        downloadFile1()
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("share", languageCode: "en")
        }
        
        sharePDF()
    }
    
    @IBAction func downloadBtnTapped(_ sender: Any) {
//        pdfHandler.downloadFile(transactionRefNo: transactionRefNo)
//        downloadPDF(transactionRefNo: transactionRefNo)
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("download", languageCode: "en")
        }
        
        downloadAndOpenPDF()
    }
    
    //MARK: - Function
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("transaction_details", comment: "")
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func setView(){
        titleLbl.text = NSLocalizedString("transferDetails", comment: "")
        referanceNoLbl1.text = NSLocalizedString("paymentReferenceNumber", comment: "")
        dateLbl1.text = NSLocalizedString("date&Time", comment: "")
        collectionRefLbl1.text = NSLocalizedString("collectionRef", comment: "")
        paindInAmntLbl1.text = NSLocalizedString("paidAmount", comment: "")
        senderInfoLbl.text = NSLocalizedString("senderInformation", comment: "")
        senderNameLbl1.text = NSLocalizedString("name", comment: "")
        senderIdLbl1.text = NSLocalizedString("id_no", comment: "")
        beneficiaryInfoLbl.text = NSLocalizedString("beneficiaryInformation", comment: "")
        benfNameLbl1.text = NSLocalizedString("name", comment: "")
        benfCountryLbl1.text = NSLocalizedString("countryT", comment: "")
        benfContactLbl1.text = NSLocalizedString("contact", comment: "")
        benfRecvTypeLbl1.text = NSLocalizedString("receiveType", comment: "")
        benfColletionPointLbl1.text = NSLocalizedString("collectionPoint", comment: "")
        transferInfoLbl.text = NSLocalizedString("transferInformation", comment: "")
        reciveAmntLbl1.text = NSLocalizedString("receiveAmount", comment: "")
        exchangeRateLbl1.text = NSLocalizedString("exchangeRate", comment: "")
        shareLbl.text = NSLocalizedString("share", comment: "")
        downloadLbl.text = NSLocalizedString("download", comment: "")
        
        
        
        
        
        
        
    }
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        return formattedDate
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

    
    
    func downloadAndOpenPDF() {
           let baseURL = "https://gulfexchange.com.qa/en/view-transfer-details-pdf/"
//           let transactionRefNo = "12345" // Replace with your dynamic reference number
           let urlString = "\(baseURL)\(transRefNo)"
//        let urlString = "https://kvongcmehsanalibrary.wordpress.com/wp-content/uploads/2021/07/harrypotter.pdf"
        print("urlString",urlString)
           let fileName = "GulfExchange-\(transRefNo).pdf"

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

    func sharePDF() {
            let baseURL = "https://gulfexchange.com.qa/work_new/en/view-transfer-details-pdf/"
            let urlString = "\(baseURL)\(transRefNo)"
            let fileName = "GulfExchange-\(transRefNo).pdf"
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let filePath = documentsDirectory.appendingPathComponent("GulfExchange").appendingPathComponent(fileName)
            
            if FileManager.default.fileExists(atPath: filePath.path) {
                // File exists, share it
                presentShareSheet(fileURL: filePath)
            } else {
                // File doesn't exist, download and share
                downloadPDF(from: urlString, fileName: fileName) { [weak self] savedURL, error in
                    guard let self = self else { return }
                    
                    if let savedURL = savedURL {
                        print("PDF successfully downloaded for sharing at: \(savedURL)")
                        DispatchQueue.main.async {
                            self.presentShareSheet(fileURL: savedURL)
                        }
                    } else if let error = error {
                        print("Failed to download PDF for sharing: \(error.localizedDescription)")
                    }
                }
            }
        }
    func presentShareSheet(fileURL: URL) {
            let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
        
       // MARK: - QLPreviewControllerDataSource

       func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
           return downloadedPDFURL == nil ? 0 : 1
       }

       func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
           return downloadedPDFURL! as QLPreviewItem
       }
    
    
    
    
    
    

    // Helper function to show alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Download Complete", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(alert, animated: true, completion: nil)
        }
    }


    
    //MARK: - APi Calls
    
    func getToken() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
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
                self.getTransactionDetails(access_token: token)
                break
            case .failure:
                break
            }
        })
    }
    func getTransactionDetails(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "transaction/viewtransaction"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"transactionRefNo":self.transRefNo]
        
        print("params viewtransaction response list",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response list",response)
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let respCode = myResult!["responseCode"]
                if(respCode == "E114")
                {
                    self.alertMessage(title: "Gulf Exchange", msg: NSLocalizedString("no_data_available", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else{
                    
                    self.referanceNoLbl.text = myResult!["transactionRefNo"].stringValue
                    self.senderNameLbl.text = self.userName
                    if myResult!["transactionDate"].stringValue.isEmpty
                    {
                        self.dateLbl.text = "----"
                    }
                    else
                    {
                        self.dateLbl.text = myResult!["transactionDate"].stringValue
                    }
                    if myResult!["customerIDNo"].stringValue.isEmpty
                    {
                        self.senderIdLbl.text = "----"
                    }
                    else
                    {
                        self.senderIdLbl.text = myResult!["customerIDNo"].stringValue
                    }
                    
                    if myResult!["beneficiaryAccountName"].stringValue.isEmpty
                    {
                        self.benfNameLbl.text = "----"
                    }
                    else
                    {
                        self.benfNameLbl.text = myResult!["beneficiaryAccountName"].stringValue
                    }
                    if myResult!["beneficiaryBankCountry"].stringValue.isEmpty
                    {
                        self.benfCountryLbl.text = "----"
                    }
                    else
                    {
                        self.benfCountryLbl.text = myResult!["beneficiaryBankCountry"].stringValue
                    }
                    if myResult!["mobileNo"].stringValue.isEmpty
                    {
                        self.benfContactLbl.text = "----"
                    }
                    else
                    {
                        self.benfContactLbl.text = myResult!["mobileNo"].stringValue
                    }
                    if myResult!["deliveryOption"].stringValue.isEmpty
                    {
                        self.benfRecvTypeLbl.text = "----"
                    }
                    else
                    {
                        self.benfRecvTypeLbl.text = myResult!["deliveryOption"].stringValue
                    }
                    if myResult!["exchangeRate"].stringValue.isEmpty
                    {
                        self.exchangeRateLbl.text = "----"
                    }
                    else
                    {
                        self.exchangeRateLbl.text = myResult!["exchangeRate"].stringValue
                    }
                    if myResult!["beneficiaryBank"].stringValue.isEmpty
                    {
                        self.benfColletionPointLbl.text = "----"
                    }
                    else
                    {
                        self.benfColletionPointLbl.text = myResult!["beneficiaryBank"].stringValue
                    }
                    if myResult!["totalPayinAmount"].stringValue.isEmpty
                    {
                        self.paindInAmntLbl.text = "----"
                    }
                    else
                    {
                        if myResult!["payinCurrency"].stringValue.isEmpty
                        {
                            self.paindInAmntLbl.text = myResult!["totalPayinAmount"].stringValue
                        }else{
                            self.paindInAmntLbl.text =  "\(myResult!["payinCurrency"].stringValue) \(myResult!["totalPayinAmount"].stringValue)"
                        }
                    }
                    if myResult!["payoutAmount"].stringValue.isEmpty
                    {
                        self.reciveAmntLbl.text = "----"
                    }
                    else
                    {
                        if myResult!["payoutCurrency"].stringValue.isEmpty
                        {
                            self.reciveAmntLbl.text = myResult!["payoutAmount"].stringValue
                        }else{
                            self.reciveAmntLbl.text =  "\(myResult!["payoutCurrency"].stringValue) \(myResult!["payoutAmount"].stringValue)"
                        }
                    }
                    
                }
            case .failure:
                break
            }

            
        })
    }
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        print("downloadLocation:", location)
//        
//        
//       
//            // create destination URL with the original pdf name
//            guard let url = downloadTask.originalRequest?.url else { return }
//            let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
//            let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
//            // delete original copy
//            try? FileManager.default.removeItem(at: destinationURL)
//            // copy from temp to Document
//            do {
//                try FileManager.default.copyItem(at: location, to: destinationURL)
//                //self.pdfURL = destinationURL
//                print("pdfurlllfilemm:", self.pdfURL)
//                
//                
////                if (pdfURL == nil) {
////                    //...
////                    print("test:", "illa")
////                } else {
////                    self.viewprint.isHidden = false
////                    //self.effectView.removeFromSuperview()
////                }
//                
//            } catch let error {
//                print("Copy Error: \(error.localizedDescription)")
//            }
//        
//    }

}
