//
//  SelectLanguageViewController.swift
//  GulfExchangeApp
//
//  Created by test on 09/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SelectLanguageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tblLang: UITableView!
    @IBOutlet weak var selectBtn: UIButton!
    
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()

   

    
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var langArray:[Language] = []
    var selectedRow:Int = 0
    let defaults = UserDefaults.standard
    var langCode:String = ""
    var isFromSettings = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

        resetTimer()

        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("select_language", comment: "")
        let check = isKeyPresentInUserDefaults(key: "appLang")
        print("check",check)
        if(check)
        {
            print("check1",check)
            
        }
        else{
            print("check2",check)
            
        }
        tblLang.dataSource = self
        tblLang.delegate = self
        getLang()
        self.selectBtn.setTitle("Select", for: .normal)
        selectBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        selectBtn.layer.cornerRadius = 15
        selectBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    
    
    @objc func userIsInactive() {
        // Alert user
//        let alert = UIAlertController(title: "You have been inactive for 5 minutes. We're going to log you off for security reasons.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
//        //Log user off
//        }))
//        present(alert, animated: true)
        
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }

    
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        if UserDefaults.standard.string(forKey: "USERID") == nil{
            self.navigationItem.hidesBackButton = true
        }else{
            self.navigationItem.hidesBackButton = false
        }
        setTitle("", andImage: UIImage(named: "titleImg")!)
        
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func selectBtn(_ sender: Any) {
        
        print("lang Code",langCode)
        
        if(langCode == "")
        {
            self.view.makeToast("Please select language", duration: 3.0, position: .center)
            return
        }
        
        if(langCode == "")
        {
            defaults.set("en", forKey: "appLang")
            self.languageButtonAction(appLang: "en")
            //            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
        }
        else{
            defaults.set(self.langCode, forKey: "appLang")
            self.languageButtonAction(appLang: self.langCode)
            // app direction
            
            
            //            LocalizationSystem.sharedInstance.setLanguage(languageCode: self.langCode)
        }
        
        //        if UserDefaults.standard.string(forKey: "USERID") == nil{
        //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //            let vc: LoginViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as! LoginViewController
        //            self.navigationController?.pushViewController(vc, animated: true)
        //
        //        }else{
        //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        //
        //            let customViewControllersArray : NSArray = [newViewController]
        //            self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
        //            self.navigationController?.pushViewController(newViewController, animated: true)
        //
        //        }
        
    }
    func languageButtonAction(appLang:String) {
        // This is done so that network calls now have the Accept-Language as "hi" (Using Alamofire) Check if you can remove these
        UserDefaults.standard.set([appLang], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        // Update the language by swaping bundle
        Bundle.setLanguage(appLang)
        if appLang == "ar" || appLang == "ur" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        // Done to reintantiate the storyboards instantly
        if(isFromSettings) {
            let newViewController: HomeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
            let navigationController = UINavigationController(rootViewController: newViewController)
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.rgba(198, 23, 30, 1)]
            navigationController.navigationBar.titleTextAttributes = textAttributes
            navigationController.navigationBar.tintColor = UIColor.rgba(198, 23, 30, 1)
            if #available(iOS 11.0, *) {
                navigationController.navigationBar.largeTitleTextAttributes = textAttributes
            } else {
                // Fallback on earlier versions
            }
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        } else {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
        }
    }
    
    func getLang() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "language_listing"
        
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                
                let myresult = try? JSON(data: response.data!)
                let resultArray = myresult!["language_listing"]
                for i in resultArray.arrayValue{
                    let lang = Language(name: i["name"].stringValue, code: i["code"].stringValue, id: i["id"].stringValue)
                    self.langArray.append(lang)
                }
                self.tblLang.reloadData()
                break
            case .failure:
                break
                
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "langCell") as! languageTableViewCell
        let lang = langArray[indexPath.row]
        cell.setLanguage(lang: lang)
        print("row",selectedRow)
        
        self.timerGesture.isEnabled = false
        if(indexPath.row == selectedRow)
        {
            if(langCode == "")
            {
                cell.selectBtn.setImage(UIImage(named: "unchecked"), for: .normal)
            }
            else
            {
            cell.selectBtn.setImage(UIImage(named: "checked"), for: .normal)
            }
        }
        else{
            cell.selectBtn.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        let code:String = lang.code
        let url = flag_url + code + ".png"
        //let imgResource = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
        let imgResource = URL(string: url)
        cell.flagImg.kf.setImage(with: imgResource)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let cell: languageTableViewCell = self.tblLang.cellForRow(at: indexPath) as! languageTableViewCell
        let str: String = cell.langLbl.text!
        selectedRow = indexPath.row
        self.tblLang.reloadData()
        let lang = langArray[indexPath.row]
        self.langCode = lang.code
        let selectText = self.setSelectText(code: lang.code)
        self.selectBtn.setTitle(selectText, for: .normal)
        
        self.timerGesture.isEnabled = true
    }
    
    func setSelectText(code: String) -> String {
        var selectText = "Select"
        switch code {
        case "en":
            selectText = "Select"
        case "ar":
            selectText = "تحديد"
        case "hi":
            selectText = "चुनते हैं"
        case "ml":
            selectText = "തിരഞ്ഞെടുക്കുക"
        case "ta":
            selectText = "தேர்ந்தெடுக்கவும்"
        case "bn":
            selectText = "নির্বাচন করা"
        case "ne":
            selectText = "चयन गर्नुहोस्"
        case "tr":
            selectText = "seçmek"
        case "sw":
            selectText = "chagua"
        case "si":
            selectText = "තෝරන්න"
        case "tl":
            selectText = "piliin"
        case "ur":
            selectText = "منتخب کریں"
        case "fr":
            selectText = "sélectionner"
        case "id":
            selectText = "Pilih"
        default:
            selectText = "Select"
        }
        return selectText
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
