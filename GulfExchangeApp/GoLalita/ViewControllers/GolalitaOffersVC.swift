//
//  GolalitaOffersVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 19/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


enum OfferSelection{
    case promocode
    case buyOne
    case discount
    case all
}

class GolalitaOffersVC: UIViewController {
    @IBOutlet weak var offersTopCollectionView: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var baseTableView: UITableView!
    
    var sectionSelection = 0
    var currentSMPage: SideMenuSelection = .offers
    var allOffersList:[OffersDetailsList]? = []
    let sideMenu = Bundle.main.loadNibNamed("GolalitaSideMenuView", owner: GolalitaHomeVC.self, options: nil)?.first as! GolalitaSideMenu
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllAPIs()
        sideMenu.delegate = self
        self.offersTopCollectionView?.register(UINib.init(nibName: "OffersTopButtonCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "OffersTopButtonCollectionViewCell")
        self.baseTableView?.register(UINib.init(nibName: "OffersBaseTableViewCell", bundle: .main), forCellReuseIdentifier: "OffersBaseTableViewCell")
        offersTopCollectionView?.delegate = self
        offersTopCollectionView?.dataSource = self
        baseTableView.delegate = self
        baseTableView.dataSource = self
        backBtn.setTitle("", for: .normal)
        addNavbar()
//        getApi()
        
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        sideMenu.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        sideMenu.alpha = 0.0
        sideMenu.setdata()
        view.addSubview(sideMenu)
        print("SendMoneyView")
        UIView.animate(withDuration: 0.3, animations: {
            self.sideMenu.alpha = 1.0
        })
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
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is GolalitaHomeVC {
                    self.navigationController?.popToViewController(viewController, animated: true)
                    return
                }
            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func navigateToOffersPage(index:Int){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        switch sectionSelection{
        case 0:
            let vc: GLPromoCodeVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLPromoCodeVC") as! GLPromoCodeVC
            vc.offerID = GolalitaApiManager.shared.promocodeOffersList?[index].id ?? 0
            vc.merchantID = GolalitaApiManager.shared.promocodeOffersList?[index].merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc: GLBuyOneGetOneVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLBuyOneGetOneVC") as! GLBuyOneGetOneVC
            vc.offerID = GolalitaApiManager.shared.b1g1OffersList?[index].id ?? 0
            vc.merchantID = GolalitaApiManager.shared.b1g1OffersList?[index].merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc: GLDiscountsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLDiscountsVC") as! GLDiscountsVC
            vc.offerID = GolalitaApiManager.shared.discountOffersList?[index].id ?? 0
            vc.merchantID = GolalitaApiManager.shared.discountOffersList?[index].merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            print("No Of Rows\(GolalitaApiManager.shared.allOffersList?.count ?? 999)")
            let offerType = GolalitaApiManager.shared.allOffersList?[index].xOfferType
            if offerType == "promocode"{
                let vc: GLPromoCodeVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLPromoCodeVC") as! GLPromoCodeVC
                vc.offerID = GolalitaApiManager.shared.allOffersList?[index].id ?? 0
                vc.merchantID = GolalitaApiManager.shared.allOffersList?[index].merchantID ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            }else if offerType == "b1g1"{
                let vc: GLBuyOneGetOneVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLBuyOneGetOneVC") as! GLBuyOneGetOneVC
                vc.offerID = GolalitaApiManager.shared.allOffersList?[index].id ?? 0
                vc.merchantID = GolalitaApiManager.shared.allOffersList?[index].merchantID ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            }else if offerType == "discount"{
                let vc: GLDiscountsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLDiscountsVC") as! GLDiscountsVC
                vc.offerID = GolalitaApiManager.shared.allOffersList?[index].id ?? 0
                vc.merchantID = GolalitaApiManager.shared.allOffersList?[index].merchantID ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            GolalitaApiManager.shared.allOffersList?.count
        default:
            break
        }
        print(index)
    }
    func navigateFromAllOffersPage(index:Int, offerType: String){
        if offerType == "promocode"{
            let vc: GLPromoCodeVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLPromoCodeVC") as! GLPromoCodeVC
            vc.offerID = GolalitaApiManager.shared.allOffersList?[index].id ?? 0
            vc.merchantID = GolalitaApiManager.shared.allOffersList?[index].merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else if offerType == "b1g1"{
            let vc: GLBuyOneGetOneVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLBuyOneGetOneVC") as! GLBuyOneGetOneVC
            vc.offerID = GolalitaApiManager.shared.allOffersList?[index].id ?? 0
            vc.merchantID = GolalitaApiManager.shared.allOffersList?[index].merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else if offerType == "discount"{
            let vc: GLDiscountsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLDiscountsVC") as! GLDiscountsVC
            vc.offerID = GolalitaApiManager.shared.allOffersList?[index].id ?? 0
            vc.merchantID = GolalitaApiManager.shared.allOffersList?[index].merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func getApi(){
//        let token = GolalitaApiManager.shared.userToken
//        getOffers(token: token)
//        getOffersPromocode(token: token)
//        getOffersDiscount(token: token)
//        getOffersB1G1(token: token)
//        baseTableView.reloadData()
    }
    func setCurrentPage(){
//        if sectionSelection
    }
    func fetchAllAPIs() {
        let dispatchGroup = DispatchGroup()

        // Start the first API call
        
        
        // Start the second API call
        dispatchGroup.enter()
        getOffersPromocode {
            dispatchGroup.leave()
        }
        
        // Start the third API call
        dispatchGroup.enter()
        getOffersDiscount {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        getOffersB1G1 {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        getOffers {
            dispatchGroup.leave()
        }
        
        // Notify once all API calls are done
        dispatchGroup.notify(queue: .main) {
            // Reload your table view or perform any action after all API calls are completed
//            self.getOffers()
            self.baseTableView.reloadData()
            
        }
    }
    func getOffers(){
        GolalitaApiManager.shared.updateAllOfferDetails()
    }
    func getOffers(completion: @escaping () -> Void){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        let params: Parameters = [
            "params": [
                "token": token,
            ]
        ]
        AF.request(GLGetOffers, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getOffers Response - \(response) - \n")
//            print("getAll Offers Response - \(response) - \n")
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
                    GolalitaApiManager.shared.updateAllOffers(from: data)
                    print("getAll Offers Response ")
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
    func getOffersPromocode(completion: @escaping () -> Void){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        let params: Parameters = [
            "params": [
                "token": token,
                "x_offer_type": "promocode"
            ]
        ]
        AF.request(GLGetOffers, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//            print("getAll Offers Response - \(response) - \n")
            switch response.result {
            case .success:
                if let data = response.data {
                    print("getOffersPromocode Response")
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
                    GolalitaApiManager.shared.updateAllOffersPromocode(from: data)
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
    func getOffersB1G1(completion: @escaping () -> Void){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        let params: Parameters = [
            "params": [
                "token": token,
                "x_offer_type": "b1g1"
            ]
        ]
        AF.request(GLGetOffers, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//            print("getAll Offers Response - \(response) - \n")
            switch response.result {
            case .success:
                if let data = response.data {
                    print("getOffersB1G1  Response")
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
                    GolalitaApiManager.shared.updateAllOffersB1G1(from: data)
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
    func getOffersDiscount(completion: @escaping () -> Void){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        let params: Parameters = [
            "params": [
                "token": token,
                "x_offer_type": "discount"
            ]
        ]
        AF.request(GLGetOffers, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//            print("getAll Offers Response - \(response) - \n")
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
                    GolalitaApiManager.shared.updateAllOffersDiscount(from: data)
                    print("getOffersDiscount  Response")
                    self.baseTableView.reloadData()
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


extension GolalitaOffersVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offersCollectionViewDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = offersTopCollectionView.dequeueReusableCell(withReuseIdentifier: "OffersTopButtonCollectionViewCell", for: indexPath) as! OffersTopButtonCollectionViewCell
        cell.sectionBtn.tag = indexPath.row
        cell.sectionBtn?.addTarget(self, action: #selector(quickAccessTapped), for: .touchUpInside)
        if sectionSelection == indexPath.row{
            cell.setData(isSelected: true, data: offersCollectionViewDatas[indexPath.row])
        }else{
            cell.setData(isSelected: false, data: offersCollectionViewDatas[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print("selected \(indexPath.row)aa \(indexPath.item)")
        
    }
    @objc func quickAccessTapped(sender: UIButton){
        print(" QuickAccess Tapped \(sender.tag)")
        sectionSelection = sender.tag
        
        offersTopCollectionView.reloadData()
        baseTableView.reloadData()
        if self.baseTableView.numberOfRows(inSection: 0) > 0 {
                // Scroll to the first row (indexPath.row = 0) in the first section (indexPath.section = 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self.baseTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
    }
    
}
extension GolalitaOffersVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionSelection{
        case 0:
            print("No Of Rows\(GolalitaApiManager.shared.promocodeOffersList?.count ?? 999)")
            return GolalitaApiManager.shared.promocodeOffersList?.count ?? 0
        case 1:
            print("No Of Rows\(GolalitaApiManager.shared.b1g1OffersList?.count ?? 999)")
            return GolalitaApiManager.shared.b1g1OffersList?.count ?? 0
        case 2:
            print("No Of Rows\(GolalitaApiManager.shared.discountOffersList?.count ?? 999)")
            return GolalitaApiManager.shared.discountOffersList?.count ?? 0
        case 3:
            print("No Of Rows\(GolalitaApiManager.shared.allOffersList?.count ?? 999)")
            return GolalitaApiManager.shared.allOffersList?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = baseTableView.dequeueReusableCell(withIdentifier: "OffersBaseTableViewCell", for: indexPath) as! OffersBaseTableViewCell
        switch sectionSelection{
        case 0:
            cell.setData(data: GolalitaApiManager.shared.promocodeOffersList?[indexPath.row])
            cell.viewBtn.addTarget(self, action: #selector(viewMoreTapped), for: .touchUpInside)
            cell.viewBtn.tag = indexPath.row
        case 1:
            cell.setData(data:GolalitaApiManager.shared.b1g1OffersList?[indexPath.row])
            cell.viewBtn.addTarget(self, action: #selector(viewMoreTapped), for: .touchUpInside)
            cell.viewBtn.tag = indexPath.row
        case 2:
            cell.setData(data:GolalitaApiManager.shared.discountOffersList?[indexPath.row])
            cell.viewBtn.addTarget(self, action: #selector(viewMoreTapped), for: .touchUpInside)
            cell.viewBtn.tag = indexPath.row
        case 3:
            cell.setData(data:GolalitaApiManager.shared.allOffersList?[indexPath.row])
            cell.viewBtn.addTarget(self, action: #selector(viewMoreTapped), for: .touchUpInside)
            cell.viewBtn.tag = indexPath.row
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @objc func viewMoreTapped(sender: UIButton){
        navigateToOffersPage(index: sender.tag)
    }
    @objc func allOffersViewMoreTapped(sender: UIButton){
        let offer = GolalitaApiManager.shared.allOffersList?[sender.tag].xOfferType
        navigateFromAllOffersPage(index: sender.tag, offerType: offer ?? "")
    }
    
    
}

extension GolalitaOffersVC: GolalitaSideMenuDelegate{
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



