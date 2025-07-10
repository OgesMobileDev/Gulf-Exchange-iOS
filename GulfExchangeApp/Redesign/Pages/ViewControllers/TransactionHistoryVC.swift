//
//  TransactionHistoryVC.swift
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

class TransactionHistoryVC: UIViewController, SetCalendar, UITextFieldDelegate, QLPreviewControllerDataSource, ErrorAlertPopupViewDelegate {
    
    
    func PutDate(dateVal: String) {
        // tblTransactions.isHidden = false
        if(self.dateField == 0)
        {
            
            fromDateTextField.text = dateVal
        }
        else if(dateField == 1)
        {
            toDateTextField.text = dateVal
        }
    }
    
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    
    @IBOutlet weak var sortLbl: UILabel!
    @IBOutlet weak var searchLbl: UILabel!
    
    
    @IBOutlet weak var baseTableView: UITableView!
    @IBOutlet weak var topMainView: UIView!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchTopBtn: UIButton!
    @IBOutlet weak var searchBottomView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchCancelBtn: UIButton!
    @IBOutlet weak var searchViewTopConstraint: NSLayoutConstraint!
    
    
    var sortTapped:Bool = false
    var searchTapped:Bool = false
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var downloadedPDFURL: URL?
    let objCustomCalendar :CustomCalendar = CustomCalendar()
    var dateField:Int = 0
    var fromDate:String = ""
    var fromDate1 = Date()
    var toDate:String = ""
    let defaults = UserDefaults.standard
    var transactionList:[MyTransactions] = []
    var udid:String!
    var transactionRefNo:String = ""
    var pdfURL: URL = URL(fileURLWithPath: "")
    
    let ErrorPopupView = Bundle.main.loadNibNamed("ErrorAlertPopupView", owner: HomePageViewController.self, options: nil)?.first as! ErrorAlertPopupView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        addNavbar()
        setView()
        self.baseTableView?.register(UINib.init(nibName: "TransactionHistoryTableViewCell", bundle: .main), forCellReuseIdentifier: "TransactionHistoryTableViewCell")
        baseTableView?.delegate = self
        baseTableView?.dataSource = self
        baseTableView.allowsSelection = false
        baseTableView.showsVerticalScrollIndicator = false
        ErrorPopupView.delegate = self
        topMainView.clipsToBounds = true
        //        createToolbar()
        //        createToolbar1()
        self.fromDate = self.getCurrentDateTime4()
        self.toDate = self.getCurrentDateTime1()
        self.getToken(num: 1, count: 0)
        self.fromDateTextField.text = self.getCurrentDateTime3()
        self.toDateTextField.text = self.getCurrentDateTime2()
        objCustomCalendar.calendarDelegate = self
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
        
                ScreenShield.shared.protect(view: self.toLbl)
                ScreenShield.shared.protect(view: self.fromLbl)
        ScreenShield.shared.protectFromScreenRecording()
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
    @IBAction func sortBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("sort by date", languageCode: "en")
        }
        
        changeViews(isSearch: false)
        
    }
    @IBAction func searchTopBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("search", languageCode: "en")
        }
        
        changeViews(isSearch: true)
    }
    @IBAction func searchCancelBtnTapped(_ sender: Any) {
        changeViews(isSearch: true)
    }
    @IBAction func fromDateBtnTapped(_ sender: Any) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.backgroundColor = UIColor.white
        }
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate))
        toolbar.setItems([done], animated: true)
        fromDateTextField.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        //        let today = Date()
        // datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -89, to: today)!
        
        datePicker.maximumDate = Date()
        let calendar = Calendar.current
        let today = Date()
        //           var components = calendar.dateComponents([.year, .month], from: today)
        //           components.month = (components.month ?? 1) - 1
        //           components.day = 1
        //
        //           if let firstDayOfPreviousMonth = calendar.date(from: components) {
        //               datePicker.date = firstDayOfPreviousMonth
        //           }
        datePicker.date = fromDate1
        fromDateTextField.inputView = datePicker
        fromDateTextField.becomeFirstResponder()
        
    }
    @IBAction func toDateBtnTapped(_ sender: Any) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
            datePicker1.preferredDatePickerStyle = .wheels
            datePicker1.backgroundColor = UIColor.white
        }
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate1))
        toolbar.setItems([done], animated: true)
        toDateTextField.inputAccessoryView = toolbar
        datePicker1.datePickerMode = .date
        datePicker1.maximumDate = Date()
        toDateTextField.inputView = datePicker1
        toDateTextField.becomeFirstResponder()
    }
    
    
    func searchByDate() {
        self.fromDate = self.convertDateFormater(self.fromDateTextField.text!)
        self.toDate = self.convertDateFormater(self.toDateTextField.text!)
        print("from Date",fromDate)
        print("to date", toDate)
        self.getToken(num: 1, count: 0)
    }
    @IBAction func searchBtn(_ sender: Any) {
        if(self.searchTF.text?.count == 0)
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_ref_no", comment: ""), action: NSLocalizedString("ok", comment: ""))
        }
        else{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.defaults.set(self.searchTF.text!, forKey: "transactionRefNo")
            self.searchTF.text = ""
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionDetails") as! TransactionDetailsViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
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
        self.navigationItem.title = NSLocalizedString("my_transactions", comment: "")
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
    
    func setView(){
        
        sortLbl.text = NSLocalizedString("sortByDate", comment: "")
        searchLbl.text = NSLocalizedString("search", comment: "")
        fromLbl.text = NSLocalizedString("from1", comment: "")
        toLbl.text = NSLocalizedString("to1", comment: "")
        searchTF.placeholder = NSLocalizedString("search", comment: "")
        
        topViewHeightConstraint.constant = 70
        sortBtn.setTitle("", for: .normal)
        fromBtn.setTitle("", for: .normal)
        toBtn.setTitle("", for: .normal)
        searchCancelBtn.setTitle("", for: .normal)
        searchTopBtn.setTitle("", for: .normal)
        searchViewTopConstraint.constant = 15
    }
    func changeViews(isSearch:Bool){
        if isSearch{
            searchTapped.toggle()
            if searchTapped{
                if sortTapped{
                    
                    self.searchViewTopConstraint.constant = 70
                    self.topViewHeightConstraint.constant = 180
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                        self.view.layoutIfNeeded()
                    }
                }else{
                    
                    self.searchViewTopConstraint.constant = 15
                    self.topViewHeightConstraint.constant = 125
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                        self.view.layoutIfNeeded()
                    }
                }
            }else{
                searchTF.resignFirstResponder()
                if sortTapped{
                    topViewHeightConstraint.constant = 125
                    searchViewTopConstraint.constant = 70
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                        self.view.layoutIfNeeded()
                    }
                }else{
                    topViewHeightConstraint.constant = 70
                    searchViewTopConstraint.constant = 15
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }else{
            sortTapped.toggle()
            if sortTapped{
                if searchTapped{
                    
                    self.searchViewTopConstraint.constant = 70
                    self.topViewHeightConstraint.constant = 180
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                        self.view.layoutIfNeeded()
                    }
                }else{
                    searchViewTopConstraint.constant = 70
                    topViewHeightConstraint.constant = 125
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                        self.view.layoutIfNeeded()
                    }
                }
            }else{
                if searchTapped{
                    
                    searchViewTopConstraint.constant = 15
                    topViewHeightConstraint.constant = 125
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                        self.view.layoutIfNeeded()
                    }
                }else{
                    searchViewTopConstraint.constant = 15
                    topViewHeightConstraint.constant = 70
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
    }
    func getCurrentDateTime() -> String {
        
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        return formattedDate
    }
    func getCurrentDateTime1() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    
    func getCurrentDateTime2() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    
    func getCurrentDateTime3() -> String {
        let calendar = Calendar.current
        // Get the date one month before
        guard let dateOneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date()) else { return "" }
        fromDate1 = dateOneMonthAgo
        let format = DateFormatter()
        format.dateFormat = "MM-yyyy"
        let formattedDate = "01-" + format.string(from: dateOneMonthAgo)
        print(formattedDate)
        return formattedDate
    }
    
    func getCurrentDateTime4() -> String {
        let calendar = Calendar.current
        // Get the date one month before
        guard let dateOneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date()) else { return "" }
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM"
        let formattedDate = format.string(from: dateOneMonthAgo) + "-01"
        print(formattedDate)
        return formattedDate
    }
    
    /*
     func getCurrentDateTime1() -> String {
     let date = Date()
     let format = DateFormatter()
     format.dateFormat = "yyyy-MM-dd"
     let formattedDate = format.string(from: date)
     print(formattedDate)
     return formattedDate
     }
     func getCurrentDateTime4() -> String {
     let date = Date()
     let format = DateFormatter()
     format.dateFormat = "yyyy-MM-" + "01"
     let formattedDate = format.string(from: date)
     print(formattedDate)
     return formattedDate
     }
     func getCurrentDateTime2() -> String {
     let date = Date()
     let format = DateFormatter()
     format.dateFormat = "dd-MM-yyyy"
     let formattedDate = format.string(from: date)
     print(formattedDate)
     return formattedDate
     }
     func getCurrentDateTime3() -> String {
     let date = Date()
     let format = DateFormatter()
     format.dateFormat = "MM-yyyy"
     let formattedDate = "01-" + format.string(from: date)
     print(formattedDate)
     return formattedDate
     }*/
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.backgroundColor = UIColor.white
        }
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate))
        toolbar.setItems([done], animated: true)
        fromDateTextField.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        let today = Date()
        // datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -89, to: today)!
        
        datePicker.maximumDate = Date()
        fromDateTextField.inputView = datePicker
    }
    
    
    func createToolbar1(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
            datePicker1.preferredDatePickerStyle = .wheels
            datePicker1.backgroundColor = UIColor.white
        }
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.showdate1))
        toolbar.setItems([done], animated: true)
        toDateTextField.inputAccessoryView = toolbar
        datePicker1.datePickerMode = .date
        datePicker1.maximumDate = Date()
        toDateTextField.inputView = datePicker1
    }
    
    @objc func showdate()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        fromDateTextField.text = dateFormat.string(from: datePicker.date)
        fromDate1 = datePicker.date
        searchByDate()
        view.endEditing(true)
    }
    
    @objc func showdate1()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        toDateTextField.text = dateFormat.string(from: datePicker1.date)
        print("asdfghjkl")
        searchByDate()
        view.endEditing(true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        
        if(textField == fromDateTextField)
        {
            //self.dateField = 0
            // let midY = (self.view.frame.height / 2)-150
            //let midX = (self.view.frame.width / 2)-150
            
            //objCustomCalendar.ShowCalendar(xpos: Int(midX), ypos: Int(midY), targetController: self)
        }
        else if(textField == toDateTextField)
        {
            self.dateField = 1
            let midY = (self.view.frame.height / 2)-150
            let midX = (self.view.frame.width / 2)-150
            objCustomCalendar.ShowCalendar(xpos: Int(midX), ypos: Int(midY), targetController: self)
        }
    }
    func alertMessage(title:String,msg:String,action:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
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
    func getToken(num:Int,count:Int) {
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
                if(num == 1)
                {
                    self.getTransactions(access_token: token, dateFrom: self.fromDate, dateTo: self.toDate)
                }
                if(num == 2)
                {
                    self.validateRemittanceStatus(count: count, accessToken: token)
                }
                
                break
            case .failure:
                break
            }
        })
    }
    func getTransactions(access_token:String,dateFrom:String,dateTo:String) {
        self.transactionList.removeAll()
        self.baseTableView.reloadData()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        print("partner id  ",partnerId)
        print("token  ",token)
        print("date  ",dateTime)
        print("user id  ",defaults.string(forKey: "USERID")!)
        print("passw  ",defaults.string(forKey: "PASSW")!)
        print("pin  ",defaults.string(forKey: "PIN")!)
        print("date from  ",dateFrom)
        print("date to  ",dateTo)
        print("regno  ",defaults.string(forKey: "REGNO")!)
        let url = ge_api_url_new + "transaction/mytransaction"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!,"mobileno":"","noOfRecords":"","transactionDateFrom":dateFrom,"transactionDateTo":dateTo,"customerRegNo":defaults.string(forKey: "REGNO")!]
        print("getTransactions url",url)
        print("getTransactions params",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        print("getTransactions params", params)
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("getTransactions response list",response)
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            switch response.result {
            case .success:
                let code = myResult!["responseCode"]
                print("getTransactions res code", code)
                let resultArray = myResult!["transactionList"]
                
                for i in resultArray.arrayValue{
                    let transaction = MyTransactions(
                        transactionRefNo: i["transactionRefNo"].stringValue,
                        gecoTransactionRefNo: i["gecoTransactionRefNo"].stringValue,
                        partnerID: i["partnerID"].stringValue,
                        sourceApplication: i["sourceApplication"].stringValue,
                        deliveryOption: i["deliveryOption"].stringValue,
                        customerRegNo: i["customerRegNo"].stringValue,
                        customerIDNo: i["customerIDNo"].stringValue,
                        mobileNo: i["mobileNo"].stringValue,
                        transactionDate: i["transactionDate"].stringValue,
                        payinCurrency: i["payinCurrency"].stringValue,
                        payinAmount: i["payinAmount"].stringValue,
                        payoutCurrency: i["payoutCurrency"].stringValue,
                        payoutAmount: i["payoutAmount"].stringValue,
                        exchangeRate: i["exchangeRate"].stringValue,
                        commission: i["commission"].stringValue,
                        charges: i["charges"].stringValue,
                        tax: i["tax"].stringValue,
                        totalPayinAmount: i["totalPayinAmount"].stringValue,
                        beneficiaryAccountNo: i["beneficiaryAccountNo"].stringValue,
                        purposeOfTxn: i["purposeOfTxn"].stringValue,
                        sourceOfIncome: i["sourceOfIncome"].stringValue,
                        paymentStatus: i["paymentStatus"].stringValue,
                        paymentMode: i["paymentMode"].stringValue,
                        paymentGatewayName: i["paymentGatewayName"].stringValue,
                        paymentGatewayTxnRefID: i["paymentGatewayTxnRefID"].stringValue,
                        txnStatus1: i["txnStatus1"].stringValue,
                        txnStatus2: i["txnStatus2"].stringValue,
                        remarks: i["remarks"].stringValue,
                        createdOn: i["createdOn"].stringValue,
                        createdBy: i["createdBy"].stringValue,
                        beneficiaryName: i["beneficiaryName"].stringValue,
                        beneficiarySerialNo: i["beneficiarySerialNo"].stringValue)
                    self.transactionList.append(transaction)
                }
                self.baseTableView.reloadData()
            case.failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
            
            
        })
    }
    
    func validateRemittanceStatus(count:Int,accessToken:String) {
        self.defaults.removeObject(forKey: "casmexCustomerCode")
        self.defaults.removeObject(forKey: "casmexSessionId")
        self.defaults.removeObject(forKey: "casmexToken")
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url_new + "utilityservice/validation"
        
        let appVersion = AppInfo.version
                     print("appVersion",appVersion)
        
        let params:Parameters =  [
            "partnerId":partnerId,
            "token":token,
            "requestTime":dateTime,
            "customerIDNo":defaults.string(forKey: "USERID")!,
            "customerPassword":"",
            "mpin":"",
            "customerEmail":"",
            "customerMobile":appVersion,
            "customerPhone":"IOS",
            "beneficiaryAccountNo":"",
            "iban":"",
            "customerDOB":"1900-01-01",
            "validationMethod":"ISREMITALLOWED",
            "isExistOrValid":"0"]
        
        print("paramsvalidationutility ",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { [self] (response) in
            
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["responseCode"]
                 print("respCoderespCoderespCode ",respCode)
                let respMsg = myResult!["responseMessage"].stringValue
                if(respCode == "S1111")
                {
                    
                    let CustomerCode = myResult!["casmexCustomerCode"].stringValue
//                    self.casmexCustomerCode = CustomerCode
                    self.defaults.set(CustomerCode, forKey: "casmexCustomerCode")
                    
                    let sessionId = myResult!["casmexSessionId"].stringValue
//                    self.casmexSessionId = sessionId
                    self.defaults.set(sessionId, forKey: "casmexSessionId")
                    
                    let token = myResult!["casmexToken"].stringValue
//                    self.casmexToken = token
                    self.defaults.set(token, forKey: "casmexToken")
                    
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BeneficiaryInfoVC") as! BeneficiaryInfoVC
                    nextViewController.beneficiaryCode = transactionList[count].beneficiarySerialNo
                    nextViewController.isSendAgain = true
                    nextViewController.sendTransactionDetails = transactionList[count]
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                else if(respCode == "S2222")
                {
                    
                    
                    let CustomerCode = myResult!["casmexCustomerCode"].stringValue
//                    self.casmexCustomerCode = CustomerCode
                    self.defaults.set(CustomerCode, forKey: "casmexCustomerCode")
                    
                    let sessionId = myResult!["casmexSessionId"].stringValue
//                    self.casmexSessionId = sessionId
                    self.defaults.set(sessionId, forKey: "casmexSessionId")
                    
                    let token = myResult!["casmexToken"].stringValue
//                    self.casmexToken = token
                    self.defaults.set(token, forKey: "casmexToken")
                    
                    let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                    let okAction = UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                      
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BeneficiaryInfoVC") as! BeneficiaryInfoVC
                        nextViewController.beneficiaryCode = transactionList[count].beneficiarySerialNo
                        nextViewController.isSendAgain = true
                        nextViewController.sendTransactionDetails = transactionList[count]
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                                        
                    }
                            commonAlert.addAction(okAction)
                    self.present(commonAlert, animated: true, completion: nil)
                }
                else if(respCode == "E9999")
                {
                       // AlertView.instance.showAlert(msg: respMsg, action: .attention)
                       // self.getPopupNotificationList()
                        self.getNewVersionalertList()
                }
                else if(respCode == "E7112")
                {
                    self.addErrorPopup(msg: respMsg, subMsg: "")
                    //original
    //                AlertView.instance.showAlert(msg: respMsg, action: .attention)
                    
    //                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
    //                let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
    //
    //                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //                   // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //                    let vc: ActualOccupationViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActualOccupationViewController") as! ActualOccupationViewController
    //                    self.navigationController?.pushViewController(vc, animated: true)
    //
    //                }
    //                        commonAlert.addAction(okAction)
    //                self.present(commonAlert, animated: true, completion: nil)
                   
                }
                
                else if(respCode == "E7002")
                {
                    let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                    let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                      
                        if let navigationController = self.navigationController {
                            // Check if ProfileVC exists in the navigation stack
                            if let tabController = navigationController.viewControllers.first(where: { $0 is CustomTabController }) as? CustomTabController {
                                tabController.selectedIndex = 2
                                tabController.profileSelection = 2
                                tabController.setTabSelections(currentIndex: 2)
                                navigationController.popToViewController(tabController, animated: true)
                            } else {
                                // If not in stack, push ProfileVC
                                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                let storyboard = UIStoryboard(name: "Main10", bundle: nil)
                                if let nextViewController = storyboard.instantiateViewController(withIdentifier: "CustomTabController") as? CustomTabController {
                                    nextViewController.profileSelection = 2
                                    nextViewController.selectedIndex = 2
                                    nextViewController.setTabSelections(currentIndex: 2)
                                    navigationController.pushViewController(nextViewController, animated: true)
                                }
                            }
                        } else {
                            print("❌ Error: navigationController is nil. Ensure this view is inside a UINavigationController.")
                        }
                                        
                    }
                            commonAlert.addAction(okAction)
                    self.present(commonAlert, animated: true, completion: nil)
                }
                
                
                else if(respCode == "E7003")
                {
                    let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                    let okAction = UIAlertAction(title:NSLocalizedString("update", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                      
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                       // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        let vc: ActualOccupationViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActualOccupationViewController") as! ActualOccupationViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                                        
                    }
                            commonAlert.addAction(okAction)
                    self.present(commonAlert, animated: true, completion: nil)
                }
                
                else
                {
                    self.addErrorPopup(msg: NSLocalizedString("u_r_not_allowed", comment: ""), subMsg: NSLocalizedString("contact_customer_care", comment: ""))
    //                AlertView.instance.showAlert(msg: NSLocalizedString("u_r_not_allowed", comment: "") + NSLocalizedString("contact_customer_care", comment: ""), action: .attention)
                }
                
            case .failure:
                break
            }

           
        
        })
    }
    
    //newvresion alert
    func getNewVersionalertList() {
       var notificMessageList1: [String] = []
       let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
             let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
               self.activityIndicator(NSLocalizedString("loading", comment: ""))
               let url = api_url + "application_update_notification"
        let params:Parameters = ["lang": appLang,"device_type":"IOS"]
                 AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                   print("NEWVERRESPONSE",response)
                    self.effectView.removeFromSuperview()
                   switch response.result{
                   case .success:
                       guard let responseData = response.data else {
                           return
                       }
                       guard let myResult = try? JSON(data: responseData) else {
                           return
                       }
                       let popupListing1 = myResult["application_update_notification"]
                       if(popupListing1.count > 0) {
                           for popupObject in popupListing1.arrayValue {
                               let currentItemKey = "app_notf_desc_" + appLang
                               let currentItemEn = "app_notf_desc_en"
                               let desc = popupObject[currentItemKey].stringValue
                               let desc2 = popupObject[currentItemEn].stringValue
                               if(desc != "") {
                               let descString = desc
                               notificMessageList1.append(descString)
                                    print("descprint",descString)
//                                self.showPopupAlert(desc: descString)
                               } else if(desc2 != "") {
                               let desc2String = desc
                               notificMessageList1.append(desc2String)
                                   print("descprint2",desc2String)
//                                self.showPopupAlert(desc: desc2String)
                           }
                       }
                           
//                           let a = ["", "", ""]
//                           let b = notificMessageList
//                        if a == b {
//                             print("Nullcontentpopup",notificMessageList)
//                        }
                          // else
                        //{
                        
                
//                        let vc: WEBVIEWHomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
//
//
//                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                        
                        
                        
                        ///
                           if notificMessageList1.count > 0 {
                           self.showPopupAlertone(descArray: notificMessageList1)
                                 print("contentpopupNEWVER",notificMessageList1)


                               //
//                               print("NullcontentpopupNEWVER",self.oncecheckpopupstr)
                           }
                        ////
                        
                        
                          // }
                        print("contentpopupNEWVERout",notificMessageList1)
                           
                           
                       }
                   break
                   case .failure:
                       break
                   
                   }
                 })
       }
    
    func showPopupAlertone(descArray: [String]) {
        var arrayFilter = descArray
        if arrayFilter.count > 0 {
//        let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: arrayFilter[0], preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { action in
//            arrayFilter.remove(at: 0)
//            self.showPopupAlert(descArray: arrayFilter)
//        }))
//        self.present(alert, animated: true)
            
            //create view controller
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController")
//            //remove black screen in background
//            vc.modalPresentationStyle = .overCurrentContext
//            //add clear color background
//            vc.view.backgroundColor = UIColor.clear
//            //present modal
//            self.present(vc, animated: true, completion: nil)
            
            
//            let vc: WEBVIEWHomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
//            vc.descArray = descArray
//
//            self.navigationController?.pushViewController(vc, animated: true)
            
            let vc: WEBTEXTVViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WEBTEXTVViewController") as! WEBTEXTVViewController
            vc.descArray = descArray
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            
    
//            let popupone : WEBVIEWHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "WEBVIEWHomeViewController") as! WEBVIEWHomeViewController
//            self.presentOnRoot(with: popupone, descArray: arrayFilter)
        }
    }
    func addErrorPopup(msg:String,subMsg:String){
        ErrorPopupView.setView(msg: msg, subMsg: subMsg)
        ErrorPopupView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        ErrorPopupView.alpha = 0.0
        view.addSubview(ErrorPopupView)
        UIView.animate(withDuration: 0.3, animations: {
            self.ErrorPopupView.alpha = 1.0
        })
        
    }
    func ErrorAlertPopupView(_ vc: ErrorAlertPopupView, action: Bool) {
        if action{
            ErrorPopupView.removeFromSuperview()
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
    
}
extension TransactionHistoryVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryTableViewCell", for: indexPath) as! TransactionHistoryTableViewCell
        let transaction = transactionList[indexPath.row]
        
        cell.trackBtn.addTarget(self, action: #selector(trackBtnTapped), for: .touchUpInside)
        cell.trackBtn.tag = indexPath.row
        cell.sendBtn.addTarget(self, action: #selector(sendBtnTapped), for: .touchUpInside)
        cell.sendBtn.tag = indexPath.row
        cell.downloadBtn.addTarget(self, action: #selector(downloadBtnTapped), for: .touchUpInside)
        cell.downloadBtn.tag = indexPath.row
        cell.detailsBtn.addTarget(self, action: #selector(detailsBtnTapped), for: .touchUpInside)
        cell.detailsBtn.tag = indexPath.row
        cell.setMyTransaction(transaction: transaction)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    @objc func trackBtnTapped(sender: UIButton){
        print("trackBtnTapped")
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("track", languageCode: "en")
        }
        
        let transactionRefNo = transactionList[sender.tag].transactionRefNo
        self.defaults.set(transactionRefNo, forKey: "transactionRefNo")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.defaults.set("track", forKey: "trackFrom")
        
        let vc: TrackTransactionsVC = UIStoryboard.init(name: "Main10", bundle: Bundle.main).instantiateViewController(withIdentifier: "TrackTransactionsVC") as! TrackTransactionsVC
        self.navigationController?.pushViewController(vc, animated: true)
        //        let vc: TrackTransactionViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "track") as! TrackTransactionViewController
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func sendBtnTapped(sender: UIButton){
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("send again", languageCode: "en")
        }
        
        print("sendBtnTapped", transactionList[sender.tag].beneficiarySerialNo)
        
        getToken(num: 2, count: sender.tag)
        
    }
    @objc func downloadBtnTapped(sender: UIButton){
        print("downloadBtnTapped")
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("download", languageCode: "en")
        }
        
        self.transactionRefNo = transactionList[sender.tag].transactionRefNo
        self.downloadAndOpenPDF()
    }
    @objc func detailsBtnTapped(sender: UIButton){
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("details", languageCode: "en")
        }
        
        let transactionRefNo = transactionList[sender.tag].transactionRefNo
        self.defaults.set(transactionRefNo, forKey: "transactionRefNo")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionReciptVC") as! TransactionReciptVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        /* self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionDetails") as! TransactionDetailsViewController
         self.navigationController?.pushViewController(nextViewController, animated: true)*/
        print("detailsBtnTapped")
    }
}
