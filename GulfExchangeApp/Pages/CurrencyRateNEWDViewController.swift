//
//  CurrencyRateNEWDViewController.swift
//  GulfExchangeApp
//
//  Created by MACBOOK PRO on 06/09/22.
//  Copyright © 2022 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class CurrencyRateNEWDViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var servicetypestr:String = ""
    
    let flag_urln:String = "https://gulfexchange.com.qa/storage/datafolder/flags/flags-medium/";
    
    var isClicked = false
    
    var countryArray = [country]()
    
    //searching
    var searching = false
    var searchedCountry = [country]()
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    var timer = Timer()
    var timerGesture = UITapGestureRecognizer()

    let defaults = UserDefaults.standard
    
    //new drop
    
    
    @IBOutlet var countrybackview: UIView!
    
    
    @IBOutlet var countryview: UIView!
    
    
    
    @IBOutlet var countrysearchtxtfd: UITextField!
    
    
    
    @IBAction func editsearchtextfd(_ sender: Any)
    {
       print("i","222")
//        let searchTxt = self.countrysearchtxtfd.text!
//
//        if !searchTxt.isEmpty {
//            searching = true
//            searchedCountry.removeAll()
//            for item in countryArray {
//                if item.countryName.lowercased().hasPrefix(searchTxt.lowercased()) {
//
//                    searchedCountry.append(item)
//                }
//            }
//        }
//        else {
//            searching = false
//            searchedCountry.removeAll()
//            searchedCountry = countryArray
//        }
//        countrytableview.reloadData()
    }
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        print("didchange","1")
        let searchTxt = self.countrysearchtxtfd.text!
        
        if !searchTxt.isEmpty {
            searching = true
            searchedCountry.removeAll()
            for item in countryArray {
                if item.countryName.lowercased().hasPrefix(searchTxt.lowercased()) {
                    
                    searchedCountry.append(item)
                }
            }
        }
        else {
            searching = false
            searchedCountry.removeAll()
            searchedCountry = countryArray
        }
        countrytableview.reloadData()
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("cleartxtfd","2")
        self.countrysearchtxtfd.resignFirstResponder()
        self.countrysearchtxtfd.text = ""
        self.searchedCountry.removeAll()
        countrytableview.reloadData()
        return true
    }

    
    
    
    @IBOutlet var countrytableview: UITableView!
    
    
    
    @IBOutlet var bottomlastlabel: UILabel!
    
    
    @IBOutlet var oneqataequalview: UIView!
    
    
    @IBOutlet var mainview: UIView!
    
    
    @IBOutlet var rateview: UIView!
    
    
    
    @IBOutlet var qatarimageview: UIImageView!
    
    
    @IBOutlet var recivecurrencyimageview: UIImageView!
    
    
    
    @IBOutlet var segmentview: UIView!
    
    
    @IBOutlet var qatarcurrencylabel: UILabel!
    
    @IBOutlet var receivecurrencylabel: UILabel!
    
    
    
    
    
    
    
    @IBOutlet var acctransferbtn: UIButton!
    
    
    
    @IBAction func acctransferbtnact(_ sender: Any)
    {
        self.servicetypestr = "CREDIT"
        
    
        self.countrysearchtxtfd.text = ""
        
        self.oneqataequalview.isHidden = true
        self.qatarcurrencylabel.isHidden = true
        self.receivecurrencylabel.isHidden = true
        self.recivecurrencyimageview.isHidden = true
        self.bottomlastlabel.isHidden = true
        receivcurrencybtn.setTitle("Select Curency", for: .normal)
        
        acctransferbtn.backgroundColor = UIColor.white
        if #available(iOS 13.0, *) {
            cashpickupbtn.backgroundColor = UIColor.systemGray5
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            cashtomobilebtn.backgroundColor = UIColor.systemGray5
        } else {
            // Fallback on earlier versions
        }
        
        self.acctransferbtn.setTitleColor(.systemRed, for: .normal)
        self.cashpickupbtn.setTitleColor(.darkGray, for: .normal)
        self.cashtomobilebtn.setTitleColor(.darkGray, for: .normal)

        self.timerGesture.isEnabled = false
        getratecountryapi()
        
    }
    
    @IBOutlet var cashpickupbtn: UIButton!
    
    
    @IBAction func cashpickupbtnact(_ sender: Any)
    {
        self.servicetypestr = "CASH"
        
        self.countrysearchtxtfd.text = ""
        

        
        self.oneqataequalview.isHidden = true
        self.qatarcurrencylabel.isHidden = true
        self.receivecurrencylabel.isHidden = true
        self.recivecurrencyimageview.isHidden = true
        self.bottomlastlabel.isHidden = true
        
        receivcurrencybtn.setTitle("Select Curency", for: .normal)
        
        if #available(iOS 13.0, *) {
            acctransferbtn.backgroundColor = UIColor.systemGray5
        } else {
            // Fallback on earlier versions
        }
        cashpickupbtn.backgroundColor = UIColor.white
        if #available(iOS 13.0, *) {
            cashtomobilebtn.backgroundColor = UIColor.systemGray5
        } else {
            // Fallback on earlier versions
        }
        
        self.acctransferbtn.setTitleColor(.darkGray, for: .normal)
        self.cashpickupbtn.setTitleColor(.systemRed, for: .normal)
        self.cashtomobilebtn.setTitleColor(.darkGray, for: .normal)

        self.timerGesture.isEnabled = false
        getratecountryapi()

    }
    
    
    
    @IBOutlet var cashtomobilebtn: UIButton!
    
    
    @IBAction func cashtomobilebtnact(_ sender: Any)
    {
        self.servicetypestr = "CASH_TO_MOBILE"
        

        self.countrysearchtxtfd.text = ""
        
        self.oneqataequalview.isHidden = true
        self.qatarcurrencylabel.isHidden = true
        self.receivecurrencylabel.isHidden = true
        self.recivecurrencyimageview.isHidden = true
        self.bottomlastlabel.isHidden = true
        
        receivcurrencybtn.setTitle("Select Curency", for: .normal)
        
        if #available(iOS 13.0, *) {
            acctransferbtn.backgroundColor = UIColor.systemGray5
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            cashpickupbtn.backgroundColor = UIColor.systemGray5
        } else {
            // Fallback on earlier versions
        }
        cashtomobilebtn.backgroundColor = UIColor.white
        
        self.acctransferbtn.setTitleColor(.darkGray, for: .normal)
        self.cashpickupbtn.setTitleColor(.darkGray, for: .normal)
        self.cashtomobilebtn.setTitleColor(.systemRed, for: .normal)

        self.timerGesture.isEnabled = false
        getratecountryapi()

    }
    
    @IBOutlet var firstview: UIView!

    
    @IBOutlet var qatarrialbtn: UIButton!
    
    
    
    @IBAction func qatarrialbtnact(_ sender: Any)
    {
        print("qatar","")
    }
    
    @IBOutlet var secondview: UIView!
    
    
    
    @IBOutlet var receivcurrencybtn: UIButton!
    
    
    
    @IBAction func receivcurrencybtnact(_ sender: Any)
    {
        print("recivecureqatarseldrop","")
        
        self.timerGesture.isEnabled = false
        
        countrybackview.isHidden = false
        countryview.isHidden = false
        self.countrytableview.reloadData()
    }
    
    
    
    @IBOutlet var oneqarlabel: UILabel!
    
    
    
    //test
    static let AlamoFireManager: Alamofire.Session = {
        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
//
    //production
//          static let AlamoFireManager: Alamofire.Session = {
//        //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
//                let configuration = URLSessionConfiguration.af.default
//                return Session(configuration: configuration)
//        //        return Session(configuration: configuration, serverTrustManager: manager)
//            }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if #available(iOS 13.0, *) {
//            //overrideUserInterfaceStyle = .light
//
//        } else {
//            // Fallback on earlier versions
//        }
        
        self.servicetypestr = "CREDIT"
        
        
        
        timer.invalidate()
        self.timerGesture.isEnabled = true

        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)
        
        

        
        self.oneqataequalview.isHidden = true
        self.qatarcurrencylabel.isHidden = true
        self.receivecurrencylabel.isHidden = true
        self.recivecurrencyimageview.isHidden = true
        self.bottomlastlabel.isHidden = true
        
        firstview.layer.borderWidth = 1
        self.firstview.layer.borderColor = UIColor.red.cgColor
        self.firstview.layer.cornerRadius = 10.0
        secondview.layer.borderWidth = 1
        self.secondview.layer.borderColor = UIColor.red.cgColor
        self.secondview.layer.cornerRadius = 10.0
        oneqataequalview.layer.borderWidth = 1
        self.oneqataequalview.layer.borderColor = UIColor.red.cgColor
        
        countrysearchtxtfd.delegate = self
        
        
        countrysearchtxtfd.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            countrysearchtxtfd.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }

        
        countryview.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            countryview.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Fallback on earlier versions
        }
        countrybackview.isHidden = true
        countryview.isHidden = true
        self.countryview.layer.cornerRadius = 12.0
        
        self.oneqataequalview.layer.cornerRadius = 12.0
        //self.oneqataequalview.layer.borderWidth = 1.0
       // if #available(iOS 13.0, *) {
         //   self.oneqataequalview.layer.borderColor = UIColor.systemGray5.cgColor
        //} else {
            // Fallback on earlier versions
       // }

        
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
            //searchTextField.textAlignment = .right
        } else {
           // searchTextField.textAlignment = .left
        }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("currency_rate", comment: "")
//
        
        self.rateview.layer.cornerRadius = 12.0
        
        self.segmentview.layer.cornerRadius = 18.0
        self.segmentview.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            self.segmentview.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
        
        self.acctransferbtn.setTitleColor(.systemRed, for: .normal)
        self.cashpickupbtn.setTitleColor(.darkGray, for: .normal)
        self.cashtomobilebtn.setTitleColor(.darkGray, for: .normal)
        
        self.acctransferbtn.layer.cornerRadius = 18.0
        self.acctransferbtn.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            self.acctransferbtn.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }

        
        acctransferbtn.backgroundColor = UIColor.white
        if #available(iOS 13.0, *) {
            cashpickupbtn.backgroundColor = UIColor.systemGray5
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            cashtomobilebtn.backgroundColor = UIColor.systemGray5
        } else {
            // Fallback on earlier versions
        }
        
        self.cashpickupbtn.layer.cornerRadius = 18.0
        self.cashpickupbtn.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            self.cashpickupbtn.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }


        self.cashtomobilebtn.layer.cornerRadius = 18.0
        self.cashtomobilebtn.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            self.cashtomobilebtn.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
        
//                rateview.layer.contentsScale = UIScreen.main.scale;
//                rateview.layer.shadowColor = UIColor.darkGray.cgColor;
//                //mainnview.layer.shadowOffset = CGSizeZero;
//                rateview.layer.shadowRadius = 4.0;
//                rateview.layer.shadowOpacity = 0.5;
//                rateview.layer.masksToBounds = false;
//                rateview.clipsToBounds = false;
        
        rateview.layer.shadowColor = UIColor.darkGray.cgColor
        rateview.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        rateview.layer.shadowRadius = 5.0
        rateview.layer.shadowOpacity = 0.5
        
        getratecountryapi()
        //segmentview.backgroundColor = UIColor.lightGray.cgColor
        

        // Do any additional setup after loading the view.
        
        if #available(iOS 13.0, *) {
           // overrideUserInterfaceStyle = .light
            
            
            if( self.traitCollection.userInterfaceStyle == .dark ){
                 //is dark
                overrideUserInterfaceStyle = .light
                
                self.segmentview.layer.borderColor = UIColor.lightGray.cgColor
                self.acctransferbtn.layer.borderColor = UIColor.lightGray.cgColor
                self.cashpickupbtn.layer.borderColor = UIColor.lightGray.cgColor
                self.cashtomobilebtn.layer.borderColor = UIColor.lightGray.cgColor
                self.countrysearchtxtfd.layer.borderColor = UIColor.lightGray.cgColor
                self.countryview.layer.borderColor = UIColor.lightGray.cgColor
                self.acctransferbtn.layer.borderWidth = 0.1
                self.cashpickupbtn.layer.borderWidth = 0.1
                self.cashtomobilebtn.layer.borderWidth = 0.1
                
              }else{
                  //is light
                  if #available(iOS 13.0, *) {
                     // overrideUserInterfaceStyle = .light
                      self.segmentview.layer.borderColor = UIColor.systemGray4.cgColor
                      self.acctransferbtn.layer.borderColor = UIColor.systemGray4.cgColor
                      self.cashpickupbtn.layer.borderColor = UIColor.systemGray4.cgColor
                      self.cashtomobilebtn.layer.borderColor = UIColor.systemGray4.cgColor
                      self.countrysearchtxtfd.layer.borderColor = UIColor.systemGray4.cgColor
                      self.countryview.layer.borderColor = UIColor.systemGray4.cgColor
                  }
              }
            
        } else {
            // Fallback on earlier versions
        }
        
        
        countrysearchtxtfd.addTarget(self, action: #selector(CurrencyRateNEWDViewController.textFieldDidChange(_:)), for: .editingChanged)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    
    @objc func userIsInactive() {
        // Alert user
        
        
//        let alert = UIAlertController(title: "You have been inactive for 5 minutes. We're going to log you off for security reasons.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
//        //Log user off
//        }))
//        present(alert, animated: true)
        
        
        
       // anotherMethod()
        
        timer.invalidate()

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
        //
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
                self.navigationController?.pushViewController(nextViewController, animated: true)


        timer.invalidate()
        
        return
     }

    @objc func resetTimer() {
        print("Reset")
        
        
        
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }

    
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getratecountryapi() {
        self.countryArray.removeAll()
        self.countrytableview.reloadData()
        
        
        
        self.countryArray.removeAll()
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = "https://78.100.141.203:8181/gecomobileapi/shiftservice/getRateCountries"
        let params:Parameters = ["serviceType":self.servicetypestr]

        CurrencyRateNEWDViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("Data list getRateCountries:  ",response)
            
            
            
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                for i in myResult!.arrayValue{
                    let countryDtls = country(countryCode: i["countryCode"].stringValue, countryName: i["countryName"].stringValue, currencyname: i["currencyname"].stringValue,currencyCode: i["currencyCode"].stringValue,currencyCodetwolet: i["countryCode2"].stringValue)
                    print("countryDetails: \(countryDtls)")
                    self.countryArray.append(countryDtls)
//
                }
                self.countrytableview.reloadData()
              break
            case .failure:
                break
            }
          })
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
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }

    
    //tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searching {
            return searchedCountry.count
        }
        else {
            return countryArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CountryRateTableViewCell
        
        cell.layoutMargins = UIEdgeInsets.zero

        cell.preservesSuperviewLayoutMargins = false
        
        if searching {
            cell.currencyName.text = searchedCountry[indexPath.row].countryName + " " + "(" + searchedCountry[indexPath.row].currencyCode + ")"
            
            let url = flag_urln + self.searchedCountry[indexPath.row].currencyCodetwolet.lowercased() + ".png"
           // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
            let imgResource = URL(string: url)
            cell.countryimageviewdop.kf.setImage(with: imgResource)
            
            
        }
        else {
        cell.currencyName.text = countryArray[indexPath.row].countryName + " " + "(" + countryArray[indexPath.row].currencyCode + ")"
            
            let url = flag_urln + self.countryArray[indexPath.row].currencyCodetwolet.lowercased() + ".png"
           // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
            let imgResource = URL(string: url)
            cell.countryimageviewdop.kf.setImage(with: imgResource)
            
        }
        return cell

        
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //getting rate from parameters saved in countryArray
        
        self.timerGesture.isEnabled = false
         
        let url = "https://78.100.141.203:8181/gecomobileapi/shiftservice/getRates"
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        if searching {
            receivcurrencybtn.setTitle(searchedCountry[indexPath.row].countryName + "(" + searchedCountry[indexPath.row].currencyCode + ")", for: .normal)
            let params:Parameters = ["serviceType":self.servicetypestr, "countryCode":searchedCountry[indexPath.row].countryCode, "countryName":searchedCountry[indexPath.row].countryName, "currencyname":searchedCountry[indexPath.row].currencyname, "currencyCode":searchedCountry[indexPath.row].currencyCode, "customerIdNo":"1234567"]
            print("params listserch:  ",params)
            
            CurrencyRateNEWDViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                print("Data list getRates:  ",response)
                    let myResult = try? JSON(data: response.data!)
                    if myResult != 0 {
                        self.oneqarlabel.text = "1 QAR" + "  = " + " " + myResult!["rate"].stringValue + " " + self.searchedCountry[indexPath.row].currencyCode
                        self.receivecurrencylabel.text = myResult!["rate"].stringValue
                        
//                        if myResult!["serviceProvider"].stringValue.isEmpty
//                        {
//                            self.bottomlastlabel.text = ""
//                        }
//                        else
//                        {
                        
                        //self.bottomlastlabel.text = "The rate is for " + myResult!["serviceProvider"].stringValue + ".,Its subject to change for other sevice provider "
                        self.bottomlastlabel.text = "Exchange rates are subject to change. Please check your exchange rate carefully before confirming transaction. "
                        //}
                        
                        self.oneqataequalview.isHidden = false
                        self.qatarcurrencylabel.isHidden = false
                        self.receivecurrencylabel.isHidden = false
                        self.bottomlastlabel.isHidden = false
                        
                        self.recivecurrencyimageview.isHidden = false

                        self.effectView.removeFromSuperview()
                    }
                    else {
                        print("Error")
                        self.effectView.removeFromSuperview()
                }
                
                
                let url = self.flag_urln + self.searchedCountry[indexPath.row].currencyCodetwolet.lowercased() + ".png"
                // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                let imgResource = URL(string: url)
                self.recivecurrencyimageview.kf.setImage(with: imgResource)
              }
            
            )
        }
        
        else {
            receivcurrencybtn.setTitle(countryArray[indexPath.row].countryName + "(" + countryArray[indexPath.row].currencyCode + ")", for: .normal)
            let params:Parameters = ["serviceType":self.servicetypestr, "countryCode":countryArray[indexPath.row].countryCode, "countryName":countryArray[indexPath.row].countryName, "currencyname":countryArray[indexPath.row].currencyname, "currencyCode":countryArray[indexPath.row].currencyCode, "customerIdNo":"1234567"]
            print("params list:  ",params)
            
            CurrencyRateNEWDViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                print("Data list:  ",response)
                    let myResult = try? JSON(data: response.data!)
                    if myResult != 0 {
                        self.oneqarlabel.text = "1 QAR" + "  = " + " " + myResult!["rate"].stringValue + " " + self.countryArray[indexPath.row].currencyCode
                        self.receivecurrencylabel.text = myResult!["rate"].stringValue
                        
//                        if myResult!["serviceProvider"].stringValue.isEmpty
//                        {
//                            self.bottomlastlabel.text = ""
//                        }
//                        else
//                        {
                        
                       // self.bottomlastlabel.text = "The rate is for " + myResult!["serviceProvider"].stringValue + ".,Its subject to change for other sevice provider "
                            
                        self.bottomlastlabel.text = "Exchange rates are subject to change. Please check your exchange rate carefully before confirming transaction. "
                        //}

                        self.oneqataequalview.isHidden = false
                        self.qatarcurrencylabel.isHidden = false
                        self.receivecurrencylabel.isHidden = false
                        self.bottomlastlabel.isHidden = false
                        
                        self.recivecurrencyimageview.isHidden = false
                        
                        self.effectView.removeFromSuperview()
                    }
                    else {
                        print("Error")
                        self.effectView.removeFromSuperview()
                }
                
                
                let url = self.flag_urln + self.countryArray[indexPath.row].currencyCodetwolet.lowercased() + ".png"
                // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                let imgResource = URL(string: url)
                self.recivecurrencyimageview.kf.setImage(with: imgResource)
                
              })
        }
        
        self.timerGesture.isEnabled = false
        
        countrybackview.isHidden = true
        countryview.isHidden = true
        
        searching = false
        self.countrysearchtxtfd.text = ""
        
        self.timerGesture.isEnabled = true
        resetTimer()

    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
