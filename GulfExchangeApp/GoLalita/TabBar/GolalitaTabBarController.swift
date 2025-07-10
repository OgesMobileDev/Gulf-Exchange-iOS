//
//  GolalitaTabBarController.swift
//  GulfExchangeApp
//
//  Created by macbook on 17/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class GolalitaTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
