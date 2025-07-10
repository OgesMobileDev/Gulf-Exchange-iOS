//
//  FAQViewController.swift
//  GulfExchangeApp
//
//  Created by test on 22/03/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class FAQViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var timerGesture = UITapGestureRecognizer()
    var timer = Timer()
    
    let defaults = UserDefaults.standard

 
    var Faqarray:[Country] = []
    
    let messageFrame = UIView()
       var activityIndicator = UIActivityIndicatorView()
       var strLabel = UILabel()
       let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
       
    
    @IBOutlet var Faqtableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        self.Faqtableview.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
               self.navigationItem.rightBarButtonItem  = custmHelpBtn
               self.title = NSLocalizedString("FAQ", comment: "")
        // Do any additional setup after loading the view.
           getfaqlist()
        
        Faqtableview.estimatedRowHeight = 90
        Faqtableview.rowHeight = UITableView.automaticDimension
        
        
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
        timerGesture = UITapGestureRecognizer(target: self, action: #selector(resetTimer))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(timerGesture)

       

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            timer.invalidate()
    }
    
    
    @objc func userIsInactive() {
        // Alert user
//        let alert = UIAlertController(title: "You have been inactive for 5 minutes. We're going to log you off for security reasons.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
//        //Log user off
//        }))
//        present(alert, animated: true)
        
        timer.invalidate()
        
        if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
        {

        }
        else
        {
        self.defaults.set("", forKey: "USERID")
        self.defaults.set("", forKey: "PASSW")
        self.defaults.set("", forKey: "PIN")
        self.defaults.set("", forKey: "REGNO")
        }

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
                self.navigationController?.pushViewController(nextViewController, animated: true)


        return
        
     }

    @objc func resetTimer() {
        print("Reset")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(userIsInactive), userInfo: nil, repeats: true)
     }

    
    
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return Faqarray.count
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        return 150
     return UITableView.automaticDimension

    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell") as! FAQTableViewCell
        //let notification = notificationArray[indexPath.row]
       // cell.setNotification(notification: notification)
       // cell.delegate = self
        Faqtableview.allowsSelection = false
        
        let country = Faqarray[indexPath.row]
        cell.Faqquestlbl.text = country.id
      //   cell.Faqquestlbl.font = UIFont(name:"system", size: 14.0)
         //self.TermsCondTextView.attributedText = content.htmlToAttributedString
       // cell.notifyMsg.attributedText = country.en_short_name.htmlToAttributedString
      //  cell.notifyMsg.text = ""
        
        
        cell.textvieww.attributedText = country.en_short_name.htmlToAttributedString
        
        cell.textvieww.isUserInteractionEnabled = true
        cell.textvieww.isEditable = false
        
       // cell.notifyMsg.font = UIFont(name:"Regular", size: 14.0)
        //cell.notifyMsg.textColor = UIColor.darkGray
        
        cell.Faqquestlbl.numberOfLines = 0
       // cell.notifyMsg.numberOfLines = 0
        
        cell.textvieww.textColor = UIColor.gray
        cell.textvieww.font = UIFont(name:"Helvetica Neue", size: 15.0)
        
        
       // cell.Faqquestlbl.text = "What are the steps need to follow for register?"
       // cell.notifyMsg.text = "Saturday to Thursday: 8am&ndash;10pm | Friday: 8&ndash;11am, 1&ndash;10pm"
       
      //  cell.dateTime.text = ".dffdhdhdfhd dfhfdhdfhdf dfhdfhdfh dfhdfhdh dfhdhdfhdfh"
      
        
        
        
        return cell
        
        
        
     }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            UIApplication.shared.open(URL)
            return false
        }
    
     
    
    func activityIndicator(_ title: String) {
          strLabel.removeFromSuperview()
          activityIndicator.removeFromSuperview()
          effectView.removeFromSuperview()
          
          strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
          strLabel.text = title
          strLabel.font = .systemFont(ofSize: 14, weight: .medium)
          strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
          
          effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
          effectView.layer.cornerRadius = 15
          effectView.layer.masksToBounds = true
          
          activityIndicator = UIActivityIndicatorView(style: .white)
          activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
          activityIndicator.startAnimating()
          
          effectView.contentView.addSubview(activityIndicator)
          effectView.contentView.addSubview(strLabel)
          view.addSubview(effectView)
      }
    
    //api
    func getfaqlist() {
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "faq_listing"
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        
        
        let params:Parameters = ["lang":"en"]
        
print("faqlisturl",url)
print("faqlistparams",params)
        
          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("history",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let resultArray = myResult!["faq_listing"]
                
                
//               if  appLang == "ar"
//               {
//                for i in resultArray.arrayValue{
//                let nationality = Country(id: i["faq_title_ar"].stringValue, num_code: i["num_code"].stringValue, alpha_2_code: i["alpha_2_code"].stringValue, alpha_3_code: i["faq_desc_ar"].stringValue, en_short_name: i["faq_desc_ar"].stringValue, nationality: i["nationality"].stringValue)
//
//                    if  i["alpha_2_code"].stringValue.isEmpty
//                    {
//
//                    }
//
//                    self.Faqarray.append(nationality)
//
//                }
//               }
                
               // if  appLang == "en"
               // {
                for i in resultArray.arrayValue{
                    let nationality = Country(id: i["faq_title_en"].stringValue, num_code: i["num_code"].stringValue, alpha_2_code: i["alpha_2_code"].stringValue, alpha_3_code: i["faq_desc_en"].stringValue, en_short_name: i["faq_desc_en"].stringValue, nationality: i["nationality"].stringValue)
                    
                     self.Faqarray.append(nationality)
                   
                }
                //}
   
                 self.Faqtableview.reloadData()
                break
            case .failure:
                break
            }
          })
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
