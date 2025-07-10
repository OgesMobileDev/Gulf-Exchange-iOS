//
//  GLDiscountsVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 23/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GLDiscountsVC: UIViewController {

    @IBOutlet weak var TitleLbl: UILabel!
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var merchantNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var goToMerchantBtn: UIButton!
    
    var merchantID = 0
    var offerID = 0
    var pageDetails:OffersDetails?
    
    var currentSMPage: SideMenuSelection = .none
    let sideMenu = Bundle.main.loadNibNamed("GolalitaSideMenuView", owner: GolalitaHomeVC.self, options: nil)?.first as! GolalitaSideMenu
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu.delegate = self
        setView()
        addNavbar()
        getOfferDetails()
        // Do any additional setup after loading the view.
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
               singleTapGesture.numberOfTapsRequired = 1
        productImgView.isUserInteractionEnabled = true
        productImgView.addGestureRecognizer(singleTapGesture)
    }
    
    @objc private func handleSingleTap(_ gestureRecognizer: UITapGestureRecognizer) {
          // Handle single tap action here
          print("Image view single-tapped")
        
        // Create a new view controller for zooming the image
        let zoomedImageViewController = ZoomedImageViewController(image: productImgView.image)
        
        // Present the zoomed image view controller
        present(zoomedImageViewController, animated: true, completion: nil)
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
    @IBAction func goToMerchantBtnTapped(_ sender: Any) {
        if let pageDetails = pageDetails{
            if let url = URL(string: pageDetails.xMerchantOnlineStore ?? "") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else{
                print("error url redirection alert view")
            }
        }else{
            print("error model redirection alert view")
        }
        print("redorect to merchant website")
    }
    func setView(){
        sideMenuBtn.setTitle("", for: .normal)
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
    
    func getOfferDetails() {
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        if merchantID == 0 || token == ""{
            print("invalid token or id")
        }else{
            let url = "https://www.golalita.com/go/api/gulfexc/offers/v2"
            let params: Parameters = [
                "params": [
                    "token": token,
                    "merchant_id": merchantID,
                    "x_offer_type": "discount"
                ]
            ]
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                print("getMerchantDetails Response - \(response) - \n")
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
                        GolalitaApiManager.shared.updateOfferDetails(from: data)
                        
                        //                        self.setApiData(merchantDetails: GolalitaApiManager.shared.merchantDetails)
                        //                        self.bannerCollectionView.reloadData()
                        //                        self.startAutoScroll()
                        self.sortApiData()
                        
                    } else {
                        print("Error: No data in response")
                    }
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            })
        }
        
    }
    func sortApiData(){
        if merchantID == 0 || offerID == 0{
            print("invalid offerId or MerchantID")
        }else{
            if let offerDetails = GolalitaApiManager.shared.offerDetails{
                for i in 0..<offerDetails.count{
                    if offerDetails[i].id == offerID{
                        pageDetails = offerDetails[i]
                        setApiData()
                    }
                }
            }
        }
    }
    
    func setApiData(){
        let merchantName = pageDetails?.merchantName ?? ""
        TitleLbl.text = merchantName
        merchantNameLbl.text = merchantName
        let logoUrl = pageDetails?.merchantLogo
        urlToImg(urlString: logoUrl ?? "", to: logoImgView)
        let imageUrl = pageDetails?.imageUrl
        urlToImg(urlString: imageUrl ?? "", to: productImgView)
        if pageDetails?.descriptionSale != "false"{
            descriptionLbl.text = pageDetails?.descriptionSale
        }else{
            descriptionLbl.text = ""
        }
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
extension GLDiscountsVC: GolalitaSideMenuDelegate{
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


