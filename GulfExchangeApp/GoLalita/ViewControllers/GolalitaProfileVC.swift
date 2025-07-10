//
//  GolalitaProfileVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 19/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class GolalitaProfileVC: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var availablePointsLbl: UILabel!
    @IBOutlet weak var pointsEarnedLbl: UILabel!
    @IBOutlet weak var pointsUsedLbl: UILabel!
    @IBOutlet weak var totalSavingsLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var numberTF: UITextField!
    var currentSMPage: SideMenuSelection = .profile
    let sideMenu = Bundle.main.loadNibNamed("GolalitaSideMenuView", owner: GolalitaHomeVC.self, options: nil)?.first as! GolalitaSideMenu
    
    //ProfileTopButtonCollectionViewCell
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu.delegate = self
        backBtn.setTitle("", for: .normal)
        addNavbar()
        getProfile()
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
    func getProfile(){
        // already called
        setApiData(data: GolalitaApiManager.shared.UserCardProfile)
    }
    func setApiData(data:UserProfileModel?){
        availablePointsLbl.text = "\(data?.profile?.availablePoints ?? 90)"
        pointsEarnedLbl.text = "\(data?.profile?.totalPointsEarn ?? 90)"
        pointsUsedLbl.text = "\(data?.profile?.totalPointsUsed ?? 90)"
        totalSavingsLbl.text = "\(data?.profile?.totalSaving ?? 90)"
        nameTF.text = data?.profile?.name
        var emailTxt = data?.profile?.email ?? ""
        if let emailT = emailTxt.split(separator: ":").last {
            print(emailT)
            emailTxt = String(emailT)// Outputs: devtest@gulf.com
        }
        emailTF.text = emailTxt
        numberTF.text = data?.profile?.phone
        let cardImage = data?.profile?.photo
        if let url = URL(string: cardImage ?? "") {
            // Create a data task to fetch the image
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Ensure there's no error and data is non-nil
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        // Set the image to the imageView on the main thread
                        self.profileImg.image = UIImage(data: data)
                    }
                }
            }.resume() // Start the task
        }
    }
}









extension GolalitaProfileVC: GolalitaSideMenuDelegate{
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

