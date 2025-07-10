//
//  SelectRegisterViewController.swift
//  GulfExchangeApp
//
//  Created by mac on 24/07/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class SelectRegisterViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var viewForBackImg: DottedBorderView!
    @IBOutlet weak var viewForFrontImg: DottedBorderView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var frontPageImage: UIImageView!
    @IBOutlet weak var backPageImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
         
   
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewForBackImg.isHidden = false
        //viewForFrontImg.isHidden = false
        nextButton.cornerRadius = 8
        
        self.navigationItem.title = "ID Verification"
    }
   
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if let newOrExistCustStr = UserDefaults.standard.string(forKey: "neworexistcuststr") {
            print("newOrExistCustStr",newOrExistCustStr)
            if newOrExistCustStr == "B" {
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let vc: RegisternewenhViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisternewenhViewController") as! RegisternewenhViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let vc: RegisterViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerr") as! RegisterViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: RegisterViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerr") as! RegisterViewController
            self.navigationController?.pushViewController(vc, animated: true)
            print("Value not found for existing register")
        }
    }
    

}
