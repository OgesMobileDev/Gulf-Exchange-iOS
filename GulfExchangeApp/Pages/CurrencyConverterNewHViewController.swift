//
//  CurrencyConverterNewHViewController.swift
//  GulfExchangeApp
//
//  Created by test on 08/10/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import ScreenShield

class CurrencyConverterNewHViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    
    var activeTextField = UITextField()
    
    var timer = Timer()
    var timerGesture = UITapGestureRecognizer()
    //var screenShield: ScreenShield?
    
    @IBOutlet weak var sendAmountTextField: UITextField!
    @IBOutlet weak var currency1Lbl: UITextField!
    @IBOutlet weak var flag1Lbl: UIImageView!
    @IBOutlet weak var recipientLbl: UILabel!
    @IBOutlet weak var receivingAmountTextField: UITextField!
    @IBOutlet weak var currency2Lbl: UITextField!
    @IBOutlet weak var flag2Lbl: UIImageView!
    @IBOutlet weak var payLbl: UILabel!
    @IBOutlet weak var debitCardLbl: UILabel!
    @IBOutlet weak var promoCodeLbl: UILabel!
    @IBOutlet weak var transferAmountLbl: UILabel!
    @IBOutlet weak var transferAmountLbl1: UILabel!
    @IBOutlet weak var transferFeeLbl: UILabel!
    @IBOutlet weak var transferFeeLbl1: UILabel!
    @IBOutlet weak var promoLbl: UILabel!
    @IBOutlet weak var promoLbl1: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var totalLbl1: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var viewAmount1: UIView!
    @IBOutlet weak var viewamount2: UIView!
    
    
    @IBOutlet var hideview: UIView!
    
    @IBOutlet var hideswitchview: UIView!
    
    @IBOutlet var countryseltableview: UITableView!
    
    
    @IBOutlet var mainview: UIView!
    
    var lastbottomstr:String = ""
    
    var retailexchangeratestr:String = ""
    
    var firsttextclickstr:String = ""
    var secondtextclikstr:String = ""
    
    var amounttypeglobstr:String = ""
    
    
    @IBOutlet var convertcurrbtn: UIButton!
    
    @IBAction func convertcurrbtnAction(_ sender: Any)
    {
//        if (!validate (value: self.sendAmountTextField.text!))
//        {
//
//            self.sendAmountTextField.text = ""
//            return
//
//        }
        if amounttypeglobstr  == "F"
        {
            
            //new
            if receivingAmountTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.viewAmount1.layer.borderColor = UIColor.red.cgColor
                self.viewamount2.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.viewAmount1.layer.cornerRadius = 20
                        self.viewAmount1.layer.borderWidth = 1
                        self.viewAmount1.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
                        self.viewamount2.layer.cornerRadius = 20
                        self.viewamount2.layer.borderWidth = 1
                        self.viewamount2.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor

                    }
                    else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                self.viewAmount1.layer.cornerRadius = 20
                self.viewAmount1.layer.borderWidth = 1
                self.viewAmount1.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
                self.viewamount2.layer.cornerRadius = 20
                self.viewamount2.layer.borderWidth = 1
                self.viewamount2.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor

                
            }

            
            guard let amount = receivingAmountTextField.text,receivingAmountTextField.text?.count != 0 else
            {
                
    //                let bottomOffset = CGPoint(x: 0, y: 0)
    //                //OR
    //                //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
    //                self.scrollView.setContentOffset(bottomOffset, animated: true)
                //self.scrollView.setContentOffset(.zero, animated: true)
                
                self.view.makeToast(NSLocalizedString("enter_amount1", comment: ""), duration: 3.0, position: .center)

               // alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_amount1", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }

            
            
            if(receivingAmountTextField.text!.count > 0)
            {
            var charSetseamound = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@#$%+_&'()*,/;<=>?[]^`{|}~)(")
            var string2seamound = receivingAmountTextField.text!

                if let strvalue = string2seamound.rangeOfCharacter(from: charSetseamound)
                {
                    self.sendAmountTextField.text = ""
                    self.receivingAmountTextField.text = ""
                          return
                }
            }
            
            if(receivingAmountTextField.text!.count > 0)
                {
                self.feelookupAmount = receivingAmountTextField.text!
                self.feelookupFrom = ""
                getToken(num: 6)
                }
                else{
                self.sendAmountTextField.text = ""
                self.transferAmountLbl1.text = "0.00 QAR"
                self.transferFeeLbl1.text = "0.00 QAR"
                self.totalLbl1.text = "0.00 QAR"
            }
            
        }
       // if amounttypeglobstr  == "L"
        else
        {
            
            //new
            if sendAmountTextField.text?.isEmpty == true
            {
               // timer.invalidate()
                self.viewamount2.layer.borderColor = UIColor.red.cgColor
                self.viewAmount1.layer.borderColor = UIColor.red.cgColor
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                    if #available(iOS 13.0, *) {
                        self.viewamount2.layer.cornerRadius = 20
                        self.viewamount2.layer.borderWidth = 1
                        self.viewamount2.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
                        self.viewAmount1.layer.cornerRadius = 20
                        self.viewAmount1.layer.borderWidth = 1
                        self.viewAmount1.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor

                        
                    } else {
                        // Fallback on earlier versions
                    }

                }
            }
            else
            {
            
                self.viewamount2.layer.cornerRadius = 20
                self.viewamount2.layer.borderWidth = 1
                self.viewamount2.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
                
                self.viewAmount1.layer.cornerRadius = 20
                self.viewAmount1.layer.borderWidth = 1
                self.viewAmount1.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor

                
            }


    guard let amount = sendAmountTextField.text,sendAmountTextField.text?.count != 0 else
    {
//            let bottomOffset = CGPoint(x: 0, y: 0)
//            //OR
//            //let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
//            self.scrollView.setContentOffset(bottomOffset, animated: true)
       // self.scrollView.setContentOffset(.zero, animated: true)
        
        self.view.makeToast(NSLocalizedString("enter_amount1", comment: ""), duration: 3.0, position: .center)
        
        //alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_amount1", comment: ""), action: NSLocalizedString("ok", comment: ""))
        return
    }

        
        if(sendAmountTextField.text!.count > 0)
        {
        var charSetseamound = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@#$%+_&'()*,/;<=>?[]^`{|}~)(")
        var string2seamound = sendAmountTextField.text!

            if let strvalue = string2seamound.rangeOfCharacter(from: charSetseamound)
            {
                self.sendAmountTextField.text = ""
                self.receivingAmountTextField.text = ""
                      return
            }
        }
        
        if(sendAmountTextField.text!.count > 0)
            {
            self.feelookupAmount = sendAmountTextField.text!
            self.feelookupFrom = ""
            getToken(num: 2)
            }
            else{
            self.receivingAmountTextField.text = ""
            self.transferAmountLbl1.text = "0.00 QAR"
            self.transferFeeLbl1.text = "0.00 QAR"
            self.totalLbl1.text = "0.00 QAR"
        }
    }
        
            self.view.endEditing(true)
         }
    
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    var tapGesture = UITapGestureRecognizer()
    
    var droptouchstr : String = ""
    
      var shiftcurrencycodeArray:[Bank] = []
    
    var singlecontry2codearr  = Array<String>()
    var singlecontry2codearrone  = Array<String>()
    var singlecontry2codearrtwo  = Array<String>()
    
    var singlecontry2codearrthree  = Array<String>()
     
     var servicetypestoredstr : String = ""
    var bankcodestoredstr : String = ""
    var citycodestr : String = ""
    var bankcodeserviceprovidercodestr : String = ""
    var countrycodestoredstr : String = ""
    var branchcodestr : String = ""
    
    
    
    
    
    
    var str_country:String = ""
    var str_bank_code:String = ""
    var str_branch_code:String = ""
    var str_first_name:String = ""
    var str_last_name:String = ""
    var str_country_name:String = ""
    var str_bank_name:String = ""
    var str_branch_name:String = ""
    var str_address:String = ""
    var str_city:String = ""
    var str_mobile:String = ""
    var str_acc_no:String = ""
    var str_ifsc:String = ""
    var str_source:String = ""
    var str_purpose:String = ""
    var str_relation:String = ""
    var str_serial_no:String = ""
    
    var str_receiver_country_2_code:String = ""
    var str_receiver_currency_3_letter:String = ""
    var str_receiver_country_3_letter:String = ""
    var str_country_3_letter:String = ""
    
    var totalglobdisplay:String = ""
    
    var priceordercodeglobalstored:String = ""
    
    var retailExchangeRate:String = ""
    var retailExchangeRate1:String = ""
    var fee_amount1:String = ""
    var payout_amount:String = ""
    var feelookupAmount:String = "1"
    var feelookupFrom:String = "qar_to_any"
    var udid:String!
    
    let defaults = UserDefaults.standard
    
    
     //test
        
        static let AlamoFireManager: Alamofire.Session = {
            let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
            let configuration = URLSessionConfiguration.af.default
            return Session(configuration: configuration, serverTrustManager: manager)
        }()
        
        //producton
//          static let AlamoFireManager: Alamofire.Session = {
//        //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
//                let configuration = URLSessionConfiguration.af.default
//                return Session(configuration: configuration)
//        //        return Session(configuration: configuration, serverTrustManager: manager)
//            }()
    
    override func viewDidLoad() {
        //self.receivingAmountTextField.background = UIImage(named: "down_arrow1")
  
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        
              
        
        self.amounttypeglobstr = "L"
        sendAmountTextField.delegate = self
        receivingAmountTextField.delegate = self
        
        let custmBackBtn = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .done, target: self, action: #selector(Backbtnaction))
        self.navigationItem.leftBarButtonItem  = custmBackBtn
        
//        flag2Lbl.layer.cornerRadius = 100
//        flag2Lbl.clipsToBounds = true
//        flag2Lbl.layer.borderWidth = 10
//        flag2Lbl.layer.borderColor = UIColor.lightGray.cgColor
        
        
        flag2Lbl?.layer.cornerRadius = ((flag2Lbl?.frame.size.width)!) / 2
        //flag2Lbl?.layer.cornerRadius = (flag2Lbl?.frame.size.width ?? 0.0) / 2
        flag2Lbl?.clipsToBounds = true
        flag2Lbl?.layer.borderWidth = 3.0
        flag2Lbl?.layer.borderColor = UIColor.white.cgColor
        
        countryseltableview.isHidden =  true
        self.countryseltableview.layer.cornerRadius = 15.0
//        countryseltableview.layer.borderColor = UIColor.lightGray.cgColor
//        countryseltableview.layer.borderWidth = 2.0
        countryseltableview.tableFooterView = UIView()
//
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(RemittancePage2ViewController.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        viewamount2.addGestureRecognizer(tapGesture)
        viewamount2.isUserInteractionEnabled = true
        
        receivingAmountTextField.isUserInteractionEnabled = true
        
       // currency2Lbl
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didRecognizeTapGesture(_:)))

        currency2Lbl.addGestureRecognizer(tapGesture)
        
        
        
        super.viewDidLoad()
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
           sendAmountTextField.textAlignment = .right
           currency1Lbl.textAlignment = .right
           receivingAmountTextField.textAlignment = .right
           currency2Lbl.textAlignment = .right
        } else {
           sendAmountTextField.textAlignment = .left
           currency1Lbl.textAlignment = .left
           receivingAmountTextField.textAlignment = .left
           currency2Lbl.textAlignment = .left
        }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("currency_converter", comment: "")
        nextBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        nextBtn.layer.cornerRadius = 15
        
        convertcurrbtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        convertcurrbtn.layer.cornerRadius = 15
        
//        flag2Lbl.layer.borderWidth = 0
//        flag2Lbl.layer.masksToBounds = true
//        flag2Lbl.layer.borderColor = UIColor.black.cgColor
//        flag2Lbl.layer.cornerRadius = flag2Lbl.frame.height/2
//        flag2Lbl.clipsToBounds = true
        
        
        setFont()
        setFontSize()
        //getValues()
        //NEWHIDE
         getToken(num: 3)
       // getToken(num: 4)
        
       // getCurrencyCode()
       
        
        viewAmount1.layer.cornerRadius = 20
        viewAmount1.layer.borderWidth = 1
        viewAmount1.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        viewamount2.layer.cornerRadius = 20
        viewamount2.layer.borderWidth = 1
        viewamount2.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.87, alpha: 1.00).cgColor
        
        sendAmountTextField.addTarget(self, action: #selector(RemittancePage2ViewController.textFieldDidChange(_:)), for: .editingChanged)
        sendAmountTextField.addTarget(self, action: #selector(RemittancePage2ViewController.textFieldShouldReturn), for: .editingDidEnd)
        
        
        
        //textfieleddonebutton
//        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
//         //create left side empty space so that done button set on right side
//         let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
//         let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "CONVERT", style: .done, target: self, action: #selector(self.doneButtonAction))
//         toolbar.setItems([flexSpace, doneBtn], animated: false)
//         toolbar.sizeToFit()
//       UIBarButtonItem.appearance().tintColor = UIColor.red
//        //doneBtn.setTitleColor(UIColor.black, for: .normal)
//         self.sendAmountTextField.inputAccessoryView = toolbar
        
        
        timer.invalidate()
        self.timerGesture.isEnabled = true

        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

       

    }
    
    override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(true)
       //  Protect ScreenShot
               ScreenShield.shared.protect(view: self.view)
               
               // Protect Screen-Recording
               ScreenShield.shared.protectFromScreenRecording()
       
           }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
        
       // ScreenShieldd.shared.removeProtection()
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

    func anotherMethod() {

        // self.activeTextField.text is an optional, we safely unwrap it here
        if let activeTextFieldText = self.activeTextField.text {
              print("Active text field's text: \(activeTextFieldText)")
              return;
        }

        print("Active text field is empty")
    }

    
//
//    @objc private dynamic func didRecognizeTapGestureone(_ gesture: UITapGestureRecognizer)
//    {
//        let point = gesture.location(in: gesture.view)
//
//
//
//
//
//        guard gesture.state == .ended, receivingAmountTextField.frame.contains(point) else { return }
//
//    }
    
    
    
    @objc func Backbtnaction()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
     @objc private dynamic func didRecognizeTapGesture(_ gesture: UITapGestureRecognizer) {
         let point = gesture.location(in: gesture.view)
         
         
         
         guard gesture.state == .ended, currency2Lbl.frame.contains(point) else { return }

         //donomething()
         print("benfitttt---","noor")
     }
    
    
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {

        print("tapviewnnnn---","tapviewnoor")
       // self.mainview.isUserInteractionEnabled = false
        //self.mainview.removeFromSuperview()
        
       // ScreenShield.shared.removeProtection()
        
        
        print("selarraycount---",self.shiftcurrencycodeArray.count)
     //  if self.shiftcurrencycodeArray.count > 1
       // {
            print("arrayoneplus---","oneplusarray")
            countryseltableview.isHidden =  false
        self.mainview.backgroundColor = UIColor.lightGray
            hideview.isHidden = true
            hideswitchview.isHidden = true
            convertcurrbtn.isHidden = true
           
            //checkcondition 1 or grater
               self.receivingAmountTextField.text = ""
               self.sendAmountTextField.text = ""
               self.transferAmountLbl1.text = "0.00 QAR"
               self.transferFeeLbl1.text = "0.00 QAR"
               self.totalLbl1.text = "0.00 QAR"
            
            self.rateLbl.text = ""
            self.shiftcurrencycodeArray.removeAll()
            self.countryseltableview.reloadData()
        
        var imageView = UIImageView();
        var image = UIImage(named: "downarrowicon.png");
        imageView.image = image;
        self.currency2Lbl.rightView = imageView;
        self.currency2Lbl.rightViewMode = UITextField.ViewMode.always
        self.currency2Lbl.rightViewMode = .always
        
        
        droptouchstr = "click"
        
            getToken(num: 3)
       // }
        

        
     
        
        
        
//        if self.viewamount2.backgroundColor == UIColor.yellow {
//                 self.viewamount2.backgroundColor = UIColor.green
//
//            self.viewamount2.backgroundColor = UIColor.green
//        }else{
//           //  self.viewTap.backgroundColor = UIColor.green
//        }
    }
    
    
    
    
    @objc func doneButtonAction() {
        
        
        if(sendAmountTextField.text!.count > 0)
            {
            self.feelookupAmount = sendAmountTextField.text!
            self.feelookupFrom = ""
            getToken(num: 2)
            }
            else{
            self.receivingAmountTextField.text = ""
            self.transferAmountLbl1.text = "0.00 QAR"
            self.transferFeeLbl1.text = "0.00 QAR"
            self.totalLbl1.text = "0.00 QAR"
        }
        
        
            self.view.endEditing(true)
         }
    
    override func viewWillAppear(_ animated: Bool) {
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        self.validateMultipleLogin()
        
        
    }
    func validateMultipleLogin() {
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            
            let url = api_url + "login_session"
        let params:Parameters = ["id_no":self.defaults.string(forKey: "USERID")!,"session_id":self.udid!]

              AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                self.effectView.removeFromSuperview()
                print("resp1111",response)
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)
                    let code = myresult!["scode"]
                    if(code == 1)
                    {
                        
                    }
                    else if(code == 2)
                    {
                        self.callLogout()
                    }
                    break
                case .failure:
                    break
                
                }
              })
           
        
    }
    func callLogout() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = api_url + "login_session_delete"
        let params:Parameters = ["id_no":self.defaults.string(forKey: "USERID")!,"session_id":udid!]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp2222",response)
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let code = myresult!["scode"]
                
                if(code == 1)
                {
                    self.defaults.set("", forKey: "USERID")
                    self.defaults.set("", forKey: "PASSW")
                    self.defaults.set("", forKey: "PIN")
                    self.defaults.set("", forKey: "REGNO")
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
                    //        self.navigationController?.pushViewController(nextViewController, animated: true)
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                break
            case .failure:
                break
            
            }
          })
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //new
       // timer.invalidate()
        resetTimer()

        
        self.activeTextField = textField
        
            if textField == sendAmountTextField {
                print("sendtxttouch")
                
                firsttextclickstr = "1"
                secondtextclikstr = ""
                print("firsttextclickstr",firsttextclickstr)
                self.amounttypeglobstr = "L"
                
                self.receivingAmountTextField.text = ""
            }
        
        if textField == receivingAmountTextField {
            print("recevetxttouch")
            secondtextclikstr = "1"
            firsttextclickstr = ""
            
            print("secondtextclikstr",secondtextclikstr)
            self.amounttypeglobstr = "F"
            
            self.sendAmountTextField.text = ""
        }
        }
  
     @objc func textFieldShouldReturn(_ textField: UITextField) {
        if(sendAmountTextField.text!.count > 0)
               {
//                   self.feelookupAmount = sendAmountTextField.text!
//                   self.feelookupFrom = ""
//                   getToken(num: 2)
               }
               else{
//                   self.receivingAmountTextField.text = ""
//                   self.transferAmountLbl1.text = "0.00 QAR"
//                   self.transferFeeLbl1.text = "0.00 QAR"
//                   self.totalLbl1.text = "0.00 QAR"
               }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(sendAmountTextField.text!.count > 0)
        {
//            self.feelookupAmount = sendAmountTextField.text!
//            self.feelookupFrom = ""
//            getToken(num: 2)
        }
        else{
//            self.receivingAmountTextField.text = ""
//            self.transferAmountLbl1.text = "0.00 QAR"
//            self.transferFeeLbl1.text = "0.00 QAR"
//            self.totalLbl1.text = "0.00 QAR"
        }
        
        resetTimer()
    }
    @IBAction func nextBtn(_ sender: Any) {
        
        if amounttypeglobstr  == "F"
        {
            print("")
            guard let amount = receivingAmountTextField.text,receivingAmountTextField.text?.count != 0 else
            {
                alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_amount1", comment: ""), action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            if(self.sendAmountTextField.text == "")
            {
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Select convert", action: NSLocalizedString("ok", comment: ""))
                return
            }
            
            
            //new
            if(receivingAmountTextField.text!.count > 0)
                {
                self.feelookupAmount = receivingAmountTextField.text!
                self.feelookupFrom = ""
                getToken(num: 7)
                }
            
            //old
            //self.getToken(num: 1)
            
        }
        else
        {
        
        
        print("")
        guard let amount = sendAmountTextField.text,sendAmountTextField.text?.count != 0 else
        {
            alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_amount1", comment: ""), action: NSLocalizedString("ok", comment: ""))
            return
        }
        
        if(self.receivingAmountTextField.text == "")
        {
            self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: "Select convert", action: NSLocalizedString("ok", comment: ""))
            return
        }
        
      
        
        
        
        //new
        if(sendAmountTextField.text!.count > 0)
            {
            self.feelookupAmount = sendAmountTextField.text!
            self.feelookupFrom = ""
            getToken(num: 5)
            }
        
        //old
        //self.getToken(num: 1)
            
        }
    }
    
    func getValues() {
        self.str_country = defaults.string(forKey: "country_code")!
        self.str_bank_code = defaults.string(forKey: "bank_code")!
        self.str_branch_code = defaults.string(forKey: "branch_code")!
        self.str_first_name = defaults.string(forKey: "first_name")!
        self.str_last_name = defaults.string(forKey: "last_name")!
        self.str_country_name = defaults.string(forKey: "country_name")!
        self.str_bank_name = defaults.string(forKey: "bank_name")!
        self.str_branch_name = defaults.string(forKey: "branch_name")!
        self.str_address = defaults.string(forKey: "address")!
        
        
        servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
        print("servicetypestoredstr2",servicetypestoredstr)
        //crashing
        if servicetypestoredstr == "CASH"||servicetypestoredstr == "CASH_TO_MOBILE"
        {
            
        }
        else
        {
        self.str_city = defaults.string(forKey: "city")!
        }
        self.str_mobile = defaults.string(forKey: "mobile")!
        self.str_acc_no = defaults.string(forKey: "acc_no")!
        self.str_ifsc = defaults.string(forKey: "ifsc")!
        self.str_source = defaults.string(forKey: "source")!
        self.str_purpose = defaults.string(forKey: "purpose")!
        self.str_relation = defaults.string(forKey: "relation")!
        self.str_serial_no = defaults.string(forKey: "serial_no")!
        
        
    }
    func alertMessage(title:String,msg:String,action:String){
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
            }))
            self.present(alert, animated: true)
        }
    func setFont() {
        sendAmountTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        currency1Lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        recipientLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        receivingAmountTextField.font = UIFont(name: "OpenSans-Regular", size: 14)
        currency2Lbl.font =  UIFont(name: "OpenSans-Regular", size: 12)
        payLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        debitCardLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        promoCodeLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        transferAmountLbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        transferAmountLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        transferFeeLbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        transferFeeLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        promoLbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        promoLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        totalLbl.font = UIFont(name: "OpenSans-Bold", size: 14)
        totalLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        nextBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        recipientLbl.font = recipientLbl.font.withSize(14)
        payLbl.font = payLbl.font.withSize(14)
        debitCardLbl.font = debitCardLbl.font.withSize(14)
        promoCodeLbl.font = promoCodeLbl.font.withSize(14)
        transferAmountLbl.font = transferAmountLbl.font.withSize(14)
        transferAmountLbl1.font = transferAmountLbl1.font.withSize(14)
        transferFeeLbl.font = transferFeeLbl.font.withSize(14)
        transferFeeLbl1.font = transferFeeLbl1.font.withSize(14)
        promoLbl.font = promoLbl.font.withSize(14)
        promoLbl1.font = promoLbl1.font.withSize(14)
        totalLbl.font = totalLbl.font.withSize(14)
        totalLbl1.font = totalLbl1.font.withSize(14)
    }
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        CurrencyConverterNewHViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!

                print("token4  ",token)
                if(num == 1)
                {
                    self.amountValidation(access_token: token)
                }
                else if(num == 2)
                {
                    if   self.droptouchstr == "click"
                       {
                        self.timerGesture.isEnabled = false
                    }
//                    else
//                    {
//                        self.timerGesture.isEnabled = false
//                    }

                    
                    self.feelookup(amount: self.feelookupAmount, receCountry: self.str_country_3_letter, receCurrency: self.str_receiver_currency_3_letter, from: self.feelookupFrom, access_token: token)
                    
                    //self.resetTimer()
                    //self.timerGesture.isEnabled = true
                }
                else if(num == 3)
                {
                    self.shiftapipayoutcurrencycodenew(access_token:token)
                    
                    //self.timerGesture.isEnabled = false
                }
                else if(num == 4)
                {
                   // self.shiftapipayoutcurrencycodenewClik(access_token:token)
                }
                
                else if(num == 5)
                {
                    self.feelookupnextbtn(amount: self.feelookupAmount, receCountry: self.str_country_3_letter, receCurrency: self.str_receiver_currency_3_letter, from: self.feelookupFrom, access_token: token)
                }
                else if(num == 6)
                {
                    
                self.feelookupsecondtxtnew(amount: self.feelookupAmount, receCountry: self.str_country_3_letter, receCurrency: self.str_receiver_currency_3_letter, from: self.feelookupFrom, access_token: token)
                    
                }
                else if(num == 7)
                {
                self.feelookupsecondtxtnenextbtn(amount: self.feelookupAmount, receCountry: self.str_country_3_letter, receCurrency: self.str_receiver_currency_3_letter, from: self.feelookupFrom, access_token: token)
                    
                }
                else if(num == 8)
                {
                    self.amountValidationnewrectxt(access_token: token)
                }
                
                
                
                break
            case .failure:
                break
            }
        })
    }
    func amountValidation(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":self.defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"","customerPhone":"","beneficiaryAccountNo":self.defaults.string(forKey: "acc_no")!,"iban":"","customerDOB":"1900-01-01","validationMethod":"PAYIN_AMOUNT","isExistOrValid":self.sendAmountTextField.text!]
        
        print("urlamountvalidation",url)
          print("paramsamountvalidation",params)
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        CurrencyConverterNewHViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            print("resp",response)
            let respCode = myResult!["responseCode"]
            let respMsg = myResult!["responseMessage"]
            
            if(respCode == "E8009")
            {
                if(self.sendAmountTextField.text == "")
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_amount1", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else if(self.receivingAmountTextField.text == "")
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg.stringValue, action: NSLocalizedString("ok", comment: ""))
                }
                else if(Double(self.sendAmountTextField.text!) == 0)
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_amount", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else{
                    self.defaults.set(self.sendAmountTextField.text!, forKey: "amount1")
                    self.defaults.set(self.payout_amount, forKey: "amount2")
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem3") as! RemittancePage3ViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
            else
            {
                self.receivingAmountTextField.text = ""
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg.stringValue, action: NSLocalizedString("ok", comment: ""))
            }
            
        })
    }
    
    
    func amountValidationnewrectxt(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":self.defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"","customerPhone":"","beneficiaryAccountNo":self.defaults.string(forKey: "acc_no")!,"iban":"","customerDOB":"1900-01-01","validationMethod":"PAYIN_AMOUNT","isExistOrValid":self.receivingAmountTextField.text!]
        
        print("urlamountvalidation",url)
          print("paramsamountvalidation",params)
        
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        CurrencyConverterNewHViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            self.effectView.removeFromSuperview()
            print("resp",response)
            let respCode = myResult!["responseCode"]
            let respMsg = myResult!["responseMessage"]
            
            if(respCode == "E8009")
            {
                if(self.sendAmountTextField.text == "")
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_amount1", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else if(self.receivingAmountTextField.text == "")
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg.stringValue, action: NSLocalizedString("ok", comment: ""))
                }
                else if(Double(self.sendAmountTextField.text!) == 0)
                {
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: NSLocalizedString("enter_valid_amount", comment: ""), action: NSLocalizedString("ok", comment: ""))
                }
                else{
                    self.defaults.set(self.sendAmountTextField.text!, forKey: "amount1")
                    self.defaults.set(self.payout_amount, forKey: "amount2")
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem3") as! RemittancePage3ViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
            else
            {
                self.receivingAmountTextField.text = ""
                self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: respMsg.stringValue, action: NSLocalizedString("ok", comment: ""))
            }
            
        })
    }
    
    
    
    func getCurrencyCode() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "nationalities"
        let params:Parameters = ["lang":"en","keyword":""]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("respNationality",response)
            let myResult = try? JSON(data: response.data!)
            let resultArray = myResult!["nationalities_listing"]
            let filePath = myResult!["file_path"].stringValue
            for i in resultArray.arrayValue{
                let countryCode = i["ge_countries_3_code"].stringValue
                if(countryCode == self.str_country)
                {
                    self.str_receiver_country_2_code = i["ge_countries_c_code"].stringValue
                    self.str_receiver_currency_3_letter = i["currency_master_code"].stringValue
                    
                    self.str_country_3_letter = i["ge_countries_3_code"].stringValue
                    
                    // 1.countrycode
                    //2.currencyCode
                    //3 currencyCode
                    
                
                    let url = filePath + self.str_receiver_country_2_code.lowercased() + ".png"
                     print("urlimage",url)
                   // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                    let imgResource = URL(string: url)
                    print("image flag",self.str_receiver_country_2_code.lowercased())
                    self.flag2Lbl.image = UIImage(named: self.str_receiver_country_2_code.lowercased())
//                    self.flag2Lbl.kf.setImage(with: imgResource)
                    self.getToken(num: 2)
                }
            }
            
          })
    }
    
    
    func shiftapipayoutcurrencycodenew(access_token:String) {
       
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
       
        print("code",str_country)
        
        let dateTime:String = getCurrentDateTime()
        //let url = ge_api_url + "shiftservice/showPayoutCurrencies"
        //newurl
        let url = ge_api_url + "shiftservice/showCountryList"
//
        //servicetypestored check
//    let userdefaultsservicetype = UserDefaults.standard
//    if let savedValue = userdefaultsservicetype.string(forKey: "servicetypestoresel"){
//        print("Here you will get saved value")
//       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//        servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
//       print("servicetypestored:\(servicetypestoredstr)")
//
//        } else {
//        servicetypestoredstr = ""
//    print("No value in Userdefault,Either you can save value here or perform other operation")
//    userdefaultsservicetype.set("", forKey: "key")
//    }
//
//
//
//        //servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
//        //print("servicetypestored:\(servicetypestoredstr)")
//
//
//        //let bankcodeserviceprovidercode
//           //str_bank_codeserviceprovidercode check
//        let userdefaultsbankcodeserviceprovidercodestr = UserDefaults.standard
//        if let savedValue = userdefaultsbankcodeserviceprovidercodestr.string(forKey: "str_bank_codeserviceprovidercode"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            bankcodeserviceprovidercodestr = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//           print("bankcodeserviceprovidercodestrstored:\(bankcodeserviceprovidercodestr)")
//
//            } else {
//            bankcodeserviceprovidercodestr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultsbankcodeserviceprovidercodestr.set("", forKey: "key")
//        }
//
//        //bankcodeserviceprovidercodestr = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//        //print("bankcodeserviceprovidercode:\(bankcodeserviceprovidercodestr)")
//
//        //let citycode
//        //city dropcode check
//        let userdefaultscitydrop = UserDefaults.standard
//        if let savedValue = userdefaultscitydrop.string(forKey: "str_bank_citydropcode"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            citycodestr = defaults.string(forKey: "str_bank_citydropcode")!
//           print("citycodestrstored:\(citycodestr)")
//
//            } else {
//            citycodestr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultscitydrop.set("", forKey: "key")
//        }
//
//
//        //citycodestr = defaults.string(forKey: "str_bank_citydropcode")!
//        //print("citydropcode:\(citycodestr)")
//
//        //let branchcode
//        //branch code checdk
//        let userdefaultsbranchcode = UserDefaults.standard
//        if let savedValue = userdefaultsbranchcode.string(forKey: "str_branch_code"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            branchcodestr = defaults.string(forKey: "str_branch_code")!
//           print("branchcodestrstored:\(branchcodestr)")
//
//            } else {
//            branchcodestr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultsbranchcode.set("", forKey: "key")
//        }
//
//
//        //branchcodestr = defaults.string(forKey: "str_branch_code")!
//        //print("branchcode:\(branchcodestr)")
//
//    // let countrycodestored
//
//
//        let userdefaultscountrycodestored = UserDefaults.standard
//        if let savedValue = userdefaultscountrycodestored.string(forKey: "countrycodestored"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            countrycodestoredstr = defaults.string(forKey: "countrycodestored")!
//           print("servicetypestored:\(servicetypestoredstr)")
//
//            } else {
//            countrycodestoredstr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultscountrycodestored.set("", forKey: "key")
//        }
//
        //countrycodestoredstr = defaults.string(forKey: "countrycodestored")!
       // print("countrycodestored:\(countrycodestoredstr)")
        
        
//  let params:Parameters =  ["destinationCountryCode":countrycodestoredstr,"serviceProviderCode":bankcodeserviceprovidercodestr,"serviceType":servicetypestoredstr,"payoutBranchCode":branchcodestr]
//
        //newinput
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerUserID":defaults.string(forKey: "USERID")!,"serviceType":"OMM"]
        
        print("urlpayout:\(url)")
        print("paramspayout:\(params)")
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        CurrencyConverterNewHViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
            
            print("historygetcontryapi",response)
            self.effectView.removeFromSuperview()
            let myResult = try? JSON(data: response.data!)
            let resultArray = myResult!["countryList"]
            
            self.shiftcurrencycodeArray.removeAll()
            
            self.singlecontry2codearr.removeAll()
            self.singlecontry2codearrone.removeAll()
            self.singlecontry2codearrtwo.removeAll()
            self.singlecontry2codearrthree.removeAll()
            
         
            
            for i in resultArray.arrayValue{
                
               i["currencyCode"].stringValue
                 print("resppayout",i["currencyCode"].stringValue)
                self.singlecontry2codearr.append(i["currencyCode"].stringValue)
                self.singlecontry2codearrone.append(i["currencyName"].stringValue)
                self.singlecontry2codearrtwo.append(i["countryCodeTL"].stringValue)
                self.singlecontry2codearrthree.append(i["countryCode"].stringValue)
                
                
                let bank = Bank(bankAddress: i["currencyCode"].stringValue, bankCode: i["bankCode"].stringValue, bankName: i["countryName"].stringValue, bankcitytype: i["countryCodeTL"].stringValue,Accountnolength: i["requiredBranch"].stringValue,Mobnolength: i["countryCode"].stringValue,ifscnolength: i["countryCode"].stringValue,Minaccnolength: i["countryCode"].stringValue)
                self.shiftcurrencycodeArray.append(bank)
            }
            
            if self.shiftcurrencycodeArray.isEmpty == true
            {
               // self.timerGesture.isEnabled = true
              print("emptyarraii","emptyarra")
           // self.showToast(message: NSLocalizedString("no_data_available", comment: ""), font: .systemFont(ofSize: 20.0))
                self.alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("no_data_available", comment: ""), action: NSLocalizedString("ok", comment: ""))
            }
            else
            {
             
             
                print("singlee:\(self.singlecontry2codearr[1])")
                let stringcurency3code = String(self.singlecontry2codearr[1])

                print("singleestr:\(stringcurency3code)")
                let stringcountry2code = String(self.singlecontry2codearrtwo[1])
                
                //new
                let stringcurency4code = String(self.singlecontry2codearrthree[1])

                print("newcountry3:\(stringcurency4code)")
                
                self.str_receiver_country_2_code = stringcountry2code
                self.str_receiver_currency_3_letter = stringcurency3code
                
//                let countrycodestored   = self.defaults.string(forKey: "countrycodestored")!
//                print("countrycodestored:\(countrycodestored)")
//
                
                
                //newww
                self.str_receiver_currency_3_letter = stringcurency3code
                self.str_receiver_country_3_letter = stringcurency4code
                                    
               // self.str_country_3_letter = countrycodestored
                self.str_country_3_letter = self.str_receiver_country_3_letter
                
                                    
                                    // 1.countrycode
                                    //2.currencyCode
                                    //3 currencyCode
                
                self.currency2Lbl.text = stringcurency3code
                let code:String = self.str_receiver_country_2_code.lowercased()
                        
                    let url = "https://gulfexchange.com.qa/storage/datafolder/flags/flags-medium/" + code + ".png"
                     print("urlimage---",url)
                   // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
                let imgResource = URL(string: url)
                self.flag2Lbl.kf.setImage(with: imgResource)
                                    
                                
//                let url = "https://gulfexchange.com.qa/storage/datafolder/flags/flags-medium/" + self.str_receiver_country_2_code.lowercased() + ".png"
//                  print("urlimage",url)
//
//                let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
//                print("image flag",self.str_receiver_country_2_code.lowercased())
//                self.flag2Lbl.image = UIImage(named: self.str_receiver_country_2_code.lowercased())
                //                    self.flag2Lbl.kf.setImage(with: imgResource)
                
                
                if self.shiftcurrencycodeArray.count > 1
                {
                    var imageView = UIImageView();
                    var image = UIImage(named: "downarrowicon.png");
                    imageView.image = image;
                    self.currency2Lbl.rightView = imageView;
                    self.currency2Lbl.rightViewMode = UITextField.ViewMode.always
                    self.currency2Lbl.rightViewMode = .always
                                    
                              
                    //self.timerGesture.isEnabled = false
                }
                else
                {
                    

                    
                }
                
                self.countryseltableview.reloadData()
            self.getToken(num: 2)
                
                
            }
   
            
            
            
        })
    }
    

    
    //payoutforclick
//
//    func shiftapipayoutcurrencycodenewClik(access_token:String) {
//
//            self.activityIndicator(NSLocalizedString("loading", comment: ""))
//
//            print("code",str_country)
//
//            let dateTime:String = getCurrentDateTime()
//            let url = ge_api_url + "shiftservice/showPayoutCurrencies"
//
//
//    //
//            //servicetypestored check
//        let userdefaultsservicetype = UserDefaults.standard
//        if let savedValue = userdefaultsservicetype.string(forKey: "servicetypestoresel"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
//           print("servicetypestored:\(servicetypestoredstr)")
//
//            } else {
//            servicetypestoredstr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultsservicetype.set("", forKey: "key")
//        }
//
//
//
//            //servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
//            //print("servicetypestored:\(servicetypestoredstr)")
//
//
//            //let bankcodeserviceprovidercode
//               //str_bank_codeserviceprovidercode check
//            let userdefaultsbankcodeserviceprovidercodestr = UserDefaults.standard
//            if let savedValue = userdefaultsbankcodeserviceprovidercodestr.string(forKey: "str_bank_codeserviceprovidercode"){
//                print("Here you will get saved value")
//               //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//                bankcodeserviceprovidercodestr = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//               print("bankcodeserviceprovidercodestrstored:\(bankcodeserviceprovidercodestr)")
//
//                } else {
//                bankcodeserviceprovidercodestr = ""
//            print("No value in Userdefault,Either you can save value here or perform other operation")
//            userdefaultsbankcodeserviceprovidercodestr.set("", forKey: "key")
//            }
//
//            //bankcodeserviceprovidercodestr = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//            //print("bankcodeserviceprovidercode:\(bankcodeserviceprovidercodestr)")
//
//            //let citycode
//            //city dropcode check
//            let userdefaultscitydrop = UserDefaults.standard
//            if let savedValue = userdefaultscitydrop.string(forKey: "str_bank_citydropcode"){
//                print("Here you will get saved value")
//               //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//                citycodestr = defaults.string(forKey: "str_bank_citydropcode")!
//               print("citycodestrstored:\(citycodestr)")
//
//                } else {
//                citycodestr = ""
//            print("No value in Userdefault,Either you can save value here or perform other operation")
//            userdefaultscitydrop.set("", forKey: "key")
//            }
//
//
//            //citycodestr = defaults.string(forKey: "str_bank_citydropcode")!
//            //print("citydropcode:\(citycodestr)")
//
//            //let branchcode
//            //branch code checdk
//            let userdefaultsbranchcode = UserDefaults.standard
//            if let savedValue = userdefaultsbranchcode.string(forKey: "str_branch_code"){
//                print("Here you will get saved value")
//               //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//                branchcodestr = defaults.string(forKey: "str_branch_code")!
//               print("branchcodestrstored:\(branchcodestr)")
//
//                } else {
//                branchcodestr = ""
//            print("No value in Userdefault,Either you can save value here or perform other operation")
//            userdefaultsbranchcode.set("", forKey: "key")
//            }
//
//
//            //branchcodestr = defaults.string(forKey: "str_branch_code")!
//            //print("branchcode:\(branchcodestr)")
//
//        // let countrycodestored
//
//
//            let userdefaultscountrycodestored = UserDefaults.standard
//            if let savedValue = userdefaultscountrycodestored.string(forKey: "countrycodestored"){
//                print("Here you will get saved value")
//               //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//                countrycodestoredstr = defaults.string(forKey: "countrycodestored")!
//               print("servicetypestored:\(servicetypestoredstr)")
//
//                } else {
//                countrycodestoredstr = ""
//            print("No value in Userdefault,Either you can save value here or perform other operation")
//            userdefaultscountrycodestored.set("", forKey: "key")
//            }
//
//            //countrycodestoredstr = defaults.string(forKey: "countrycodestored")!
//           // print("countrycodestored:\(countrycodestoredstr)")
//
//
//      let params:Parameters =  ["destinationCountryCode":countrycodestoredstr,"serviceProviderCode":bankcodeserviceprovidercodestr,"serviceType":servicetypestoredstr,"payoutBranchCode":branchcodestr]
//
//            print("urlpayout:\(url)")
//            print("paramspayout:\(params)")
//
//            let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
//
//        CurrencyConverterNewHViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
//                let myResult = try? JSON(data: response.data!)
//                print("resppayout",response)
//                self.effectView.removeFromSuperview()
//                let resultArray = myResult![]
//
//                self.shiftcurrencycodeArray.removeAll()
//
//                self.singlecontry2codearr.removeAll()
//                self.singlecontry2codearrone.removeAll()
//                self.singlecontry2codearrtwo.removeAll()
//                self.singlecontry2codearrthree.removeAll()
//
//
//
//                for i in resultArray.arrayValue{
//
//                   i["currencyCode"].stringValue
//                     print("resppayout",i["currencyCode"].stringValue)
//                    self.singlecontry2codearr.append(i["currencyCode"].stringValue)
//                    self.singlecontry2codearrone.append(i["currencyName"].stringValue)
//                    self.singlecontry2codearrtwo.append(i["countryCodeTL"].stringValue)
//                    self.singlecontry2codearrthree.append(i["countryCode"].stringValue)
//
//
//
//                    let bank = Bank(bankAddress: i["currencyCode"].stringValue, bankCode: i["bankCode"].stringValue, bankName: i["countryName"].stringValue, bankcitytype: i["countryCodeTL"].stringValue,Accountnolength: i["requiredBranch"].stringValue,Mobnolength: i["countryCode"].stringValue)
//                    self.shiftcurrencycodeArray.append(bank)
//                }
//
//                if self.shiftcurrencycodeArray.isEmpty == true
//                {
//                  print("emptyarraii","emptyarra")
//               // self.showToast(message: NSLocalizedString("no_data_available", comment: ""), font: .systemFont(ofSize: 20.0))
//                    self.alertMessage(title:NSLocalizedString("gulf_exchange", comment: ""),msg: NSLocalizedString("no_data_available", comment: ""), action: NSLocalizedString("ok", comment: ""))
//                }
//                else
//                {
//
////
////                    print("singlee:\(self.singlecontry2codearr[0])")
////                    let stringcurency3code = String(self.singlecontry2codearr[0])
////
////                    print("singleestr:\(stringcurency3code)")
////                    let stringcountry2code = String(self.singlecontry2codearrtwo[0])
////
////
////                    self.str_receiver_country_2_code = stringcountry2code
////                    self.str_receiver_currency_3_letter = stringcurency3code
////
//                    let countrycodestored   = self.defaults.string(forKey: "countrycodestored")!
//                    print("countrycodestored:\(countrycodestored)")
//
//                    self.str_country_3_letter = countrycodestored
//
//                                        // 1.countrycode
//                                        //2.currencyCode
//                                        //3 currencyCode
//
//
////                    let url = "https://gulfexchange.com.qa/storage/datafolder/flags/flags-medium/" + self.str_receiver_country_2_code.lowercased() + ".png"
////                      print("urlimage",url)
////
////                    let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
////                    print("image flag",self.str_receiver_country_2_code.lowercased())
////                    self.flag2Lbl.image = UIImage(named: self.str_receiver_country_2_code.lowercased())
//                    //                    self.flag2Lbl.kf.setImage(with: imgResource)
//
//                    if self.shiftcurrencycodeArray.count > 1
//                    {
//                        var imageView = UIImageView();
//                        var image = UIImage(named: "downarrowicon.png");
//                        imageView.image = image;
//                        self.currency2Lbl.rightView = imageView;
//                        self.currency2Lbl.rightViewMode = UITextField.ViewMode.always
//                        self.currency2Lbl.rightViewMode = .always
//
//
//
//                    }
//                    else
//                    {
//
//                    }
//
//
//                    self.countryseltableview.reloadData()
//                self.getToken(num: 2)
//
//                }
//
//
//
//
//            })
//        }

    
    
    
    
    
    
    
func feelookup(amount:String,receCountry:String,receCurrency:String,from:String,access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/currencyConversion"
        
       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
       // print("servicetypestored:\(servicetypestored)")
    
        //servicetypestored check
//    let userdefaultsservicetype = UserDefaults.standard
//    if let savedValue = userdefaultsservicetype.string(forKey: "servicetypestoresel"){
//        print("Here you will get saved value")
//       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//        servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
//       print("servicetypestored:\(servicetypestoredstr)")
//
//        } else {
//        servicetypestoredstr = ""
//    print("No value in Userdefault,Either you can save value here or perform other operation")
//    userdefaultsservicetype.set("", forKey: "key")
//    }
//
//      // let bankcodeserviceprovidercode = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//      //  print("bankcodeserviceprovidercode:\(bankcodeserviceprovidercode)")
//
//    let userdefaultsbankcodeserviceprovidercodestr = UserDefaults.standard
//    if let savedValue = userdefaultsbankcodeserviceprovidercodestr.string(forKey: "str_bank_codeserviceprovidercode"){
//        print("Here you will get saved value")
//       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//        bankcodeserviceprovidercodestr = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//       print("bankcodeserviceprovidercodestrstored:\(bankcodeserviceprovidercodestr)")
//
//        } else {
//        bankcodeserviceprovidercodestr = ""
//    print("No value in Userdefault,Either you can save value here or perform other operation")
//    userdefaultsbankcodeserviceprovidercodestr.set("", forKey: "key")
//    }
//
//        //let citycode = defaults.string(forKey: "str_bank_citydropcode")!
//        //print("citydropcode:\(citycode)")
//
//    //city dropcode check
//      let userdefaultscitydrop = UserDefaults.standard
//      if let savedValue = userdefaultscitydrop.string(forKey: "str_bank_citydropcode"){
//          print("Here you will get saved value")
//         //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//          citycodestr = defaults.string(forKey: "str_bank_citydropcode")!
//         print("citycodestrstored:\(citycodestr)")
//
//          } else {
//          citycodestr = ""
//      print("No value in Userdefault,Either you can save value here or perform other operation")
//      userdefaultscitydrop.set("", forKey: "key")
//      }
//
//
//
//
//       // let branchcode = defaults.string(forKey: "str_branch_code")!
//            // print("branchcode:\(branchcode)")
//
//    //branch code checdk
//        let userdefaultsbranchcode = UserDefaults.standard
//        if let savedValue = userdefaultsbranchcode.string(forKey: "str_branch_code"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            branchcodestr = defaults.string(forKey: "str_branch_code")!
//           print("branchcodestrstored:\(branchcodestr)")
//
//            } else {
//            branchcodestr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultsbranchcode.set("", forKey: "key")
//        }
//
    
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print("appVersion",appVersion)
        
        //customerIDNo
    
    
        
        let params:Parameters =  ["agentId":agentId,"token":token_remi,"timeStamp":dateTime,"sendCountry":"QAT","sendCurrency":"QAR","receiveCountry":str_receiver_country_3_letter,"receiveCurrency":str_receiver_currency_3_letter,"deliveryOption":"CREDIT","providerId":"1","sendAmount":amount,"serviceProviderCode":"","cityCode":"","payoutBranchCode":"","customerIDNo":defaults.string(forKey: "USERID")!,"deviceType":"IOS","versionName":appVersion,"types":"M","amountType":"L"]
        
        //srvicetype delivery optionil pass cheyanam
        //serviceProviderCode bankcode
        // 2 cityCode = citydrop selCode
      // 3 branch selcode
    // 4 types M STATIC MATHI
    print("urlfeelookup",url)
      print("paramsfeelookup",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

    CurrencyConverterNewHViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { [self] (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["resposeCode"]
            print("respCode",respCode)
            if(respCode == "0")
            {
                
                if myResult!["priceOrderCode"].stringValue.isEmpty
                {
//                   self.priceordercodeglobalstored = ""
//                    UserDefaults.standard.removeObject(forKey: "priceordercodestored")
//                    UserDefaults.standard.set(self.priceordercodeglobalstored, forKey: "priceordercodestored")
                }
                else
                {
//                self.priceordercodeglobalstored = myResult!["priceOrderCode"].stringValue
//                UserDefaults.standard.removeObject(forKey: "priceordercodestored")
//                UserDefaults.standard.set(self.priceordercodeglobalstored, forKey: "priceordercodestored")
                }
                
                //self.retailExchangeRate = myResult!["retailExchangeRate"].stringValue
             
                
                let retailexchangeratedecimal = myResult!["retailExchangeRate"].stringValue
                var retailexchange = Double(retailexchangeratedecimal)
                self.retailExchangeRate = String(format: "%.2f", retailexchange as! CVarArg)
                print("retailexchangeratedecimaly ",self.retailExchangeRate)
                             
//                let numberFormatter = NumberFormatter()
//                numberFormatter.numberStyle = .decimal
//                let formattedNumber = numberFormatter.string(from: NSNumber(value:rec_amount!))
                
                
               // self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency
                self.currency2Lbl.text = receCurrency
                if(from == "qar_to_any")
                {
                    self.retailExchangeRate1 = myResult!["retailExchangeRate"].stringValue
                    self.fee_amount1 = myResult!["feeAmount"].stringValue
                    
                    print("1",self.retailExchangeRate1)
                    print("2",self.fee_amount1)
                }
                else{
                    
                    self.retailExchangeRate1 = myResult!["retailExchangeRate"].stringValue
                    self.fee_amount1 = myResult!["feeAmount"].stringValue
                    print("1",self.retailExchangeRate1)
                    print("2",self.fee_amount1)
                    
                    self.rateLbl.isHidden = false
                    if(self.sendAmountTextField.text == "")
                    {
                        self.receivingAmountTextField.text = ""
                    }
                    else{
                        let receiveAmount = myResult!["receiveAmount"].stringValue
                        var rec_amount = Double(receiveAmount)
                        self.payout_amount = String(format: "%.2f", rec_amount as! CVarArg)
                        print("pay out ",self.payout_amount)
                
                        let numberFormatter = NumberFormatter()
                        numberFormatter.numberStyle = .decimal
                        let formattedNumber = numberFormatter.string(from: NSNumber(value:rec_amount!))
                        self.receivingAmountTextField.text = self.payout_amount
                    }
                   /// self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency
                    self.transferAmountLbl1.text = amount + ".00 QAR"
                    if(self.fee_amount1 == "0.0")
                    {
                        self.transferFeeLbl1.text = self.fee_amount1 + "0 QAR"
                    }
                    else
                    {
                        self.transferFeeLbl1.text = self.fee_amount1 + " QAR"
                    }
                    let amount1 = Double(amount) ?? 0.0
                    let amount2 = Double(self.fee_amount1) ?? 0.0
                    
                    let total = amount1 + amount2
                    
                    self.totalglobdisplay = String(total)
                    //newtotaldisplay
//                    var totalglobdisplayy = Double(total)
//                    self.totalglobdisplay = String(format: "%.2f", totalglobdisplayy as! CVarArg)
                    
                    let tottdecimal = String(total)
                    var tot = Double(tottdecimal)
                    let totalglobdisplay = String(format: "%.2f", tot as! CVarArg)
                    String(total)
                    print("totalglobdisplayyyold ",String(total))
                    print("totalglobdisplayyy ",String(totalglobdisplay))
                    
                    //old
                    //self.totalLbl1.text = String(total) + "0 QAR"
                    self.totalLbl1.text = String(totalglobdisplay) + " QAR"
                    
                    
                    //new
          
                    if(self.sendAmountTextField.text!.count > 0) && (self.receivingAmountTextField.text!.count > 0)
                    {
                        
                    
                    let sendAmountDouble = Double(self.sendAmountTextField.text!)
                    let receiveAmountDouble = Double(self.receivingAmountTextField.text!)
                    var reversal = sendAmountDouble!/receiveAmountDouble!
                    let doubleStr = String(format: "%.5f", reversal)
                    let value3:String = (Double(doubleStr)?.removeZerosFromEnd())!
                    //
                    let lastbottomstrdecimal = value3
                    var lastbottomstrdecimalrate = Double(lastbottomstrdecimal)
                    self.lastbottomstr = String(format: "%.2f", lastbottomstrdecimalrate as! CVarArg)
                    print("Dcheckkk ","1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR")
                    
                    
                    //
                    print("lastbottomstr ",self.lastbottomstr)
                        self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency + "           " + "1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR"
                        //  self.currencyToQarLbl.text = "1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR"
                    }
                    
                    //self.qarToCurrencyLbl.text
                         // = "1 QAR = " + self.retailexchangeratestr + " " + myResult!["receiveCurrency"].stringValue
                    
                    
//
//                  self.defaults.set(self.retailExchangeRate1, forKey: "exchangeRate")
//                    self.defaults.set(self.fee_amount1, forKey: "commission")
//                    //old
//                    //self.defaults.set(String(total), forKey: "totalAmount")
//                    self.defaults.set(String(totalglobdisplay), forKey: "totalAmount")
//                    self.defaults.set(receCurrency, forKey: "currency")
                }
            }
            else{
                if(from == "qar_to_any")
                {
                    self.retailExchangeRate1 = ""
                }
                else{
                    self.receivingAmountTextField.text = ""
                    self.rateLbl.isHidden = true
                    let desc = myResult!["description"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: desc, action: NSLocalizedString("ok", comment: ""))
                }
            }
        })
    }
    
    
    //nextbuton
    
    
    
func feelookupnextbtn(amount:String,receCountry:String,receCurrency:String,from:String,access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/currencyConversion"
        
       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
       // print("servicetypestored:\(servicetypestored)")
    
        //servicetypestored check
//    let userdefaultsservicetype = UserDefaults.standard
//    if let savedValue = userdefaultsservicetype.string(forKey: "servicetypestoresel"){
//        print("Here you will get saved value")
//       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//        servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
//       print("servicetypestored:\(servicetypestoredstr)")
//
//        } else {
//        servicetypestoredstr = ""
//    print("No value in Userdefault,Either you can save value here or perform other operation")
//    userdefaultsservicetype.set("", forKey: "key")
//    }
//
//      // let bankcodeserviceprovidercode = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//      //  print("bankcodeserviceprovidercode:\(bankcodeserviceprovidercode)")
//
//    let userdefaultsbankcodeserviceprovidercodestr = UserDefaults.standard
//    if let savedValue = userdefaultsbankcodeserviceprovidercodestr.string(forKey: "str_bank_codeserviceprovidercode"){
//        print("Here you will get saved value")
//       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//        bankcodeserviceprovidercodestr = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//       print("bankcodeserviceprovidercodestrstored:\(bankcodeserviceprovidercodestr)")
//
//        } else {
//        bankcodeserviceprovidercodestr = ""
//    print("No value in Userdefault,Either you can save value here or perform other operation")
//    userdefaultsbankcodeserviceprovidercodestr.set("", forKey: "key")
//    }
//
//        //let citycode = defaults.string(forKey: "str_bank_citydropcode")!
//        //print("citydropcode:\(citycode)")
//
//    //city dropcode check
//      let userdefaultscitydrop = UserDefaults.standard
//      if let savedValue = userdefaultscitydrop.string(forKey: "str_bank_citydropcode"){
//          print("Here you will get saved value")
//         //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//          citycodestr = defaults.string(forKey: "str_bank_citydropcode")!
//         print("citycodestrstored:\(citycodestr)")
//
//          } else {
//          citycodestr = ""
//      print("No value in Userdefault,Either you can save value here or perform other operation")
//      userdefaultscitydrop.set("", forKey: "key")
//      }
//
//
//
//
//       // let branchcode = defaults.string(forKey: "str_branch_code")!
//            // print("branchcode:\(branchcode)")
//
//    //branch code checdk
//        let userdefaultsbranchcode = UserDefaults.standard
//        if let savedValue = userdefaultsbranchcode.string(forKey: "str_branch_code"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            branchcodestr = defaults.string(forKey: "str_branch_code")!
//           print("branchcodestrstored:\(branchcodestr)")
//
//            } else {
//            branchcodestr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultsbranchcode.set("", forKey: "key")
//        }
    
    
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print("appVersion",appVersion)
        
        //customerIDNo
    
    
        
        let params:Parameters =  ["agentId":agentId,"token":token_remi,"timeStamp":dateTime,"sendCountry":"QAT","sendCurrency":"QAR","receiveCountry":str_receiver_country_3_letter,"receiveCurrency":str_receiver_currency_3_letter,"deliveryOption":"CREDIT","providerId":"1","sendAmount":amount,"serviceProviderCode":"","cityCode":"","payoutBranchCode":"","customerIDNo":defaults.string(forKey: "USERID")!,"deviceType":"IOS","versionName":appVersion,"types":"M","amountType":"L"]
        
        //srvicetype delivery optionil pass cheyanam
        //serviceProviderCode bankcode
        // 2 cityCode = citydrop selCode
      // 3 branch selcode
    // 4 types M STATIC MATHI
        
    print("urlfeelookup",url)
      print("paramsfeelookup",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

    CurrencyConverterNewHViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["resposeCode"]
            print("respCode",respCode)
            if(respCode == "0")
            {
                
                if myResult!["priceOrderCode"].stringValue.isEmpty
                {
//                   self.priceordercodeglobalstored = ""
//                    UserDefaults.standard.removeObject(forKey: "priceordercodestored")
//                    UserDefaults.standard.set(self.priceordercodeglobalstored, forKey: "priceordercodestored")
                }
                else
                {
//                self.priceordercodeglobalstored = myResult!["priceOrderCode"].stringValue
//                UserDefaults.standard.removeObject(forKey: "priceordercodestored")
//                UserDefaults.standard.set(self.priceordercodeglobalstored, forKey: "priceordercodestored")
                }
                
                //self.retailExchangeRate = myResult!["retailExchangeRate"].stringValue
             
                
                let retailexchangeratedecimal = myResult!["retailExchangeRate"].stringValue
                var retailexchange = Double(retailexchangeratedecimal)
                self.retailExchangeRate = String(format: "%.2f", retailexchange as! CVarArg)
                print("retailexchangeratedecimaly ",self.retailExchangeRate)
                             
//                let numberFormatter = NumberFormatter()
//                numberFormatter.numberStyle = .decimal
//                let formattedNumber = numberFormatter.string(from: NSNumber(value:rec_amount!))
                
                
               // self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency
                self.currency2Lbl.text = receCurrency
                if(from == "qar_to_any")
                {
                    self.retailExchangeRate1 = myResult!["retailExchangeRate"].stringValue
                    self.fee_amount1 = myResult!["feeAmount"].stringValue
                    
                    print("1",self.retailExchangeRate1)
                    print("2",self.fee_amount1)
                }
                else{
                    
                    self.retailExchangeRate1 = myResult!["retailExchangeRate"].stringValue
                    self.fee_amount1 = myResult!["feeAmount"].stringValue
                    print("1",self.retailExchangeRate1)
                    print("2",self.fee_amount1)
                    
                    self.rateLbl.isHidden = false
                    if(self.sendAmountTextField.text == "")
                    {
                        self.receivingAmountTextField.text = ""
                    }
                    else{
                        let receiveAmount = myResult!["receiveAmount"].stringValue
                        var rec_amount = Double(receiveAmount)
                        self.payout_amount = String(format: "%.2f", rec_amount as! CVarArg)
                        print("pay out ",self.payout_amount)
                
                        let numberFormatter = NumberFormatter()
                        numberFormatter.numberStyle = .decimal
                        let formattedNumber = numberFormatter.string(from: NSNumber(value:rec_amount!))
                        self.receivingAmountTextField.text = self.payout_amount
                    }
                   // self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency
                    self.transferAmountLbl1.text = amount + ".00 QAR"
                    if(self.fee_amount1 == "0.0")
                    {
                        self.transferFeeLbl1.text = self.fee_amount1 + "0 QAR"
                    }
                    else
                    {
                        self.transferFeeLbl1.text = self.fee_amount1 + " QAR"
                    }
                    let amount1 = Double(amount) ?? 0.0
                    let amount2 = Double(self.fee_amount1) ?? 0.0
                    
                    let total = amount1 + amount2
                    
                    self.totalglobdisplay = String(total)
                    //newtotaldisplay
//                    var totalglobdisplayy = Double(total)
//                    self.totalglobdisplay = String(format: "%.2f", totalglobdisplayy as! CVarArg)
                    
                    let tottdecimal = String(total)
                    var tot = Double(tottdecimal)
                    let totalglobdisplay = String(format: "%.2f", tot as! CVarArg)
                    String(total)
                    print("totalglobdisplayyyold ",String(total))
                    print("totalglobdisplayyy ",String(totalglobdisplay))
                    
                    //old
                    //self.totalLbl1.text = String(total) + "0 QAR"
                    self.totalLbl1.text = String(totalglobdisplay) + " QAR"
                    
                    
                    
                    
                    //new
          
                    if(self.sendAmountTextField.text!.count > 0) && (self.receivingAmountTextField.text!.count > 0)
                    {
                        
                    
                    let sendAmountDouble = Double(self.sendAmountTextField.text!)
                    let receiveAmountDouble = Double(self.receivingAmountTextField.text!)
                    var reversal = sendAmountDouble!/receiveAmountDouble!
                    let doubleStr = String(format: "%.5f", reversal)
                    let value3:String = (Double(doubleStr)?.removeZerosFromEnd())!
                    //
                    let lastbottomstrdecimal = value3
                    var lastbottomstrdecimalrate = Double(lastbottomstrdecimal)
                    self.lastbottomstr = String(format: "%.2f", lastbottomstrdecimalrate as! CVarArg)
                    print("Dcheckkk ","1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR")
                    
                    
                    //
                    print("lastbottomstr ",self.lastbottomstr)
                        self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency + "           " + "1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR"
                    
                        //  self.currencyToQarLbl.text = "1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR"
                    }
                    
//                  self.defaults.set(self.retailExchangeRate1, forKey: "exchangeRate")
//                    self.defaults.set(self.fee_amount1, forKey: "commission")
//                    //old
//                    //self.defaults.set(String(total), forKey: "totalAmount")
//                    self.defaults.set(String(totalglobdisplay), forKey: "totalAmount")
//                    self.defaults.set(receCurrency, forKey: "currency")
                }
                
                //newlyadded
                self.getToken(num: 1)
                
            }
            else{
                if(from == "qar_to_any")
                {
                    self.retailExchangeRate1 = ""
                }
                else{
                    self.receivingAmountTextField.text = ""
                    self.rateLbl.isHidden = true
                    let desc = myResult!["description"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: desc, action: NSLocalizedString("ok", comment: ""))
                }
            }
        })
    }
    
    
    
    
func feelookupsecondtxtnew(amount:String,receCountry:String,receCurrency:String,from:String,access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/currencyConversion"
        
       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
       // print("servicetypestored:\(servicetypestored)")
    
        //servicetypestored check
//    let userdefaultsservicetype = UserDefaults.standard
//    if let savedValue = userdefaultsservicetype.string(forKey: "servicetypestoresel"){
//        print("Here you will get saved value")
//       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//        servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
//       print("servicetypestored:\(servicetypestoredstr)")
//
//        } else {
//        servicetypestoredstr = ""
//    print("No value in Userdefault,Either you can save value here or perform other operation")
//    userdefaultsservicetype.set("", forKey: "key")
//    }
//
//      // let bankcodeserviceprovidercode = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//      //  print("bankcodeserviceprovidercode:\(bankcodeserviceprovidercode)")
//
//    let userdefaultsbankcodeserviceprovidercodestr = UserDefaults.standard
//    if let savedValue = userdefaultsbankcodeserviceprovidercodestr.string(forKey: "str_bank_codeserviceprovidercode"){
//        print("Here you will get saved value")
//       //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//        bankcodeserviceprovidercodestr = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//       print("bankcodeserviceprovidercodestrstored:\(bankcodeserviceprovidercodestr)")
//
//        } else {
//        bankcodeserviceprovidercodestr = ""
//    print("No value in Userdefault,Either you can save value here or perform other operation")
//    userdefaultsbankcodeserviceprovidercodestr.set("", forKey: "key")
//    }
//
//        //let citycode = defaults.string(forKey: "str_bank_citydropcode")!
//        //print("citydropcode:\(citycode)")
//
//    //city dropcode check
//      let userdefaultscitydrop = UserDefaults.standard
//      if let savedValue = userdefaultscitydrop.string(forKey: "str_bank_citydropcode"){
//          print("Here you will get saved value")
//         //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//          citycodestr = defaults.string(forKey: "str_bank_citydropcode")!
//         print("citycodestrstored:\(citycodestr)")
//
//          } else {
//          citycodestr = ""
//      print("No value in Userdefault,Either you can save value here or perform other operation")
//      userdefaultscitydrop.set("", forKey: "key")
//      }
//
//
//
//
//       // let branchcode = defaults.string(forKey: "str_branch_code")!
//            // print("branchcode:\(branchcode)")
//
//    //branch code checdk
//        let userdefaultsbranchcode = UserDefaults.standard
//        if let savedValue = userdefaultsbranchcode.string(forKey: "str_branch_code"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            branchcodestr = defaults.string(forKey: "str_branch_code")!
//           print("branchcodestrstored:\(branchcodestr)")
//
//            } else {
//            branchcodestr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultsbranchcode.set("", forKey: "key")
//        }
    
    
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print("appVersion",appVersion)
        
        //customerIDNo
    
    
        
    let params:Parameters =  ["agentId":agentId,"token":token_remi,"timeStamp":dateTime,"sendCountry":"QAT","sendCurrency":"QAR","receiveCountry":str_receiver_country_3_letter,"receiveCurrency":str_receiver_currency_3_letter,"deliveryOption":"CREDIT","providerId":"1","sendAmount":receivingAmountTextField.text!,"serviceProviderCode":"","cityCode":"","payoutBranchCode":"","customerIDNo":defaults.string(forKey: "USERID")!,"deviceType":"IOS","versionName":appVersion,"types":"M","amountType":"F"]
        
        //srvicetype delivery optionil pass cheyanam
        //serviceProviderCode bankcode
        // 2 cityCode = citydrop selCode
      // 3 branch selcode
    // 4 types M STATIC MATHI
    print("urlfeelookup",url)
      print("paramsfeelookup",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

    CurrencyConverterNewHViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["resposeCode"]
            print("respCode",respCode)
            if(respCode == "0")
            {
                
                if myResult!["priceOrderCode"].stringValue.isEmpty
                {
//                   self.priceordercodeglobalstored = ""
//                    UserDefaults.standard.removeObject(forKey: "priceordercodestored")
//                    UserDefaults.standard.set(self.priceordercodeglobalstored, forKey: "priceordercodestored")
                }
                else
                {
//                self.priceordercodeglobalstored = myResult!["priceOrderCode"].stringValue
//                UserDefaults.standard.removeObject(forKey: "priceordercodestored")
//                UserDefaults.standard.set(self.priceordercodeglobalstored, forKey: "priceordercodestored")
                }
                
                //self.retailExchangeRate = myResult!["retailExchangeRate"].stringValue
             
                
                let retailexchangeratedecimal = myResult!["retailExchangeRate"].stringValue
                var retailexchange = Double(retailexchangeratedecimal)
                self.retailExchangeRate = String(format: "%.2f", retailexchange as! CVarArg)
                print("retailexchangeratedecimaly ",self.retailExchangeRate)
                             
//                let numberFormatter = NumberFormatter()
//                numberFormatter.numberStyle = .decimal
//                let formattedNumber = numberFormatter.string(from: NSNumber(value:rec_amount!))
                
                
               // self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency
                self.currency2Lbl.text = receCurrency
                if(from == "qar_to_any")
                {
                    self.retailExchangeRate1 = myResult!["retailExchangeRate"].stringValue
                    self.fee_amount1 = myResult!["feeAmount"].stringValue
                    
                    print("1",self.retailExchangeRate1)
                    print("2",self.fee_amount1)
                }
                else{
                    
                    self.retailExchangeRate1 = myResult!["retailExchangeRate"].stringValue
                    self.fee_amount1 = myResult!["feeAmount"].stringValue
                    print("1",self.retailExchangeRate1)
                    print("2",self.fee_amount1)
                    
                    self.rateLbl.isHidden = false
                    if(self.receivingAmountTextField.text == "")
                    {
                        self.sendAmountTextField.text = ""
                    }
                    else{
                        let receiveAmount = myResult!["localAmount"].stringValue
                        var rec_amount = Double(receiveAmount)
                        self.payout_amount = String(format: "%.2f", rec_amount as! CVarArg)
                        print("pay out ",self.payout_amount)
                
                        let numberFormatter = NumberFormatter()
                        numberFormatter.numberStyle = .decimal
                        let formattedNumber = numberFormatter.string(from: NSNumber(value:rec_amount!))
                        self.sendAmountTextField.text = self.payout_amount
                    }
                   // self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency
                    self.transferAmountLbl1.text = amount + ".00 QAR"
                    if(self.fee_amount1 == "0.0")
                    {
                        self.transferFeeLbl1.text = self.fee_amount1 + "0 QAR"
                    }
                    else
                    {
                        self.transferFeeLbl1.text = self.fee_amount1 + " QAR"
                    }
                    let amount1 = Double(amount) ?? 0.0
                    let amount2 = Double(self.fee_amount1) ?? 0.0
                    
                    let total = amount1 + amount2
                    
                    self.totalglobdisplay = String(total)
                    //newtotaldisplay
//                    var totalglobdisplayy = Double(total)
//                    self.totalglobdisplay = String(format: "%.2f", totalglobdisplayy as! CVarArg)
                    
                    let tottdecimal = String(total)
                    var tot = Double(tottdecimal)
                    let totalglobdisplay = String(format: "%.2f", tot as! CVarArg)
                    String(total)
                    print("totalglobdisplayyyold ",String(total))
                    print("totalglobdisplayyy ",String(totalglobdisplay))
                    
                    //old
                    //self.totalLbl1.text = String(total) + "0 QAR"
                    self.totalLbl1.text = String(totalglobdisplay) + " QAR"
                    
                    
                    //new
          
                    if(self.sendAmountTextField.text!.count > 0) && (self.receivingAmountTextField.text!.count > 0)
                    {
                        
                    
                    let sendAmountDouble = Double(self.sendAmountTextField.text!)
                    let receiveAmountDouble = Double(self.receivingAmountTextField.text!)
                    var reversal = sendAmountDouble!/receiveAmountDouble!
                    let doubleStr = String(format: "%.5f", reversal)
                    let value3:String = (Double(doubleStr)?.removeZerosFromEnd())!
                    //
                    let lastbottomstrdecimal = value3
                    var lastbottomstrdecimalrate = Double(lastbottomstrdecimal)
                    self.lastbottomstr = String(format: "%.2f", lastbottomstrdecimalrate as! CVarArg)
                    print("Dcheckkk ","1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR")
                    
                    
                    //
                    print("lastbottomstr ",self.lastbottomstr)
                        
                        self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency + "           " + "1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR"
                    
                        //  self.currencyToQarLbl.text = "1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR"
                    }
                    
//                  self.defaults.set(self.retailExchangeRate1, forKey: "exchangeRate")
//                    self.defaults.set(self.fee_amount1, forKey: "commission")
//                    //old
//                    //self.defaults.set(String(total), forKey: "totalAmount")
//                    self.defaults.set(String(totalglobdisplay), forKey: "totalAmount")
//                    self.defaults.set(receCurrency, forKey: "currency")
                }
            }
            else{
                if(from == "qar_to_any")
                {
                    self.retailExchangeRate1 = ""
                }
                else{
                    self.receivingAmountTextField.text = ""
                    self.rateLbl.isHidden = true
                    let desc = myResult!["description"].stringValue
                    self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: desc, action: NSLocalizedString("ok", comment: ""))
                }
            }
        })
    }
    
    
    func feelookupsecondtxtnenextbtn(amount:String,receCountry:String,receCurrency:String,from:String,access_token:String) {
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            let dateTime:String = getCurrentDateTime()
            let url = ge_api_url + "utilityservice/currencyConversion"
            
           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
           // print("servicetypestored:\(servicetypestored)")
        
            //servicetypestored check
//        let userdefaultsservicetype = UserDefaults.standard
//        if let savedValue = userdefaultsservicetype.string(forKey: "servicetypestoresel"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            servicetypestoredstr = defaults.string(forKey: "servicetypestoresel")!
//           print("servicetypestored:\(servicetypestoredstr)")
//
//            } else {
//            servicetypestoredstr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultsservicetype.set("", forKey: "key")
//        }
//
//          // let bankcodeserviceprovidercode = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//          //  print("bankcodeserviceprovidercode:\(bankcodeserviceprovidercode)")
//
//        let userdefaultsbankcodeserviceprovidercodestr = UserDefaults.standard
//        if let savedValue = userdefaultsbankcodeserviceprovidercodestr.string(forKey: "str_bank_codeserviceprovidercode"){
//            print("Here you will get saved value")
//           //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//            bankcodeserviceprovidercodestr = defaults.string(forKey: "str_bank_codeserviceprovidercode")!
//           print("bankcodeserviceprovidercodestrstored:\(bankcodeserviceprovidercodestr)")
//
//            } else {
//            bankcodeserviceprovidercodestr = ""
//        print("No value in Userdefault,Either you can save value here or perform other operation")
//        userdefaultsbankcodeserviceprovidercodestr.set("", forKey: "key")
//        }
//
//            //let citycode = defaults.string(forKey: "str_bank_citydropcode")!
//            //print("citydropcode:\(citycode)")
//
//        //city dropcode check
//          let userdefaultscitydrop = UserDefaults.standard
//          if let savedValue = userdefaultscitydrop.string(forKey: "str_bank_citydropcode"){
//              print("Here you will get saved value")
//             //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//              citycodestr = defaults.string(forKey: "str_bank_citydropcode")!
//             print("citycodestrstored:\(citycodestr)")
//
//              } else {
//              citycodestr = ""
//          print("No value in Userdefault,Either you can save value here or perform other operation")
//          userdefaultscitydrop.set("", forKey: "key")
//          }
//
//
//
//
//           // let branchcode = defaults.string(forKey: "str_branch_code")!
//                // print("branchcode:\(branchcode)")
//
//        //branch code checdk
//            let userdefaultsbranchcode = UserDefaults.standard
//            if let savedValue = userdefaultsbranchcode.string(forKey: "str_branch_code"){
//                print("Here you will get saved value")
//               //let servicetypestored = defaults.string(forKey: "servicetypestoresel")!
//                branchcodestr = defaults.string(forKey: "str_branch_code")!
//               print("branchcodestrstored:\(branchcodestr)")
//
//                } else {
//                branchcodestr = ""
//            print("No value in Userdefault,Either you can save value here or perform other operation")
//            userdefaultsbranchcode.set("", forKey: "key")
//            }
        
        
            
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            print("appVersion",appVersion)
            
            //customerIDNo
        
        
            
            let params:Parameters =  ["agentId":agentId,"token":token_remi,"timeStamp":dateTime,"sendCountry":"QAT","sendCurrency":"QAR","receiveCountry":str_receiver_country_3_letter,"receiveCurrency":str_receiver_currency_3_letter,"deliveryOption":"CREDIT","providerId":"1","sendAmount":receivingAmountTextField.text!,"serviceProviderCode":"","cityCode":"","payoutBranchCode":"","customerIDNo":defaults.string(forKey: "USERID")!,"deviceType":"IOS","versionName":appVersion,"types":"M","amountType":"F"]
            
            //srvicetype delivery optionil pass cheyanam
            //serviceProviderCode bankcode
            // 2 cityCode = citydrop selCode
          // 3 branch selcode
        // 4 types M STATIC MATHI
            
        print("urlfeelookup",url)
          print("paramsfeelookup",params)
            
            let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        CurrencyConverterNewHViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                let myResult = try? JSON(data: response.data!)
                print("resp",response)
                self.effectView.removeFromSuperview()
                let respCode = myResult!["resposeCode"]
                print("respCode",respCode)
                if(respCode == "0")
                {
                    
                    if myResult!["priceOrderCode"].stringValue.isEmpty
                    {
//                       self.priceordercodeglobalstored = ""
//                        UserDefaults.standard.removeObject(forKey: "priceordercodestored")
//                        UserDefaults.standard.set(self.priceordercodeglobalstored, forKey: "priceordercodestored")
                    }
                    else
                    {
//                    self.priceordercodeglobalstored = myResult!["priceOrderCode"].stringValue
//                    UserDefaults.standard.removeObject(forKey: "priceordercodestored")
//                    UserDefaults.standard.set(self.priceordercodeglobalstored, forKey: "priceordercodestored")
                    }
                    
                    //self.retailExchangeRate = myResult!["retailExchangeRate"].stringValue
                 
                    
                    let retailexchangeratedecimal = myResult!["retailExchangeRate"].stringValue
                    var retailexchange = Double(retailexchangeratedecimal)
                    self.retailExchangeRate = String(format: "%.2f", retailexchange as! CVarArg)
                    print("retailexchangeratedecimaly ",self.retailExchangeRate)
                                 
    //                let numberFormatter = NumberFormatter()
    //                numberFormatter.numberStyle = .decimal
    //                let formattedNumber = numberFormatter.string(from: NSNumber(value:rec_amount!))
                    
                    
                    //self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency
                    self.currency2Lbl.text = receCurrency
                    if(from == "qar_to_any")
                    {
                        self.retailExchangeRate1 = myResult!["retailExchangeRate"].stringValue
                        self.fee_amount1 = myResult!["feeAmount"].stringValue
                        
                        print("1",self.retailExchangeRate1)
                        print("2",self.fee_amount1)
                    }
                    else{
                        
                        self.retailExchangeRate1 = myResult!["retailExchangeRate"].stringValue
                        self.fee_amount1 = myResult!["feeAmount"].stringValue
                        print("1",self.retailExchangeRate1)
                        print("2",self.fee_amount1)
                        
                        self.rateLbl.isHidden = false
                        if(self.receivingAmountTextField.text == "")
                        {
                            self.sendAmountTextField.text = ""
                        }

                        else{
                            let receiveAmount = myResult!["localAmount"].stringValue
                            var rec_amount = Double(receiveAmount)
                            self.payout_amount = String(format: "%.2f", rec_amount as! CVarArg)
                            print("pay out ",self.payout_amount)
                    
                            let numberFormatter = NumberFormatter()
                            numberFormatter.numberStyle = .decimal
                            let formattedNumber = numberFormatter.string(from: NSNumber(value:rec_amount!))
                            self.sendAmountTextField.text = self.payout_amount
                        }
                       // self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency
                        self.transferAmountLbl1.text = amount + ".00 QAR"
                        if(self.fee_amount1 == "0.0")
                        {
                            self.transferFeeLbl1.text = self.fee_amount1 + "0 QAR"
                        }
                        else
                        {
                            self.transferFeeLbl1.text = self.fee_amount1 + " QAR"
                        }
                        let amount1 = Double(amount) ?? 0.0
                        let amount2 = Double(self.fee_amount1) ?? 0.0
                        
                        let total = amount1 + amount2
                        
                        self.totalglobdisplay = String(total)
                        //newtotaldisplay
    //                    var totalglobdisplayy = Double(total)
    //                    self.totalglobdisplay = String(format: "%.2f", totalglobdisplayy as! CVarArg)
                        
                        let tottdecimal = String(total)
                        var tot = Double(tottdecimal)
                        let totalglobdisplay = String(format: "%.2f", tot as! CVarArg)
                        String(total)
                        print("totalglobdisplayyyold ",String(total))
                        print("totalglobdisplayyy ",String(totalglobdisplay))
                        
                        //old
                        //self.totalLbl1.text = String(total) + "0 QAR"
                        self.totalLbl1.text = String(totalglobdisplay) + " QAR"
                        
                        
                        //new
              
                        if(self.sendAmountTextField.text!.count > 0) && (self.receivingAmountTextField.text!.count > 0)
                        {
                            
                        
                        let sendAmountDouble = Double(self.sendAmountTextField.text!)
                        let receiveAmountDouble = Double(self.receivingAmountTextField.text!)
                        var reversal = sendAmountDouble!/receiveAmountDouble!
                        let doubleStr = String(format: "%.5f", reversal)
                        let value3:String = (Double(doubleStr)?.removeZerosFromEnd())!
                        //
                        let lastbottomstrdecimal = value3
                        var lastbottomstrdecimalrate = Double(lastbottomstrdecimal)
                        self.lastbottomstr = String(format: "%.2f", lastbottomstrdecimalrate as! CVarArg)
                        print("Dcheckkk ","1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR")
                        
                        
                        //
                        print("lastbottomstr ",self.lastbottomstr)
                            self.rateLbl.text = "1 QAR = " + self.retailExchangeRate + " " + receCurrency + "           " + "1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR"
                            //  self.currencyToQarLbl.text = "1 " + myResult!["receiveCurrency"].stringValue + " = " + self.lastbottomstr + " QAR"
                        }
                        
//                      self.defaults.set(self.retailExchangeRate1, forKey: "exchangeRate")
//                        self.defaults.set(self.fee_amount1, forKey: "commission")
//                        //old
//                        //self.defaults.set(String(total), forKey: "totalAmount")
//                        self.defaults.set(String(totalglobdisplay), forKey: "totalAmount")
//                        self.defaults.set(receCurrency, forKey: "currency")
                    }
                    
                    //newlyadded
                    self.getToken(num: 8)
                    
                }
                else{
                    if(from == "qar_to_any")
                    {
                        self.retailExchangeRate1 = ""
                    }
                    else{
                        self.receivingAmountTextField.text = ""
                        self.rateLbl.isHidden = true
                        let desc = myResult!["description"].stringValue
                        self.alertMessage(title: NSLocalizedString("gulf_exchange", comment: ""), msg: desc, action: NSLocalizedString("ok", comment: ""))
                    }
                }
            })
        }
    
    
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
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
    
    
    
   //tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shiftcurrencycodeArray.count
        //return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        
        if shiftcurrencycodeArray.isEmpty
        {
            //timerGesture.isEnabled = false
        }
        else
        {
        let municipality = shiftcurrencycodeArray[indexPath.row]
            // cell.textLabel?.text = municipality.bankcitytype
        cell.countryLbl.text = municipality.bankAddress
        print("countryselecttxt---",cell.countryLbl.text)
        print("countryselcode---",municipality.bankcitytype)
            
        let code:String = municipality.bankcitytype.lowercased()
            
        let url = "https://gulfexchange.com.qa/storage/datafolder/flags/flags-medium/" + code + ".png"
         print("urlimage---",url)
       // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
            let imgResource = URL(string: url)
            cell.flagImg.kf.setImage(with: imgResource)
            
            //timerGesture.isEnabled = true
        }
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
       // let str: String =  cell.countryLbl.text!
        //selectReceiverBtn.setTitle("\(str)", for: .normal)
        //self.currency2Lbl.text = str
        
        let municipality = shiftcurrencycodeArray[indexPath.row]
            // cell.textLabel?.text = municipality.bankcitytype
        self.currency2Lbl.text = municipality.bankAddress
        
        self.str_receiver_country_2_code = municipality.bankcitytype
        self.str_receiver_currency_3_letter = municipality.bankAddress
        //self.str_country_3_letter = countrycodestored
        self.str_receiver_country_3_letter = municipality.Mobnolength
        
//        currency1Lbl.text = ""
//        currency2Lbl.text = ""
        
        
        self.receivingAmountTextField.text = ""
        self.sendAmountTextField.text = ""
        self.transferAmountLbl1.text = "0.00 QAR"
        self.transferFeeLbl1.text = "0.00 QAR"
        self.totalLbl1.text = "0.00 QAR"
        
        hideview.isHidden = false
        hideswitchview.isHidden = false
        
        convertcurrbtn.isHidden = false
        self.mainview.backgroundColor = UIColor.white
        self.countryseltableview.isHidden =  true
        
        
        let code:String = self.str_receiver_country_2_code.lowercased()
                
            let url = "https://gulfexchange.com.qa/storage/datafolder/flags/flags-medium/" + code + ".png"
             print("urlimage---",url)
           // let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
        let imgResource = URL(string: url)
        self.flag2Lbl.kf.setImage(with: imgResource)
        
        self.timerGesture.isEnabled = true
        droptouchstr = ""
        
        //self.mainview.isUserInteractionEnabled = true
        
    }

    

}
