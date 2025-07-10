//
//  IDverificationRegisterVC.swift
//  GulfExchangeApp
//
//  Created by mac on 24/07/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class IDverificationRegisterVC: UIViewController {

    
    @IBOutlet weak var frontview: UIView!
    
    @IBOutlet weak var frontimageview: UIImageView!
    
    @IBOutlet weak var backimageview: UIImageView!
    
    @IBOutlet weak var backview: UIView!
    
    @IBOutlet weak var cameraview: UIView!
    
  
    
    @IBOutlet weak var qataeidbtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        backimageview.layer.cornerRadius = 13
        backimageview.layer.masksToBounds = true
        
        frontimageview.layer.cornerRadius = 13
        frontimageview.layer.masksToBounds = true
        
        cameraview.layer.cornerRadius = 15
        cameraview.layer.masksToBounds = true
        
        qataeidbtn.layer.cornerRadius = 10
        qataeidbtn.layer.masksToBounds = true
        
        frontview.layer.cornerRadius = 20
        frontview.layer.masksToBounds = true
        
        backview.layer.cornerRadius = 20
        backview.layer.masksToBounds = true
        
        
        self.frontview.layer.borderWidth = 1
        self.frontview.layer.borderColor = UIColor(red:182/255, green:42/255, blue:41/255, alpha: 1).cgColor
        
        self.backview.layer.borderWidth = 1
        self.backview.layer.borderColor = UIColor(red:182/255, green:42/255, blue:41/255, alpha: 1).cgColor


        // Do any additional setup after loading the view.
    }
    
    @IBAction func camerarntclk(_ sender: Any) 
    {
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "photo1") as! Photo1ViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        self.navigationItem.title = "ID Verification"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
