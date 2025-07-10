//
//  GolalitaSideMenu.swift
//  GulfExchangeApp
//
//  Created by macbook on 21/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
enum SideMenuSelection {
    case home
    case profile
    case card
    case offers
    case search
    case none
}
protocol GolalitaSideMenuDelegate:AnyObject{
    func GolalitaSideMenu(_ vc: GolalitaSideMenu, action: SideMenuSelection)
}

class GolalitaSideMenu: UIView {
    
    weak var delegate: GolalitaSideMenuDelegate?
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var emptyBtn: UIButton!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var profiileView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var offersView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet var emptyBtns: [UIButton]!
    
    func setdata(){
        for eBtn in emptyBtns{
            eBtn.setTitle("", for: .normal)
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func homeBtnTapped(_ sender: Any) {
        delegate?.GolalitaSideMenu(self, action: .home)
        self.removeFromSuperview()
    }
    @IBAction func profileBtnTapped(_ sender: Any) {
        delegate?.GolalitaSideMenu(self, action: .profile)
        self.removeFromSuperview()
    }
    @IBAction func cardBtnTapped(_ sender: Any) {
        delegate?.GolalitaSideMenu(self, action: .card)
        self.removeFromSuperview()
    }
    @IBAction func offersBtnTapped(_ sender: Any) {
        delegate?.GolalitaSideMenu(self, action: .offers)
        self.removeFromSuperview()
    }
    @IBAction func searchBtnTapped(_ sender: Any) {
        delegate?.GolalitaSideMenu(self, action: .search)
        self.removeFromSuperview()
    }
    
}



/*{
        "login" : "abdullha123@gmail.com",
        "password":"abc123123",
        "device_id":"6B563F01-D266-4279-AC6F-4FA5C1AC5719",
        "device_token":"6B563F01-D266-4279-AC6F-4FA5C1AC5719",
        "device_type":"ios"
}
beef96f1fe114ddc97875abefc0e2d06
*/
