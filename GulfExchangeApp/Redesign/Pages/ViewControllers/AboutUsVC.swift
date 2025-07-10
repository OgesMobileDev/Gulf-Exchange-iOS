//
//  AboutUsVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 28/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield
import Alamofire
import SwiftyJSON

class AboutUsVC: UIViewController {
    
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    // about
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var aboutExpandView: UIView!
    @IBOutlet weak var aboutHideView: UIView!
    @IBOutlet weak var aboutDescLbl: UILabel!
    @IBOutlet weak var aboutArrowBtn: UIImageView!
    @IBOutlet weak var aboutViewHeightConstraint: NSLayoutConstraint!
    // management
    @IBOutlet weak var managementLbl: UILabel!
    @IBOutlet weak var managementBtn: UIButton!
    @IBOutlet weak var managementArrowImg: UIImageView!
    @IBOutlet weak var managementExpandView: UIView!
    @IBOutlet weak var managementHiddenView: UIView!
    @IBOutlet weak var managementDescLbl: UILabel!
    @IBOutlet weak var managementViewHeightConstraint: NSLayoutConstraint!
    // mission
    @IBOutlet weak var missionLbl: UILabel!
    @IBOutlet weak var missionArrowImg: UIImageView!
    @IBOutlet weak var missionBtn: UIButton!
    @IBOutlet weak var missionExpandingView: UIView!
    @IBOutlet weak var missionHideView: UIView!
    @IBOutlet weak var missionTitleLbl: UILabel!
    @IBOutlet weak var visionTitleLbl: UILabel!
    @IBOutlet weak var valuesTitleLbl: UILabel!
    @IBOutlet weak var missionDescLbl: UILabel!
    @IBOutlet weak var visionDescLbl: UILabel!
    @IBOutlet weak var valuesDescLbl: UILabel!
    @IBOutlet weak var missionViewHeightConstraint: NSLayoutConstraint!
    // members
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var membersImg: UIImageView!
    @IBOutlet weak var membersBtn: UIButton!
    @IBOutlet weak var membersArrowImg: UIImageView!
    @IBOutlet weak var membersExpandView: UIView!
    @IBOutlet weak var membersDescLbl: UILabel!
    @IBOutlet weak var membersHiddenView: UIView!
    @IBOutlet weak var membersViewHeightConstraint: NSLayoutConstraint!
    // aml
    @IBOutlet weak var amlLbl: UILabel!
    @IBOutlet weak var amlBtn: UIButton!
    @IBOutlet weak var amlArrowImg: UIImageView!
    @IBOutlet weak var amlExpandView: UIView!
    @IBOutlet weak var amlDescLbl: UILabel!
    @IBOutlet weak var amlHideView: UIView!
    @IBOutlet weak var amlViewHeightConstraint: NSLayoutConstraint!
    
    
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var backgroundView: UIView?

    
    var aboutViewToggle:Bool = false
    var managementViewToggle:Bool = false
    var missionViewToggle:Bool = false
    var membersViewToggle:Bool = false
    var amlViewToggle:Bool = false
    let defaults = UserDefaults.standard
    
    var aboutUSData:AboutUsResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.stopActivityIndicator(enableInteraction: true)
        
        addNavbar()
        resetFields()
        getAboutUsData()
        aboutBtn.setTitle("", for: .normal)
        managementBtn.setTitle("", for: .normal)
        missionBtn.setTitle("", for: .normal)
        membersBtn.setTitle("", for: .normal)
        amlBtn.setTitle("", for: .normal)
        
//        aboutDescLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "about_us", comment: "")
        managementDescLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "message_from_ge", comment: "")
        missionDescLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "mission_ge", comment: "")
        visionDescLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "vision_ge", comment: "")
        valuesDescLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "values_ge", comment: "")
        amlDescLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "compliance", comment: "")
        
        membersViewHeightConstraint.constant = 0
        
        membersLbl.isHidden = true
        membersBtn.isHidden = true
        membersArrowImg.isHidden = true
        membersExpandView.isHidden = true
        membersDescLbl.isHidden = true
        membersHiddenView.isHidden = true
        membersImg.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.stopActivityIndicator(enableInteraction: true)
        APIManager.shared.fetchToken { token in
            if let token = token {
                // Call login session update
                APIManager.shared.updateSession(sessionType: "1", accessToken: token) { responseCode in
                    if responseCode == "S222" {
                        print("Session Valid")
                    } else {
                        self.handleSessionError()
                    }
                }
            } else {
                print("Failed to fetch token")
            }
        }
//        ScreenShield.shared.protect(view: aboutExpandView)
//        ScreenShield.shared.protect(view: managementExpandView)
//        ScreenShield.shared.protect(view: missionExpandingView)
//        ScreenShield.shared.protect(view: membersExpandView)
//        ScreenShield.shared.protect(view: amlExpandView)
        ScreenShield.shared.protectFromScreenRecording()
    }
    func handleSessionError() {
        //        if !defaults.string(forKey: "biometricenabled") == "biometricenabled"{
        //
        //        }
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
        self.defaults.set("logoutbiometrc", forKey: "logoutbiometrc")
                UserDefaults.standard.set(false, forKey: "isLoggedIN")
        //        UserDefaults.standard.removeObject(forKey: "biometricenabled")
                
                if let navigationController = self.navigationController {
                    for controller in navigationController.viewControllers {
                        if let tabController = controller as? MainLoginViewController {
                            navigationController.popToViewController(tabController, animated: true)
                            return
                        }
                    }
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
    }
    
    @IBAction func aboutBtnTapped(_ sender: Any) {
        
        
        aboutViewToggle.toggle()
        if aboutViewToggle{
            aboutArrowBtn.image = UIImage(named: "faq_up")
            aboutHideView.isHidden = false
            aboutExpandView.isHidden = false
            let calculatedHeight = getLabelHeight(textLabel: aboutDescLbl)
            aboutViewHeightConstraint.constant = calculatedHeight + 35 + 70
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant + aboutViewHeightConstraint.constant
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()
                
                if self.defaults.bool(forKey: "accessibilityenabled"){
                    SpeechHelper.shared.speak("about gulf exchange", languageCode: "en")
                }

            }
        }else{
            aboutArrowBtn.image = UIImage(named: "faq_down")
            
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant - aboutViewHeightConstraint.constant
            aboutViewHeightConstraint.constant = 70
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.aboutHideView.isHidden = true
                self.aboutExpandView.isHidden = true
            }
        }
    }
    @IBAction func managementBtnTapped(_ sender: Any) {
        managementViewToggle.toggle()
        if managementViewToggle{
            managementArrowImg.image = UIImage(named: "faq_up")
            managementHiddenView.isHidden = false
            managementExpandView.isHidden = false
            let calculatedHeight = getLabelHeight(textLabel: managementDescLbl)
            managementViewHeightConstraint.constant = calculatedHeight + 35 + 70
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant + managementViewHeightConstraint.constant
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()
                
                if self.defaults.bool(forKey: "accessibilityenabled"){
                    SpeechHelper.shared.speak("message from management", languageCode: "en")
                }
            }
        }else{
            managementArrowImg.image = UIImage(named: "faq_down")
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant - managementViewHeightConstraint.constant
            managementViewHeightConstraint.constant = 70
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.managementHiddenView.isHidden = true
                self.managementExpandView.isHidden = true
            }
        }
    }
    @IBAction func missionBtnTapped(_ sender: Any) {
        missionViewToggle.toggle()
        if missionViewToggle{
            missionArrowImg.image = UIImage(named: "faq_up")
            missionHideView.isHidden = false
            missionExpandingView.isHidden = false
            let calculatedHeight1 = getLabelHeight(textLabel: missionDescLbl)
            let calculatedHeight2 = getLabelHeight(textLabel: visionDescLbl)
            let calculatedHeight3 = getLabelHeight(textLabel: valuesDescLbl)
            let height = calculatedHeight1 + calculatedHeight2 + calculatedHeight3 + 155 + 70
            missionViewHeightConstraint.constant =  height
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant + missionViewHeightConstraint.constant
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()
                
                if self.defaults.bool(forKey: "accessibilityenabled"){
                    SpeechHelper.shared.speak("mission,vision & values", languageCode: "en")
                }
                
            }
        }else{
            missionArrowImg.image = UIImage(named: "faq_down")
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant - missionViewHeightConstraint.constant
            missionViewHeightConstraint.constant = 70
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.missionHideView.isHidden = true
                self.missionExpandingView.isHidden = true
            }
        }
    }
    @IBAction func membersBtnTapped(_ sender: Any) {
        membersViewToggle.toggle()
        if membersViewToggle{
            membersArrowImg.image = UIImage(named: "faq_up")
            membersHiddenView.isHidden = false
            membersExpandView.isHidden = false
            let calculatedHeight = getLabelHeight(textLabel: membersDescLbl)
            membersViewHeightConstraint.constant = calculatedHeight + 35 + 70
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant + membersViewHeightConstraint.constant
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()
                
                
                if self.defaults.bool(forKey: "accessibilityenabled"){
                    SpeechHelper.shared.speak("team members", languageCode: "en")
                }
                
            }
        }else{
            membersArrowImg.image = UIImage(named: "faq_down")
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant - membersViewHeightConstraint.constant
            membersViewHeightConstraint.constant = 70
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.membersHiddenView.isHidden = true
                self.membersExpandView.isHidden = true
            }
        }
    }
    @IBAction func amlBtnTapped(_ sender: Any) {
        amlViewToggle.toggle()
        if amlViewToggle{
            amlArrowImg.image = UIImage(named: "faq_up")
            amlHideView.isHidden = false
            amlExpandView.isHidden = false
            let calculatedHeight = getLabelHeight(textLabel: amlDescLbl)
            amlViewHeightConstraint.constant = calculatedHeight + 35 + 70
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant + amlViewHeightConstraint.constant
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()
                
                
                if self.defaults.bool(forKey: "accessibilityenabled"){
                    SpeechHelper.shared.speak("aml & cft compliance", languageCode: "en")
                }
            }
        }else{
            amlArrowImg.image = UIImage(named: "faq_down")
            scrollViewHeightConstraint.constant = scrollViewHeightConstraint.constant - amlViewHeightConstraint.constant
            amlViewHeightConstraint.constant = 70
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.amlHideView.isHidden = true
                self.amlExpandView.isHidden = true
            }
        }
    }
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = NSLocalizedString("about_us_title", comment: "")
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func resetFields(){
        scrollViewHeightConstraint.constant = 400
        
        aboutArrowBtn.image = UIImage(named: "faq_down")
        aboutHideView.isHidden = true
        aboutExpandView.isHidden = true
        aboutViewHeightConstraint.constant = 70
        
        managementArrowImg.image = UIImage(named: "faq_down")
        managementViewHeightConstraint.constant = 70
        managementHiddenView.isHidden = true
        managementExpandView.isHidden = true
        
        missionArrowImg.image = UIImage(named: "faq_down")
        missionViewHeightConstraint.constant = 70
        missionHideView.isHidden = true
        missionExpandingView.isHidden = true
        
        membersArrowImg.image = UIImage(named: "faq_down")
        membersViewHeightConstraint.constant = 70
        membersHiddenView.isHidden = true
        membersExpandView.isHidden = true
        
        amlArrowImg.image = UIImage(named: "faq_down")
        amlViewHeightConstraint.constant = 70
        amlHideView.isHidden = true
        amlExpandView.isHidden = true
    }
    
    private func getLabelHeight(textLabel:UILabel) -> CGFloat {
        let maxSize = CGSize(width: textLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)
        let size = textLabel.sizeThatFits(maxSize)
        return size.height
    }
    
    
    func setApiData(){
        
        let aboutDesc = convertHTMLToAttributedString(htmlText: aboutUSData?.aboutUsGulf?[0].aboutUsDesc ?? "")
        let aboutMessageDesc = convertHTMLToAttributedString(htmlText: aboutUSData?.aboutUsMessage?[0].aboutUsDesc ?? "")
        let aboutComplianceDesc = convertHTMLToAttributedString(htmlText: aboutUSData?.aboutUsCompliance?[0].aboutUsDesc ?? "")
        
        var missionDesc:NSAttributedString?
        var visionDesc:NSAttributedString?
        var valuesDesc:NSAttributedString?
        
        for i in 0..<(aboutUSData?.aboutUsMission?.count ?? 0){
//            if aboutUSData?.aboutUsMission[i].id
            let id = aboutUSData?.aboutUsMission?[i].id ?? ""
            // our vision
            if id == "7"{
                visionDesc = convertHTMLToAttributedString(htmlText: aboutUSData?.aboutUsMission?[i].aboutUsDesc ?? "")
                self.visionTitleLbl.text = aboutUSData?.aboutUsMission?[i].aboutUsTitle ?? ""
            }
            
            if id == "12"{
                missionDesc = convertHTMLToAttributedString(htmlText: aboutUSData?.aboutUsMission?[i].aboutUsDesc ?? "")
                self.missionTitleLbl.text = aboutUSData?.aboutUsMission?[i].aboutUsTitle ?? ""
            }
            
            if id == "13"{
                valuesDesc = convertHTMLToAttributedString(htmlText: aboutUSData?.aboutUsMission?[i].aboutUsDesc ?? "")
                self.valuesTitleLbl.text = aboutUSData?.aboutUsMission?[i].aboutUsTitle ?? ""
            }
            
            
                
        }
        
        
        
//        aboutDescLbl.text = aboutUSData?.aboutUsGulf?[0].aboutUsDesc ?? ""
        aboutDescLbl.attributedText = aboutDesc
        managementDescLbl.attributedText = aboutMessageDesc
        amlDescLbl.attributedText = aboutComplianceDesc
        missionDescLbl.attributedText = missionDesc
        visionDescLbl.attributedText = visionDesc
        valuesDescLbl.attributedText = valuesDesc
        
        aboutLbl.text = aboutUSData?.aboutUsGulf?[0].aboutUsTitle ?? ""
        managementLbl.text = aboutUSData?.aboutUsMessage?[0].aboutUsTitle ?? ""
        amlLbl.text = aboutUSData?.aboutUsCompliance?[0].aboutUsTitle ?? ""
        
        self.stopActivityIndicator(enableInteraction: true)
    }
    
    func convertHTMLToAttributedString(htmlText: String) -> NSAttributedString? {
        guard let data = htmlText.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        // Apply custom font and size
        let font = UIFont(name: "Poppins-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }

    /*
    func convertHTMLToAttributedString(htmlText: String) -> NSAttributedString? {
        guard let data = htmlText.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
    */
    func activityIndicator(_ title: String, disableInteraction: Bool = true, width: Int) {
        // Remove existing views if any
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        backgroundView?.removeFromSuperview() // Remove the background view if it exists

        // Create and add a white background view
        backgroundView = UIView(frame: view.bounds)
        backgroundView?.backgroundColor = .white
        backgroundView?.tag = 999 // Set a tag to identify it later if needed
        view.addSubview(backgroundView!)

        // Configure the label
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 190, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)

        // Configure the blur effect view
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width / 2,
                                  y: view.frame.midY - strLabel.frame.height / 2,
                                  width: 160,
                                  height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true

        // Configure the activity indicator
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()

        // Add subviews to effectView
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)

        // Add effectView on top of the white background
        view.addSubview(effectView)

        // Disable user interaction if requested
        if disableInteraction {
            view.isUserInteractionEnabled = false
        }
    }

    func stopActivityIndicator(enableInteraction: Bool = true) {
        // Remove all subviews related to the activity indicator
        effectView.removeFromSuperview()
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        strLabel.removeFromSuperview()
        
        // Remove the white background view if it exists
        backgroundView?.removeFromSuperview()
        
        // Enable user interaction if previously disabled
        if enableInteraction {
            view.isUserInteractionEnabled = true
        }
    }

    
    //MARK: - API Calls
    
    func getAboutUsData() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""), disableInteraction: true, width: 160)
        let url = about_us_api
        let params:Parameters = ["lang":"en"]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print("getAboutUsData",response)
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let result = myResult!
                let aboutUsGulf = result["aboutus_gulf"].arrayValue.map{ AboutItem in
                    AboutUsItem(id: AboutItem["id"].stringValue,
                                aboutUsTypeId: AboutItem["aboutus_type_id"].stringValue,
                                aboutUsName: AboutItem["aboutus_name"].stringValue,
                                aboutUsDesignation: AboutItem["aboutus_designation"].stringValue,
                                aboutUsTitle: AboutItem["aboutus_title"].stringValue,
                                aboutUsDesc: AboutItem["aboutus_desc"].stringValue,
                                aboutUsFileName: AboutItem["aboutus_file_name"].stringValue,
                                aboutUsFileMimeType: AboutItem["aboutus_file_mime_type"].stringValue)
                    
                }
                let aboutUsMessage = result["aboutus_message"].arrayValue.map{ AboutItem in
                    AboutUsItem(id: AboutItem["id"].stringValue,
                                aboutUsTypeId: AboutItem["aboutus_type_id"].stringValue,
                                aboutUsName: AboutItem["aboutus_name"].stringValue,
                                aboutUsDesignation: AboutItem["aboutus_designation"].stringValue,
                                aboutUsTitle: AboutItem["aboutus_title"].stringValue,
                                aboutUsDesc: AboutItem["aboutus_desc"].stringValue,
                                aboutUsFileName: AboutItem["aboutus_file_name"].stringValue,
                                aboutUsFileMimeType: AboutItem["aboutus_file_mime_type"].stringValue)
                    
                }
                let aboutUsMission = result["aboutus_mission"].arrayValue.map{ AboutItem in
                    AboutUsItem(id: AboutItem["id"].stringValue,
                                aboutUsTypeId: AboutItem["aboutus_type_id"].stringValue,
                                aboutUsName: AboutItem["aboutus_name"].stringValue,
                                aboutUsDesignation: AboutItem["aboutus_designation"].stringValue,
                                aboutUsTitle: AboutItem["aboutus_title"].stringValue,
                                aboutUsDesc: AboutItem["aboutus_desc"].stringValue,
                                aboutUsFileName: AboutItem["aboutus_file_name"].stringValue,
                                aboutUsFileMimeType: AboutItem["aboutus_file_mime_type"].stringValue)
                    
                }
                let aboutUsCompliance = result["aboutus_compliance"].arrayValue.map{ AboutItem in
                    AboutUsItem(id: AboutItem["id"].stringValue,
                                aboutUsTypeId: AboutItem["aboutus_type_id"].stringValue,
                                aboutUsName: AboutItem["aboutus_name"].stringValue,
                                aboutUsDesignation: AboutItem["aboutus_designation"].stringValue,
                                aboutUsTitle: AboutItem["aboutus_title"].stringValue,
                                aboutUsDesc: AboutItem["aboutus_desc"].stringValue,
                                aboutUsFileName: AboutItem["aboutus_file_name"].stringValue,
                                aboutUsFileMimeType: AboutItem["aboutus_file_mime_type"].stringValue)
                    
                }
                
                let aboutUSDetails = AboutUsResponse(aboutUsGulf: aboutUsGulf,
                                                     aboutUsMessage: aboutUsMessage,
                                                     aboutUsMission: aboutUsMission,
                                                     aboutUsCompliance: aboutUsCompliance,
                                                     fileLink: result["file_link"].stringValue)
                self.aboutUSData = aboutUSDetails
                print("aboutUSData --------------\n\n\(aboutUSDetails)")
                self.setApiData()
                break
            case .failure:
                break
            }
        })
    }
}

import Foundation

// MARK: - Root Response
struct AboutUsResponse: Codable {
    let aboutUsGulf: [AboutUsItem]?
    let aboutUsMessage: [AboutUsItem]?
    let aboutUsMission: [AboutUsItem]?
    let aboutUsCompliance: [AboutUsItem]?
    let fileLink: String?

    enum CodingKeys: String, CodingKey {
        case aboutUsGulf = "aboutus_gulf"
        case aboutUsMessage = "aboutus_message"
        case aboutUsMission = "aboutus_mission"
        case aboutUsCompliance = "aboutus_compliance"
        case fileLink = "file_link"
    }
}

// MARK: - About Us Item
struct AboutUsItem: Codable {
    let id: String
    let aboutUsTypeId: String
    let aboutUsName: String?
    let aboutUsDesignation: String?
    let aboutUsTitle: String
    let aboutUsDesc: String
    let aboutUsFileName: String?
    let aboutUsFileMimeType: String?

    enum CodingKeys: String, CodingKey {
        case id
        case aboutUsTypeId = "aboutus_type_id"
        case aboutUsName = "aboutus_name"
        case aboutUsDesignation = "aboutus_designation"
        case aboutUsTitle = "aboutus_title"
        case aboutUsDesc = "aboutus_desc"
        case aboutUsFileName = "aboutus_file_name"
        case aboutUsFileMimeType = "aboutus_file_mime_type"
    }
}
struct CasmexBranch1:Codable {
    let branchCode: String
    let branchName: String
    let address: String
    let email: String
    let phone: String
    let bicDetails: [CasmexBICDetail1]
}

struct CasmexBICDetail1:Codable {
    let bicType: String
    let bicValue: String
}
