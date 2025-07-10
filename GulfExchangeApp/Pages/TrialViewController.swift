//
//  TrialViewController.swift
//  GulfExchangeApp
//
//  Created by test on 04/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit

class TrialViewController: UIViewController, WKNavigationDelegate {

    var webView:WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let url1 = URL(string: payment_gateway_url + "payment/secure_hash_generation.php?TRefNo=" + "MOB054458412" + "&TPayAm=" + "1000.0" + "&type=1")
//        let url = URL(string: "https://google.com")
//        webView.load(URLRequest(url: url1!))
//        webView.allowsBackForwardNavigationGestures = true
        
        let url = "https://gulfexchange.com.qa/work_test/payment/mobile_app_payment_success.php?CardNo=421537******3243&CardExDate=2610&Con_ID=202007231131382670000000000&amount=200"
        let url1 = "https://gulfexchange.com.qa/work_test/payment/mobile_app_payment_success.php?"
        
        let removed = url.replacingOccurrences(of: url1, with: "")
        print("removed",removed)
        
        let array = removed.components(separatedBy: "&")
        let cardStr = array[0]
        let cardExpStr = array[1]
        let conIdStr = array[2]
    
        print("a ",cardStr)
        print("b ",cardExpStr)
        print("c ",conIdStr)
        
        let cardNo = cardStr.replacingOccurrences(of: "CardNo=", with: "")
        let cardExpDate = cardExpStr.replacingOccurrences(of: "CardExDate=", with: "")
        let conId = conIdStr.replacingOccurrences(of: "Con_ID=", with: "")
        
        print("a ",cardNo)
        print("b ",cardExpDate)
        print("c ",conId)
 }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            //urlStr is what you want
            print("url  ",urlStr)
        }

        decisionHandler(.allow)
    }
}

