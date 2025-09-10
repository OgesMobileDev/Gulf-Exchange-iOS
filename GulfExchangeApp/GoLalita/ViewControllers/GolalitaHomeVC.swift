//
//  GolalitaHomeVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 16/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CommonCrypto
import PassKit

class GolalitaHomeVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var emptyBtn: [UIButton]!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var notificationCountLbl: UILabel!
    @IBOutlet weak var notificationImg: UIImageView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTFView: UIView!
    @IBOutlet weak var categoryAllBtn: UIButton!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var newMemberView: UIView!
    @IBOutlet weak var newMemberAllBtn: UIButton!
    @IBOutlet weak var newMemberCollectionView: UICollectionView!
    @IBOutlet weak var merchantView: UIView!
    @IBOutlet weak var merchantBtn: UILabel!
    @IBOutlet weak var merchantCollectionView: UICollectionView!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var currentSMPage: SideMenuSelection = .home
    let sideMenu = Bundle.main.loadNibNamed("GolalitaSideMenuView", owner: GolalitaHomeVC.self, options: nil)?.first as! GolalitaSideMenu
    let defaults = UserDefaults.standard
    
    
    var userEmail = ""
    //sajeev@ogesinfotech.com
    var userPassword = ""
    var userName = ""
    var userPhone = ""
    var userFirstName = ""
    /*
     gl email - Optional("tst@tst.com")
     gl password - Optional("Omar@1235")
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        GolalitaApiManager.shared.clearAll()
        
        //        print(defaults.string(forKey: "PASSW"))
        //        print(defaults.string(forKey: "USERID"))
        //        print(defaults.string(forKey: "strEmailnew"))
        
        userPassword = defaults.string(forKey: "PASSW") ?? ""
        userFirstName = defaults.string(forKey: "GLFirstName") ?? ""
        userEmail = defaults.string(forKey: "GLEmail") ?? ""
        userName = defaults.string(forKey: "GLUserName") ?? ""
        userPhone = defaults.string(forKey: "GLPhone") ?? ""
        nameLbl.text = userFirstName + "👋"
        print("GL Email - \(userEmail)\n GLUserName - \(userName)\n GLPhone - \(userPhone)\n GLPassword -\(userPassword) ")
        sideMenu.delegate = self
        self.categoryCollectionView?.register(UINib.init(nibName: "GolalitaHomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "GolalitaHomeCollectionViewCell")
        categoryCollectionView?.delegate = self
        categoryCollectionView?.dataSource = self
        self.newMemberCollectionView?.register(UINib.init(nibName: "GolalitaHomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "GolalitaHomeCollectionViewCell")
        newMemberCollectionView?.delegate = self
        newMemberCollectionView?.dataSource = self
        self.merchantCollectionView?.register(UINib.init(nibName: "GolalitaHomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "GolalitaHomeCollectionViewCell")
        merchantCollectionView?.delegate = self
        merchantCollectionView?.dataSource = self
        
        self.searchResultTableView.isHidden  = true
        searchTF.delegate = self
        self.searchResultTableView.register(UINib.init(nibName: "SearchResultsTableViewCell", bundle: .main), forCellReuseIdentifier: "SearchResultsTableViewCell")
        
        for button in emptyBtn{
            button.setTitle("", for: .normal)
        }
        
        addShadow(view: searchTFView)
        addNavbar()
        checkEmail()
//                fetchAllAPIs()
        
        //        getToken()
        
    }
    
    @IBAction func notificationBtnTapped(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: GLAllNotificationsVC = UIStoryboard.init(name: "MainGolalita", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLAllNotificationsVC") as! GLAllNotificationsVC
        //        vc.currentPage = .category
        self.navigationController?.pushViewController(vc, animated: true)
        
//        getAppleWallet()
    }
    @IBAction func sideMenuBtnTapped(_ sender: Any) {
        if searchResultTableView.isHidden == false{
            sideMenuBtn.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
            searchResultTableView.isHidden = true
        }else{
            sideMenu.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            sideMenu.alpha = 0.0
            sideMenu.setdata()
            view.addSubview(sideMenu)
            print("SendMoneyView")
            UIView.animate(withDuration: 0.3, animations: {
                self.sideMenu.alpha = 1.0
            })
            
            print("sideMenuBtnTapped")
        }
    }
    @IBAction func categoryAllBtnTapped(_ sender: Any) {
        print("categoryAllBtnTapped")
        //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: GLCategoryVC = UIStoryboard.init(name: "MainGolalita", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLCategoryVC") as! GLCategoryVC
        vc.currentPage = .category
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func newMemberAllBtnTapped(_ sender: Any) {
        print("newMemberAllBtnTapped")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: GLCategoryVC = UIStoryboard.init(name: "MainGolalita", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLCategoryVC") as! GLCategoryVC
        vc.currentPage = .member
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func merchantAllBtnTapped(_ sender: Any) {
        print("merchantAllBtnTapped")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: GLCategoryVC = UIStoryboard.init(name: "MainGolalita", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLCategoryVC") as! GLCategoryVC
        vc.currentPage = .merchant
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.navigationItem.title = "Golalita Rewards"
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HelpVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
   /* func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
        if let backImage = UIImage(named: "arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.navigationItem.title = "Golalita Rewards"
    }*/
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func SetApiData(){
//        nameLbl.text = (GolalitaApiManager.shared.userProfile?.name ?? "") + "👋"
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        print("done","")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("typp","")
        
        if ((searchTF.text?.isEmpty) != nil)
        {
            getSearchResults(searchTxt:searchTF.text!)
        }
        else
        {
            print(".....","")
        }
        
        return true
    }
    
    
    
    //MARK: API CALLS
    
    func fetchAllAPIs() {
        let mainGroup = DispatchGroup()
        
        mainGroup.enter()
        getToken { [self] in
            
            let parallelGroup = DispatchGroup()
            parallelGroup.enter()
            
            getCategory { [self] in
                parallelGroup.leave()
                
                mainGroup.enter()
                getNewMerchant {
                    mainGroup.leave()
                    
                    mainGroup.enter()
                    getNotification {
                        mainGroup.leave()
                    }
                }
            }
            parallelGroup.enter()
            getAllMerchant {
                parallelGroup.leave()
            }
            parallelGroup.notify(queue: .main) {
                mainGroup.leave()
            }
        }
        
        // Notify once all API calls are done
        mainGroup.notify(queue: .main) {
            self.SetApiData()
            self.categoryCollectionView.reloadData()
            self.newMemberCollectionView.reloadData()
            self.merchantCollectionView.reloadData()
            self.getProfile()
            // self.getNotification()
            // self.getNotification()
            
        }
    }
    
    func checkEmail(){
            self.activityIndicator(NSLocalizedString("loading", comment: ""))
            let params: Parameters = [
                "params": [
                    "email": userEmail
                ]
            ]
            //"mailto:email":"safeermeppayur@gmail.com"
            print("checkEmail - parameters: \(params)")
            AF.request(GLCheckEmail, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                print("checkEmail Response - \(response) - \n")
                switch response.result {
                case .success:
                    // Safely unwrap the response data
                    if let data = response.data {
                        do {
                            // Decode the response data into ApiResponse model
                            let response = try JSONDecoder().decode(CheckEmailResponse.self, from: data)
                            
                            // Check if there is an error message
                            if let errorMessage = response.result?.error {
                                if errorMessage == "User already exits with this email !!" || errorMessage == "User already exists with this email !!" {
                                    // Call the fetchApi() function
                                    self.fetchAllAPIs()
                                } else if errorMessage == "User already exists with this email, Try to reset the password !!" {
                                    self.showAlert(title: "Error", message: errorMessage)
                                    print("Error: \(errorMessage)")
                                }else{
                                    self.showAlert(title: "Error", message: "User registration failed! Please try again")
                                    print("Error: \(errorMessage)")
                                }
                            }
                            
                            // Check if there is a success message
                            if let successMessage = response.result?.sucess {
                                print("Success: \(successMessage)")
                                if successMessage == "This email is not associated with any users yet !"{
                                    self.registerUser()
                                }
                            }else  if let successMessage = response.result?.success {
                                print("Success: \(successMessage)")
                                if successMessage == "This email is not associated with any users yet !"{
                                    self.registerUser()
                                }
                            }
                            
                        } catch {
                            self.showAlert(title: "Error", message: "User registration failed! Please try again")
                            print("Failed to decode response: \(error)")
                        }
                        
                    } else {
                        self.showAlert(title: "Error", message: "User registration failed! Please try again")
                        print("Error: No data in response")
                    }
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            })
        }
    
    func registerUser(){
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        let url = "https://www.golalita.com/organisation/employee/registration/v2/gulf/exchange"
        let params: Parameters = [
            "params": [
                "parent_id": "3898",
                "password": userPassword,
                "email": userEmail,
                "name": userName,
                "phone": userPhone
                //                "code":""
            ]
        ]
        print("registerUser - parameters: \(params)")
        
        AF.request(GLRegisterUser, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("registerUser Response - \(response) - \n")
            switch response.result {
            case .success:
                // Safely unwrap the response data
                if let data = response.data {
                    do {
                        // Decode the response data into RegistrationResponse model
                        let response = try JSONDecoder().decode(RegistrationResponse.self, from: data)
                        print("register response model - \(response)")
                        if let isSuccess = response.result?.success{
                            if isSuccess == "true" || isSuccess == "1"{
                                // Call getToken() if the response is successful
                                self.fetchAllAPIs()
                            }else{
                                self.showAlert(title: "Error", message: "User registration failed! Please try again")
                            }
                        } else if let errorMessage = response.result?.error {
                            // Handle different error messages
                            if errorMessage == "User is already registered with this code" {
                                // Also call getToken() for this specific error
                                self.fetchAllAPIs()
                            } else {
                                // Call checkEmail() for other error cases
                                print("Error: \(errorMessage)")
                                self.showAlert(title: "Error", message: "User registration failed! Please try again")
                            }
                            
                        }
                    } catch {
                        print("Failed to decode response: \(error)")
                    }
                    
                } else {
                    print("Error: No data in response")
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    /*
    func checkEmail(){
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        let url = "https://www.golalita.com/go/api/user/email/check"
        let params: Parameters = [
            "params": [
                "email": userEmail
            ]
        ]
        print("checkEmail - parameters: \(params)")
        AF.request(GLCheckEmail, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("checkEmail Response - \(response) - \n")
            switch response.result {
            case .success:
                // Safely unwrap the response data
                if let data = response.data {
                    do {
                        // Decode the response data into ApiResponse model
                        let response = try JSONDecoder().decode(CheckEmailResponse.self, from: data)
                        
                        // Check if there is an error message
                        if let errorMessage = response.result?.error {
                            if errorMessage == "User already exits with this email !!" {
                                // Call the fetchApi() function
                                self.fetchAllAPIs()
                            } else {
                                self.showAlert(title: "Error", message: "User registration failed! Please try again")
                                print("Error: \(errorMessage)")
                            }
                        }
                        
                        // Check if there is a success message
                        if let successMessage = response.result?.sucess {
                            print("Success: \(successMessage)")
                            if successMessage == "This email is not associated with any users yet !"{
                                self.registerUser()
                            }
                        }
                        
                    } catch {
                        self.showAlert(title: "Error", message: "User registration failed! Please try again")
                        print("Failed to decode response: \(error)")
                    }
                    
                } else {
                    self.showAlert(title: "Error", message: "User registration failed! Please try again")
                    print("Error: No data in response")
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    func registerUser(){
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        //        let url = "https://www.golalita.com/organisation/employee/registration/v2/gulf/exchange"
        let params: Parameters = [
            "params": [
                "parent_id": "3898",
                "password": userPassword,
                "email": userEmail,
                "name": userName,
                "phone": userPhone
                //                "code":""
            ]
        ]
        print("registerUser - parameters: \(params)")
        
        AF.request(GLRegisterUser, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("registerUser Response - \(response) - \n")
            switch response.result {
            case .success:
                // Safely unwrap the response data
                if let data = response.data {
                    do {
                        // Decode the response data into RegistrationResponse model
                        let response = try JSONDecoder().decode(RegistrationResponse.self, from: data)
                        print("register response model - \(response)")
                        if let isSuccess = response.result?.success{
                            if isSuccess == "true" || isSuccess == "1"{
                                // Call getToken() if the response is successful
                                self.fetchAllAPIs()
                            }else{
                                self.showAlert(title: "Error", message: "User registration failed! Please try again")
                            }
                        } else if let errorMessage = response.result?.error {
                            // Handle different error messages
                            if errorMessage == "User is already registered with this code" {
                                // Also call getToken() for this specific error
                                self.fetchAllAPIs()
                            } else {
                                // Call checkEmail() for other error cases
                                print("Error: \(errorMessage)")
                                self.showAlert(title: "Error", message: "User registration failed! Please try again")
                            }
                            
                        }
                    } catch {
                        print("Failed to decode response: \(error)")
                    }
                    
                } else {
                    print("Error: No data in response")
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    */
    
    func getToken(completion: @escaping () -> Void) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let ePassword = ""
        print(" e password -- \(ePassword)")
        let udid = UIDevice.current.identifierForVendor!.uuidString
        let url = "https://www.golalita.com/go/api/gulfexc/get_token"
//        let key = "My157187ghja8971998189198"
        let key = "e9e6b0138afe1c861d7c9d3af96e33d3"
        let encryptedPassword = encrypt(plaintext: userPassword, key: key)
        print ("encryptedPassword\(encryptedPassword)")
        /*
         "login": email,
         "password": ePassword,
         "device_id": "string",
         "device_token": "",
         "device_type": "android"
         "login": "devtest@gulf.com",
         "password": "DtYEfpygjA7SBZVGStepKFrxqNkt7E8ScNBIrF6/R6A=",
         "device_id": "string",
         "device_token": "",
         "device_type": "android"
         
         */
        //        c2FOoCXNSTVfdzrZXR4F4uDGQxAN9rHp4ZQvnlvEQHA=
        /*
         "login": "devtest@gulf.com",
         "password": "DtYEfpygjA7SBZVGStepKFrxqNkt7E8ScNBIrF6/R6A=",
         "login": userEmail,
         "password": encryptedPassword,
         "login": "devtest@gulf.com",
         "password": "DtYEfpygjA7SBZVGStepKFrxqNkt7E8ScNBIrF6/R6A=",
         "login": email,
         "password": encryptedPassword,
         "device_id": udid,
         */
        let params: Parameters = [
            "params": [
                "login": userEmail,
                "password": encryptedPassword,
                "device_id": udid,
                "device_token": "",
                "device_type": "android"
            ]
        ]
        
        //        let params:Parameters = [ "token": "2c30e14317714e728a61cdbe9eefb5f1", "fields":"['id','name','image_url','x_image_url_2']"]
        print("url getToken",url)
        print("params getToken",params)
        AF.request(GLGetToken, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("Response - \(response) - \n")
            switch response.result {
            case .success:
                // Safely unwrap the response data
                if let data = response.data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let result = jsonResponse["result"] as? [String: Any],
                           let error = result["error"] as? String {
                            
                            // Check if the error is "Invalid User Token"
                            if error == "Invalid User Token" {
                                self.showAlertHome(title: "Error", message: "Your session has expired. Please return to the home page")
                            } else {
                                print("No problem with the response")
                                // Handle other cases here if needed
                            }
                        }
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                    GolalitaApiManager.shared.updateUserProfile(from: data)
                    
                    
                    GolalitaApiManager.shared.userToken = GolalitaApiManager.shared.userProfile?.token ?? ""
                    
                    
                } else {
                    print("Error: No data in response")
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            completion()
        })
    }
    func getCategory(completion: @escaping () -> Void){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        let url = "https://www.golalita.com/go/api/partner.category/search"
        let params: Parameters = [
            "params": [
                "token": token,
                "fields":"['id','name','image_url','x_image_url_2']"
            ]
        ]
        AF.request(GLGetCategory, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            //            print("getCategory Response - \(response) - \n")
            switch response.result {
            case .success:
                if let data = response.data {
                    
                    GolalitaApiManager.shared.updateCategory(from: data)
                    
                } else {
                    print("Error: No data in response")
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            completion()
        })
    }
    func getNewMerchant(completion: @escaping () -> Void){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        //        let url = "https://www.golalita.com/go/api/gulfexc/category/new/merchant/lists"
        let params: Parameters = [
            "params": [
                "token": token,
            ]
        ]
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        AF.request(GLGetNewMerchants, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
             print("getNewMerchant Response - \(response) - \n")
            
            switch response.result {
            case .success:
                if let data = response.data {
                    GolalitaApiManager.shared.updateNewMerchant(from: data)
                    
                } else {
                    print("Error: No data in response")
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            completion()
        })
    }
    func getAllMerchant(completion: @escaping () -> Void){
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        //        let url = "https://golalita.com/go/api/gulfexc/category/merchant/lists"
        let params: Parameters = [
            "params": [
                "token": token,
                //                "x_online_store": null,
                //                "category_id":null,
                //                "merchant_name":null,
                //                "merchant_id": null
            ]
        ]
        AF.request(GLGetAllMerchants, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            //            print("getNewMerchant Response - \(response) - \n")
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let result = jsonResponse["result"] as? [String: Any],
                           let error = result["error"] as? String {
                            
                            // Check if the error is "Invalid User Token"
                            if error == "Invalid User Token" {
                                self.showAlertHome(title: "Error", message: "Your session has expired. Please return to the home page")
                            } else {
                                print("No problem with the response")
                                // Handle other cases here if needed
                            }
                        }
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                    GolalitaApiManager.shared.updateAllMerchant(from: data)
                    //                    print(GolalitaApiManager.shared.newMerchants)
                    
                } else {
                    print("Error: No data in response")
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            completion()
        })
    }
    func getProfile(){
        let token = GolalitaApiManager.shared.userToken
        let params: Parameters = [
            "params": [
                "token": token,
            ]
        ]
        print("getProfile parameters - \(params)\n")
        AF.request(GLGetProfile, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getProfile Response - \(response) - \n")
            switch response.result {
            case .success:
                if let data = response.data {
                    GolalitaApiManager.shared.updateUserCardData(from: data)
                    self.effectView.removeFromSuperview()
                } else {
                    print("Error: No data in response")
                    self.effectView.removeFromSuperview()
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.effectView.removeFromSuperview()
            }
        })
    }
    
    
    
    
    
    func getNotification(completion: @escaping () -> Void){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        //        let url = "https://www.golalita.com/go/api/gulfexc/category/new/merchant/lists"
        let params: Parameters = [
            "params": [
                "token": token,
            ]
        ]
        
        print("getnotificationurluu - \(GLNotificationlist)\n")
        print("getnotificationparameters - \(params)\n")
        
        AF.request(GLNotificationlist, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("GLNotificationlist Response - \(response) - \n")
            switch response.result {
            case .success:
                if let data = response.data {
                    GolalitaApiManager.shared.updateNotification(from: data)
                    
                    let notificationCount = GolalitaApiManager.shared.Notification?.count ?? 0
                    
                    // Convert the count to a string and update the label's text
                    self.notificationCountLbl.text = "\(notificationCount)"
                } else {
                    print("Error: No data in response")
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            completion()
        })
    }
    
    
    func getSearchResults(searchTxt:String){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        //        let url = "https://golalita.com/go/api/gulfexc/category/merchant/lists"
        let params: Parameters = [
            "params": [
                "token": token,
                //                "x_online_store": null,
                // "category_id":selectedCategoryId,
                "merchant_name":searchTxt,
                //                "country_id":selectedCountry
                //                "merchant_id": null
            ]
        ]
        AF.request(GLGetAllMerchants, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            //            print("getNewMerchant Response - \(response) - \n")
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let result = jsonResponse["result"] as? [String: Any],
                           let error = result["error"] as? String {
                            
                            // Check if the error is "Invalid User Token"
                            if error == "Invalid User Token" {
                                self.showAlertHome(title: "Error", message: "Your session has expired. Please return to the home page")
                            } else {
                                print("No problem with the response")
                                // Handle other cases here if needed
                            }
                        }
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                    GolalitaApiManager.shared.updateMerchantSearchDetails(from: data)
                    //                    print(GolalitaApiManager.shared.newMerchants)
                    self.ShowSearchResults()
                    
                } else {
                    print("Error: No data in response")
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    
    
    func ShowSearchResults(){
        searchResultTableView.reloadData()
        searchResultTableView.isHidden = false
        // resetTFData()
        sideMenuBtn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        self.searchTF.text = ""
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
    
    func showAlert(title: String, message: String){
        let commonAlert = UIAlertController(title:title, message:message, preferredStyle:.alert)
        let okAction = UIAlertAction(title:"OK", style: .cancel)
        commonAlert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(commonAlert, animated: true, completion: nil)
    }
    func showAlertHome(title: String, message: String) {
        let commonAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            // Navigate to HomeViewController
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            if let viewControllers = self.navigationController?.viewControllers {
                for viewController in viewControllers {
                    if viewController is CustomTabController {
                        self.navigationController?.popToViewController(viewController, animated: true)
                        break
                    }
                }
            }else{
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        
        commonAlert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(commonAlert, animated: true, completion: nil)
    }
    
    //MARK: PK TEST
    
    
    func getAppleWallet(){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        let url = "https://www.golalita.com/go/api/pass/gulfexchange"
        let params: Parameters = [
            "params": [
                "token": token,
            ]
        ]
        
        print("getAppleWallet url - \(url)\n")
        print("getAppleWallet params - \(params)\n")
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getAppleWallet Response - \(response) - \n")
            switch response.result {
            case .success:
                let myResult = try? JSON(data: response.data!)
                print("resp",response)
                let resultArray = myResult?["result"]
                let url = resultArray?["url"].stringValue
                self.downloadAndPresentPass(pkUrl: url ?? "")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    
    func downloadAndPresentPass(pkUrl:String) {
        guard let url = URL(string: pkUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading pass: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let pass = try PKPass(data: data)
                let passVC = PKAddPassesViewController(pass: pass)
                
                DispatchQueue.main.async {
                    if let passVC = passVC {
                        UIApplication.shared.windows.first?.rootViewController?.present(passVC, animated: true, completion: nil)
                    }
                }
            } catch {
                print("Failed to create pass: \(error)")
            }
        }
        task.resume()
    }

    
}





extension GolalitaHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            if GolalitaApiManager.shared.merchantCategories?.count ?? 0 > 10{
                return 10
            }else{
                return GolalitaApiManager.shared.merchantCategories?.count ?? 0
            }
        }else if collectionView == newMemberCollectionView{
            if GolalitaApiManager.shared.newMerchants?.count ?? 0 > 10{
                return 10
            }else{
                return GolalitaApiManager.shared.newMerchants?.count ?? 0
            }
        }else{
            if GolalitaApiManager.shared.allMerchants?.count ?? 0 > 10{
                return 10
            }else{
                return GolalitaApiManager.shared.allMerchants?.count ?? 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "GolalitaHomeCollectionViewCell", for: indexPath) as! GolalitaHomeCollectionViewCell
            let categories = GolalitaApiManager.shared.merchantCategories
            cell.setCategoryData(data: categories?[indexPath.row])
            return cell
        }else if collectionView == newMemberCollectionView{
            let cell = newMemberCollectionView.dequeueReusableCell(withReuseIdentifier: "GolalitaHomeCollectionViewCell", for: indexPath) as! GolalitaHomeCollectionViewCell
            let newMerchants = GolalitaApiManager.shared.newMerchants
            cell.setNewMerchantData(data: newMerchants?[indexPath.row])
            return cell
        }else{
            let cell = merchantCollectionView.dequeueReusableCell(withReuseIdentifier: "GolalitaHomeCollectionViewCell", for: indexPath) as! GolalitaHomeCollectionViewCell
            let allMerchants = GolalitaApiManager.shared.allMerchants
            cell.setAllMerchantData(data: allMerchants?[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Dummy", bundle:nil)
        if collectionView == categoryCollectionView{
            let categoryID = GolalitaApiManager.shared.merchantCategories?[indexPath.item].id
            print("categorySearch Tapped \(indexPath.row)")
            let vc: GLCategoryVC = UIStoryboard.init(name: "MainGolalita", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLCategoryVC") as! GLCategoryVC
            vc.categoryName = GolalitaApiManager.shared.merchantCategories?[indexPath.item].name ?? "Category"
            vc.currentPage = .categorySearch
            vc.categoryID = categoryID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
            print("categoryCollectionView Tapped \(indexPath.row)")
        }else if collectionView == newMemberCollectionView{
            print("newMemberCollectionView Tapped \(indexPath.row)")
            let merchantID = GolalitaApiManager.shared.newMerchants?[indexPath.item].merchantID
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GLMerchantDetailsVC") as! GLMerchantDetailsVC
            nextViewController.merchantID = merchantID ?? 0
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }else{
            let merchantID = GolalitaApiManager.shared.allMerchants?[indexPath.item].merchantID
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GLMerchantDetailsVC") as! GLMerchantDetailsVC
            nextViewController.merchantID = merchantID ?? 0
            self.navigationController?.pushViewController(nextViewController, animated: true)
            print("merchantCollectionView Tapped \(indexPath.row)")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 130)
        
    }
    
}


extension GolalitaHomeVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return GolalitaApiManager.shared.merchantSearch?.count ?? 0
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "SearchResultsTableViewCell", for: indexPath) as! SearchResultsTableViewCell
        cell.viewMoreBtn.tag = indexPath.row
        cell.viewMoreBtn.addTarget(self, action: #selector(searchViewMoreTapped), for: .touchUpInside)
        cell.setApiData(data: GolalitaApiManager.shared.merchantSearch?[indexPath.row])
        
        
        // Initialize the star rating view
        
        let rating = indexPath.row % 5 // Example rating
        cell.configure(with: rating)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @objc func searchViewMoreTapped(sender: UIButton){
        let merchantID = GolalitaApiManager.shared.merchantSearch?[sender.tag].merchantID
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: GLMerchantDetailsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLMerchantDetailsVC") as! GLMerchantDetailsVC
        vc.merchantID = merchantID ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        print("merchant Tapped \(sender.tag)")
    }
}

extension GolalitaHomeVC
{
    // import UIKit
    
    class RatingView: UIView {
        private var starButtons = [UIButton]()
        var rating: Int = 0 {
            didSet {
                updateRating()
            }
        }
        private let numberOfStars = 5
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
        
        private func setupView() {
            for _ in 0..<numberOfStars {
                let button = UIButton()
                button.setTitle("★", for: .normal)
                button.setTitleColor(.lightGray, for: .normal)
                button.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
                addSubview(button)
                starButtons.append(button)
            }
            setupConstraints()
            updateRating()
        }
        
        private func setupConstraints() {
            for (index, button) in starButtons.enumerated() {
                button.translatesAutoresizingMaskIntoConstraints = false
                button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(index * 30)).isActive = true
                button.topAnchor.constraint(equalTo: topAnchor).isActive = true
                button.widthAnchor.constraint(equalToConstant: 30).isActive = true
                button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
        }
        
        @objc private func starTapped(_ sender: UIButton) {
            guard let index = starButtons.firstIndex(of: sender) else { return }
            rating = index + 1
        }
        
        private func updateRating() {
            for (index, button) in starButtons.enumerated() {
                button.setTitleColor(index < rating ? .yellow : .lightGray, for: .normal)
            }
        }
    }
    
}


extension GolalitaHomeVC: GolalitaSideMenuDelegate{
    func GolalitaSideMenu(_ vc: GolalitaSideMenu, action: SideMenuSelection) {
        print("gg8")
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainGolalita", bundle:nil)
        switch action {
        case .home:
            if currentSMPage != .home{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaHomeVC") as! GolalitaHomeVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .profile:
            if currentSMPage != .profile{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaProfileVC") as! GolalitaProfileVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .card:
            if currentSMPage != .card{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaCardsVC") as! GolalitaCardsVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .offers:
            if currentSMPage != .offers{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaOffersVC") as! GolalitaOffersVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .search:
            if currentSMPage != .search{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaSearchVC") as! GolalitaSearchVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .none:
            print("Error None selected for sidemenu delegate")
        }
    }
    
    
}




