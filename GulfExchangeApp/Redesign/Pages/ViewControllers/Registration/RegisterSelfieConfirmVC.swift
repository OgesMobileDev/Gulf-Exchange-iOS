//
//  RegisterSelfieConfirmVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 03/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit

class RegisterSelfieConfirmVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        configureButton(button: cancelBtn, title: "Cancel", size: 16, font: .medium)
        configureButton(button: okBtn, title: "Ok", size: 16, font: .medium)
        playBtn.setTitle("", for: .normal)
        
    }
    
    //MARK: - Button Functions
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
    }
    @IBAction func okBtnTapped(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterReviewVC") as! RegisterReviewVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func playBtnTapped(_ sender: Any) {
    }
    
    //MARK: - Functions
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "Registration"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
