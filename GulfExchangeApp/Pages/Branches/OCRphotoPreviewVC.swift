//
//  OCRphotoPreviewVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 05/07/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class OCRphotoPreviewVC: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var viewForBackImg: DottedBorderView!
    @IBOutlet weak var viewForFrontImg: DottedBorderView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var frontPageImage: UIImageView!
    @IBOutlet weak var backPageImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
         
        getImages()
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewForBackImg.isHidden = false
        viewForFrontImg.isHidden = false
        nextButton.cornerRadius = 8
        
        self.navigationItem.title = "Register"
    }
    func getImages(){
        guard UserDefaults.standard.string(forKey: "recognizedQidText") != nil && UserDefaults.standard.string(forKey: "recognizedExpiryText") != nil  else{
            viewForBackImg.isHidden = true
            viewForFrontImg.isHidden = true
            return
            
        }
       
        if defaults.object(forKey: "frontimage") == nil
        {
            print("No value in Userdefault serviceproviderBANKname")
        }
        else
        {
            let imageData = defaults.data(forKey: "frontimage")
            let orgImage : UIImage = UIImage(data: imageData!)!
            frontPageImage.image = orgImage
            frontPageImage.contentMode = .scaleAspectFill
            frontPageImage.translatesAutoresizingMaskIntoConstraints = false

        }
        
        
        if defaults.object(forKey: "backimage") == nil
        {
            print("No value in Userdefault serviceproviderBANKname")
        }
        else
        {
        
        let imageDataback = defaults.data(forKey: "backimage")
        let orgImageback : UIImage = UIImage(data: imageDataback!)!
            backPageImage.image = orgImageback
            backPageImage.contentMode = .scaleAspectFill
            
            backPageImage.translatesAutoresizingMaskIntoConstraints = false
        }

           
    }
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if let newOrExistCustStr = UserDefaults.standard.string(forKey: "neworexistcuststr") {
            print("newOrExistCustStr",newOrExistCustStr)
            if newOrExistCustStr == "B" {
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let vc: RegisternewenhViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisternewenhViewController") as! RegisternewenhViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
