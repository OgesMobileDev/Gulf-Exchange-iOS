//
//  REGReviewViewController.swift
//  GulfExchangeApp
//
//  Created by MACBOOK PRO on 13/05/22.
//  Copyright © 2022 Oges. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MobileCoreServices
import ScreenShield

class REGReviewViewController: UIViewController, UINavigationControllerDelegate {
    
    let defaults = UserDefaults.standard
    
    var strBase64:String!
    var strBase641:String!
    var strBase642:String!
    
    var strBase64video:String!

    
    
    var str_buildingno:String = ""
    
    @IBOutlet var mainvieww: UIView!
    
    
    @IBOutlet var idtypelabel: UILabel!
    
    
    @IBOutlet var idissuerlabel: UILabel!
    
    
    @IBOutlet var idnumberlabel: UILabel!
    
    
    
    @IBOutlet var idexpirydatelabel: UILabel!
    
    
    @IBOutlet var fullnameenglishlabel: UILabel!
    
    
    @IBOutlet var fullnamearabiclabel: UILabel!
    
    
    
    @IBOutlet var emaillabel: UILabel!
    
    
    @IBOutlet var doblabel: UILabel!
    
    
    
    @IBOutlet var nationalitylabel: UILabel!
    
    @IBOutlet weak var dualNationalityLbl: UILabel!
    
    @IBOutlet var countryresilabel: UILabel!
    
    
    @IBOutlet var muncipalitylabel: UILabel!
    
    
    @IBOutlet var zonelabel: UILabel!
    
    
    @IBOutlet var homeaddresslabel: UILabel!
    
    
    @IBOutlet var genderlabel: UILabel!
    
    
    
    @IBOutlet var mobilelabel: UILabel!
    
    
    @IBOutlet var employerlabel: UILabel!
    
    
    @IBOutlet var expectincomelabel: UILabel!
    
    
    
    @IBOutlet var workaddresslabel: UILabel!
    
    
    @IBOutlet var occupationlabel: UILabel!
    
    
    @IBOutlet var actualoccupationlabel: UILabel!
    
    
    
    @IBOutlet var frontimageview: UIImageView!
    
    
    
    @IBOutlet var backimageview: UIImageView!
    
    
    @IBOutlet var selfieimageview: UIImageView!
    
    @IBOutlet var backbtn: UIButton!
    
    
    @IBAction func backbtnaction(_ sender: Any)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    @IBOutlet var confirmbtn: UIButton!
    
    
    @IBAction func confirmbtnaction(_ sender: Any)
    {
        
//        = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        let vc: RegisterPage1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "reg1") as! RegisterPage1ViewController
                        self.navigationController?.pushViewController(vc, animated: true)
          
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainvieww.layer.masksToBounds = true
       // tblView.layer.borderColor = UIColor( red: 153/255, green: 153/255, blue:0/255, alpha: 1.0 ).cgColor
        mainvieww.layer.borderColor = UIColor.lightGray.cgColor
        mainvieww.layer.borderWidth = 0.7
        
        confirmbtn.layer.cornerRadius = 8.0

        backbtn.layer.cornerRadius = 8.0
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        getValuesview()

    }
    
    override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        getValuesview()
               // Protect ScreenShot
                    //  ScreenShield.shared.protect(view: self.mainvieww)
                      
                      // Protect Screen-Recording
                    //  ScreenShield.shared.protectFromScreenRecording()
              
           }
    func getValuesview()  {
        idtypelabel.text = defaults.string( forKey: "id_type")!
        idissuerlabel.text =  defaults.string( forKey: "id_issuer")!
        idnumberlabel.text = defaults.string( forKey: "id_no")!
        idexpirydatelabel.text =  defaults.string( forKey: "id_exp_date")!
        fullnameenglishlabel.text = defaults.string( forKey: "name_en")!
        
        
        if(defaults.string(forKey: "name_ar")! == "")
        {
            fullnamearabiclabel.text = "-"
        }
        else
        {
            fullnamearabiclabel.text = defaults.string( forKey: "name_ar")!
        }
        
        
        emaillabel.text = defaults.string( forKey: "email")!
        doblabel.text = defaults.string( forKey: "dob")!
        if let savedText = defaults.string(forKey: "nationalityname") {
                   nationalitylabel.text = savedText
                  }
        if let savedText1 = defaults.string(forKey: "dualnationalityname") {
                  dualNationalityLbl.text = savedText1
                 }
//        dualNationalityLbl.text = defaults.string(forKey: "nationalitynamestr1") ?? ""
        //countryresilabel.text = defaults.string( forKey: "country")!
        countryresilabel.text = "Qatar"
        muncipalitylabel.text = defaults.string( forKey: "zone")!
//        zonelabel.text = defaults.string( forKey: "zone")!
        
        //str_buildingno = defaults.string( forKey: "str_buildingno")!
        homeaddresslabel.text = defaults.string( forKey: "str_buildingno")!
        
        if(defaults.string(forKey: "home_addr")! == "")
        {
            //if defaults.object(forKey: "home_addr") != nil {
           // 3. If there is not an object, then set a default. This will
           //    not be ran if there is an object.
          // defaults.set("dark", forKey: "theme")
           // homeaddresslabel.text = "-"
            zonelabel.text = "-"
         }
        else
        {
            zonelabel.text = defaults.string( forKey: "home_addr")!
        //homeaddresslabel.text = defaults.string( forKey: "home_addr")!
        }
        genderlabel.text = defaults.string( forKey: "gender")!
        mobilelabel.text = defaults.string( forKey: "mobile")!
        employerlabel.text = defaults.string( forKey: "employer")!
        expectincomelabel.text = defaults.string( forKey: "income")!
        workaddresslabel.text =  defaults.string( forKey: "work_addr")!
        occupationlabel.text =  defaults.string( forKey: "str_occupationname")!
        actualoccupationlabel.text = defaults.string( forKey: "str_actualoccupationname")!
        
        strBase64 = defaults.string(forKey: "strBase64")
        strBase641 = defaults.string(forKey: "strBase641")
        strBase642 = defaults.string(forKey: "strBase642")
        strBase64video = defaults.string(forKey: "strBase64video")
        
        //new
        
        
        if defaults.object(forKey: "frontimage") == nil
        {
            print("No value in Userdefault serviceproviderBANKname")
        }
        else
        {
            let imageData = defaults.data(forKey: "frontimage")
            let orgImage : UIImage = UIImage(data: imageData!)!
            frontimageview.image = orgImage

        }
        
        
        if defaults.object(forKey: "backimage") == nil
        {
            print("No value in Userdefault serviceproviderBANKname")
        }
        else
        {
        
        let imageDataback = defaults.data(forKey: "backimage")
        let orgImageback : UIImage = UIImage(data: imageDataback!)!
        backimageview.image = orgImageback
        }
        
        
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
            
            selfieimageview.image = thumbnail
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        getValuesview()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func generateThumbnail(for url: URL) -> UIImage? {
//        let asset = AVAsset(url: url)
//        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
//        assetImageGenerator.appliesPreferredTrackTransform = true
//        
//        let time = CMTimeMake(value: 1, timescale: 2)
//        var actualTime = CMTime.zero
//        
//        do {
//            let cgImage = try assetImageGenerator.copyCGImage(at: time, actualTime: &actualTime)
//            let image = UIImage(cgImage: cgImage)
//            return image
//        } catch {
//            print("Error generating thumbnail: \(error)")
//            return nil
//        }
//    }

}
