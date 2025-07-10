//
//  RegisterImage1VC.swift
//  GulfExchangeApp
//
//  Created by macbook on 23/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON
import ScreenShield

class RegisterImage1VC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cameraBaseView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var retakeBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var captureBtn: UIButton!
    @IBOutlet weak var captureBtnView: UIView!
    //    scanner overlay
    @IBOutlet weak var scannerMainView: UIView!
    @IBOutlet weak var scannerBaseView: UIView!
    @IBOutlet weak var scannerViewHeight: NSLayoutConstraint!
    
    
    private var captureSession: AVCaptureSession?
    private var videoOutput: AVCaptureVideoPreviewLayer?
    private var photoOutput: AVCapturePhotoOutput?
    private var capturedImage: UIImage?
    var isSecond:Bool = false
    let defaults = UserDefaults.standard
    
    var strBase64:String = ""
    var strBase641:String = ""
    
    var referenceNo:String = ""
    var idImageFrontData: Data?
    var idImageBackData: Data?
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var verificationType:VerificationFlow = .register
    
    
    override var shouldAutorotate: Bool {
        return false // Prevents the screen from rotating
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait // Locks the screen to portrait orientation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraBaseView.clipsToBounds = true
        scannerMainView.clipsToBounds = true
//        setScannerView()
//        addIDCardOverlay()
        
        addNavbar()
        titleLbl.text = NSLocalizedString("photo_id_front", comment: "")
        captureBtn.setTitle("", for: .normal)
        okBtn.isHidden = true
        retakeBtn.isHidden = true
        checkCameraPermissionAndSetup(from: self) {
            self.setupCamera()
        }
    }
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //
    //    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.restrictRotation = .portrait // Lock this view controller to portrait mode
        }
        if verificationType == .update{
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
        }
        ScreenShield.shared.protectFromScreenRecording()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.restrictRotation = .all // Restore the default rotation for other view controllers
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoOutput?.frame = cameraBaseView.bounds
        
        setScannerView()
        addIDCardOverlay()
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
    
    
    @IBAction func retakeBtnTapped(_ sender: Any) {
        captureBtnView.isHidden = false
        capturedImage = nil // Clear the stored image
        retakeBtn.isHidden = true // Hide buttons
        okBtn.isHidden = true
        captureBtn.isHidden = false
        scannerBaseView.isHidden = false
        checkCameraPermissionAndSetup(from: self) {
            self.setupCamera()
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession?.startRunning()
        }
    }
    @IBAction func okBtnTapped(_ sender: Any) {
        
        if let image = capturedImage, let compressedData = compressImageToMaxSize(image: image, maxSizeInMB: 1.0) {
            let compressedImage = UIImage(data: compressedData) // Use this compressed image
            
            self.capturedImage = compressedImage
            print("image compressed and navigating")
            self.saveAndNavigate()
        }else{
            print("image not compressed and navigating")
            self.saveAndNavigate()
        }
        
        
        
        
        
    }
    @IBAction func captureBtnTapped(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
        captureBtnView.isHidden = true
        
    }
    
    //MARK: - Functions
    
    func addNavbar(){
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        if verificationType == .register{
            self.navigationItem.title = "ID Verification"
        }else{
            self.navigationItem.title = "Update Profile"
        }
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func setScannerView(){
        let screenWidth = UIScreen.main.bounds.width
        let cardAspectRatio: CGFloat = 1.586 // Aspect ratio of a Qatar ID card
        let viewWidth = screenWidth - 40
        let viewHeight = viewWidth / cardAspectRatio
        scannerViewHeight.constant = viewHeight
    }
    func addIDCardOverlay() {
        let screenWidth = UIScreen.main.bounds.width
        let cardAspectRatio: CGFloat = 1.586 // Qatar ID card aspect ratio
        let viewWidth = screenWidth - 20
        let viewHeight = viewWidth / cardAspectRatio
        
//        // Create an overlay view covering the entire scannerBaseView
//        let overlay = UIView(frame: scannerMainView.bounds)
//        overlay.backgroundColor = UIColor.black
//        
//        // Create a mask layer with a transparent cutout
//        let maskLayer = CAShapeLayer()
//        let path = UIBezierPath(rect: overlay.bounds)
//        
//        // Define the cutout frame (centered in the overlay)
//        let cutoutRect = CGRect(
//            x: (overlay.bounds.width - viewWidth) / 2,
//            y: (overlay.bounds.height - viewHeight - 40) / 2,
//            width: viewWidth,
//            height: viewHeight
//        )
//        print("Cutput viewHeight",viewHeight)
//        print("Cutput viewWidth",viewWidth)
//        let cutoutPath = UIBezierPath(roundedRect: cutoutRect, cornerRadius: 10) // Optional rounded corners
//        path.append(cutoutPath)
//        
//        maskLayer.path = path.cgPath
//        maskLayer.fillRule = .evenOdd
//        overlay.layer.mask = maskLayer
//        scannerMainView.addSubview(overlay)
        
        
        let safeFrame = scannerMainView.safeAreaLayoutGuide.layoutFrame
                let overlay = UIView(frame: scannerMainView.bounds)
                overlay.backgroundColor = UIColor.black
         
                let maskLayer = CAShapeLayer()
                let path = UIBezierPath(rect: overlay.bounds)
         
                let cutoutRect = CGRect(
                    x: safeFrame.minX + (safeFrame.width - viewWidth) / 2,
                    y: safeFrame.minY + (safeFrame.height - viewHeight) / 2,
                    width: viewWidth,
                    height: viewHeight
                )
         
                let cutoutPath = UIBezierPath(roundedRect: cutoutRect, cornerRadius: 10)
                path.append(cutoutPath)
                maskLayer.path = path.cgPath
                maskLayer.fillRule = .evenOdd
         
                overlay.layer.mask = maskLayer
                scannerMainView.addSubview(overlay)
    }
    //MARK: crop image

    func cropImageToIDCardFrame(_ originalImage: UIImage) -> UIImage? {
        let image = fixImageOrientation(originalImage) // Ensure upright orientation
           guard let cgImage = image.cgImage else { return nil }

           // Get the aspect ratio of the Qatar ID card
           let cardAspectRatio: CGFloat = 1.586
           let screenWidth = UIScreen.main.bounds.width
           let viewWidth = screenWidth
           let viewHeight = viewWidth / cardAspectRatio

           // Cutout frame in UIView coordinates
           let cutoutRect = CGRect(
               x: (cameraBaseView.bounds.width - viewWidth) / 2,
               y: (cameraBaseView.bounds.height - viewHeight ) / 2,
               width: viewWidth,
               height: viewHeight
           )

           // Convert UIView coordinates to image coordinates
           let scaleX = CGFloat(cgImage.width) / cameraBaseView.bounds.width
           let scaleY = CGFloat(cgImage.height) / cameraBaseView.bounds.height

           let cropRect = CGRect(
               x: cutoutRect.origin.x * scaleX,
               y: cutoutRect.origin.y * scaleY,
               width: cutoutRect.width * scaleX,
               height: cutoutRect.height * scaleY
           )

           // Crop the image
           if let croppedCgImage = cgImage.cropping(to: cropRect) {
               return UIImage(cgImage: croppedCgImage, scale: image.scale, orientation: .up)
           }

           return nil
    }





    func fixImageOrientation(_ image: UIImage) -> UIImage {
        guard image.imageOrientation != .up else { return image }

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        let fixedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return fixedImage ?? image
    }
    



    
    func setSecondImg(){
        titleLbl.text = NSLocalizedString("photo_id_back", comment: "")
        isSecond = true
        capturedImage = nil
        retakeBtn.isHidden = true // Hide buttons
        okBtn.isHidden = true
        captureBtn.isHidden = false
        scannerBaseView.isHidden = false
        captureBtnView.isHidden = false
        checkCameraPermissionAndSetup(from: self) {
            self.setupCamera()
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession?.startRunning()
        }
    }
    func saveAndNavigate(){
        guard let image = capturedImage else {
            print("No image to convert")
            return
        }
        
        guard let imageData1 = image.jpegData(compressionQuality: 0.8) else { // Use JPEG for better compression
            print("Could not get JPEG data")
            return
        }
        guard let imageData = compressImageToUnder2MB(image) else {
            print("Could not get JPEG data")
            return
        }

//                if let image = capturedImage, let imageData = image.jpegData(compressionQuality: 1) { // Use 1.0 for full quality
//                                let imageSizeInBytes = imageData.count
//                                let imageSizeInKB = Double(imageSizeInBytes) / 1024.0
//                                let imageSizeInMB = imageSizeInKB / 1024.0
//                                print("saveAndNavigate Image Size: \(imageSizeInMB) MB)")
//                            } else {
//                                print("Failed to get image data")
//                            }
        let imageSizeInBytes = imageData.count
        let imageSizeInKB = Double(imageSizeInBytes) / 1024.0
        let imageSizeInMB = imageSizeInKB / 1024.0
        print("saveAndNavigate Image Size: \(imageSizeInMB) MB)")
        let base64String = imageData.base64EncodedString()
        //                print("Base64 Image:\n\(base64String)")
        let idImageData = imageData
        if isSecond{
            self.defaults.set(base64String, forKey: "strBase641")
            self.defaults.set(imageData, forKey: "backimage")
            self.strBase641 = base64String
            self.idImageBackData = idImageData
            
            let strBase64123 = defaults.string(forKey: "strBase641") ?? ""
            if strBase64123.isEmpty || strBase64123 == ""{
                print("strBase64 empty")
            }
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterSelfieVC") as! RegisterSelfieVC
            nextViewController.strBase64 = self.strBase64
            nextViewController.strBase641 = self.strBase641
            nextViewController.referenceNo = self.referenceNo
            nextViewController.verificationType = self.verificationType
            nextViewController.idImageBackData = self.idImageBackData
            nextViewController.idImageFrontData = self.idImageFrontData
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
        }else{
            self.defaults.set(base64String, forKey: "strBase64")
            self.defaults.set(imageData, forKey: "frontimage")
            self.strBase64 = base64String
            self.idImageFrontData = idImageData
            
            
            let strBase64123 = defaults.string(forKey: "strBase64") ?? ""
            if strBase64123.isEmpty || strBase64123 == ""{
                print("strBase64 empty")
            }
            setSecondImg()
        }
        // You can now use base64String (e.g., send it to a server)
        // Reset the UI for the next capture:
    }
    func compressImageToUnder2MB(_ image: UIImage) -> Data? {
        let maxSize = 2 * 1024 * 1024  // 2 MB in bytes
        var compression: CGFloat = 0.9
        let minCompression: CGFloat = 0.1

        while compression >= minCompression {
            if let imageData = image.jpegData(compressionQuality: compression),
               imageData.count <= maxSize {
                return imageData
            }
            compression -= 0.1
        }

        // Final attempt with minimum compression
        if let imageData = image.jpegData(compressionQuality: minCompression),
           imageData.count <= maxSize {
            return imageData
        }

        print("Could not compress image below 2MB")
        return nil
    }

    private func setupCamera() {
        // 1. Create Capture Session
        captureSession = AVCaptureSession()
        captureSession?.beginConfiguration() // Important for configuration changes
        
        // Set session preset for quality/performance balance
        if captureSession!.canSetSessionPreset(.photo){
            captureSession!.sessionPreset = .photo
        } else if captureSession!.canSetSessionPreset(.high){
            captureSession!.sessionPreset = .high
        }
        
        // 2. Get the default camera
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("No camera available")
            return
        }
        
        do {
            // 3. Create input from the camera
            let input = try AVCaptureDeviceInput(device: camera)
            
            // 4. Add the input to the session
            if captureSession!.canAddInput(input) {
                captureSession!.addInput(input)
            } else {
                print("Could not add camera input to session")
                return
            }
            
            // 5. Create Video Output Layer
            videoOutput = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoOutput?.videoGravity = .resizeAspectFill // or .resizeAspect
            videoOutput?.frame = cameraBaseView.bounds
            cameraBaseView.layer.addSublayer(videoOutput!)
            
            // 6. Create Photo Output
            photoOutput = AVCapturePhotoOutput()
            
            if captureSession!.canAddOutput(photoOutput!) {
                captureSession!.addOutput(photoOutput!)
            } else {
                print("Could not add photo output to session")
                return
            }
            
            captureSession?.commitConfiguration() // End configuration changes
            
            // 7. Start the session
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession?.startRunning()
            }
            
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    // AVCapturePhotoCaptureDelegate methods
   /* func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            print("Could not get image data")
            return
        }
        
        guard let image = UIImage(data: imageData) else {
            print("Could not create image from data")
            return
        }
    
        capturedImage = image
        retakeBtn.isHidden = false // Show buttons
        okBtn.isHidden = false
        captureSession?.stopRunning()
        
        // Or save it to Photos:
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }*/
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            print("error saving image : \(error.localizedDescription)")
        } else {
            print("image saved successfully")
        }
    }
    
    func compressImageToMaxSize(image: UIImage, maxSizeInMB: Double) -> Data? {
        let maxSizeInBytes = Int(maxSizeInMB * 1024 * 1024)
        var compressionQuality: CGFloat = 1.0
        var compressedImageData: Data?
        
        while compressionQuality > 0 {
            if let data = image.jpegData(compressionQuality: compressionQuality) {
                if data.count <= maxSizeInBytes {
                    compressedImageData = data
                    break
                }
            }
            compressionQuality -= 0.1
        }
        
        if let compressedData = compressedImageData {
            print("Compressed Image Size: \(Double(compressedData.count) / 1024.0 / 1024.0) MB")
        } else {
            print("Failed to compress image to the desired size")
        }
        
        return compressedImageData
    }
    
    
}

extension RegisterImage1VC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let originalImage = UIImage(data: imageData) else {
            print("Error capturing image: \(error?.localizedDescription ?? "Unknown error")")
            return
        }

        // Crop the image to match the ID card cutout
        if let croppedImage = cropImageToIDCardFrame(originalImage) {
            DispatchQueue.main.async {
                // Remove camera preview
                self.videoOutput?.removeFromSuperlayer()
                
                // Set cropped image as the background of cameraBaseView
                self.cameraBaseView.layer.contents = croppedImage.cgImage
                self.cameraBaseView.layer.contentsGravity = .resizeAspect
               
                self.capturedImage = croppedImage
                self.retakeBtn.isHidden = false // Show buttons
                self.okBtn.isHidden = false
//                self.scannerMainView.isHidden = true
                self.scannerBaseView.isHidden = true
                self.captureSession?.stopRunning()
            }
        }
    }
}
