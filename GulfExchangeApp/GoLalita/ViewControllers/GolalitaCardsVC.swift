//
//  GolalitaCardsVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 19/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import CoreImage
import Alamofire
import SwiftyJSON
import CommonCrypto

class GolalitaCardsVC: UIViewController {
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var barcodeImgView: UIImageView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var expiryLbl: UILabel!
    @IBOutlet weak var cardBgView: UIView!
    
    
    var currentSMPage: SideMenuSelection = .card
    let sideMenu = Bundle.main.loadNibNamed("GolalitaSideMenuView", owner: GolalitaHomeVC.self, options: nil)?.first as! GolalitaSideMenu
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu.delegate = self
        sideMenuBtn.setTitle("", for: .normal)
        addNavbar()
//        getProfile()
        cardBgView.clipsToBounds = true
        setApiData(data: GolalitaApiManager.shared.UserCardProfile)
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
    
    
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: .ascii)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            if let ciImage = filter.outputImage {
                let transform = CGAffineTransform(scaleX: 5, y: 5)
                let scaledImage = ciImage.transformed(by: transform)
                return UIImage(ciImage: scaledImage)
            }
        }
        
        return nil
    }
    
    func setApiData(data:UserProfileModel?){
        barcodeImgView.contentMode = .scaleToFill
        cardImageView.contentMode = .scaleToFill
        userNameLbl.text = data?.profile?.name
        let barcode = data?.profile?.barcode
        if let barcodeImage = generateBarcode(from: barcode ?? "") {
            barcodeImgView.image = barcodeImage
            }
        let cardImage = data?.walletDesign
        urlToImg(urlString: data?.walletDesign ?? "", to: cardImageView)
        expiryLbl.text = data?.xUserExpiry
    }

}



extension GolalitaCardsVC: GolalitaSideMenuDelegate{
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


