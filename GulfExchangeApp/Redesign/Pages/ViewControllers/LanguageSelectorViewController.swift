//
//  LanguageSelectorViewController.swift
//  GulfExchangeApp
//
//  Created by macbook on 13/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class LanguageSelectorViewController: UIViewController{

    @IBOutlet weak var tblLang: UITableView!
    @IBOutlet weak var selectBtn: UIButton!
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    var timer = Timer()
    
    var timerGesture = UITapGestureRecognizer()

   

    
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var langArray:[Language] = []
    var langArrayMain:[Language] = []
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
        searchTF.delegate = self
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)
        configureButton(button: searchBtn, title: "", size: 12, font: .regular)
        resetTimer()
        if isFromSettings{
            addNavbar()
        }else{
            addNavbarLoggedin()
        }
        
//        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
//        self.navigationItem.rightBarButtonItem  = custmHelpBtn
//        self.title = NSLocalizedString("select_language", comment: "")
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

    
    
    
  
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        if isFromSettings{
            addNavbar()
        }else{
            addNavbarLoggedin()
        }
//        if UserDefaults.standard.string(forKey: "USERID") == nil{
//            self.navigationItem.hidesBackButton = true
//        }else{
//            self.navigationItem.hidesBackButton = false
//        }
//        setTitle("", andImage: UIImage(named: "titleImg")!)
        
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HelpVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addNavbarLoggedin(){
        let imageView = UIImageView(image: UIImage(named: "ge_logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let leftBarButtonItem = UIBarButtonItem(customView: imageView)
        let helpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = helpBtn
        self.navigationItem.leftBarButtonItem = createBarButtonItem(title: "Choose the language", size: 16, font: .medium)
    }
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("select_language", comment: "")
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        langArrayMain
    }
    
    
    @IBAction func selectBtn(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("select", languageCode: "en")
        }
        
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
        let data = ["language": true] as [String : Any]
        NotificationCenter.default.post(name: languageChangedNotification, object: nil, userInfo: data)
        if(isFromSettings) {
            let newViewController: CustomTabController = UIStoryboard.init(name: "Main10", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
            let navigationController = UINavigationController(rootViewController: newViewController)
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.rgba(19, 56, 82, 1)]
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
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.rgba(19, 56, 82, 1)]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            navigationController?.navigationBar.tintColor = UIColor.rgba(198, 23, 30, 1)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
            
        }
    }
    
    func getLang() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "language_listing"
        
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getLang resp",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                
                let myresult = try? JSON(data: response.data!)
                let resultArray = myresult!["language_listing"]
                for i in resultArray.arrayValue{
                    let lang = Language(name: i["name"].stringValue, code: i["code"].stringValue, id: i["id"].stringValue)
                    self.langArray.append(lang)
                    self.langArrayMain.append(lang)
                }
                self.tblLang.reloadData()
                break
            case .failure:
                break
                
            }
        })
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

extension LanguageSelectorViewController:  UITableViewDelegate, UITableViewDataSource {
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
                cell.selectBtn.setImage(UIImage(named: ""), for: .normal)
                cell.backgroundColor = UIColor.clear
            }
            else
            {
                cell.backgroundColor = UIColor.rgba(255, 245, 245, 1)
            cell.selectBtn.setImage(UIImage(named: "selected_red"), for: .normal)
            }
        }
        else{
            cell.selectBtn.setImage(UIImage(named: ""), for: .normal)
            cell.backgroundColor = UIColor.clear
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
    
}
extension LanguageSelectorViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if updatedText.isEmpty {
            // If the text field is empty, reset the filtered branches
            langArray = langArrayMain
        } else {
            langArray = langArrayMain.filter { item in
                if let country = item.name as? String{
                    return country.lowercased().contains(updatedText.lowercased())
                }
                return false
            }
        }
        tblLang.reloadData()
        return true
    }
        
}
