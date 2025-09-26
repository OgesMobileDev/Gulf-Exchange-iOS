//
//  RegisterReviewVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 03/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MobileCoreServices
import ScreenShield

class RegisterReviewVC: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var idDetailsLbl: UILabel!
    @IBOutlet weak var idTypeLbl: UILabel!
    @IBOutlet weak var idTypeLbl1: UILabel!
    @IBOutlet weak var idIssuerLbl: UILabel!
    @IBOutlet weak var idIssuerLbl1: UILabel!
    @IBOutlet weak var idNumberLbl: UILabel!
    @IBOutlet weak var idNumberLbl1: UILabel!
    @IBOutlet weak var idExpDateLbl: UILabel!
    @IBOutlet weak var idExpDateLbl1: UILabel!
    @IBOutlet weak var personalInfoLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var fullNameLbl1: UILabel!
    @IBOutlet weak var fullNameArLbl: UILabel!
    @IBOutlet weak var fullNameArLbl1: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailLbl1: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dobLbl1: UILabel!
    @IBOutlet weak var nationalityLbl: UILabel!
    @IBOutlet weak var nationalityLbl1: UILabel!
    @IBOutlet weak var secondNationalityLbl: UILabel!
    @IBOutlet weak var secondNationalityLbl1: UILabel!
    @IBOutlet weak var zoneLbl: UILabel!
    @IBOutlet weak var zoneLbl1: UILabel!
    @IBOutlet weak var StreetLbl: UILabel!
    @IBOutlet weak var StreetLbl1: UILabel!
    @IBOutlet weak var buildingNumLbl: UILabel!
    @IBOutlet weak var buildingNumLbl1: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var genderLbl1: UILabel!
    @IBOutlet weak var mobileNumLbl: UILabel!
    @IBOutlet weak var mobileNumLbl1: UILabel!
    @IBOutlet weak var employerLbl: UILabel!
    @IBOutlet weak var employerLbl1: UILabel!
    @IBOutlet weak var expIncomeLbl: UILabel!
    @IBOutlet weak var expIncomeLbl1: UILabel!
    @IBOutlet weak var workAddressLbl: UILabel!
    @IBOutlet weak var workAddressLbl1: UILabel!
    @IBOutlet weak var occupationLbl: UILabel!
    @IBOutlet weak var occupationLbl1: UILabel!
    @IBOutlet weak var actualOccLbl: UILabel!
    @IBOutlet weak var actualOccLbl1: UILabel!
    @IBOutlet weak var regCodeLbl: UILabel!
    @IBOutlet weak var regCodeLbl1: UILabel!
    @IBOutlet weak var idFrontLbl: UILabel!
    @IBOutlet weak var idBackLblLbl: UILabel!
    @IBOutlet weak var selfieVidLbl: UILabel!
    
    @IBOutlet weak var idFrontImgView: UIImageView!
    @IBOutlet weak var idBackImgView: UIImageView!
    @IBOutlet weak var idSelfieVideoView: UIView!
    @IBOutlet weak var idSelfieTempImg: UIImageView!
    @IBOutlet weak var idSelfieImg: UIImageView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    
    let defaults = UserDefaults.standard
    var strBase64:String!
    var strBase641:String!
    var strBase642:String!
    var strBase64video:String!
    var strBase64Selfie:String!
    var idImageFrontData: Data?
    var idImageBackData: Data?
    var idImageSelfieVideoData: Data?
    override func viewDidLoad() {
        super.viewDidLoad()

        addNavbar()
        configureButton(button: cancelBtn, title: "Cancel", size: 16, font: .medium)
        configureButton(button: okBtn, title: "Confirm", size: 16, font: .medium)
        setView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        ScreenShield.shared.protect(view: self.idDetailsLbl)
        ScreenShield.shared.protect(view: self.idTypeLbl)
        ScreenShield.shared.protect(view: self.idTypeLbl1)
        ScreenShield.shared.protect(view: self.idIssuerLbl)
        ScreenShield.shared.protect(view: self.idIssuerLbl1)
        ScreenShield.shared.protect(view: self.idNumberLbl)
        ScreenShield.shared.protect(view: self.idNumberLbl1)
        ScreenShield.shared.protect(view: self.idExpDateLbl)
        ScreenShield.shared.protect(view: self.idExpDateLbl1)
        ScreenShield.shared.protect(view: self.personalInfoLbl)
        ScreenShield.shared.protect(view: self.fullNameLbl)
        ScreenShield.shared.protect(view: self.fullNameLbl1)
        ScreenShield.shared.protect(view: self.fullNameArLbl)
        ScreenShield.shared.protect(view: self.fullNameArLbl1)
        ScreenShield.shared.protect(view: self.emailLbl)
        ScreenShield.shared.protect(view: self.emailLbl1)
        ScreenShield.shared.protect(view: self.dobLbl)
        ScreenShield.shared.protect(view: self.dobLbl1)
        ScreenShield.shared.protect(view: self.nationalityLbl)
        ScreenShield.shared.protect(view: self.nationalityLbl1)
        ScreenShield.shared.protect(view: self.secondNationalityLbl)
        ScreenShield.shared.protect(view: self.secondNationalityLbl1)
        ScreenShield.shared.protect(view: self.zoneLbl)
        ScreenShield.shared.protect(view: self.zoneLbl1)
        ScreenShield.shared.protect(view: self.StreetLbl)
        ScreenShield.shared.protect(view: self.StreetLbl1)
        ScreenShield.shared.protect(view: self.buildingNumLbl)
        ScreenShield.shared.protect(view: self.buildingNumLbl1)
        ScreenShield.shared.protect(view: self.genderLbl)
        ScreenShield.shared.protect(view: self.genderLbl1)
        ScreenShield.shared.protect(view: self.mobileNumLbl)
        ScreenShield.shared.protect(view: self.mobileNumLbl1)
        ScreenShield.shared.protect(view: self.employerLbl)
        ScreenShield.shared.protect(view: self.employerLbl1)
        ScreenShield.shared.protect(view: self.expIncomeLbl)
        ScreenShield.shared.protect(view: self.expIncomeLbl1)
        ScreenShield.shared.protect(view: self.workAddressLbl)
        ScreenShield.shared.protect(view: self.workAddressLbl1)
        ScreenShield.shared.protect(view: self.occupationLbl)
        ScreenShield.shared.protect(view: self.occupationLbl1)
        ScreenShield.shared.protect(view: self.actualOccLbl)
        ScreenShield.shared.protect(view: self.actualOccLbl1)
        ScreenShield.shared.protect(view: self.regCodeLbl)
        ScreenShield.shared.protect(view: self.regCodeLbl1)
        ScreenShield.shared.protect(view: self.idFrontLbl)
        ScreenShield.shared.protect(view: self.idBackLblLbl)
        ScreenShield.shared.protect(view: self.selfieVidLbl)
        ScreenShield.shared.protect(view: self.idFrontImgView)
        ScreenShield.shared.protect(view: self.idBackImgView)
        ScreenShield.shared.protect(view: self.idSelfieVideoView)
        ScreenShield.shared.protectFromScreenRecording()
        setView()
        
        
    }
    
    @IBAction func okBtnTapped(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterOtpVC") as! RegisterOtpVC
        nextViewController.idImageFrontData = self.idImageFrontData
        nextViewController.idImageBackData = self.idImageBackData
        nextViewController.idImageSelfieVideoData = self.idImageSelfieVideoData
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = "Registration Details"
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    func setView(){
        
        idTypeLbl.text = defaults.string(forKey: "id_type")!
            idIssuerLbl.text =  defaults.string(forKey: "id_issuer")!
            idNumberLbl.text = defaults.string(forKey: "id_no")!
            idExpDateLbl.text =  defaults.string(forKey: "id_exp_date")!
            fullNameLbl.text = defaults.string(forKey: "name_en")!
            
            
            if(defaults.string(forKey: "name_ar")! == "")
            {
                fullNameArLbl.text = "-"
            }
            else
            {
                fullNameArLbl.text = defaults.string( forKey: "name_ar")!
            }
            
            
            emailLbl.text = defaults.string( forKey: "email")!
            dobLbl.text = defaults.string( forKey: "dob")!
            if let savedText = defaults.string(forKey: "nationalityname") {
                       nationalityLbl.text = savedText
                      }
            if let savedText1 = defaults.string(forKey: "dualnationalityname") {
                      secondNationalityLbl.text = savedText1
                     }
//            .text = "Qatar"
            zoneLbl.text = defaults.string( forKey: "zone")!
    //        zonelabel.text = defaults.string( forKey: "zone")!
            
            //str_buildingno = defaults.string( forKey: "str_buildingno")!
            buildingNumLbl.text = defaults.string( forKey: "str_buildingno")!
            
            if(defaults.string(forKey: "home_addr")! == "")
            {
                //if defaults.object(forKey: "home_addr") != nil {
               // 3. If there is not an object, then set a default. This will
               //    not be ran if there is an object.
              // defaults.set("dark", forKey: "theme")
               // homeaddresslabel.text = "-"
                StreetLbl.text = "-"
             }
            else
            {
                StreetLbl.text = defaults.string( forKey: "home_addr")!
            //homeaddresslabel.text = defaults.string( forKey: "home_addr")!
            }
            genderLbl.text = defaults.string( forKey: "gender")!
            mobileNumLbl.text = defaults.string( forKey: "mobile")!
            employerLbl.text = defaults.string( forKey: "employer")!
            expIncomeLbl.text = defaults.string( forKey: "income")!
            workAddressLbl.text =  defaults.string( forKey: "work_addr")!
            occupationLbl.text =  defaults.string( forKey: "str_occupationname")!
            actualOccLbl.text = defaults.string( forKey: "str_actualoccupationname")!
            regCodeLbl.text = defaults.string( forKey: "reg_code")!
            
        
            strBase64 = defaults.string(forKey: "strBase64")
            strBase641 = defaults.string(forKey: "strBase641")
//            strBase642 = defaults.string(forKey: "strBase642")
        strBase64Selfie = defaults.string(forKey: "strBase64video")
//        strBase64Selfie = defaults.string(forKey: "strBase64Selfie")check
            
            //new
            
            
            if defaults.object(forKey: "frontimage") == nil
            {
                print("No value in Userdefault serviceproviderBANKname")
            }
            else
            {
                let imageData = defaults.data(forKey: "frontimage")
                let orgImage : UIImage = UIImage(data: imageData!)!
                idFrontImgView.image = orgImage

            }
            
            
            if defaults.object(forKey: "backimage") == nil
            {
                print("No value in Userdefault serviceproviderBANKname")
            }
            else
            {
            
            let imageDataback = defaults.data(forKey: "backimage")
            let orgImageback : UIImage = UIImage(data: imageDataback!)!
            idBackImgView.image = orgImageback
            }
            
        
//        if defaults.object(forKey: "selfieimage") == nil
//        {
//            print("No value in Userdefault serviceproviderBANKname")
//        }
//        else
//        {
//        
//        let imageDataback = defaults.data(forKey: "selfieimage")
//        let orgImageback : UIImage = UIImage(data: imageDataback!)!
//            idSelfieImg.image = orgImageback
//        }
            
            // video view
            displayThumbnail()
            
            func getVideoDataFromBase64String() -> Data? {
                if let base64String = UserDefaults.standard.string(forKey: "strBase64video") {
                    return Data(base64Encoded: base64String, options: .ignoreUnknownCharacters)
                }
                return nil
            }

            
            func saveVideoDataToTempFile(videoData: Data) -> URL? {
                let tempDirectory = FileManager.default.temporaryDirectory
                let videoURL = tempDirectory.appendingPathComponent("tempVideo.mov")
                
                do {
                    try videoData.write(to: videoURL)
                    return videoURL
                } catch {
                    print("Failed to write video data to file: \(error)")
                    return nil
                }
            }

            
            func generateThumbnail(for url: URL) -> UIImage? {
                let asset = AVAsset(url: url)
                let assetImageGenerator = AVAssetImageGenerator(asset: asset)
                assetImageGenerator.appliesPreferredTrackTransform = true
                
                let time = CMTimeMake(value: 1, timescale: 2)
                var actualTime = CMTime.zero
                
                do {
                    let cgImage = try assetImageGenerator.copyCGImage(at: time, actualTime: &actualTime)
                    let image = UIImage(cgImage: cgImage)
                    return image
                } catch {
                    print("Error generating thumbnail: \(error)")
                    return nil
                }
            }

            
            func displayThumbnail() {
                guard let videoData = getVideoDataFromBase64String(),
                      let videoURL = saveVideoDataToTempFile(videoData: videoData) else {
                    print("Failed to get video URL from base64 string")
                    return
                }
                
                guard let thumbnail = generateThumbnail(for: videoURL) else {
                    print("Failed to generate thumbnail")
                    return
                }
                
                idSelfieImg.image = thumbnail
            }

            /* test 1
             if let base64String = UserDefaults.standard.string(forKey: "strBase64video") {
                    displayThumbnail(from: base64String)
                }
            func displayThumbnail(from base64String: String) {
                guard let videoURL = decodeBase64ToVideoFile(base64String: base64String) else {
                    print("Failed to get video URL")
                    return
                }
                
                guard let thumbnail = generateThumbnail(for: videoURL) else {
                    print("Failed to generate thumbnail")
                    return
                }
                
                selfieimageview.image = thumbnail
            }
            func decodeBase64ToVideoFile(base64String: String) -> URL? {
                guard let videoData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
                    print("Failed to decode base64 string")
                    return nil
                }
                
                let tempDirectory = FileManager.default.temporaryDirectory
                let videoURL = tempDirectory.appendingPathComponent("tempVideo.mov")
                
                do {
                    try videoData.write(to: videoURL)
                    return videoURL
                } catch {
                    print("Failed to write video data to file: \(error)")
                    return nil
                }
            }


            func generateThumbnail(for url: URL) -> UIImage? {
                let asset = AVAsset(url: url)
                let assetImageGenerator = AVAssetImageGenerator(asset: asset)
                assetImageGenerator.appliesPreferredTrackTransform = true
                
                let time = CMTimeMake(value: 1, timescale: 2)
                var actualTime = CMTime.zero
                
                do {
                    let cgImage = try assetImageGenerator.copyCGImage(at: time, actualTime: &actualTime)
                    let image = UIImage(cgImage: cgImage)
                    return image
                } catch {
                    print("Error generating thumbnail: \(error)")
                    return nil
                }
            }*/


    //        //new
    //        if defaults.object(forKey: "selfieimage") == nil
    //        {
    //            print("No value in Userdefault serviceproviderBANKname")
    //        }
    //        else
    //        {
    //
    //        let imageDataselfie = defaults.data(forKey: "selfieimage")
    //        let orgImageselfie : UIImage = UIImage(data: imageDataselfie!)!
    //        selfieimageview.image = orgImageselfie
    //        }

            
            
            
            
            
    //        let documentsFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    //        let videoURL = documentsFolder.appendingPathComponent("MyDownloads/Arrow.S05E01.mp4")
    //        let player = AVPlayer(url: videoURL)
            
          //  self.frontimageview.image = defaults.data(forKey: "frontimage")
            
            //frontimage
    //        let base64EncodedString = strBase64! // Your Base64 Encoded String
    //        if let imageData = Data(base64Encoded: base64EncodedString) {
    //                        let image = UIImage(data: imageData)
    //                        self.frontimageview.image = image
    //
    //            //backimage
    //            let base64EncodedString = strBase641! // Your Base64 Encoded String
    //            if let imageData = Data(base64Encoded: base64EncodedString) {
    //                            let image = UIImage(data: imageData)
    //                            self.backimageview.image = image
    //                        }
    //                    }
            
        
    }
}
