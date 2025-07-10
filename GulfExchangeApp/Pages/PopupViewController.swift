//
//  PopupViewController.swift
//  GulfExchangeApp
//
//  Created by Experion on 06/10/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import WebKit

class PopupViewController: UIViewController, UIWebViewDelegate, WKUIDelegate {
    var descArray:[String] = []
    
    lazy var webView: WKWebView = {
        
        let webConfiguration = WKWebViewConfiguration()
        //let webView = WKWebView(frame: CGRect(x: 0, y: 16, width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height/4 - 16), configuration: webConfiguration)
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 16, width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height/4 - 16), configuration: webConfiguration)
        
        //let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), configuration: configuration)
        webView.backgroundColor = .clear
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        let overLayView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height))
        overLayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let viewHeight = UIScreen.main.bounds.height / 4 + 53
        let centerY = (UIScreen.main.bounds.height - viewHeight) / 2
        
        let webViewContainer:UIView = UIView(frame: CGRect(x: 40, y: centerY, width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height/4 + 53))
        let button:UIButton = UIButton(frame: CGRect.zero)
        button.backgroundColor = .rgba(198, 23, 30, 1)
        button.setTitle("Ok", for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        webViewContainer.backgroundColor = .white
        webViewContainer.addSubview(webView)
        webViewContainer.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        webViewContainer.cornerRadius = 10
        webViewContainer.layer.masksToBounds = true
        button.cornerRadius = 10
        button.layer.masksToBounds = true
        button.centerXAnchor.constraint(equalTo: webViewContainer.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 210).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor, constant: -16).isActive = true
        self.view.addSubview(overLayView)
        self.view.addSubview(webViewContainer)
//        self.view.addSubview(button)
        self.view.backgroundColor = .clear
        self.showPopupWebview()
    }
    
    func showPopupWebview() {
              if descArray.count > 0 {
              webView.loadHTMLString(descArray[0], baseURL: Bundle.main.bundleURL)
              } else {
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func buttonClicked() {
        descArray.remove(at: 0)
        self.showPopupWebview()
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
