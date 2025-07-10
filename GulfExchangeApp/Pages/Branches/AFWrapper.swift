//
//  AFWrapper.swift
//  GulfExchangeApp
//
//  Created by Philip on 28/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AFWrapper: NSObject {
        
    class func requestPOST(methodName:String, parameters: Dictionary<String,Any>, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
//         let BaseURL = "https://gulfexchange.com.qa/work_new/api/get-request/"
         let BaseURL = api_url

            print(parameters)
            
            AF.request(URL(string: BaseURL+methodName )!, method: .post, parameters: parameters, encoding:URLEncoding.default, headers: ["Authorization": "Basic)", "Accept": "application/json"] )/*validate()*/.responseJSON { (responseObject) -> Void in
                print("Branches Listing response",responseObject)
//                print()
                switch responseObject.result{
                case .success:
                    let resJson = try? JSON(data: responseObject.data!)
//                    let code = myresult!["scode"]
                    
                    success(resJson ?? "")
                   
                    break
                case .failure:
                    break
                
                }
                
    //           common.hideHUD()
//                if responseObject.result{
//                    let resJson = JSON(responseObject.result.data!)
//                    success(resJson)
//                    print(resJson)
//                }
//                if responseObject.result.Failure {
//                    let error : Error = responseObject.result.error!
//                    if(error.localizedDescription == "The Internet connection appears to be offline."){
//                        common.showAlert(title: "Network Connection", message: error.localizedDescription)
//                    }
//                    else{
//                        common.showAlert(title: "Sorry", message: "Unable to connect to server! Please check your internet connection and try again.")
//                    }
//                    failure(error)
              //  }
            }
        }
}
