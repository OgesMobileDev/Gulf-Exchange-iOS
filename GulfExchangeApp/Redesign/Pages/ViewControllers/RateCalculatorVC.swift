//
//  RateCalculatorVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Photos
import Toast_Swift
import ScreenShield

class RateCalculatorVC: UIViewController {
    
    @IBOutlet weak var rateRefreshBtn: UIButton!
    @IBOutlet weak var rateCalculatorView: UIView!
    @IBOutlet weak var bankTransferBottomView: UIView!
    @IBOutlet weak var bankTransferBtn: UIButton!
    @IBOutlet weak var cashPickupBtn: UIButton!
    @IBOutlet weak var cashPickupBottomView: UIView!
    @IBOutlet weak var mobileWalletBtn: UIButton!
    @IBOutlet weak var mobileWalletBottomView: UIView!
    @IBOutlet weak var rateCalculatorContentView: UIView!
    @IBOutlet weak var sendingImgView: UIImageView!
    @IBOutlet weak var sendingLbl: UILabel!
    @IBOutlet weak var sendingTF: UITextField!
    @IBOutlet weak var recivingImgView: UIImageView!
    @IBOutlet weak var recivingDownImg: UIImageView!
    @IBOutlet weak var recivingLbl: UILabel!
    @IBOutlet weak var recivingBtn: UIButton!
    @IBOutlet weak var recivingTF: UITextField!
    @IBOutlet weak var exchangeBtn: UIButton!
    @IBOutlet weak var exchangeRateLbl: UILabel!
    @IBOutlet weak var rateCountryTableView: UITableView!
    @IBOutlet weak var rateExpandingView: UIView!
    @IBOutlet weak var rateViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rateBaseView: UIView!
    
    
    @IBOutlet var sendamountlabel: UILabel!
    
    @IBOutlet var receiveamountlabel: UILabel!
    
    
    @IBOutlet var exchangeratelabel: UILabel!
    
    var expandToggle = false
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var selectedRateCalculator:RateCalculator = .bankTransfer
    var serviceType: String = ""
    var rateCountryList:[CasmexRateCalcCountry] = []
    let transparentView = UIView()
    var divCount = 0
    var viewHeight = 0
    var selectedRate:CasmexRateCalcCountry?
    var amountType:String = ""
    var amount:String = "0"
    var rateDetails:CasmexRateDetails?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rateCountryTableView?.register(UINib.init(nibName: "RateCountryListTableViewCell", bundle: .main), forCellReuseIdentifier: "RateCountryListTableViewCell")
        
        rateCountryTableView.delegate = self
        rateCountryTableView.dataSource = self
        setView()
        addNavbar()
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
//        ScreenShield.shared.protect(view: self.)
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
    @IBAction func rateRefreshBtnTapped(_ sender: Any) {
        print("rateRefreshBtnTapped")
        selectedRateCalculator = .bankTransfer
        changeRateCalclContent()
        rateCountryList.removeAll()
        recivingTF.text = ""
        sendingTF.text = ""
        recivingImgView.image = UIImage(named: "default_image")
        recivingLbl.text = "---"
        expandToggle = true
        setDropDownView()
    }
    @IBAction func bankTransferBtnTapped(_ sender: Any) {
        selectedRateCalculator = .bankTransfer
        recivingTF.text = ""
        sendingTF.text = ""
        changeRateCalclContent()
    }
    @IBAction func cashPickupBtnTapped(_ sender: Any) {
        selectedRateCalculator = .cashPickup
        recivingTF.text = ""
        sendingTF.text = ""
        changeRateCalclContent()
    }
    @IBAction func mobileWalletBtnTapped(_ sender: Any) {
        selectedRateCalculator = .mobileWallet
        recivingTF.text = ""
        sendingTF.text = ""
        changeRateCalclContent()
    }
    @IBAction func recivingCountryBtnTapped(_ sender: Any) {
        print("recivingCountryBtnTapped")
        setDropDownView()
    }
    @IBAction func exchangeBtnTapped(_ sender: Any) {
        print("exchangeBtnTapped")
        expandToggle = true
        setDropDownView()
        getRateDetails()
    }
    
    //MARK: - Functions
    func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("Rate Calculater", comment: "")
        var notificationIMg = "notification_y"
        if notificationCount{
            notificationIMg = "notification_y"
        }else{
            notificationIMg = "notification_n"
        }
        let notificationBtn = UIBarButtonItem(image: UIImage(named: notificationIMg), style: .done, target: self, action: #selector(notificationAction))
        let helpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItems  = [helpBtn, notificationBtn]
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
        
        rateViewHeight.constant = 40
        rateExpandingView.isHidden = true
        exchangeRateLbl.isHidden = true
//        recivingImgView.contentMode = .scaleAspectFit
        rateRefreshBtn.setTitle("", for: .normal)
        rateRefreshBtn.setImage(UIImage(named: "reload_icon 1"), for: .normal)
        rateRefreshBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rateRefreshBtn.imageView?.contentMode = .scaleAspectFit
        bankTransferBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("BankTransfer", comment: ""), size: 10, font: .semiBold), for: .normal)
        cashPickupBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("cash_pickup", comment: ""), size: 10, font: .semiBold), for: .normal)
        mobileWalletBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("Mobile Wallet", comment: ""), size: 10, font: .semiBold), for: .normal)
        //        rateRefreshBtn.tintColor = UIColor(named: "color_red")
        recivingBtn.setAttributedTitle(buttonTitleSet(title: "", size: 10, font: .semiBold), for: .normal)
        exchangeBtn.setAttributedTitle(buttonTitleSet(title: "", size: 10, font: .semiBold), for: .normal)
        rateCalculatorView.layer.cornerRadius = 10
        rateCalculatorView.layer.borderWidth = 1
        rateCalculatorView.layer.borderColor = UIColor.rgba(19, 56, 82, 0.1).cgColor
        rateCalculatorView.clipsToBounds = true
        changeRateCalclContent()
        addShadow(view: rateCalculatorView)
        
        sendamountlabel.text = NSLocalizedString("sending_amount", comment: "")
        receiveamountlabel.text = NSLocalizedString("receiving_amount", comment: "")
        exchangeratelabel.text = NSLocalizedString("Exhange rates are indicatve and are subject to change", comment: "")
        
    }
    func setRateData(){
        
        loadCountryFlag(for: rateCountryList[0].countryCode, into: recivingImgView)
        recivingLbl.text = rateCountryList[0].currencyCode
        selectedRate = rateCountryList[0]
    }
    func changeRateCalclContent(){
        expandToggle = true
        setDropDownView()
        switch selectedRateCalculator {
        case .bankTransfer:
            serviceType = "CREDIT"
            bankTransferBottomView.isHidden = false
            mobileWalletBottomView.isHidden = true
            cashPickupBottomView.isHidden = true
            bankTransferBtn.tintColor = colorRed
            cashPickupBtn.tintColor = .black
            mobileWalletBtn.tintColor = .black
            
        case .cashPickup:
            serviceType = "CASH"
            bankTransferBottomView.isHidden = true
            mobileWalletBottomView.isHidden = true
            cashPickupBottomView.isHidden = false
            cashPickupBtn.tintColor = colorRed
            bankTransferBtn.tintColor = .black
            mobileWalletBtn.tintColor = .black
            
        case .mobileWallet:
            serviceType = "CASH_TO_MOBILE"
            bankTransferBottomView.isHidden = true
            mobileWalletBottomView.isHidden = false
            cashPickupBottomView.isHidden = true
            mobileWalletBtn.tintColor = colorRed
            bankTransferBtn.tintColor = .black
            cashPickupBtn.tintColor = .black
        }
        self.getRateCountries()
        
    }
    
    
    func setDropDownView(){
        exchangeRateLbl.isHidden = true
        expandToggle.toggle()
        rateCountryTableView.reloadData()
        if expandToggle{
            var viewHeight = 0
            divCount = rateCountryList.count
            if divCount > 4{
                viewHeight = 155
            }else{
                viewHeight = Int(divCount * 40 + 40)
            }
            rateBaseView.layer.cornerRadius = 4
            rateBaseView.layer.borderWidth = 1
            rateBaseView.layer.borderColor = UIColor.rgba(242, 242, 242, 1).cgColor
            
            rateExpandingView.isHidden = false
            recivingDownImg.isHidden = true
            rateViewHeight.constant = CGFloat(viewHeight)
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()
                addShadow(view: self.rateBaseView)
            }
        }else{
            rateViewHeight.constant = 40
            rateBaseView.layer.cornerRadius = 0
            rateBaseView.layer.borderWidth = 0
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.sendingTF.resignFirstResponder()
                self.recivingTF.resignFirstResponder()
                self.sendingTF.text?.removeAll()
                self.recivingTF.text?.removeAll()
                self.rateExpandingView.isHidden = true
                self.recivingDownImg.isHidden = false
                removeShadow(view: self.rateBaseView)
            }
        }
    }
    func getRateDetails(){
        if sendingTF.text == "" && recivingTF.text == ""{
            showAlert(title: "ERROR", message: "Please enter amount in one field")
        }else if sendingTF.text != "" && recivingTF.text != ""{
            showAlert(title: "ERROR", message: "Please fill in only one field with the amount")
        }else {
            if sendingTF.text == ""{
                amountType = "F"
                amount = recivingTF.text ?? "0"
            }else{
                amountType = "L"
                amount = sendingTF.text ?? "0"
            }
            getRates()
        }
    }
    func setRateDetails(){
        exchangeRateLbl.isHidden = false
        sendingTF.text = rateDetails?.lcyAmount
        recivingTF.text = rateDetails?.fcyAmount
//        let divRate = rateDetails?.divRate ?? "0"
//        var trimmedDivRate:String = "0.00"
//        if let divRateDouble = Double(divRate) {
//            trimmedDivRate = String(format: "%.2f", divRateDouble)
//        } else {
//            print("Invalid number format")
//        }
        exchangeRateLbl.text = "1 QAR = \(rateDetails?.divRate ?? "0") \(selectedRate?.currencyCode ?? "") "
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
    //MARK: - API Calls
    func getRateCountries(){
        rateCountryList.removeAll()
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        self.bankNameBtn.setTitle(NSLocalizedString("bank_name1", comment: ""), for: .normal)
        
        let url = ge_api_url_new + "shiftservice/getRateCountries"
        let params:Parameters =  [
            "serviceType":serviceType
        ]
        
        print("URL getRateCountries",url)
        print("params getRateCountries",params)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("getRateCountries resp",response)
            self.effectView.removeFromSuperview()
            if let resultArray = myResult?["data"]{
                for i in resultArray.arrayValue{
                    let rateList = CasmexRateCalcCountry(countryCode:  i["countryCode"].stringValue, countryName:  i["countryName"].stringValue, currencyCode:  i["currencyCode"].stringValue, currencyName:  i["currencyName"].stringValue)
                    self.rateCountryList.append(rateList)
                    self.setRateData()
                }
//                response code 400 back to base
            }
            
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
        })
    }
    
    func getRates(){
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "shiftservice/getRates"
        let params:Parameters =  [
            "serviceType":serviceType,
            "amountType":amountType,
            "amount":amount,
            "currencyCode":selectedRate?.currencyCode,
            "countryCode":selectedRate?.countryCode
        ]
        
        print("URL getRates",url)
        print("params getRates",params)
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("getRates resp",response)
            self.effectView.removeFromSuperview()
            if let statusCode = myResult?["statusCode"]{
                if statusCode == "200"{
                    let rate = CasmexRateDetails(statusCode: myResult?["statusCode"].rawValue as! String,
                                                 statusMessage: myResult?["statusMessage"].rawValue as! String,
                                                 fcyAmount: myResult?["fcyAmount"].rawValue as! String,
                                                 lcyAmount: myResult?["lcyAmount"].rawValue as! String,
                                                 mulRate: myResult?["mulRate"].rawValue as! String,
                                                 divRate: myResult?["divRate"].rawValue as! String,
                                                 charge: myResult?["charge"].rawValue as! String,
                                                 vat: myResult?["vat"].rawValue as! String)
                    self.rateDetails = rate
                    self.setRateDetails()
                }else{
                    showAlert(title: "ERROR", message: "Error loading data \n Please try again")
                }
            }
            //            self.timerGesture.isEnabled = false
            //            self.resetTimer()
        })
    }
    

}
extension RateCalculatorVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return rateCountryList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "RateCountryListTableViewCell", for: indexPath) as! RateCountryListTableViewCell
            cell.countryLbl.text = rateCountryList[indexPath.row].currencyCode
            cell.setData(code: rateCountryList[indexPath.row].countryCode)
            return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            setDropDownView()
            selectedRate = rateCountryList[indexPath.row]
            recivingLbl.text = selectedRate?.currencyCode
            loadCountryFlag(for: selectedRate?.countryCode ?? "", into: recivingImgView)
    }
}
