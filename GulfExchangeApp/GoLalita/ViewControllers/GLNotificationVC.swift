//
//  GLNotificationVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 22/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class GLNotificationVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var readMoreBtn: UIButton!
    
    var NotificationID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeBtn.setTitle("", for: .normal)
        bgView.clipsToBounds = true
        
        getNotificationDetails()
        addNavbar()
    }
    
    
    func getNotificationDetails() {
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        if NotificationID == 0 || token == ""{
            print("invalid token or id")
        }else{
            let params: Parameters = [
                "params": [
                    "token": token,
                    //                "x_online_store": null,
                    //                "category_id":null,
                    //                "merchant_name":null,
                    "notification_id": NotificationID
                ]
            ]
            
            print("getnotificationurldetails - \(GLNotificationlist)\n")
            print("getnotificationdetailsparameters - \(params)\n")
            
            AF.request(GLNotificationlist, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                print("GLNotificationlistdetailss Response - \(response) - \n")
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
                        GolalitaApiManager.shared.updateNotification(from: data)
                        
//                        
//                        merchantBanner = GolalitaApiManager.shared.merchantDetails?.banners
//                        
//                        urlToImg(urlString: merchantDetails?.merchantLogo ?? "", to: logoImage)
//                        titleLbl.text = merchantDetails?.category

                       // GolalitaApiManager.shared.Notification!.banner
                        if let firstNotification = GolalitaApiManager.shared.Notification?.first {
                            // Now you can access the `banner` property of the `NotificationList` instance
                            let banner = firstNotification.offer_image
                            urlToImg(urlString: firstNotification.offer_image ?? "", to: self.imageView)
                            // Do something with `banner`
                        } else {
                            print("No notifications available")
                        }
                        
                        if let html_description = GolalitaApiManager.shared.Notification?.first {
                            // Now you can access the `banner` property of the `NotificationList` instance
                            let descrptionn = html_description.html_description
                           // urlToImg(urlString: firstNotification.banner ?? "", to: self.imageView)
                            // Do something with `banner`
                            
                            let htmlString = """
                                <!DOCTYPE html>
                                <html>
                                <head>
                                    <title>Sample</title>
                                </head>
                                <body>
                                    <p>This is a sample text to demonstrate font size increase.</p>
                                </body>
                                </html>
                                """
                           /// self.webView.loadHTMLString(htmlString, baseURL: nil)
                            self.webView.loadHTMLString(html_description.html_description ?? "", baseURL: nil)
                                
                                // Adjust the font size after content is loaded
                            self.webView.evaluateJavaScript("document.body.style.fontSize = '48px';", completionHandler: { result, error in
                                    if let error = error {
                                        print("Error adjusting font size: \(error)")
                                    }
                                })
                            
//                            self.webView.loadHTMLString(html_description.html_description ?? "", baseURL: nil)
                        } else {
                            print("No descrption available")
                        }
                        
                        //self.loadImage(from: "\(GolalitaApiManager.shared.Notification.banner)", into: self.imageView)

                        // Convert the count to a string and update the label's text
                        
                    } else {
                        print("Error: No data in response")
                    }
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
                //completion()
            })
        }
        
    }
    
    func loadImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create a URLSession data task to fetch the image
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            
            // Update the UIImageView on the main thread
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func readMoreBtnTapped(_ sender: Any) {
        print("readMoreBtnTapped")
        
       
        
        // Create a new view controller for zooming the image
        let zoomedImageViewController = ZoomedImageViewController(image: imageView.image)
        
        // Present the zoomed image view controller
        present(zoomedImageViewController, animated: true, completion: nil)
        
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
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.navigationItem.title = "Golalita Rewards"
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HelpVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
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

// WKNavigationDelegate method to know when content is loaded
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      // Adjust the font size after content is loaded
      let script = "document.body.style.fontSize = '48px';"
      print("webafterloaded: \("..")")
      webView.evaluateJavaScript(script) { result, error in
          if let error = error {
              print("Error adjusting font size: \(error)")
          }
      }
  }

