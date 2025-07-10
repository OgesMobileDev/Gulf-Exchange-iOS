//
//  CheckUserModel.swift
//  GulfExchangeApp
//
//  Created by macbook on 24/09/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation
struct CheckEmailResponse: Codable {
    let jsonrpc: String?
    let id: String?
    let result: CheckEmail?
}

struct CheckEmail: Codable {
    let error: String?
    let sucess: String?
    let success: String?
}
struct RegistrationResponse: Codable {
    let jsonrpc: String?
    let id: String?
    let result: RegistrationResult?
}
struct RegistrationResult: Codable {
    let error: String?
    let success: String?
    let org: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        org = try? container.decode(String.self, forKey: .org)
        error = try? container.decode(String.self, forKey: .error)
        if let stringValue = try? container.decode(String.self, forKey: .success) {
            success = stringValue
        } else if let boolValue = try? container.decode(Bool.self, forKey: .success) {
            success = boolValue ? "true" : "false"
        } else if let intValue = try? container.decode(Int.self, forKey: .success) {
            success = String(intValue)
        } else {
            success = ""
        }

    }
}

struct Organization: Codable {
    let id: Int
    let name: String
    let email: String
}
/*checkEmail Response - success({
    id = "<null>";
    jsonrpc = "2.0";
    result =     {
        sucess = "This email is not associated with any users yet !";
    };
}) -


registerUser Response - success({
    id = "<null>";
    jsonrpc = "2.0";
    result =     {
        org = "res.partner(3898,)";
        success = 1;
    };
}) -

 Success: This email is not associated with any users yet !
 registerUser - parameters: ["params": ["email": "hiya@gmail.com", "name": "hiya jis", "password": "Omar@1234", "phone": "97425851474", "parent_id": "3898"]]

 */
