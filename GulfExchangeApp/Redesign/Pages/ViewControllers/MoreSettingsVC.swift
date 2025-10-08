//
//  MoreSettingsVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 23/12/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
import LocalAuthentication
import CryptoKit

class MoreSettingsVC: UIViewController {
    @IBOutlet var hideLbls: [UILabel]!
    @IBOutlet var hideImgs: [UIImageView]!
    
    @IBOutlet weak var changeLanguageBtn: UIButton!
//    @IBOutlet weak var biometricsBtn: UIButton!
    @IBOutlet var sampleswitch: UISwitch!
    @IBOutlet weak var changeLanguageLbl: UILabel!
    @IBOutlet weak var biometricLbl: UILabel!
    @IBOutlet weak var accessibilityLbl: UILabel!
    @IBOutlet weak var accessibilitySwitch: UISwitch!
    @IBOutlet weak var accessibilityBaseView: UIView!
    
    let defaults = UserDefaults.standard
    private static var isAlertPresented = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        accessibilityBaseView.isHidden = true
        addNavbar()
        changeLanguageBtn.setTitle("", for: .normal)
        changeLanguageLbl.text = NSLocalizedString("select_language", comment: "")
        biometricLbl.text = "Biometrics Authentication"
//        NSLocalizedString("enablebiometric", comment: "")
        if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
        {
            sampleswitch.setOn(true, animated: false)
        }
        else
        {
        sampleswitch.setOn(false, animated: false)
        }
        let accessibilityenabled:Bool = defaults.bool(forKey: "accessibilityenabled")
        
        if accessibilityenabled {
            accessibilitySwitch.setOn(true, animated: false)
        }else{
            accessibilitySwitch.setOn(false, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let udid = UIDevice.current.identifierForVendor!.uuidString
//        APIManager.shared.fetchToken { token in
//            if let token = token {
//                // Call login session update
//                APIManager.shared.updateSession(sessionType: "1", accessToken: token) { responseCode in
//                    if responseCode == "S222" {
//                        print("Session Valid")
//                    } else {
//                        self.handleSessionError()
//                    }
//                }
//            } else {
//                print("Failed to fetch token")
//            }
//        }
        for labl in hideLbls{
            ScreenShield.shared.protect(view: labl)
        }
        for image in hideImgs{
            ScreenShield.shared.protect(view: image)
        }
        
        
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    
    
    
    func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("settings", comment: "")
    }
    @objc func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func changeLanguageBtnTapped(_ sender: Any) {
        
        if self.defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("change language", languageCode: "en")
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main11", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LanguageSelectorViewController") as! LanguageSelectorViewController
        nextViewController.isFromSettings = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func biometricsBtnTapped(_ sender: Any) {
        if sampleswitch.isOn {
            self.defaults.set("biometricenabled", forKey: "biometricenabled")
               
               
               print("typed","typedbtn")
               //biometric
               let context = LAContext()
               var error:NSError? = nil
               if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error)
               {
                let reason = "Please Autherise With Touch Id"
                   context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                               [weak self] success, error in
                       DispatchQueue.main.async { [self] in
                       guard success, error == nil else{
                           return
                       
                       }
                          // self!.getLoginFailedCount()
                           UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
                           UserDefaults.standard.set(true, forKey: "isLoggedIN")

                       }
                       }
               }
               else
               {
                   self.showNoBiometricsAlert()
                   
               }
            
               UserDefaults.standard.set(false, forKey: "IS_POPUP_SHOWN")
               UserDefaults.standard.set(true, forKey: "isLoggedIN")
            
            if self.defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("biometric authentication", languageCode: "en")
            }
         }
         else {
            UserDefaults.standard.removeObject(forKey: "biometricenabled")
         }
    }

    @IBAction func accessibilitySwitchTapped(_ sender: Any) {
        if accessibilitySwitch.isOn {
            self.defaults.set(true, forKey: "accessibilityenabled")
            
            if self.defaults.bool(forKey: "accessibilityenabled"){
                SpeechHelper.shared.speak("accessibility", languageCode: "en")
            }
        }
        else {
            self.defaults.set(false, forKey: "accessibilityenabled")
        }
    }
    
    func showNoBiometricsAlert(){
        guard !MoreSettingsVC.isAlertPresented else { return }
        MoreSettingsVC.isAlertPresented = true

                let ac = UIAlertController(
                    title: "Biometrics Not Available",
                    message: "Please enable Face ID or Touch ID to use this feature.",
                    preferredStyle: .alert
                )

                ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    MoreSettingsVC.isAlertPresented = false
                })

                ac.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
                    MoreSettingsVC.isAlertPresented = false
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString),
                           UIApplication.shared.canOpenURL(settingsURL) {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                        }
                    }
                })

                DispatchQueue.main.async {
                    if let topVC = UIApplication.topViewController() {
                        topVC.present(ac, animated: true)
                    } else {
                        MoreSettingsVC.isAlertPresented = false // safety fallback
                    }
                }
    }
}
