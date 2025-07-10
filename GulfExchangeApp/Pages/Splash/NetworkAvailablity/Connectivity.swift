//
//  Connectivity.swift
//  GulfExchangeApp
//
//  Created by Philip on 28/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire

class Connectivity: NSObject {
    
    class var isNetworkAvailable:Bool{
        
        let isNetworkAvailable = NetworkReachabilityManager()!.isReachable
        
        if(!isNetworkAvailable){
            showAlert(title: "Network Unavailable", message: "Please check your internet connection and try again!")
        }
        
        return isNetworkAvailable
    }

}
func showAlert(title: String, message: String){
    let commonAlert = UIAlertController(title:title, message:message, preferredStyle:.alert)
    let okAction = UIAlertAction(title:"OK", style: .cancel)
    commonAlert.addAction(okAction)
    UIApplication.shared.keyWindow?.rootViewController?.present(commonAlert, animated: true, completion: nil)
}
