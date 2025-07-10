//
//  BranchDataModel.swift
//  GulfExchangeApp
//
//  Created by Philip on 28/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

enum branchList{
    case success([[String:AnyObject]])
    case failure(String)
}

class BranchDataModel: NSObject {
    var arrRes:[[String:AnyObject]]=[]

    public func FetchDataJson(completionHandler: @escaping (branchList) -> ()){
        let para = ["lang" : "en",
                    "cat_id":"1"]
             AFWrapper.requestPOST(methodName: "branches_listing", parameters: para, success:{ (JSONResponse) in
               print(JSONResponse["status"].string)
//               if let status = JSONResponse["status"].string{
//                   if(status == "success"){
                       print((JSONResponse["branches_listing"].arrayObject) != nil)
                       if((JSONResponse["branches_listing"].arrayObject) != nil) {
                        
                            if let swiftyJsonVar = (JSONResponse["branches_listing"].arrayObject){
                                self.arrRes = swiftyJsonVar as? [[String : AnyObject]] ?? []
                                completionHandler(.success(self.arrRes))
                            }
                        
                       }
                
//                   }
                       
                       
                   else{
                        let message = JSONResponse["message"].string
                        completionHandler(.failure("error"))//( message ?? ""))
                    }
//               }
               
               
               
           }) { (error) in
               print(error)
           }
       
    }
}
