//
//  GLCategoryVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 21/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum SelectedHomeCategory{
    case category
    case member
    case merchant
    case categorySearch
}

class GLCategoryVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var baseCollectionView: UICollectionView!
    @IBOutlet weak var sideMenuBtn: UIButton!
    var categoryID:Int = 0
    var currentPage: SelectedHomeCategory = .category
    var currentSMPage: SideMenuSelection = .none
    var categoryName = "Category"
    let sideMenu = Bundle.main.loadNibNamed("GolalitaSideMenuView", owner: GolalitaHomeVC.self, options: nil)?.first as! GolalitaSideMenu
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu.delegate = self
        self.baseCollectionView?.register(UINib.init(nibName: "GolalitaHomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "GolalitaHomeCollectionViewCell")
        baseCollectionView?.delegate = self
        baseCollectionView?.dataSource = self
        sideMenuBtn.setTitle("", for: .normal)
        switch currentPage {
        case .category:
            titleLbl.text = "Category"
            print("category")
        case .member:
            titleLbl.text = "New Members"
            print("member")
        case .merchant:
            titleLbl.text = "All Merchants"
            print("merchant")
        case .categorySearch:
            getCategorySearch(token: GolalitaApiManager.shared.userProfile?.token ?? "")
            
            print("categorySearch")
        }
        addNavbar()
        
    }
    
    @IBAction func sideMenuBtnTapped(_ sender: Any) {
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
    @objc func customBackButtonTapped() {
            self.navigationController?.popViewController(animated: true)
    }
    
    func setcategorySearchData(){
        titleLbl.text = categoryName
    }
    func getCategorySearch(token:String){
        print("Token - \(token) - \n")
        let url = "https://golalita.com/go/api/gulfexc/category/merchant/lists"
        let params: Parameters = [
            "params": [
                "token": token,
//                "x_online_store": null,
                "category_id":categoryID,
//                "merchant_name":null,
//                "merchant_id": null
            ]
        ]
        AF.request(GLGetAllMerchants, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getNewMerchant Response - \(response) - \n")
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
                    GolalitaApiManager.shared.updateCategorySearch(from: data)
//                    print(GolalitaApiManager.shared.newMerchants)
                    self.baseCollectionView.reloadData()
                    self.setcategorySearchData()
                } else {
                    print("Error: No data in response")
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
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


}

extension GLCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentPage {
        case .category:
            return GolalitaApiManager.shared.merchantCategories?.count ?? 0
        case .member:
            return GolalitaApiManager.shared.newMerchants?.count ?? 0
        case .merchant:
            return GolalitaApiManager.shared.allMerchants?.count ?? 0
        case .categorySearch:
            return GolalitaApiManager.shared.merchantList?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = baseCollectionView.dequeueReusableCell(withReuseIdentifier: "GolalitaHomeCollectionViewCell", for: indexPath) as! GolalitaHomeCollectionViewCell
        switch currentPage {
        case .category:
            let categories = GolalitaApiManager.shared.merchantCategories
            cell.setCategoryData(data: categories?[indexPath.row])
        case .member:
            let newMerchants = GolalitaApiManager.shared.newMerchants
            cell.setNewMerchantData(data: newMerchants?[indexPath.row])
        case .merchant:
            let allMerchants = GolalitaApiManager.shared.allMerchants
            cell.setAllMerchantData(data: allMerchants?[indexPath.row])
        case .categorySearch:
            let merchantList = GolalitaApiManager.shared.merchantList
            cell.setAllMerchantData(data: merchantList?[indexPath.row])
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 130)
//        let width = UIScreen.main.bounds.width
//        let cellWidth = (width - 60) / 3
//            return CGSize(width: cellWidth, height: 130)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Dummy", bundle:nil)
        switch currentPage{
        case .category:
            let categoryID = GolalitaApiManager.shared.merchantCategories?[indexPath.item].id
            print("categorySearch Tapped \(indexPath.row)")
            let vc: GLCategoryVC = UIStoryboard.init(name: "MainGolalita", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLCategoryVC") as! GLCategoryVC
            vc.categoryName = GolalitaApiManager.shared.merchantCategories?[indexPath.item].name ?? "Category"
            vc.currentPage = .categorySearch
            vc.categoryID = categoryID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        case .member:
            print("newMember Tapped \(indexPath.row)")
            let merchantID = GolalitaApiManager.shared.newMerchants?[indexPath.item].merchantID
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: GLMerchantDetailsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLMerchantDetailsVC") as! GLMerchantDetailsVC
            vc.merchantID = merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        case .merchant:
            let merchantID = GolalitaApiManager.shared.allMerchants?[indexPath.item].merchantID
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: GLMerchantDetailsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLMerchantDetailsVC") as! GLMerchantDetailsVC
            vc.merchantID = merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
            print("merchant Tapped \(indexPath.row)")
        case .categorySearch:
            let merchantID = GolalitaApiManager.shared.merchantList?[indexPath.item].merchantID
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: GLMerchantDetailsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLMerchantDetailsVC") as! GLMerchantDetailsVC
            vc.merchantID = merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
            print("merchantList Tapped \(indexPath.row)")
        }
    }
}
extension GLCategoryVC: GolalitaSideMenuDelegate{
    func GolalitaSideMenu(_ vc: GolalitaSideMenu, action: SideMenuSelection) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainGolalita", bundle:nil)
        switch action {
        case .home:
            if currentSMPage != .home{
                if let viewControllers = self.navigationController?.viewControllers {
                    for viewController in viewControllers {
                        if viewController is GolalitaHomeVC {
                            self.navigationController?.popToViewController(viewController, animated: true)
                            break
                        }
                    }
                }else{
                    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaHomeVC") as! GolalitaHomeVC
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }

                
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



