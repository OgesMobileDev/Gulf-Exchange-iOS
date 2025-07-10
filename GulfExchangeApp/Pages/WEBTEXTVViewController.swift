//
//  WEBTEXTVViewController.swift
//  GulfExchangeApp
//
//  Created by test on 25/05/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit

class WEBTEXTVViewController: UIViewController {
    
    var descArray:[String] = []
    
    
    @IBOutlet var txtvieww: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        addNavbar()
        
        txtvieww.isUserInteractionEnabled = true
        txtvieww.isEditable = false
        
        if self.descArray.count > 0 {
        txtvieww.attributedText = descArray[0].htmlToAttributedString
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }
    func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.isNavigationBarHidden = false
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        let helpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItems  = [helpBtn]
//        let imageView = UIImageView(image: UIImage(named: "ge_logo"))
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        let leftBarButtonItem = UIView(customView: imageView)
//        self.navigationItem.titleView?.addSubview(imageView)
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HelpVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func customBackButtonTapped() {
        if let window = UIApplication.shared.windows.first {
            let storyboard = UIStoryboard(name: "Main10", bundle: nil)
            if let tabBarController = storyboard.instantiateViewController(withIdentifier: "CustomTabController") as? CustomTabController {
                tabBarController.selectedIndex = 0
                tabBarController.setTabSelections(currentIndex: 0)
                let navigationController = UINavigationController(rootViewController: tabBarController)
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        }
    }
}
