//
//  NotificationDetailsVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

class NotificationDetailsVC: UIViewController {

    @IBOutlet weak var notificationLbl: UILabel!
    var notification:Notificationn?
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        notificationLbl.text = notification?.notifyMessage
    }
    override func viewWillAppear(_ animated: Bool) {
        
        ScreenShield.shared.protect(view: self.notificationLbl)
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "Notification"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
