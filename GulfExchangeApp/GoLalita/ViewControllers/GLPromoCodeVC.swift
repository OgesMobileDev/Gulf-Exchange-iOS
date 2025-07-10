//
//  GLPromoCodeVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 23/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GLPromoCodeVC: UIViewController {
    @IBOutlet weak var TitleLbl: UILabel!
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var merchantNameLbl: UILabel!
    
    @IBOutlet weak var visitMerchantBtn: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var offerdetailsLbl: UILabel!
    @IBOutlet weak var deliveryDetailsLbl: UILabel!
    @IBOutlet weak var codeBtnView: UIView!
    @IBOutlet weak var applyPromoLbl: UILabel!
    @IBOutlet weak var showPromoLbl: UILabel!
    @IBOutlet weak var goToMerchantBtn: UIButton!
    // swipe view
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var hiddenCodeLabel: UILabel!
    @IBOutlet weak var swipeableView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var copyCodeBtn: UIButton!
    
    private var animator: UIViewPropertyAnimator?
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
        
        addPanGesture()
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
    @IBAction func visitMerchantBtnTapped(_ sender: Any) {
        if let pageDetails = pageDetails{
            let merchantID = pageDetails.merchantID
            let vc: GLMerchantDetailsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLMerchantDetailsVC") as! GLMerchantDetailsVC
            vc.merchantID = merchantID ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            print("error redirection alert view")
        }
        print("redirects to the merchant’s details in the “Merchant” page")
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
        
        print("redirects the customer to the merchant’s website.")
    }
    @IBAction func copyBtnTapped(_ sender: UIButton) {
        // The code to copy
        let codeToCopy = "12345"
        
        // Copy the code to the clipboard
        UIPasteboard.general.string = codeToCopy
        
        // Optional: Show an alert or notification to the user
        let alert = UIAlertController(title: "Copied!", message: "The code has been copied to your clipboard.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func setView(){
        hiddenCodeLabel.isHidden = true
        seperatorView.isHidden = true
        copyCodeBtn.isHidden = true
        sideMenuBtn.setTitle("", for: .normal)
        visitMerchantBtn.setTitle("", for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13)
        ]
        let attributedTitle = NSAttributedString(string: "Go to MERCHANT Online Store", attributes: attributes)
        goToMerchantBtn.setAttributedTitle(attributedTitle, for: .normal)
        goToMerchantBtn.titleLabel?.textAlignment = .center
        
    }
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        swipeableView.addGestureRecognizer(panGesture)
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
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .changed:
            if translation.x > 0 && swipeableView.frame.origin.x + translation.x <= baseView.frame.maxX - swipeableView.frame.width {
                swipeableView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            }
        case .ended:
            let swipeableViewMaxX = swipeableView.frame.origin.x + swipeableView.frame.width + translation.x
            if swipeableViewMaxX >= baseView.frame.maxX - 10 {
                // Reveal hidden code and move swipeable view to the end
                
                animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
                    self.swipeableView.transform = CGAffineTransform(translationX: self.baseView.frame.width - self.swipeableView.frame.width, y: 0)
                }
                self.hiddenCodeLabel.alpha = 0
                self.seperatorView.alpha = 0
                self.copyCodeBtn.alpha = 0
                self.hiddenCodeLabel.isHidden = false
                self.seperatorView.isHidden = false
                self.copyCodeBtn.isHidden = false
                animator?.addCompletion { _ in
                                   UIView.animate(withDuration: 0.3, animations: {
                                       self.swipeableView.alpha = 0
                                       self.codeLabel.alpha = 0
                                       self.seperatorView.alpha = 1
                                       self.copyCodeBtn.alpha = 1
                                       self.hiddenCodeLabel.alpha = 1
                                   }) { _ in
                                       self.swipeableView.isHidden = true
                                       self.codeLabel.isHidden = true
                                       
                                       
                                   }
                               }
                animator?.startAnimation()
                
            } else {
                // Revert swipe
                animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
                    self.swipeableView.transform = .identity
                }
                animator?.startAnimation()
            }
        default:
            break
        }
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
                    "x_offer_type": "promocode"
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
        hiddenCodeLabel.isHidden = true
        seperatorView.isHidden = true
        copyCodeBtn.isHidden = true
        sideMenuBtn.setTitle("", for: .normal)
        visitMerchantBtn.setTitle("", for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13)
        ]
        
        let attributedTitle = NSAttributedString(string: "Go to \(merchantName) Online Store", attributes: attributes)
        goToMerchantBtn.setAttributedTitle(attributedTitle, for: .normal)
        TitleLbl.text = merchantName
        merchantNameLbl.text = merchantName
        hiddenCodeLabel.text = pageDetails?.xOfferTypePromoCode ?? "0000"
        let logoUrl = pageDetails?.merchantLogo
        urlToImg(urlString: logoUrl ?? "", to: logoImgView)
        let imageUrl = pageDetails?.imageUrl
        urlToImg(urlString: imageUrl ?? "", to: productImgView)
        if pageDetails?.descriptionSale != "false"{
            descriptionLbl.text = pageDetails?.descriptionSale
        }else{
            descriptionLbl.text = "----"
        }
        
        offerdetailsLbl.text = "Get a discount of \(merchantName)"
        applyPromoLbl.text = "Apply the promo code on \(merchantName) to avail the discount."
        
        
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


extension GLPromoCodeVC: GolalitaSideMenuDelegate{
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


import UIKit

class CopyCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup if needed
    }

    @IBAction func copyBtnTapped(_ sender: UIButton) {
        // The code to copy
        let codeToCopy = "12345"
        
        // Copy the code to the clipboard
        UIPasteboard.general.string = codeToCopy
        
        // Optional: Show an alert or notification to the user
        let alert = UIAlertController(title: "Copied!", message: "The code has been copied to your clipboard.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


