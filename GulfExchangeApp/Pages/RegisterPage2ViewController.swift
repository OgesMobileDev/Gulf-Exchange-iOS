//
//  RegisterPage2ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 23/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

class RegisterPage2ViewController: UIViewController {
    @IBOutlet weak var msgLbl1: UILabel!
    @IBOutlet weak var msgLbl2: UILabel!
    @IBOutlet weak var msgLbl3: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
       
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
//        self.navigationItem.rightBarButtonItem  = custmHelpBtn
//        self.navigationController?.navigationItem.hidesBackButton = true
        self.title = NSLocalizedString("register", comment: "")
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.navigationController?.isNavigationBarHidden = true
        loginBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        loginBtn.layer.cornerRadius = 15
        setFont()
        setFontSize()
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func loginBtn(_ sender: Any) {
        if let navigationController = self.navigationController {
            for controller in navigationController.viewControllers {
                if let tabController = controller as? MainLoginViewController {
                    navigationController.popToViewController(tabController, animated: true)
                    return
                }
            }
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    func setFont() {
        msgLbl1.font = UIFont(name: "OpenSans-Regular", size: 14)
        msgLbl2.font = UIFont(name: "OpenSans-Regular", size: 14)
        msgLbl3.font = UIFont(name: "OpenSans-Regular", size: 14)
        loginBtn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
    }
    func setFontSize() {
        msgLbl1.font = msgLbl1.font.withSize(14)
        msgLbl2.font = msgLbl2.font.withSize(14)
        msgLbl3.font = msgLbl3.font.withSize(14)
    
    }
    
}
