//
//  HomeViewController.swift
//  GulfExchangeApp
//
//  Created by test on 20/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ScreenShield

class HomeViewController: UIViewController {
    
    //var timer = Timer()
    var timer : Timer?
    
    var timerGesture = UITapGestureRecognizer()
    var counter = 20
    var isTimerRunning = false
    
    
    
    var namestr:String = ""
    var emailstr:String = ""
    var phonestr:String = ""
    
    var pdfglolalitastr:String = ""
    
    
    
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var notifyBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var sendMoneyBtn: UIButton!
    @IBOutlet weak var myTransactionBtn: UIButton!
    @IBOutlet weak var trackTransactionBtn: UIButton!
    @IBOutlet weak var currencyRateBtn: UIButton!
    @IBOutlet weak var currencyConverterBtn: UIButton!
    @IBOutlet weak var aboutUsBtn: UIButton!
    @IBOutlet weak var branchesBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var notifyLbl: UILabel!
    @IBOutlet weak var settingsLbl: UILabel!
    @IBOutlet weak var logoutLbl: UILabel!
    
    @IBOutlet weak var sendMoneyLbl: UILabel!
    @IBOutlet weak var myTransactionsLbl: UILabel!
    @IBOutlet weak var trackTransactionLbl: UILabel!
    @IBOutlet weak var currencyRateLbl: UILabel!
    @IBOutlet weak var currencyConverterLbl: UILabel!
    @IBOutlet weak var aboutUsLbl: UILabel!
    @IBOutlet weak var branchesLbl: UILabel!
    @IBOutlet weak var helpLbl: UILabel!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var img_chat: UIImageView!
    @IBOutlet weak var countBtn: UIButton!
    
    @IBOutlet var faqlabel: UILabel!
    
    @IBOutlet var Faqbtn: UIButton!
    
    @IBAction func FaqbtnAction(_ sender: Any)
    {
        
        timer?.invalidate()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
            //       self.present(nextViewController, animated:true, completion:nil)
            self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    
    @IBAction func GoLalitaRewardsbtnact(_ sender: Any) {
        
        timer?.invalidate()
        
        self.getToken(num: 3)
        
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GoLalitaVC") as! GoLalitaVC
//            //       self.present(nextViewController, animated:true, completion:nil)
//            self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    var oncecheckpopupstr:String = ""
    var udid:String!
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
        //test
        static let AlamoFireManager: Alamofire.Session = {
            let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator(),
                                                          "ws.gulfexchange.com.qa": DisabledEvaluator()])
            let configuration = URLSessionConfiguration.af.default
            return Session(configuration: configuration, serverTrustManager: manager)
        }()
        
        
        //production
//            static let AlamoFireManager: Alamofire.Session = {
//        //        let manager = ServerTrustManager(evaluators: ["78.100.141.203": DisabledEvaluator()])
//                let configuration = URLSessionConfiguration.af.default
//                return Session(configuration: configuration)
//        //        return Session(configuration: configuration, serverTrustManager: manager)
//            }()
        
    
    let defaults = UserDefaults.standard
    var count:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        timer = nil
        if counter > 0 {
              print("\(counter) seconds to the end of the world")
              counter -= 15*60
           // counter = 0
          }
        

        print("\(counter) timer resetcountdw")
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        
        //removeprofstore
      
        UserDefaults.standard.removeObject(forKey: "frontlabelphotostr")
        UserDefaults.standard.removeObject(forKey: "backlabelphotostr")
        UserDefaults.standard.removeObject(forKey: "selfielabelphotostr")
        
        UserDefaults.standard.removeObject(forKey: "strBase64photo")
        UserDefaults.standard.removeObject(forKey: "strBase641photo1")
        UserDefaults.standard.removeObject(forKey: "strBase642photo2")
        
        //viedioprofile
        UserDefaults.standard.removeObject(forKey: "strBase64videoProfile")
        
        
        UserDefaults.standard.removeObject(forKey: "photovcyesstr")
        UserDefaults.standard.removeObject(forKey: "photovcyesstr")
        UserDefaults.standard.removeObject(forKey: "photovcyesstr")
        
        //newprof
        UserDefaults.standard.removeObject(forKey: "str_id_nonew")
        UserDefaults.standard.removeObject(forKey: "str_id_exp_datenew")
        
        UserDefaults.standard.removeObject(forKey: "str_name_ennew")
        UserDefaults.standard.removeObject(forKey: "str_name_arnew")
        UserDefaults.standard.removeObject(forKey: "strEmailnew")
        UserDefaults.standard.removeObject(forKey: "str_dobnew")
        UserDefaults.standard.removeObject(forKey: "str_nationalitynew")
        UserDefaults.standard.removeObject(forKey: "str_addressnew")
        UserDefaults.standard.removeObject(forKey: "str_citynew")
        UserDefaults.standard.removeObject(forKey: "str_gendernew")
        UserDefaults.standard.removeObject(forKey: "str_employernew")
        
        UserDefaults.standard.removeObject(forKey: "str_working_addressnew")
        UserDefaults.standard.removeObject(forKey: "str_incomenew")
        UserDefaults.standard.removeObject(forKey: "str_zonenew")
        UserDefaults.standard.removeObject(forKey: "strMobilenew")
        UserDefaults.standard.removeObject(forKey: "str_occupationnew")
        UserDefaults.standard.removeObject(forKey: "str_occupationnewtext")
        UserDefaults.standard.removeObject(forKey: "str_occupationnew")
        UserDefaults.standard.removeObject(forKey: "str_actualoccupation")
        UserDefaults.standard.removeObject(forKey: "str_actualoccupationtext")
        
        
        
        setFont()
        setFontSize()
        setLang()
        let defaults = UserDefaults.standard
        let reg = defaults.string(forKey: "REGNO") ?? ""
        let id = defaults.string(forKey: "USERID") ?? ""
        let pass = defaults.string(forKey: "PASSW") ?? ""
        let pin = defaults.string(forKey: "PIN") ?? ""
        print("RegisterNo1",reg)
        print("RegisterNo2",id)
        print("RegisterNo3",pass)
        print("RegisterNo4",pin)
        self.img_chat.layer.cornerRadius = 25
        self.countBtn.layer.cornerRadius = 10
        self.udid = UIDevice.current.identifierForVendor!.uuidString
        let isPopupShown = (UserDefaults.standard.object(forKey: "IS_POPUP_SHOWN") as? Bool) ?? false
        let y = "1"
        let x = self.oncecheckpopupstr
        if x == y {
             print("Nullcontentpopup",oncecheckpopupstr)
        }
        
//        if oncecheckpopupstr == "1"
//        {
//
//        }
        else if(!isPopupShown)
        {
            self.getPopupNotificationList()
        }
        
        
        
        //localize
        
        self.sendMoneyLbl.text = (NSLocalizedString("send_money", comment: ""))
        self.myTransactionsLbl.text = (NSLocalizedString("my_transactions", comment: ""))
        self.trackTransactionLbl.text = (NSLocalizedString("track_transactions", comment: ""))
        self.currencyRateLbl.text = (NSLocalizedString("currency_rate", comment: ""))
        self.currencyConverterLbl.text = (NSLocalizedString("currencyconverter", comment: ""))
        self.aboutUsLbl.text = (NSLocalizedString("aboutus", comment: ""))
        self.branchesLbl.text = (NSLocalizedString("branches", comment: ""))
        self.helpLbl.text = (NSLocalizedString("help", comment: ""))
        self.faqlabel.text = (NSLocalizedString("faq", comment: ""))
        //self.Faqbtn.setTitle(NSLocalizedString("faq", comment: ""), for: .normal)
        self.homeLbl.text = (NSLocalizedString("home", comment: ""))
        self.profileLbl.text = (NSLocalizedString("profile", comment: ""))
        self.notifyLbl.text = (NSLocalizedString("notification", comment: ""))
        self.settingsLbl.text = (NSLocalizedString("settings", comment: ""))
        self.logoutLbl.text = (NSLocalizedString("logout", comment: ""))

        
        
        
//        //new logout
//                timer = Timer.scheduledTimer(timeInterval: 1*60, target: self, selector: #selector(HomeViewController.doStuff), userInfo: nil, repeats: true)
//        timerGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.resetTimer));
//                self.view.isUserInteractionEnabled = true
//                self.view.addGestureRecognizer(timerGesture)
        
        //timer.invalidate()
        
        
        //resetTimer()
        //timer.invalidate()
//        timer.fire()
    }
    


    
    @objc func doStuff() {
        // perform any action you wish to
        print("User inactive for more than 1 min 0 seconds .")
        
        timer?.invalidate()
        
//        self.defaults.set("", forKey: "USERID")
//        self.defaults.set("", forKey: "PASSW")
//        self.defaults.set("", forKey: "PIN")
//        self.defaults.set("", forKey: "REGNO")
//
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
//        //        self.navigationController?.pushViewController(nextViewController, animated: true)
//                self.navigationController?.pushViewController(nextViewController, animated: true)
//
//        //callLogoutinactivestate()
       
       
     }
//     @objc func resetTimer() {
//         print("Reset")
//
//        timer.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 1*60, target: self, selector: #selector(HomeViewController.doStuff), userInfo: nil, repeats: true)
//     }
    
    @objc func userIsInactive() {
        // Alert user
        print("\(counter) timer countlogout")
        
//        let alert = UIAlertController(title: "homeYou have been inactive for 5 minutes. We're going to log you off for security reasons.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
//        //Log user off
//        }))
//        present(alert, animated: true)
        
        
        
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

       

        timer?.invalidate()
     
            //timer = nil
        
        return
     }

    @objc func resetTimer() {
        print("Reset")
        timer?.invalidate()
        
        if counter > 0 {
              print("\(counter) seconds to the end of the world")
              counter -= 15*60
            //counter = 0
          }
        print("\(counter) timer resetcountdw")
        
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }
    
 


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer?.invalidate()
    }
     
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        setTitle("", andImage: UIImage(named: "titleImg")!)
        self.validateMultipleLogin()
        self.getToken(num: 2)
        
        print("gett ","gettt")
        
        //timer = nil
        
        timer?.invalidate()
        timer?.fire()
       resetTimer()
       


    }
  

    @IBAction func profileBtn(_ sender: Any) {
        
        timer?.invalidate()
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
//       self.present(nextViewController, animated:true, completion:nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: ProfileViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
       
    }
    @IBAction func notifyBtn(_ sender: Any) {
        
        timer?.invalidate()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: NotificationListViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "notify") as! NotificationListViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func chatBtn(_ sender: Any) {
        let phoneNumber =  "+97444383293" // you need to change this number
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            // WhatsApp is not installed
        }
    }
    @IBAction func settingsBtn(_ sender: Any) {
        
        timer?.invalidate()
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "settingsNav") as! UINavigationController
//        self.present(nextViewController, animated:true, completion:nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: SettingsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "settings") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func logoutBtn(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("gulf_exchange", comment: ""), message: NSLocalizedString("want_to_logout", comment: ""), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { action in
            self.callLogout()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { action in
            
        }))
        self.present(alert, animated: true)
    }
    @IBAction func sendMoneyBtn(_ sender: Any) {
        timer?.invalidate()
        timer = nil
        self.getToken(num: 1)
    }
    @IBAction func myTransactionsBtn(_ sender: Any) {
        
        
        timer?.invalidate()
        
        /*
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "transactions") as! MyTransactionsListViewController
        self.present(nextViewController, animated:true, completion:nil)
        */
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: MyTransactionsListViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "transactions") as! MyTransactionsListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func trackTransactionsBtn(_ sender: Any) {
        
        timer?.invalidate()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: TrackTransactionViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "track") as! TrackTransactionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func currencyRateBtn(_ sender: Any) {
        
        timer?.invalidate()
        
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let vc: CurrencyRateListViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "currencyRateList") as! CurrencyRateListViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: CurrencyRateNEWDViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CurrencyRateNEWDViewController") as! CurrencyRateNEWDViewController
        self.navigationController?.pushViewController(vc, animated: true)

        
        
      }
    @IBAction func currencyConverterBtn(_ sender: Any) {
        /*let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "converter") as! CurrencyConverterViewController
        self.present(nextViewController, animated:true, completion:nil)*/
        
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let vc: CurrencyConverterViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "converter") as! CurrencyConverterViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
        timer?.invalidate()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: CurrencyConverterNewHViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CurrencyConverterNewHViewController") as! CurrencyConverterNewHViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func aboutUsBtn(_ sender: Any) {
        
       // timer = nil
        //resetTimer()
        timer?.invalidate()
       // timer.fire()

        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "aboutus") as! AboutUsViewController
//       self.present(nextViewController, animated:true, completion:nil)
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    @IBAction func branchesBtn(_ sender: Any) {
        
        timer?.invalidate()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "BranchListVC") as! BranchListViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    @IBAction func helpBtn(_ sender: Any) {
        
        timer?.invalidate()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "help") as! HelpViewController
//        self.present(nextViewController, animated:true, completion:nil)
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    
    func setFont() {
        homeLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        profileLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        notifyLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        settingsLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        logoutLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        sendMoneyLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        myTransactionsLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        trackTransactionLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        currencyRateLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        currencyConverterLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        aboutUsLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        branchesLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        helpLbl.font = UIFont(name: "OpenSans-Regular", size: 14)
    }
    func setFontSize() {
        homeLbl.font = homeLbl.font.withSize(14)
        profileLbl.font = profileLbl.font.withSize(14)
        notifyLbl.font = notifyLbl.font.withSize(14)
        settingsLbl.font = settingsLbl.font.withSize(14)
        logoutLbl.font = logoutLbl.font.withSize(14)
        sendMoneyLbl.font = sendMoneyLbl.font.withSize(14)
        myTransactionsLbl.font = myTransactionsLbl.font.withSize(14)
        trackTransactionLbl.font = trackTransactionLbl.font.withSize(14)
        currencyRateLbl.font = currencyRateLbl.font.withSize(14)
        currencyConverterLbl.font = currencyConverterLbl.font.withSize(14)
        aboutUsLbl.font = aboutUsLbl.font.withSize(14)
        branchesLbl.font = branchesLbl.font.withSize(14)
        helpLbl.font = helpLbl.font.withSize(14)
    }
    func setLang() {
        let lang = defaults.string(forKey: "appLang")
        print("appLang Home",lang ?? "")
//        self.homeLbl.text = NSLocalizedString("home", comment: "")
        
    }
    func getToken(num:Int) {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        
        let url = ge_api_url + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        ChangeEmailViewController.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                
                print("token4  ",token)
                if(num == 1)
                {
                    self.validateRemittanceStatus(check: 1, accessToken: token)
                    self.timer?.invalidate()
                    self.resetTimer()
                }
                else if(num == 2)
                {
                    self.getNotificationCount(accessToken: token)
                    self.timer?.invalidate()
                    self.resetTimer()
                }
                
                else if(num == 3)
                {
                    self.getProfileInfo(access_token: token)
                    self.timer?.invalidate()
                    self.resetTimer()
                }
                
                
                
                break
            case .failure:
                break
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
    
    //api
    func getProfileInfo(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]

        ProfileViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("respviewprof",response)
            self.effectView.removeFromSuperview()
            let respCode = myResult!["responseCode"]
            if(respCode == "S104")
            {
                
                //store local in app
                
                

                self.namestr =  myResult!["workingAddress3"].stringValue
                self.emailstr = myResult!["email"].stringValue
                self.phonestr =  myResult!["customerMobile"].stringValue
                print("self.namestr",self.namestr)
                print("self.emailstr",self.emailstr)
                print("self.phonestr",self.phonestr)
                self.getGolalitaInfo()
               // self.getToken(num: 2)
                
                
                
                
                
                
            }
        })
    }
    
    
    func getGolalitaInfo() {
       // self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = Glolitaapi
        
      //  let params:Parameters =  ["Name":"sayed","Email":"test@gulf.com","Phone":"+97430444432"]
        
        let params:Parameters =  ["Name":namestr,"Email":self.emailstr,"Phone":self.phonestr]
        
       // let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        print("urlg",url)
        print("paramsg",params)
//
//        LoginViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//
//            let myResult = try? JSON(data: response.data!)
//            print("respgloatia",response)
//            self.effectView.removeFromSuperview()
//            let respCode = myResult!["responseCode"]
//            if(respCode == "S104")
//            {
//
//                //store local in app
//
//
//
//
//
//
//
//
//
//
//
//            }
//        })
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                self.activityIndicator.stopAnimating()
                
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        print("Response JSON:", json)
                        
                        let dataa = json["data"]
                        
                        //let pdfstringurl = json["data"].stringValue
                        if dataa  == nil
                        {
                            
                        }
                        else
                        {
                            self.pdfglolalitastr = dataa as! String
                        }
                        if self.pdfglolalitastr.isEmpty == false
                        {
                            
                         //   let url = URL(string: self.pdfglolalitastr)
                            //check test
//                            print("urlwebview  ",url)
//
//                            self.webView.load(URLRequest(url: url!))
//                            self.webView.allowsBackForwardNavigationGestures = true
                            if let url = URL(string: self.pdfglolalitastr) {
                                        // Check if the URL can be opened
                                        if UIApplication.shared.canOpenURL(url) {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                         
                                        } else {
                                            // Handle the case where the URL cannot be opened
                                            print("Cannot open URL")
                                        }
                                    } else {
                                        // Handle the case where the URL is invalid
                                        print("Invalid URL")
                                    }
                            self.dismiss(animated: true)
                        }
            
                        
                        
//                        print("dataaaa:", dataa)
                        print("dataaaayyyy:", self.pdfglolalitastr ?? "")
                        // Accessing responseCode from JSON
                        if let respCode = json["responseCode"] as? String {
                            if respCode == "S104" {
                                // Handle success scenario here
                                print("Login successful")
                                
                                // Example: Store local data in app if needed
                            } else {
                                // Handle other response codes or scenarios
                                print("Login failed with code:", respCode)
                            }
                        } else {
                            print("Response code not found in JSON")
                        }
                    } else {
                        print("Response data is not in expected JSON format")
                    }
                    
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                    // Handle error scenario, e.g., show an alert to the user
                }
            }
        
    }

    
    
    
    
    func validateRemittanceStatus(check:Int,accessToken:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
        let url = ge_api_url + "utilityservice/validation"
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                     print("appVersion",appVersion)
        
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":"","mpin":"","customerEmail":"","customerMobile":"1.0","customerPhone":"IOS","beneficiaryAccountNo":"","iban":"","customerDOB":"1900-01-01","validationMethod":"ISREMITALLOWED","isExistOrValid":"0"]
        
        print("paramsvalidationutility ",params)
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
        
        ChangeEmailViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            self.effectView.removeFromSuperview()
            print("validateemail ",response)
            
            let myResult = try? JSON(data: response.data!)
            let respCode = myResult!["responseCode"]
             print("respCoderespCoderespCode ",respCode)
            let respMsg = myResult!["responseMessage"].stringValue
            if(respCode == "S1111")
            {
                if(check == 1)
                {
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem1") as! RemittancePage1ViewController
//                    self.present(nextViewController, animated:true, completion:nil)
                    self.navigationController?.pushViewController(nextViewController, animated: true)

                }
                else if(check == 2)
                {
                    
                }
                else if(check == 3)
                {
                    
                }
            }
            else if(respCode == "S2222")
            {
                let commonAlert = UIAlertController(title:NSLocalizedString("gulf_exchange", comment: ""), message: respMsg, preferredStyle:.alert)
                let okAction = UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .cancel){ (action:UIAlertAction) in
                                  
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rem1") as! RemittancePage1ViewController
                    //                    self.present(nextViewController, animated:true, completion:nil)
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
                
                //original
                AlertView.instance.showAlert(msg: respMsg, action: .attention)
                
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
                                  
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                   // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let vc: ProfileViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profile") as! ProfileViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                                    
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
                AlertView.instance.showAlert(msg: NSLocalizedString("u_r_not_allowed", comment: "") + NSLocalizedString("contact_customer_care", comment: ""), action: .attention)
            }
            
        
        })
    }
    func getNotificationCount(accessToken:String) {
        print("notification count......")
        self.count = 0
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            let dateTime:String = getCurrentDateTime()
            let url = ge_api_url + "utilityservice/listordeletenotification"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW") ?? "","mpin":defaults.string(forKey: "PIN") ?? "","notificationID":"","messageReadFag":" ","actionType":"LIST"]
            let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
            
            HomeViewController.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                
                self.effectView.removeFromSuperview()
                print("validateemail ",response)
                let myResult = try? JSON(data: response.data!)
                let respCode = myResult!["responseCode"]
                let respMsg = myResult!["responseMessage"].stringValue
                print("respCode...",respCode)
                print("respMsg...",respMsg)
                if(respCode == "S120")
                {
                    let resultArray = myResult!["notificationList"]
                    for i in resultArray.arrayValue{
                        if(i["messageReadFlag"].stringValue == "UNREAD")
                        {
                            self.count = self.count + 1
                            print("countt",self.count)
                            
                            
                        }
                        if(self.count == 0)
                        {
                            self.countBtn.isHidden = true
                        }
                        else{
                            self.countBtn.isHidden = false
                            self.countBtn.setTitle(String(self.count), for: .normal)
                        }
                    }
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
                               print("NullcontentpopupNEWVER",self.oncecheckpopupstr)
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
    
    
    
    
     func getPopupNotificationList() {
        var notificMessageList: [String] = []
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
              let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
                self.activityIndicator(NSLocalizedString("loading", comment: ""))
                let url = api_url + "popup_notification_listing"
            let params:Parameters = ["lang": appLang]
                  AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                    print("popup_notification_listing response",response)
                    switch response.result{
                    case .success:
                        guard let responseData = response.data else {
                            return
                        }
                        guard let myResult = try? JSON(data: responseData) else {
                            return
                        }
                        let popupListing = myResult["popup_notification_listing"]
                        if(popupListing.count > 0) {
                            for popupObject in popupListing.arrayValue {
                                let currentItemKey = "popup_notf_desc_" + appLang
                                let currentItemEn = "popup_notf_desc_en"
                                let desc = popupObject[currentItemKey].stringValue
                                let desc2 = popupObject[currentItemEn].stringValue
                                if(desc != "") {
                                let descString = desc
                                notificMessageList.append(descString)
                                     print("descprint",descString)
//                                self.showPopupAlert(desc: descString)
                                } else if(desc2 != "") {
                                let desc2String = desc
                                notificMessageList.append(desc2String)
                                    print("descprint2",desc2String)
//                                self.showPopupAlert(desc: desc2String)
                            }
                        }
                            
                            let a = ["", "", ""]
                            let b = notificMessageList
                         if a == b {
                              print("Nullcontentpopup",notificMessageList)
                         }
                            else
                         {
                            if notificMessageList.count > 0 {
                            self.showPopupAlert(descArray: notificMessageList)
                                  print("contentpopup",notificMessageList)
                                
                                self.oncecheckpopupstr = "1"
                                //
                                print("Nullcontentpopup",self.oncecheckpopupstr)
                            }
                            }
                            
                            
                            
                        }
                    break
                    case .failure:
                        break
                    
                    }
                  })
        }
    

    func showPopupAlert(descArray: [String]) {
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
            UserDefaults.standard.set(true, forKey: "IS_POPUP_SHOWN")
            let popup : PopupViewController = self.storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
            self.presentOnRoot(with: popup, descArray: arrayFilter)
        }
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
    
    
    func callLogout() {
    
    self.activityIndicator(NSLocalizedString("loading", comment: ""))
    
            let url = api_url + "login_session_delete"
        let params:Parameters = ["id_no":self.defaults.string(forKey: "USERID") ?? "","session_id":self.udid ?? ""]

              AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                self.effectView.removeFromSuperview()
                print("resp",response)
                switch response.result{
                case .success:
                    
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
                    
                    
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
                    //        self.navigationController?.pushViewController(nextViewController, animated: true)
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                    
                  //  UIControl().sendAction(#selector(NSXPCConnection.suspend),
                                         //  to: UIApplication.shared, for: nil)
                    
                    break
                case .failure:
                    break
                
                }
              })
        }
    func validateMultipleLogin() {
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            
            let url = api_url + "login_session"
        let params:Parameters = ["id_no":self.defaults.string(forKey: "USERID") ?? "","session_id":self.udid ?? ""]

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
    
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension UIViewController {
    func presentOnRoot(`with` viewController : PopupViewController, descArray: [String]){
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.descArray = descArray
        self.present(viewController, animated: false, completion: nil)
    }
}

