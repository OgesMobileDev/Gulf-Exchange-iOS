//
//  APIManager.swift
//  GulfExchangeApp
//
//  Created by macbook on 17/12/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class APIManager {
    let defaults = UserDefaults.standard
    var count:Int = 0
    static let shared = APIManager()
    private init() {}

    // MARK: - Token Fetching
    func fetchToken(completion: @escaping (String?) -> Void) {
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString() ?? ""
        let headers: HTTPHeaders = ["Authorization" : "Basic \(encodedValue)"]

        // Call API
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        let json = try? JSON(data: data)
                        let token = json?["access_token"].string
                        // Call getNotificationCount immediately after fetching the token
                                           if let accessToken = token {
                                               let loggedIn = (UserDefaults.standard.object(forKey: "isLoggedIN") as? Bool) ?? false
                                               if loggedIn{
                                                   self.getNotificationCount(accessToken: accessToken)
                                               }
                                           }

                        completion(token) // Return token to the caller
                    } else {
                        completion(nil)
                    }
                case .failure:
                    completion(nil)
                }
            }
    }
    
    // MARK: - Session Update
    func updateSession(sessionType: String, accessToken: String, completion: @escaping (String) -> Void) {
        let url = ge_api_url_new + "utilityservice/updateSession"
        let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let params: Parameters = [
            "partnerId": partnerId,
            "token": token,
            "customerUserId": UserDefaults.standard.string(forKey: "USERID") ?? "",
            "loginSessionId": udid,
            "sessionType": sessionType
        ]
        print("updateSession params",params)
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessToken)"]

        // Call API
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                print("updateSession response\(response)")
                if let data = response.data {
                    let json = try? JSON(data: data)
                    let responseCode = json?["responseCode"].string ?? "Unknown"
                    completion(responseCode) // Return response code to the caller
                } else {
                    completion("Error")
                }
            }
    }
    
    func getNotificationCount(accessToken:String) {
        print("notification count......")
        self.count = 0
            let dateTime:String = getCurrentDateTime()
            let url = ge_api_url_new + "utilityservice/listordeletenotification"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"customerIDNo":defaults.string(forKey: "USERID")!,"customerPassword":defaults.string(forKey: "PASSW") ?? "","mpin":defaults.string(forKey: "PIN") ?? "","notificationID":"","messageReadFag":" ","actionType":"LIST"]
            let headers:HTTPHeaders = ["Authorization" : "Bearer \(accessToken )"]
            
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
//                print("getNotificationCount ",response)
                switch response.result{
                case .success:
                    let myResult = try? JSON(data: response.data!)
                    let respCode = myResult!["responseCode"]
                    let respMsg = myResult!["responseMessage"].stringValue
    //                print("respCode...",respCode)
    //                print("respMsg...",respMsg)
                    if(respCode == "S120")
                    {
                        
                        /*let resultArray = myResult!["notificationList"]
                        for i in resultArray.arrayValue{
                            if(i["messageReadFlag"].stringValue == "UNREAD")
                            {
                                self.count = self.count + 1
                                print("getNotificationCount countt",self.count)
                                
                                
                            }
                        }*/
                        let unreadCount = myResult?["unreadCount"].intValue
//                        print("unreadCount - \(unreadCount ?? 0)")
                        self.count = unreadCount ?? 0
                        
                        if(self.count == 0)
                        {
                            notificationCount = false
                            print("notificationCount = false")
                            
                        }
                        else
                        {
                            notificationCount = true
                            print("notificationCount = true")
                        }
                    }
                case .failure:
                    break
                }
                
                
            })
        }
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        return formattedDate
    }
}


