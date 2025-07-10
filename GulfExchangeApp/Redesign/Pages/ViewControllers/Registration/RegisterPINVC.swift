//
//  RegistrationPINVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 03/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import ScreenShield

class RegisterPINVC: UIViewController, TermsPopupUIViewDelegate {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var pinTF: UITextField!
    @IBOutlet weak var pinEyeBtn: UIButton!
    @IBOutlet weak var pinEyeImg: UIImageView!
    
    @IBOutlet weak var iAgreeLbl: UILabel!
    @IBOutlet weak var agreeImg: UIImageView!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var iAgreeBtn: UIButton!
    @IBOutlet weak var createProfileBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    let popUpView2 = Bundle.main.loadNibNamed("TermsPopupUIView", owner: TransferPage1VC.self, options: nil)?.first as! TermsPopupUIView
    
    var temrsContent = ""
    var isTermsPopup:Bool = false
    var termsClick:Bool = false
    var pinEye = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        popUpView2.delegate = self
        iAgreeBtn.setTitle("", for: .normal)
        pinEyeBtn.setTitle("", for: .normal)
        configureButton(button: termsBtn, title: "Terms and Conditions", size: 12, font: .regular)
        configureButton(button: createProfileBtn, title: "Create Profile", size: 16, font: .medium)
        configureButton(button: cancelBtn, title: "Cancel", size: 16, font: .medium)
    }
    override func viewWillAppear(_ animated: Bool) {
//        ScreenShield.shared.protect(view: self.)
        ScreenShield.shared.protect(view: self.pinTF)
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    @IBAction func pinEyeBtnTapped(_ sender: Any) {
        if pinEye {
            pinTF.isSecureTextEntry = false
            pinEyeImg.image = UIImage(named: "show pswrd")
        } else {
            pinTF.isSecureTextEntry = true
            pinEyeImg.image = UIImage(named: "hide pswrd")
        }
        pinEye.toggle()
    }
    
    @IBAction func termsBtnTapped(_ sender: Any) {
        popUpView2.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpView2.alpha = 0.0
        if temrsContent != ""{
            popUpView2.setView(content: temrsContent)
        }else{
            popUpView2.setView(content: "")
        }
        isTermsPopup = true
        view.addSubview(popUpView2)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView2.alpha = 1.0
        })
    }
    
    @IBAction func iAgreeBtnTapped(_ sender: Any) {
        if !termsClick{
            showAlert(title: "", message: "Please read the Terms And Conditions")
        }
    }
    
    @IBAction func createProfileBtnTapped(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterSelfieVC") as! RegisterSelfieVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
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
        self.navigationItem.title = "Set Your PIN"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - popupDelegates
    func TermsPopupUIView(_ vc: TermsPopupUIView, action: Bool) {
        if action {
            isTermsPopup = false
            termsClick = true
            if #available(iOS 13.0, *) {
                agreeImg.image = UIImage(systemName: "checkmark.square.fill")
                agreeImg.tintColor = UIColor.rgba(198, 23, 30, 1)
            } else {
                // Fallback on earlier versions
            }
        }
    }

}
