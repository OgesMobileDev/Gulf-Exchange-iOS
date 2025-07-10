//
//  ProfileVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 25/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import AVKit
import Alamofire
import SwiftyJSON
import Kingfisher
import AVFoundation
import Photos
import Toast_Swift
import ScreenShield
var fromVideoPopup:String = "NO"
class ProfileVC: UIViewController {
    
    //MARK: - Variable Declaration
    @IBOutlet weak var screenshotView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var changeProfileBtn: UIButton!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var profileBgView: UIView!
    
    @IBOutlet weak var personalInfoLbl: UILabel!
    @IBOutlet weak var idDetailLbl: UILabel!
    
    @IBOutlet weak var mobileLbl1: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var emailLbl1: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var nationalityLbl1: UILabel!
    @IBOutlet weak var nationalityLbl: UILabel!
    @IBOutlet weak var genderLbl1: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var branchLbl1: UILabel!
    @IBOutlet weak var branchLbl: UILabel!
    @IBOutlet weak var dobLbl1: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var addressLbl1: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var workAddLbl1: UILabel!
    @IBOutlet weak var workAddLbl: UILabel!
    @IBOutlet weak var occupationLbl1: UILabel!
    @IBOutlet weak var occupationLbl: UILabel!
    @IBOutlet weak var actualOccLbl1: UILabel!
    @IBOutlet weak var actualOccLbl: UILabel!
    @IBOutlet weak var employerLbl1: UILabel!
    @IBOutlet weak var employerLbl: UILabel!
    @IBOutlet weak var incomeLbl1: UILabel!
    @IBOutlet weak var incomeLbl: UILabel!
    @IBOutlet weak var idNumLbl1: UILabel!
    @IBOutlet weak var idNumLbl: UILabel!
    @IBOutlet weak var idNumBtn: UIButton!
    @IBOutlet weak var idExpLbl1: UILabel!
    @IBOutlet weak var idExpLbl: UILabel!
    @IBOutlet weak var idTypeLbl1: UILabel!
    @IBOutlet weak var idTypeLbl: UILabel!
    @IBOutlet weak var idIssuerLbl1: UILabel!
    @IBOutlet weak var idIssuerLbl: UILabel!
    @IBOutlet weak var idSelfieLbl: UILabel!
    @IBOutlet weak var viewSelfieLbl: UILabel!
    @IBOutlet weak var idSelfieBtn: UIButton!
    @IBOutlet weak var idFrontLbl: UILabel!
    @IBOutlet weak var viewIdFrontLbl: UILabel!
    @IBOutlet weak var idFrontBtn: UIButton!
    @IBOutlet weak var idBackLbl: UILabel!
    @IBOutlet weak var viewIdBackLbl: UILabel!
    @IBOutlet weak var idBackBtn: UIButton!
    @IBOutlet var emptyBtns: [UIButton]!
    // video layer
    @IBOutlet weak var popupVideoView: UIView!
    @IBOutlet weak var contentBaseView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
//    selfie hide
    @IBOutlet weak var selfieBaseView: UIView!
    @IBOutlet weak var selfieViewHeight: NSLayoutConstraint!
    
    
    let popUpView = Bundle.main.loadNibNamed("ImagePopupView", owner: self, options: nil)?.first as! ImagePopupView
    
    let playerViewController = AVPlayerViewController()
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let defaults = UserDefaults.standard
    
    var str_id_issuer:String = ""
    var str_id_no:String = ""
    var str_id_exp_date:String = ""
    var str_name_en:String = ""
    var str_name_ar:String = ""
    var strEmail:String = ""
    var str_dob:String = ""
    var str_nationality:String = ""
    var str_address:String = ""
    var str_city:String = ""
    var str_country:String = ""
    var str_gender:String = ""
    var str_country_code:String = ""
    var str_employer:String = ""
    var str_occupation:String = ""
    var str_actualoccupation:String = ""
    var str_occupationtext:String = ""
    var str_working_address:String = ""
    var str_buildingnotxtfd:String = ""
    var str_income:String = ""
    var str_zone:String = ""
    var strMobile:String = ""
    var dualnationalityselstr:String = ""
    var photoviewinputstr:String = ""
    
    //    var testfirstnamestr:String = ""
    //    var testlastnamestr:String = ""
    //    var testmiddlenamestr:String = ""
    //
    //    var municipality_id:String = ""
    //     var municipality_idoccupationid:String = ""
    
    
    //MARK: - Vew LifeCycles
    
    func overrideHorizontalSizeClassIfNeeded() {
            if #available(iOS 18.0, *) {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    self.traitOverrides.horizontalSizeClass = .unspecified
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        overrideHorizontalSizeClassIfNeeded()
        idSelfieBtn.isHidden = true
        idSelfieLbl.isHidden = true
        viewSelfieLbl.isHidden = true
        selfieBaseView.isHidden = true
        selfieViewHeight.constant = 0
        
        if fromVideoPopup == "YES"{
            let bottomOffset = CGPoint(x: 0, y: scrollView.frame.maxY)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
        popupVideoView.isHidden = true
        contentBaseView.clipsToBounds = true
        for btn in emptyBtns{
            btn.setTitle("", for: .normal)
        }
        changeProfileBtn.isHidden = true
//        idNumBtn.isHidden = false
        idNumBtn.setTitle("", for: .normal)
        personalInfoLbl.text = NSLocalizedString("personal_info", comment: "")
        idDetailLbl.text = NSLocalizedString("identification_details", comment: "")
        self.getToken(num: 1)
        profileBgView.isHidden = true
        getCountryName(code: "IN", from: 1)
        
        //localized
        self.mobileLbl1.text = (NSLocalizedString("mobile_no", comment: ""))
        self.emailLbl1.text = (NSLocalizedString("Email", comment: ""))
        self.nationalityLbl1.text = (NSLocalizedString("nationality", comment: ""))
        self.genderLbl1.text = (NSLocalizedString("gender", comment: ""))
        //        //self.user.text = (NSLocalizedString("mobile_no", comment: ""))
        self.dobLbl1.text = (NSLocalizedString("dob", comment: ""))
        self.addressLbl1.text = (NSLocalizedString("address", comment: ""))
        self.workAddLbl1.text = (NSLocalizedString("working_add", comment: ""))
        self.occupationLbl1.text = (NSLocalizedString("occupation", comment: ""))
        self.actualOccLbl1.text = (NSLocalizedString("ActualOccupation", comment: ""))
        self.employerLbl1.text = (NSLocalizedString("employer", comment: ""))
        self.incomeLbl1.text = (NSLocalizedString("exp_income", comment: ""))
        self.idNumLbl1.text = (NSLocalizedString("id_number", comment: ""))
        self.idExpLbl1.text = (NSLocalizedString("IDExpiry", comment: ""))
        self.idTypeLbl1.text = (NSLocalizedString("id_type", comment: ""))
        self.idIssuerLbl1.text = (NSLocalizedString("id_issuer", comment: ""))
        self.idSelfieLbl.text = (NSLocalizedString("SelfieWithID", comment: ""))
        self.idFrontLbl.text = (NSLocalizedString("IDFront", comment: ""))
        self.idBackLbl.text = (NSLocalizedString("IDBack", comment: ""))
        self.branchLbl1.text = (NSLocalizedString("UserBranch", comment: ""))
        setTxtToSpeech()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        //        ScreenShield.shared.protect(view: screenshotView)
        
        ScreenShield.shared.protect(view: self.userNameLbl)
        ScreenShield.shared.protect(view: self.mobileLbl)
        ScreenShield.shared.protect(view: self.mobileLbl1)
        ScreenShield.shared.protect(view: self.emailLbl)
        ScreenShield.shared.protect(view: self.emailLbl1)
        ScreenShield.shared.protect(view: self.nationalityLbl)
        ScreenShield.shared.protect(view: self.nationalityLbl1)
        ScreenShield.shared.protect(view: self.genderLbl)
        ScreenShield.shared.protect(view: self.genderLbl1)
        ScreenShield.shared.protect(view: self.branchLbl)
        ScreenShield.shared.protect(view: self.branchLbl1)
        ScreenShield.shared.protect(view: self.dobLbl)
        ScreenShield.shared.protect(view: self.dobLbl1)
        ScreenShield.shared.protect(view: self.addressLbl)
        ScreenShield.shared.protect(view: self.addressLbl1)
        ScreenShield.shared.protect(view: self.workAddLbl)
        ScreenShield.shared.protect(view: self.workAddLbl1)
        ScreenShield.shared.protect(view: self.occupationLbl)
        ScreenShield.shared.protect(view: self.occupationLbl1)
        ScreenShield.shared.protect(view: self.actualOccLbl)
        ScreenShield.shared.protect(view: self.actualOccLbl1)
        ScreenShield.shared.protect(view: self.employerLbl)
        ScreenShield.shared.protect(view: self.employerLbl1)
        ScreenShield.shared.protect(view: self.incomeLbl)
        ScreenShield.shared.protect(view: self.incomeLbl1)
        ScreenShield.shared.protect(view: self.idNumLbl)
        ScreenShield.shared.protect(view: self.idNumLbl1)
        ScreenShield.shared.protect(view: self.idExpLbl)
        ScreenShield.shared.protect(view: self.idExpLbl1)
        ScreenShield.shared.protect(view: self.idTypeLbl)
        ScreenShield.shared.protect(view: self.idTypeLbl1)
        ScreenShield.shared.protect(view: self.idIssuerLbl)
        ScreenShield.shared.protect(view: self.idIssuerLbl1)
        ScreenShield.shared.protect(view: self.profileBgView)
        ScreenShield.shared.protect(view: self.profileImg)
        ScreenShield.shared.protect(view: self.personalInfoLbl)
        ScreenShield.shared.protect(view: self.idDetailLbl)
        ScreenShield.shared.protect(view: self.idFrontLbl)
        ScreenShield.shared.protect(view: self.idBackLbl)
        ScreenShield.shared.protectFromScreenRecording()
        
    }
    //MARK: - Button Actions
    
    
    @IBAction func editProfileBtnTapped(_ sender: Any) {
        print("editProfileBtnTapped")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: EditProfileVC = UIStoryboard.init(name: "Main10", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func editIDBtnTapped(_ sender: Any) {
        print("editProfileBtnTapped")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IDVerificationBaseVC") as! IDVerificationBaseVC
        nextViewController.verificationType = .update
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateIDVC") as! UpdateIDVC
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    @IBAction func changeProfileBtnTapped(_ sender: Any) {
        print("changeProfileBtnTapped")
    }
    @IBAction func emailBtnTapped(_ sender: Any) {
        print("emailBtnTapped")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "TestDummy", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateEmailVC") as! UpdateEmailVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func idSelfieBtnTapped(_ sender: Any) {
        print("idSelfieBtnTapped")
        photoviewinputstr = "S"
        self.getToken(num: 3)
    }
    @IBAction func idFrontBtnTapped(_ sender: Any) {
        print("idFrontBtnTapped")
        photoviewinputstr = "F"
        self.getToken(num: 3)
        
    }
    @IBAction func idBackBtnTapped(_ sender: Any) {
        print("idBackBtnTapped")
        //apiprofileview
        photoviewinputstr = "B"
        self.getToken(num: 3)
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        popupVideoView.isHidden = true
    }
    //MARK: - Functions
    func protectAllSubviews(of view: UIView) {
        ScreenShield.shared.protect(view: view)
        for subview in view.subviews {
            protectAllSubviews(of: subview)
        }
    }
    func showVideoPopup(base64String: String){
        popUpView.setView(base64String: base64String)
        popUpView.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        popUpView.alpha = 0.0
        view.addSubview(popUpView)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.alpha = 1.0
        })
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
    func getCurrentDateTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        return formattedDate
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return  dateFormatter.string(from: date!)
        
    }
    func convertDateFormater1(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
    }
    func documentsPathForFileName(name: String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentsPath.appending(name)
    }
    //    @objc func playerDidFinishPlaying(note: NSNotification) {
    //        self.playerViewController.dismiss(animated: true)
    //    }
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(personalInfoLblTapped(_:)))
        personalInfoLbl.isUserInteractionEnabled = true
        personalInfoLbl.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(idDetailLblTapped(_:)))
        idDetailLbl.isUserInteractionEnabled = true
        idDetailLbl.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(mobileLblTapped(_:)))
        mobileLbl1.isUserInteractionEnabled = true
        mobileLbl1.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(emailLblTapped(_:)))
        emailLbl1.isUserInteractionEnabled = true
        emailLbl1.addGestureRecognizer(tapGesture3)

        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(nationalityLblTapped(_:)))
        nationalityLbl1.isUserInteractionEnabled = true
        nationalityLbl1.addGestureRecognizer(tapGesture4)
        
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(genderLblTapped(_:)))
        genderLbl1.isUserInteractionEnabled = true
        genderLbl1.addGestureRecognizer(tapGesture5)
        
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(userbranchLblTapped(_:)))
        branchLbl1.isUserInteractionEnabled = true
        branchLbl1.addGestureRecognizer(tapGesture6)
        
        let tapGesture7 = UITapGestureRecognizer(target: self, action: #selector(dobLblTapped(_:)))
        dobLbl1.isUserInteractionEnabled = true
        dobLbl1.addGestureRecognizer(tapGesture7)
        
        let tapGesture8 = UITapGestureRecognizer(target: self, action: #selector(addressLblTapped(_:)))
        addressLbl1.isUserInteractionEnabled = true
        addressLbl1.addGestureRecognizer(tapGesture8)
        
        let tapGesture9 = UITapGestureRecognizer(target: self, action: #selector(occupationLblTapped(_:)))
        occupationLbl1.isUserInteractionEnabled = true
        occupationLbl1.addGestureRecognizer(tapGesture9)
        
        let tapGesture10 = UITapGestureRecognizer(target: self, action: #selector(actualoccupationLblTapped(_:)))
        actualOccLbl1.isUserInteractionEnabled = true
        actualOccLbl1.addGestureRecognizer(tapGesture10)
        
        let tapGesture11 = UITapGestureRecognizer(target: self, action: #selector(employerLblTapped(_:)))
        employerLbl1.isUserInteractionEnabled = true
        employerLbl1.addGestureRecognizer(tapGesture11)
        
        let tapGesture12 = UITapGestureRecognizer(target: self, action: #selector(workaddressLblTapped(_:)))
        workAddLbl1.isUserInteractionEnabled = true
        workAddLbl1.addGestureRecognizer(tapGesture12)
        
        let tapGesture13 = UITapGestureRecognizer(target: self, action: #selector(expectedincomeLblTapped(_:)))
        incomeLbl1.isUserInteractionEnabled = true
        incomeLbl1.addGestureRecognizer(tapGesture13)
        
        let tapGesture14 = UITapGestureRecognizer(target: self, action: #selector(idnumberLblTapped(_:)))
        idNumLbl1.isUserInteractionEnabled = true
        idNumLbl1.addGestureRecognizer(tapGesture14)
        
        let tapGesture15 = UITapGestureRecognizer(target: self, action: #selector(idexpiryLblTapped(_:)))
        idExpLbl1.isUserInteractionEnabled = true
        idExpLbl1.addGestureRecognizer(tapGesture15)
        
        let tapGesture16 = UITapGestureRecognizer(target: self, action: #selector(idtypeLblTapped(_:)))
        idTypeLbl1.isUserInteractionEnabled = true
        idTypeLbl1.addGestureRecognizer(tapGesture16)
        
        let tapGesture17 = UITapGestureRecognizer(target: self, action: #selector(idissuerLblTapped(_:)))
        idIssuerLbl1.isUserInteractionEnabled = true
        idIssuerLbl1.addGestureRecognizer(tapGesture17)
        
        
        let tapGesture18 = UITapGestureRecognizer(target: self, action: #selector(idfrontLblTapped(_:)))
        idFrontLbl.isUserInteractionEnabled = true
        idFrontLbl.addGestureRecognizer(tapGesture18)
        
        let tapGesture19 = UITapGestureRecognizer(target: self, action: #selector(idbackLblTapped(_:)))
        idBackLbl.isUserInteractionEnabled = true
        idBackLbl.addGestureRecognizer(tapGesture19)
        
    }
    @objc func personalInfoLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("Personal information", languageCode: "en")
            }
        }
    }
    @objc func idDetailLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("identification details", languageCode: "en")
            }
        }
        
    }
    
    @objc func mobileLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("mobile number", languageCode: "en")
            }
        }
    }
    
    @objc func emailLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("email", languageCode: "en")
            }
        }
    }
    
    @objc func nationalityLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("nationality", languageCode: "en")
            }
        }
    }
    
    @objc func genderLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("gender", languageCode: "en")
            }
        }
    }
    
    @objc func userbranchLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("user branch", languageCode: "en")
            }
        }
    }
    
    @objc func dobLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("date of birth", languageCode: "en")
            }
        }
    }
    
    @objc func addressLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("address", languageCode: "en")
            }
        }
    }
    
    @objc func occupationLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("occupation", languageCode: "en")
            }
        }
    }
    
    @objc func actualoccupationLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("actual occupation", languageCode: "en")
            }
        }
    }
    
    
    @objc func employerLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("employer", languageCode: "en")
            }
        }
    }
    
    @objc func workaddressLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("work address", languageCode: "en")
            }
        }
    }
    
    @objc func expectedincomeLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("expected income", languageCode: "en")
            }
        }
    }
    
    @objc func idnumberLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id number", languageCode: "en")
            }
        }
    }
    
    @objc func idexpiryLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id expiry", languageCode: "en")
            }
        }
    }
    
    @objc func idtypeLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id type", languageCode: "en")
            }
        }
    }
    
    @objc func idissuerLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id issuer", languageCode: "en")
            }
        }
    }
    
    @objc func idfrontLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id front", languageCode: "en")
            }
        }
    }
    
    @objc func idbackLblTapped(_ sender: UITapGestureRecognizer) {
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("id back", languageCode: "en")
            }
        }
    }
    
  


    
    
    
    
    //MARK: - API Calls
    func getToken(num:Int) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("getToken response",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                let token:String = myresult!["access_token"].string!
                print("token  ",token)
                if(num == 1)
                {
                    self.getProfileInfo(access_token: token)
                }
                else if(num == 2)
                {
                    //                    self.updateProfile(access_token: token)
                }
                else if(num == 3)
                {
                    self.profileimageviewapi(access_token: token)
                }
                
                
                break
            case .failure:
                break
            }
            
        })
    }
    func getProfileInfo(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let dateTime:String = getCurrentDateTime()
//        let url = ge_api_url_new + "customer/viewProfile"
        let url = ge_api_url_new + "customer/viewcustomer"
        let params:Parameters =  ["partnerId":partnerId,"token":token,"requestTime":dateTime,"customerRegNo":defaults.string(forKey: "REGNO")!,"userID":defaults.string(forKey: "USERID")!,"password":defaults.string(forKey: "PASSW")!,"mpin":defaults.string(forKey: "PIN")!]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        print("getProfileInfo params - \(params)")
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            print("resp getProfileInfo",response)
            self.effectView.removeFromSuperview()
            switch response.result{
            case .success:
                let respCode = myResult!["responseCode"]
                if(respCode == "S104")
                {
                    //store local in app
                    //self.emailTextField.text = myResult!["email"].stringValue
                    UserDefaults.standard.removeObject(forKey: "strEmailnew")
                    self.strEmail = myResult!["email"].stringValue
                    
                    self.defaults.set(self.strEmail, forKey: "strEmailnew")
                    
                    if ((self.defaults.string(forKey: "strEmailnew")?.isEmpty) != nil)
                    {
                        self.emailLbl.text = self.strEmail
                        print("strEmailstore",self.strEmail)
                    }
                    else
                    {
                        self.emailLbl.text  = ""
                        self.strEmail =  ""
                    }
                    UserDefaults.standard.removeObject(forKey: "strEmailnew")
                    self.str_name_en = myResult!["workingAddress3"].stringValue
                    
                    self.defaults.set(self.str_name_en, forKey: "str_name_ennew")
                    
                    if ((self.defaults.string(forKey: "str_name_ennew")?.isEmpty) != nil)
                    {
                        
                        self.userNameLbl.text = self.str_name_en
                        self.profileBgView.isHidden = false
                        self.profileImg.isHidden = true
                        createAvatar(username: self.str_name_en, view: self.profileBgView, font: 50)
                        print("str_name_ennewstore",self.str_name_en)
                        
                    }
                    else
                    {
                        self.userNameLbl.text  = ""
                        self.str_name_en =  ""
                    }
                    
                    
                    
                    
                    
                    //                check
                    //                self.fullnameArTextField.text = myResult!["customerNameArabic"].stringValue
                    self.str_name_ar = myResult!["customerNameArabic"].stringValue
                    //                self.dobLbl.text = self.convertDateFormater(myResult!["customerDOB"].stringValue)
                    //                self.str_dob = myResult!["customerDOB"].stringValue
                    self.dobLbl.text = myResult!["visaType"].stringValue
                    self.str_dob = myResult!["visaType"].stringValue
                    
                    if myResult!["customerBranch"].stringValue.isEmpty {
                        self.branchLbl.text = "----"
                    }else{
                        self.branchLbl.text = myResult!["customerBranch"].stringValue
                    }
                    if(myResult!["street"].stringValue == "-")
                    {
                        self.addressLbl.text = ""
                        self.str_address = ""
                    }
                    else
                    {
                        self.addressLbl.text = myResult!["street"].stringValue
                        self.str_address = myResult!["street"].stringValue
                    }
                    
                    if(myResult!["customerCity"].stringValue == "-" ) || (myResult!["customerCity"].stringValue == "Municipality")
                    {
                        
                        self.str_city = ""
                        //                self.municipalityBtn.titleLabel?.text = "Municipality"
                        //                    self.municipalityBtn.setTitleColor(UIColor.gray, for: .normal)
                    }
                    else
                    {
                        //                    self.municipalityBtn.setTitle(myResult!["customerCity"].stringValue, for: .normal)
                        self.str_city = myResult!["customerCity"].stringValue
                        //                    self.municipalityBtn.setTitleColor(UIColor.black, for: .normal)
                    }
                    
                    if(myResult!["mZone"].stringValue == "-") || (myResult!["mZone"].stringValue == "Zone")
                    {
                        
                        //                    self.zoneBtn.titleLabel?.text = "Zone"
                        //                    self.zoneBtn.setTitleColor(UIColor.gray, for: .normal)
                    }
                    else
                    {
                        //                    self.zoneBtn.setTitle(myResult!["mZone"].stringValue, for: .normal)
                        self.str_zone = myResult!["mZone"].stringValue
                        //                    self.zoneBtn.setTitleColor(UIColor.black, for: .normal)
                    }
                    
                    if(myResult!["buildingNo"].stringValue == "-") || (myResult!["buildingNo"].stringValue == "<null>") || (myResult!["buildingNo"].stringValue.isEmpty == true)
                        
                    {
                        //                    self.buildiongnotxtfd.text = ""
                    }
                    else
                    {
                        //                    self.buildiongnotxtfd.text = myResult!["buildingNo"].stringValue
                    }
                    
                    
                    self.genderLbl.text = myResult!["gender"].stringValue
                    //                self.genderBtn.setTitle(myResult!["gender"].stringValue, for: .normal)
                    //                if(myResult!["gender"].stringValue == "Male")
                    //                {
                    //                    self.checkMaleBtn.setImage(UIImage(named: "radio_green"), for: .normal)
                    //                    self.checkFemaleBtn.setImage(UIImage(named: "radio_light"), for: .normal)
                    //                }
                    //                else{
                    //                    self.checkMaleBtn.setImage(UIImage(named: "radio_light"), for: .normal)
                    //                    self.checkFemaleBtn.setImage(UIImage(named: "radio_green"), for: .normal)
                    //                }
                    self.str_gender = myResult!["gender"].stringValue
                    //                self.genderBtn.setTitleColor(UIColor.black, for: .normal)
                    self.mobileLbl.text = myResult!["customerMobile"].stringValue
                    self.strMobile = myResult!["customerMobile"].stringValue
                    self.employerLbl.text = myResult!["employerName"].stringValue
                    self.str_employer = myResult!["employerName"].stringValue
                    self.incomeLbl.text = myResult!["expectedIncome"].stringValue
                    self.str_income = myResult!["expectedIncome"].stringValue
                    self.workAddLbl.text = myResult!["workingAddress1"].stringValue
                    self.str_working_address = myResult!["workingAddress1"].stringValue
                    self.occupationLbl.text = myResult!["occupation"].stringValue
                    self.str_occupation = myResult!["occupation"].stringValue
                    
                    self.actualOccLbl.text = myResult!["actualOccupation"].stringValue
                    self.str_actualoccupation = myResult!["actualOccupation"].stringValue
                    
                    
                    
                    //                self.nationalityBtn.titleLabel?.font = self.nationalityBtn.titleLabel?.font.withSize(14)
                    //                self.nationalityBtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
                    
                    print("3 letter code",myResult!["customerNationality"].stringValue)
                    
                    
                    if let customerNationality = myResult?["customerNationality"].stringValue {
                        if customerNationality.filter({ $0.isLetter }).count < 3 {
                            self.getCountryName(code: customerNationality, from: 1)
                        } else {
                            self.nationalityLbl.text = customerNationality
                        }
                    } else {
                        print("customerNationality is nil or not a valid string")
                    }
                    
                    
//                                        self.nationalityLbl.text = myResult!["customerNationality"].stringValue
                    
                    self.str_nationality = myResult!["customerNationality"].stringValue
                    
                    
                    
                    //self.str_country = myResult!["customerCountry"].stringValue
//                    self.getCountryName(code: myResult!["customerCountry"].stringValue, from: 2)
                    
                    //
                    //                self.dualnationalitybtn.titleLabel?.font = self.nationalityBtn.titleLabel?.font.withSize(14)
                    //                self.dualnationalitybtn.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
                    self.dualnationalityselstr = myResult!["customerCountry"].stringValue
                    
                    
                    self.idTypeLbl.text = myResult!["customerIDType"].stringValue
                    //                self.idTypeBtn.setTitle(myResult!["customerIDType"].stringValue, for: .normal)
                    //                self.idTypeBtn.setTitleColor(UIColor.black, for: .normal)
                    self.str_id_issuer = myResult!["customerIDIssuedBy"].stringValue
                    if(self.str_id_issuer == "QATAR MOI")
                    {
                        self.idIssuerLbl.text = "Ministry of Interior"
                    }
                    else if(self.str_id_issuer == "QATAR MOFA")
                    {
                        self.idIssuerLbl.text = "Ministry of Foreign Affairs"
                    }
                    self.idNumLbl.text = myResult!["customerIDNo"].stringValue
                    self.str_id_no = myResult!["customerIDNo"].stringValue
                    self.idExpLbl.text = self.convertDateFormater(myResult!["customerIDExpiryDate"].stringValue)
                    self.str_id_exp_date = myResult!["customerIDExpiryDate"].stringValue
                }
            case .failure:
                self.showToast(message: "No data available", font: .systemFont(ofSize: 12.0))
                break
            }
            
            
        })
    }
    
    
    func getCountryName(code:String,from:Int){
        print("from",from)
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = api_url + "get_country_name_from_2lettercode"
        let params:Parameters = ["code":code]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            self.effectView.removeFromSuperview()
            print("resp",response)
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let arrayResult  = myResult!["get_country"]
                for i in arrayResult.arrayValue{
                    if(from == 1)
                    {
    //                    self.nationalityLbl.text = i["en_short_name"].stringValue
                    }
                    else if(from == 2)
                    {
                        //                        self.dualnationalitybtn.setTitle(i["en_short_name"].stringValue, for: .normal)
                        //                        self.dualnationalitybtn.setTitleColor(UIColor.black, for: .normal)
                    }
                }
            case .failure:
                break
            }
            
        })
    }
    func profileimageviewapi(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "customer/viewcustomerImage"
        let params:Parameters =  ["customerIDNo":str_id_no,"customerImgType": photoviewinputstr]
        print("urlurl",url)
        print("paramsurl",params)
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            let myResult = try? JSON(data: response.data!)
            
            print("profileimageviewapi resp",response)
            
            
            self.effectView.removeFromSuperview()
            let resultArray = myResult![]
            let respCode = myResult!["responseCode"]
            if myResult!["idImage"].stringValue.isEmpty
            {
                print("respnullll","nullll")
            }
            else if(respCode == "S105"){
                    let base64 = myResult!["idImage"].stringValue
                    self.showVideoFromBase64(base64String: base64)
                }else{
                    
                        
                        
                        let baseimagestr:String =  myResult!["idImage"].string!
                        
                        print("64444",baseimagestr)
                        let base64EncodedString = baseimagestr // Your Base64 Encoded String
                        
                        // 1
                        
                        let url : String = base64EncodedString
                        let urlStr : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                        let convertedURL : URL = URL(string: urlStr)!
                        print("64444URLLLL",convertedURL)
                        
                        if let imageData = Data(base64Encoded: base64EncodedString) {
                            
                            
                            //new
                            
                            /*let respCode = myResult!["responseCode"]
                             print("respCode,responseCode",respCode)
                             //                if(respCode == "S105")
                             if(self.photoviewinputstr == "S")
                             {
                             
                             if myResult!["idImage"].stringValue.isEmpty
                             {
                             print("respnullll","nullll")
                             }
                             else
                             /*
                              //old Video
                              {
                              
                              
                              
                              let filePath = self.documentsPathForFileName(name: "video.mp4")
                              let imageData = NSData()
                              imageData.write(toFile: filePath, atomically: true)
                              let videoFileURL = NSURL(fileURLWithPath: filePath)
                              
                              
                              print("urllllllllviedio",videoFileURL)
                              
                              
                              /// let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                              // let videoURL = documentsURL.URLByAppendingPathComponent("video.mp4")//what ever your filename and extention
                              
                              let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                              let fileURL = documentURL.appendingPathComponent("video.mp4")
                              
                              
                              imageData.write(to: fileURL, atomically: true)
                              
                              
                              // UISaveVideoAtPathToSavedPhotosAlbum(fileURL.path, self, #selector(self.imagePickerController()), nil)
                              
                              print("urllllllllviedio",fileURL)
                              
                              UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(fileURL.path)
                              //save to galery
                              UISaveVideoAtPathToSavedPhotosAlbum(fileURL.relativePath, self, nil, nil)
                              
                              //UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(fileURL)
                              
                              let dataa = Data()
                              let str = String(decoding: imageData, as: UTF8.self)
                              print("urlllstrstr",str)
                              /// UISaveVideoAtPathToSavedPhotosAlbum(videoFileURL.relativePath!, self, nil, nil)
                              // print("urllllllllviedioalbum",videoFileURL.relativePath!)
                              //
                              //                       // DispatchQueue.global(qos: .background).async {
                              //                            if let url = URL(string: ""),
                              //                               let urlData = NSData(contentsOf: videoFileURL as URL)
                              //                            {
                              //                                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                              //                                let filePath="\(documentsPath)/tempFile.mp4"
                              //                                DispatchQueue.main.async {
                              //                                    urlData.write(toFile: filePath, atomically: true)
                              //                                    PHPhotoLibrary.shared().performChanges({
                              //                                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                              //                                    }) { completed, error in
                              //                                        if completed {
                              //                                            print("Video is saved!")
                              //
                              //                                            let alert = UIAlertController(title: "Success  Video was saved albu", message: "savedgalery", preferredStyle: .alert)
                              //
                              //                                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                              //                                            }))
                              //                                            self.present(alert, animated: true)
                              //                                        }
                              //                                    }
                              //                                }
                              //                            }
                              //                        //}
                              //
                              
                              
                              
                              //code for play
                              // let movieURL = Bundle.main.url(forResource: "ElephantSeals", withExtension: "mp4")!
                              // let player = AVPlayer(url: fileURL as URL)
                              let player = AVPlayer(url: NSURL(string: baseimagestr) as! URL)
                              
                              
                              //                        do{
                              //
                              //                        let video = try NSData(contentsOf: nsurlItem as URL, options: .mappedIfSafe) as! NSURL
                              //                        let nsurlItem = NSURL(dataRepresentation: imageData as Data, relativeTo: nil)
                              //                        let avAsset = AVAsset(url: video as URL)
                              //                                   let playerItem = AVPlayerItem(asset: avAsset)
                              //                                   let player = AVPlayer(playerItem: playerItem)
                              //                        }
                              
                              //print("movieURLe",movieURL)
                              
                              self.playerViewController.player = player
                              NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.playerViewController.player?.currentItem)
                              
                              self.present(self.playerViewController, animated: true) {
                              self.playerViewController.player!.play()
                              }
                              
                              
                              
                              
                              }*/
                             {
                             let base64 = myResult!["idImage"].stringValue
                             self.showVideoFromBase64(base64String: base64)
                             }
                             
                             ///
                             }*/
                            
                            //        else{
                            // Create a custom view controller for the alert
                            let popupVC = UIViewController()
                            popupVC.preferredContentSize = CGSize(width: 320, height: 400) // Adjust size for better visibility
                            
                            // Create the imageView
                            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 360)) // Larger dimensions
                            imageView.image = UIImage(data: imageData)
                            imageView.contentMode = .scaleAspectFit // Keeps aspect ratio while zooming
                            imageView.translatesAutoresizingMaskIntoConstraints = false
                            
                            // Add the imageView to the popupVC's view
                            popupVC.view.addSubview(imageView)
                            
                            // Add constraints to center and expand the imageView
                            NSLayoutConstraint.activate([
                                imageView.topAnchor.constraint(equalTo: popupVC.view.topAnchor, constant: 20),
                                imageView.centerXAnchor.constraint(equalTo: popupVC.view.centerXAnchor),
                                imageView.widthAnchor.constraint(equalToConstant: 300), // Adjust width
                                imageView.heightAnchor.constraint(equalToConstant: 360) // Adjust height
                            ])
                            var title = "ID Image"
                            switch self.photoviewinputstr{
                            case "S":
                                title = "Selfie with ID"
                            case "F":
                                title = "Front ID image"
                            case "B":
                                title = "Back ID image"
                            default:
                                title = "ID Image"
                            }
                            
                            // Create the UIAlertController
                            let showAlert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                            
                            // Add the custom view controller as a child to the alert
                            showAlert.setValue(popupVC, forKey: "contentViewController")
                            
                            // Add the "Close" action
                            showAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                            
                            // Present the alert
                            self.present(showAlert, animated: true, completion: nil)}
                        
                        //}
                    
                }
            /*
             if(self.photoviewinputstr == "S")
            {
                
                if myResult!["idImage"].stringValue.isEmpty
                {
                    print("respnullll","nullll")
                }
                else
                {
                    let respCode = myResult!["responseCode"]
                    
                    if(respCode == "S105"){
                        let base64 = myResult!["idImage"].stringValue
                        self.showVideoFromBase64(base64String: base64)
                    }else{
                        
                    }
                    
                    
                }
                
                ///
            }else
            
            
            {}*/
            
            //
            
            
            
            
        })
    }
    
    
    // ful;screen
    func showVideoFromBase64yu(base64String: String) {
        guard let videoData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            print("Failed to decode Base64 string.")
            return
        }
        
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempVideoURL = tempDirectory.appendingPathComponent("tempVideo.mp4")
        
        do {
            try videoData.write(to: tempVideoURL)
            print("Video file saved to: \(tempVideoURL)")
        } catch {
            print("Failed to save video file: \(error)")
            return
        }
        
        // Preserve the current tab index
        guard let tabBarController = self.tabBarController else { return }
        let currentTabIndex = tabBarController.selectedIndex
        
        // Create the AVPlayer and AVPlayerViewController
        let player = AVPlayer(url: tempVideoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.modalPresentationStyle = .fullScreen // Use fullScreen or .overCurrentContext if needed
        
        // Add observer for playback completion
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            print("Video playback completed.")
            // Optionally, reset the video to the beginning
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // Your function call here
                let data = ["player": true] as [String : Any]
                NotificationCenter.default.post(name: playerFinishNotification, object: nil, userInfo: data)
            }
            player.seek(to: .zero)
        }
        
        // Present the player in a new view controller or use a custom transition
        self.present(playerViewController, animated: true) {
            player.play()
        }
        
        // Optionally, use a custom tab bar behavior to avoid resetting:
        tabBarController.selectedIndex = currentTabIndex // Ensure tab stays at the current index
        
    }
    
    // av layer
    func showVideoFromBase64(base64String: String) {
        // Decode the base64 string to get the video data
        guard let videoData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            print("Failed to decode Base64 string.")
            return
        }
        
        // Save the video data to a temporary file
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempVideoURL = tempDirectory.appendingPathComponent("tempVideo.mp4")
        
        do {
            try videoData.write(to: tempVideoURL)
            print("Video file saved to: \(tempVideoURL)")
        } catch {
            print("Failed to save video file: \(error)")
            return
        }
        
        popupVideoView.isHidden = false
        // Create the AVPlayer instance with the video URL
        let player = AVPlayer(url: tempVideoURL)
        fromVideoPopup = "YES"
        // Create a player layer to display the video
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = contentBaseView.bounds // Set the player layer frame (you can adjust it as needed)
        playerLayer.videoGravity = .resizeAspectFill // Optionally adjust the aspect ratio
        
        // Add the player layer to the current view
        self.contentBaseView.layer.addSublayer(playerLayer)
        
        guard let playerItem = player.currentItem else {
            print("Failed to retrieve player item.")
            return
        }
        
        playerItem.asset.loadValuesAsynchronously(forKeys: ["duration"]) {
            DispatchQueue.main.async {
                let duration = CMTimeGetSeconds(playerItem.asset.duration)
                guard duration.isFinite else {
                    print("Unable to determine video duration.")
                    return
                }
                print("Video duration: \(duration) seconds")
                
                // Add a periodic observer to monitor playback time
                let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
                player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak player] currentTime in
                    let currentSeconds = CMTimeGetSeconds(currentTime)
                    
                    // Pause the video just before the end (e.g., 1 second before finish)
                    if duration - currentSeconds <= 0.25 {
                        print("Pausing video before it finishes.")
                        player?.pause()
                    }
                }
            }
        }
        
        // Start playback
        player.play()
        
        // Add observer for playback completion
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            print("Video playback completed.")
            player.pause()
            // Optionally, reset the video to the beginning
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // Your function call here
                
                let data = ["player": true] as [String : Any]
                NotificationCenter.default.post(name: playerFinishNotification, object: nil, userInfo: data)
            }
            //
            player.seek(to: .zero) // Reset the video to the beginning
        }
        
        // Optionally, you can add a custom UI to close the video (like a button) or perform other actions when the video ends.
    }
    func showToast(message: String, font: UIFont) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let maxWidthPercentage: CGFloat = 0.8
        let maxTitleSize = CGSize(width: view.bounds.size.width * maxWidthPercentage, height: view.bounds.size.height * maxWidthPercentage)
        var titleSize = toastLabel.sizeThatFits(maxTitleSize)
        titleSize.width += 20
        titleSize.height += 10
        toastLabel.frame = CGRect(x: view.frame.size.width / 2 - titleSize.width / 2, y: view.frame.size.height - 50, width: titleSize.width, height: titleSize.height)
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
    
}


/*
 
 
 let showAlert = UIAlertController(title: "RAHUL", message: nil, preferredStyle: .alert)
 
 let imageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 255, height: 260))
 let image = UIImage(data: imageData)
 //self.imageView.image = image
 
 //imageView.image = UIImage(named: "selfie")// Your image here...
 imageView.image = image// Your image here...
 showAlert.view.addSubview(imageView)
 let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 350)
 let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280)
 showAlert.view.addConstraint(height)
 showAlert.view.addConstraint(width)
 
 //                             let label = UILabel(frame: CGRect(x: 15, y: 255, width: 350, height: 60))
 //                             label.text = "Please take a selfie holding your ID"
 //                             label.font = label.font.withSize(16)
 //                             label.numberOfLines = 0
 //                             showAlert.view.addSubview(label)
 let subview :UIView = showAlert.view.subviews.first! as UIView
 let alertContentView = subview.subviews.first! as UIView
 alertContentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
 alertContentView.layer.cornerRadius = 15
 
 
 showAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { action in
 // your actions here...
 
 //                    print("urlss","ttttt")
 //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
 //                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
 //                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "forgotPIN") as! ForgotPINViewController
 //                    self.navigationController?.pushViewController(nextViewController, animated: true)
 
 }))
 self.present(showAlert, animated: true, completion: nil)
 
 
 
 
 
 */

