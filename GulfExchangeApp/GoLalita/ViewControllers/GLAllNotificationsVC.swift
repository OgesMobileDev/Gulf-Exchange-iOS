//
//  GLAllNotificationsVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 22/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
// AllNotificationsTableViewCell

import UIKit

class GLAllNotificationsVC: UIViewController {

    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var baseTableView: UITableView!
    
    var NotificationID = 0
    
    var currentSMPage: SideMenuSelection = .none
    let sideMenu = Bundle.main.loadNibNamed("GolalitaSideMenuView", owner: GolalitaHomeVC.self, options: nil)?.first as! GolalitaSideMenu
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseTableView?.register(UINib.init(nibName: "AllNotificationsTableViewCell", bundle: .main), forCellReuseIdentifier: "AllNotificationsTableViewCell")
        baseTableView.delegate = self
        baseTableView.dataSource = self
        sideMenu.delegate = self
        sideMenuBtn.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
        addNavbar()
        
       // getNotification()
    }
    
    
//    func getNotification(){
//        // already called
//        setApiData(data: GolalitaApiManager.shared.Notification)
//    }
    
    func setApiData(data:NotificationMessage?)
    {
       // data?.description
       
        print("SendMoneyView")
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
    func navigateToNotification(index: Int){
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: GLNotificationVC = UIStoryboard.init(name: "MainGolalita", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLNotificationVC") as! GLNotificationVC
        vc.NotificationID = NotificationID
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
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
   

}

extension GLAllNotificationsVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return 1
        return GolalitaApiManager.shared.Notification?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = baseTableView.dequeueReusableCell(withIdentifier: "AllNotificationsTableViewCell", for: indexPath) as! AllNotificationsTableViewCell
                  //  cell.setData()
        
        let Notification = GolalitaApiManager.shared.Notification
        cell.setNotificationData(data: Notification?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // navigateToNotification(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        let notificatioID = GolalitaApiManager.shared.Notification?[indexPath.item].notification_id
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: GLNotificationVC = UIStoryboard.init(name: "MainGolalita", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLNotificationVC") as! GLNotificationVC
        vc.NotificationID = notificatioID ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension GLAllNotificationsVC: GolalitaSideMenuDelegate{
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


