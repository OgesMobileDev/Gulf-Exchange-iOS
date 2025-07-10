//
//  ViedionewViewController.swift
//  GulfExchangeApp
//
//  Created by test on 20/10/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices




class ViedionewViewController: UIViewController {
    
    @IBOutlet weak var RecordButton: UIButton!
    var videoAndImageReview = UIImagePickerController()
    var videoURL: URL?
    var videoURLtest: URL?
    
    var strBase64video:String!
    
    let defaults = UserDefaults.standard
    
    let videoFileName = "/video.mp4"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.removeObject(forKey: "strBase64video")
        
       // self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.title = NSLocalizedString("register", comment: "")
        
       /// ViedionewViewController.startRecord(delegate: self, sourceType: .camera)
        RecordButton.isHidden = true
        
        let showAlert = UIAlertController(title: "", message: nil, preferredStyle: .alert)

                        let imageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 255, height: 260))
                        imageView.image = UIImage(named: "selfie")// Your image here...
                        showAlert.view.addSubview(imageView)
                        let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400)
                        let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280)
                        showAlert.view.addConstraint(height)
                        showAlert.view.addConstraint(width)

                     let label = UILabel(frame: CGRect(x: 15, y: 285, width: 260, height: 40))
                     label.text = "Please take a 3 seconds video holding your ID and blinking your eyes"
                     label.font = label.font.withSize(14)
                     label.numberOfLines = 0
                     label.lineBreakMode = .byWordWrapping
                     showAlert.view.addSubview(label)
                let subview :UIView = showAlert.view.subviews.first! as UIView
                let alertContentView = subview.subviews.first! as UIView
                alertContentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                alertContentView.layer.cornerRadius = 15


                        showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            // your actions here...

        //                    print("urlss","ttttt")
        //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "forgotPIN") as! ForgotPINViewController
        //                    self.navigationController?.pushViewController(nextViewController, animated: true)
            
        ViedionewViewController.startRecord(delegate: self, sourceType: .camera)
                            
                    self.RecordButton.isHidden = false

                }))
                self.present(showAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // ViedionewViewController.startRecord(delegate: self, sourceType: .camera)
        
        print("testviewdidappear UnAvaialable")
       }
    
    static func startRecord(delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate, sourceType: UIImagePickerController.SourceType) {
        
        print("testviewdidappearinnn UnAvaialable")
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }

        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = sourceType
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = false
        mediaUI.delegate = delegate

        //mediaUI.videoMaximumDuration = 1 * 3
        mediaUI.videoMaximumDuration = Double(3)
        mediaUI.videoQuality = .typeMedium
        
     
        
        delegate.present(mediaUI, animated: true, completion: nil)
        
    }
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Video was saved" : "Video failed to save"
        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
//        //        self.navigationController?.pushViewController(nextViewController, animated: true)
//                self.navigationController?.pushViewController(nextViewController, animated: true)

//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
    }

    @IBAction func RecordAction(_ sender: UIButton) {
        
        ViedionewViewController.startRecord(delegate: self, sourceType: .camera)
        
//        let showAlert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
//
//                        let imageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 255, height: 260))
//                        imageView.image = UIImage(named: "selfie")// Your image here...
//                        showAlert.view.addSubview(imageView)
//                        let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 350)
//                        let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280)
//                        showAlert.view.addConstraint(height)
//                        showAlert.view.addConstraint(width)
//
//                     let label = UILabel(frame: CGRect(x: 15, y: 255, width: 350, height: 60))
//                     label.text = "Please take a selfie holding your ID"
//                     label.font = label.font.withSize(16)
//                     label.numberOfLines = 0
//                     showAlert.view.addSubview(label)
//                let subview :UIView = showAlert.view.subviews.first! as UIView
//                let alertContentView = subview.subviews.first! as UIView
//                alertContentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
//                alertContentView.layer.cornerRadius = 15
//
//
//                        showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                            // your actions here...
//
//        //                    print("urlss","ttttt")
//        //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        //                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        //                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "forgotPIN") as! ForgotPINViewController
//        //                    self.navigationController?.pushViewController(nextViewController, animated: true)
//
//                }))
//                self.present(showAlert, animated: true, completion: nil)

        
       
    
        
        
        
        
        
//
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
//            print("Camera Available")
//
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = .camera
//            imagePicker.mediaTypes = [kUTTypeMovie as String]
//            imagePicker.allowsEditing = false
//
//            imagePicker.videoMaximumDuration = Double(3)
//            imagePicker.videoQuality = .typeLow
//
//            self.present(imagePicker, animated: true, completion: nil)
//
//
//
//        } else {
//            print("Camera UnAvaialable")
//        }
        
    }
    
//
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String : Any]) {
//        dismiss(animated: true, completion: nil)
//
//        guard
//            let mediaType = info[UIImagePickerController.InfoKey.mediaType.rawValue] as? String,
//            mediaType == (kUTTypeMovie as String),
//            let url = info[UIImagePickerController.InfoKey.mediaURL.rawValue] as? URL,
//            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
//            else {
//                return
//        }
//
//
//
////        let alert1 = UIAlertController(title: title, message: (String(describing: url)), preferredStyle: .alert)
////        alert1.addAction(UIAlertAction(title: "OKiia", style: UIAlertActionStyle.cancel, handler: nil))
////        present(alert1, animated: true, completion: nil)
//
//
//        if let videoData = NSData(contentsOf: url) {
//                    print(videoData.length)
//
//
//            self.strBase64video = videoData.base64EncodedString(options: .lineLength64Characters)
//
//            //base64alert
//            let alert1 = UIAlertController(title: title, message: self.strBase64video, preferredStyle: .alert)
//            alert1.addAction(UIAlertAction(title: "OKiiabase64", style: UIAlertAction.Style.cancel, handler: nil))
//            present(alert1, animated: true, completion: nil)
//
//
//            //filesize
////            let fileSize = Double(videoData.count / 1048576) //Convert in to MB
////            print("File size in MB: ", fileSize)
//
////            let alert2 = UIAlertController(title: title, message: (String(describing: (videoData.count))), preferredStyle: .alert)
////            alert2.addAction(UIAlertAction(title: "OKiia", style: UIAlertActionStyle.cancel, handler: nil))
////            present(alert1, animated: true, completion: nil)
//                }
//
//        // Handle a movie capture
//        UISaveVideoAtPathToSavedPhotosAlbum(
//            url.path,
//            self,
//            #selector(video(_:didFinishSavingWithError:contextInfo:)),
//            nil)
//
//
//
//
//
//
//    }
    

  
    @IBAction func openImgVideoPicker() {
        
        
        if ((defaults.string(forKey: "strBase64video")?.isEmpty) != nil)
        {
      
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
//            //        self.navigationController?.pushViewController(nextViewController, animated: true)
//                    self.navigationController?.pushViewController(nextViewController, animated: true)

        }
        else
        {
            //illa
        }
        
       // else
       // {

            //nextvc

        
//
//        videoAndImageReview.sourceType = .savedPhotosAlbum
//        videoAndImageReview.delegate = self
//        videoAndImageReview.mediaTypes = ["public.movie"]
//        present(videoAndImageReview, animated: true, completion: nil)
        //}
    }
    
//    func videoAndImageReview(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        videoURL = info[UIImagePickerController.InfoKey.mediaURL.rawValue] as? URL
//        print("videoURL:\(String(describing: videoURL))")
//
//        let alert1 = UIAlertController(title: title, message: (String(describing: videoURL)), preferredStyle: .alert)
//        alert1.addAction(UIAlertAction(title: "OKii", style: UIAlertAction.Style.cancel, handler: nil))
//        present(alert1, animated: true, completion: nil)
//
//
//        self.dismiss(animated: true, completion: nil)
//    }

}

extension ViedionewViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate
{
    
    
   // private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    internal func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        
        dismiss(animated: true, completion: nil)

                guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
                    mediaType == (kUTTypeMovie as String),
                    let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
                    UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
                    else { return }

                // Handle a movie capture
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
        
            if let videoData = NSData(contentsOf: url) {
                        print(videoData.length)
                
                
                self.strBase64video = videoData.base64EncodedString(options: .lineLength64Characters)
                
                self.defaults.set(strBase64video, forKey: "strBase64video")
        
//        let alert1 = UIAlertController(title: title, message: (String(describing: url)), preferredStyle: .alert)
//        alert1.addAction(UIAlertAction(title: "OKiia", style: UIAlertActionStyle.cancel, handler: nil))
//        present(alert1, animated: true, completion: nil)
        

      
            
            //base64alert
//            let alert1 = UIAlertController(title: title, message: self.strBase64video, preferredStyle: .alert)
//            alert1.addAction(UIAlertAction(title: "OKiiabase64", style: UIAlertAction.Style.cancel, handler: nil))
//            present(alert1, animated: true, completion: nil)
            
            ////
            
           // let alert = UIAlertController(title: "Done ", message: "", preferredStyle: .alert)
            
          //  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                
                //nextvc
            
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: REGReviewViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "REGReviewViewController") as! REGReviewViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                let vc: RegisterPage1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "reg1") as! RegisterPage1ViewController
//                self.navigationController?.pushViewController(vc, animated: true)
           // }))
           // self.present(alert, animated: true)
            
  
            
            
            //filesize
//            let fileSize = Double(videoData.count / 1048576) //Convert in to MB
//            print("File size in MB: ", fileSize)

//            let alert2 = UIAlertController(title: title, message: (String(describing: (videoData.count))), preferredStyle: .alert)
//            alert2.addAction(UIAlertAction(title: "OKiia", style: UIAlertActionStyle.cancel, handler: nil))
//            present(alert1, animated: true, completion: nil)
                }
        
        // Handle a movie capture
//        UISaveVideoAtPathToSavedPhotosAlbum(
//            url.path,
//            self,
//            #selector(video(_:didFinishSavingWithError:contextInfo:)),
//            nil)
//
//
//        dismiss(animated: true, completion: nil)
   

        
    }
    
//    @objc private func videoo(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
//        let title = (error == nil) ? "Success" : "Error"
//        let message = (error == nil) ? "Video was saved" : "Video failed to save"
//
//        videoURLtest = info[UIImagePickerController.InfoKey.mediaURL] as? URL
//        print("videoURLtest:\(String(describing: videoURLtest))")
//
//
////        let alert1 = UIAlertController(title: title, message: (String(describing: videoURLtest)), preferredStyle: .alert)
////        alert1.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
////        present(alert1, animated: true, completion: nil)
//
////
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OKy", style: UIAlertAction.Style.cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
//
//
//
//
//
//
//
//
//
//    }
    
    
    
    
}
// DOESN'T CRASH
@objc protocol MyDelegate: UIImagePickerControllerDelegate {

}

extension MyDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // code
        
    }
}
