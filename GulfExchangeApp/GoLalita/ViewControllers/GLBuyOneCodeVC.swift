//
//  GLBuyOneCodeVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 23/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GLBuyOneCodeVC: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var offerTitleLbl: UILabel!
    @IBOutlet weak var pinEnterLbl: UILabel!
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var clearAllBtn: UIButton!
    @IBOutlet weak var applyCodeLbl: UILabel!
    
    var merchantName = ""
    var pincode:String = ""
    var offerTitle = ""
    var customerEmail = GolalitaApiManager.shared.userProfile?.email ?? ""
    var customerID = "\(GolalitaApiManager.shared.userProfile?.id ?? 0)"
    var customerName = GolalitaApiManager.shared.userProfile?.name ?? ""
    var customerPhone = GolalitaApiManager.shared.userProfile?.phone ?? ""
    var productID = 0
    var trackValue = ""
    
    let jsonString = """
    {
        "jsonrpc": "2.0",
        "id": null,
        "result": 1
    }
    """

    /*
     "customer_email": "mailto:devtest@gulf.com",
     "customer_id": "24499",
     "customer_name": "Sayed",
     "customer_phone": "+97430444432",
     "product_id": 21489,
     "token": "b8d60c656f9746eca539f84f2afa4c80" ,
     "track_type": "b1g1",
     "track_value": "5529"
     */
    var textFields:[UITextField] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        addTxtField()
        setLablelTxt()
//        clearAllBtn.titleLabel
    }
    
    @IBAction func redeemBtnTapped(_ sender: Any) {

        pincode.removeAll()
        for text in textFields {
            if (text.text == "" || text.text == nil){
                print("redeemBtnTapped - error pin empty")
                showAlert(title: "Error", message: "Please type the PIN properly")
                break
            }else{
                pincode.append(text.text!)
            }
            
        }
        if pincode.count == 4{
            
            print("redeemBtnTapped - pin \(pincode)")
            trackValue = pincode
            getRedeemCode()
        }
        
    }
    
    @IBAction func clearAllBtnTapped(_ sender: Any) {
        
        pincode.removeAll()
        
        
        for textField in textFields {
            textField.text = ""
        }
        textFields[0].becomeFirstResponder()
        
    }
    func setLablelTxt(){
        if offerTitle != "" {
            offerTitleLbl.text = offerTitle
        }else{
            offerTitleLbl.text = "Buy 1 Get 1 Free"
        }
        let title = "Clear All"
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 10)
        ])

        // Apply the attributed string to the button's title
        clearAllBtn.setAttributedTitle(attributedTitle, for: .normal)
        
        pinEnterLbl.text = "Please ask \(merchantName) to enter it's PIN"
        applyCodeLbl.text = "Apply the promo code on \(merchantName) to avail the discount"
    }
    func checkValuesAndProceed() {
        if !merchantName.isEmpty &&
            !pincode.isEmpty &&
            !offerTitle.isEmpty &&
            !customerEmail.isEmpty &&
            !customerID.isEmpty &&
            !customerName.isEmpty &&
            !customerPhone.isEmpty &&
            productID != 0 &&
            !trackValue.isEmpty {
            getRedeemCode()
        } else {
            print("One or more fields are empty.")
        }
    }
    func getRedeemCode(){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        let params: Parameters = [
            "params": [
                "token": token,
                "customer_email": customerEmail,
                "customer_id": customerID,
                "customer_name": customerName,
                "customer_phone": customerPhone,
                "product_id": productID,
                "track_type": "b1g1",
                "track_value": trackValue
            ]
        ]
        AF.request(GLB1G1Redeem, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getMerchantDetails Response - \(response) - \n")
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                      let result = jsonResponse["result"] as? [String: Any],
                           let error = result["error"] as? String {
                            
                            // Check if the error is "Invalid User Token"
                            if error == "Invalid User Token" {
                                self.showAlertHome(title: "Error", message: "Your session has expired. Please return to the home page")
                            } else {
                                print("No problem with the response")
                                // Handle other cases here if needed
                            }
                        }
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                    self.handleApiResponse(data)
                } else {
                    showAlert(title: "Failure", message: "Error Please Try again")
                    print("Error: No data in response")
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    func handleApiResponse(_ data: Data) {
        do {
            // Attempt to deserialize the JSON data into a dictionary
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                // Check for the "result" key and its value
                if let result = jsonResponse["result"] as? Bool {
                    // Check if the result is true or false
                    if result {
                        showAlert(title: "Success", message: "The operation was successful.")
                    } else {
                        showAlert(title: "Failure", message: "Error Please Try again")
                        print("The operation failed.")
                    }
                } else if let result = jsonResponse["result"] as? Int {
                    // Check if the result is 1 or 0
                    if result == 1 {
                        showAlert(title: "Success", message: "The operation was successful.")
                    } else {
                        showAlert(title: "Failure", message: "")
                        print("The operation failed.")
                    }
                } else {
                    showAlert(title: "Error", message: "Invalid PIN, please try again.")
                    print("Unexpected result type.")
                }
            } else {
                showAlert(title: "Error", message: "Invalid PIN, please try again.")
                print("Invalid JSON structure.")
            }
        } catch {
            // Handle JSON deserialization error
            showAlert(title: "Error", message: "Invalid PIN, please try again.")
            print("Failed to parse response.")
        }
    }
    //Invalid OTP, please try again.

    func addTxtField(){
        let width:CGFloat = ((textFieldView.frame.width - 28) / 4)
        for i in 0...3 {
            let textField = UITextField(frame: CGRect(x: CGFloat(3+i*(Int(width) + 8)), y: 5, width: width, height: 70))
            textField.backgroundColor = .white
            textField.textColor = .black
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
            textField.borderStyle = .none
            textField.delegate = self
            textField.isSecureTextEntry = false
            textField.tag = i
            textField.layer.cornerRadius = 10
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.gray.cgColor
            textFields.append(textField)
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            textFieldView.addSubview(textField)
        }
    }
    @objc func textFieldDidChange(textField:UITextField) {
        let text = textField.text
        for i in 0...3{
            switch textField {
            case textFields[i]:
                if i<3{
                    textFields[i+1].becomeFirstResponder()
                }else{
                    textFields[i].resignFirstResponder()
                }
            default:
                break
            }
        }
        if text?.count == 0{
            
            for i in 0...3 {
                switch textField {
                case textFields[i]:
                    if i>0{
                        textFields[i-1].becomeFirstResponder()
                    }else{
                        textFields[i].becomeFirstResponder()
                    }
                default:
                    break
                    
                }
            }
        }
    }
//    func showAlert(title: String, message: String){
//        let commonAlert = UIAlertController(title:title, message:message, preferredStyle:.alert)
//        let okAction = UIAlertAction(title:"OK", style: .cancel)
//        commonAlert.addAction(okAction)
//        UIApplication.shared.keyWindow?.rootViewController?.present(commonAlert, animated: true, completion: nil)
//    }
    func showAlertHome(title: String, message: String) {
        let commonAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            // Navigate to HomeViewController
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            if let viewControllers = self.navigationController?.viewControllers {
                for viewController in viewControllers {
                    if viewController is CustomTabController {
                        self.navigationController?.popToViewController(viewController, animated: true)
                        break
                    }
                }
            }else{
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        
        commonAlert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(commonAlert, animated: true, completion: nil)
    }

}
