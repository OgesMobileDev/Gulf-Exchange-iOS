//
//  BiometricViewController.swift
//  GulfExchangeApp
//
//  Created by MacBook Pro on 8/14/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit
import LocalAuthentication

class BiometricViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let button:UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        button.backgroundColor = .black
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonClicked(sender : UIButton)
    {
        
        print("typed","typedbtn")
        //biometric
        let context = LAContext()
        var error:NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error)
        {
         let reason = "Please Autherise With Touch Id"
            //context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason), reply: weak<#T##(Bool, Error?) -> Void#>)
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                        [weak self] success, error in
                DispatchQueue.main.async {
                guard success, error == nil else{
                    
                    
                    let ac = UIAlertController(title: "Failed To Authentication", message: "Please Try Again!", preferredStyle: .alert)
                                       ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self!.present(ac, animated: true)

                    return
                
                }
                 let vc = BiometricViewController()
                    vc.title = "Welcome"
                    vc.view.backgroundColor = .systemBlue
                    self?.present(UINavigationController(rootViewController: vc),animated: true,completion: nil)
                    
                    
                
                }
                }
        }
        else
        {
            let ac = UIAlertController(title: "Unavailable", message: "You Cant Use This Feature!", preferredStyle: .alert)
                               ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            
        }
        
                    //Write button action here
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
