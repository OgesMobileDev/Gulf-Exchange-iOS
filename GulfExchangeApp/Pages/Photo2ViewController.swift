//
//  Photo2ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 30/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import Vision
import ScreenShield

class Photo2ViewController: UIViewController,AVCapturePhotoCaptureDelegate {
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var capturedImageView: UIImageView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var cameraActionView: UIView!
    @IBOutlet weak var choosePhotoActionView: UIView!
    @IBOutlet weak var photoSaveButton: UIButton!
    @IBOutlet weak var photoCancelButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    var croppedImageView = UIImageView()
    var cropImageRect = CGRect()
    var cropImageRectCorner = UIRectCorner()
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var detectedBarcode = ""
    var strBase641:String!
    let defaults = UserDefaults.standard
    
    var qidNo:String?
    var expiryDate: String?
    var dob: String?
    var nationality: String?
    let qid = UserDefaults.standard.string(forKey: "recognizedQidText")
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "recognizedPassportNumber")
        UserDefaults.standard.removeObject(forKey: "recognizedSerialNumber")
        UserDefaults.standard.removeObject(forKey: "recognizedPassportExpiryText")
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("register", comment: "")
        // Do any additional setup after loading the view.
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        // Protect ScreenShot
//                    ScreenShield.shared.protect(view: self.mainStackView)
                    
                    // Protect Screen-Recording
                    ScreenShield.shared.protectFromScreenRecording()
        
        captureSession = AVCaptureSession()
//        captureSession.sessionPreset = .medium
        captureSession.sessionPreset = .high
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera")
                return
        }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            stillImageOutput.isHighResolutionCaptureEnabled = true
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupCameraPreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
       

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    func setupCameraPreview() {
            
            let imageView = setupGuideLineArea()
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer.videoGravity = .resizeAspectFill
            videoPreviewLayer.connection?.videoOrientation = .portrait
            previewView.layer.addSublayer(videoPreviewLayer)
            previewView.addSubview(imageView)
            cropImageRect = imageView.frame
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
                DispatchQueue.main.async {
                    self.videoPreviewLayer.frame = self.previewView.bounds
                }
            }
        }
        
        func setupGuideLineArea() -> UIImageView {
            
            let edgeInsets:UIEdgeInsets = UIEdgeInsets.init(top: 22, left: 22, bottom: 22, right: 22)
            
            let resizableImage = (UIImage(named: "guideImage")?.resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch))
            let imageSize = CGSize(width: previewView.frame.size.width, height: previewView.frame.size.height)
            cropImageRectCorner = [.allCorners]
            
            let imageView = UIImageView(image: resizableImage)
            imageView.frame.size = imageSize
            imageView.center = CGPoint(x: previewView.bounds.midX, y: previewView.bounds.midY);
            return imageView
        }
        
        func previewViewLayerMode(image: UIImage?, isCameraMode: Bool) {
            if isCameraMode {
                self.captureSession.startRunning()
                
                cameraActionView.isHidden = false
                choosePhotoActionView.isHidden = true
                
                previewView.isHidden = false
                capturedImageView.isHidden = true
            } else {
                self.captureSession.stopRunning()
                cameraActionView.isHidden = true
                choosePhotoActionView.isHidden = false
                
                previewView.isHidden = true
                capturedImageView.isHidden = false
                
                // Original image to blureffect
                let blurEffect = UIBlurEffect(style: .light)
                let blurView = UIVisualEffectView(effect: blurEffect)
                blurView.frame = capturedImageView.bounds
                capturedImageView.addSubview(blurView)
                
                // Crop guide Image
                croppedImageView = UIImageView(image: image!)
                croppedImageView.center = CGPoint(x:capturedImageView.frame.width/2, y:capturedImageView.frame.height/2)
                croppedImageView.frame = cropImageRect
                croppedImageView.roundCorners(cropImageRectCorner, radius: 10)
                capturedImageView.addSubview(croppedImageView)
            }
        }
        
        // MARK: - AVCapturePhotoCaptureDelegate
  @available(iOS 11.0, *)
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            
            guard error == nil else {
                print("Fail to capture photo: \(String(describing: error))")
                return
            }
            
            // Check if the pixel buffer could be converted to image data
            guard let imageData = photo.fileDataRepresentation() else {
                print("Fail to convert pixel buffer")
                return
            }
            
            let orgImage : UIImage = UIImage(data: imageData)!
            capturedImageView.image = orgImage
            let originalSize: CGSize
            let visibleLayerFrame = cropImageRect
            
            // Calculate the fractional size that is shown in the preview
            let metaRect = (videoPreviewLayer?.metadataOutputRectConverted(fromLayerRect: visibleLayerFrame )) ?? CGRect.zero
            
            if (orgImage.imageOrientation == UIImage.Orientation.left || orgImage.imageOrientation == UIImage.Orientation.right) {
                originalSize = CGSize(width: orgImage.size.height, height: orgImage.size.width)
            } else {
                originalSize = orgImage.size
            }
            let cropRect: CGRect = CGRect(x: metaRect.origin.x * originalSize.width, y: metaRect.origin.y * originalSize.height, width: metaRect.size.width * originalSize.width, height: metaRect.size.height * originalSize.height).integral
            
            if let finalCgImage = orgImage.cgImage?.cropping(to: cropRect) {
                let image = UIImage(cgImage: finalCgImage, scale: 1.0, orientation: orgImage.imageOrientation)
                previewViewLayerMode(image: image, isCameraMode: false)
//                detectedBarcode = ""
//                detectBarcodes(from: image) { barcodeValues in
//                    if let values = barcodeValues {
//                       
//                        for value in values {
//                            let valueStr = String(value)
//                            
//                            print("Detected barcode value: \(value)")
//                            
//                            if self.qid != valueStr{
//                                self.detectedBarcode = ""
//                                let alert = UIAlertController(title: "Please try again." , message: "ID Card mismatch", preferredStyle: .alert)
//                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                                self.present(alert, animated: true, completion: nil)
//                                
//                            }else{
//                                self.detectedBarcode = String(value)
//                            }
//                        }
//                        if values.isEmpty{self.detectedBarcode = ""
//                            let alert = UIAlertController(title: "Please try again." , message: "No barcode detected", preferredStyle: .alert)
//                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
//                        }
//                    } else {
//                        self.detectedBarcode = ""
//                        print("No barcodes detected.")
//                    }
//                }
//                recognizeTextInImage(image)
            }
        }
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
  if let error = error {
      print(error.localizedDescription)
  }

  if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
    let orgImage : UIImage = UIImage(data: dataImage)!
              capturedImageView.image = orgImage
              let originalSize: CGSize
              let visibleLayerFrame = cropImageRect
              
              // Calculate the fractional size that is shown in the preview
              let metaRect = (videoPreviewLayer?.metadataOutputRectConverted(fromLayerRect: visibleLayerFrame )) ?? CGRect.zero
              
              if (orgImage.imageOrientation == UIImage.Orientation.left || orgImage.imageOrientation == UIImage.Orientation.right) {
                  originalSize = CGSize(width: orgImage.size.height, height: orgImage.size.width)
              } else {
                  originalSize = orgImage.size
              }
              let cropRect: CGRect = CGRect(x: metaRect.origin.x * originalSize.width, y: metaRect.origin.y * originalSize.height, width: metaRect.size.width * originalSize.width, height: metaRect.size.height * originalSize.height).integral
              
              if let finalCgImage = orgImage.cgImage?.cropping(to: cropRect) {
                  let image = UIImage(cgImage: finalCgImage, scale: 1.0, orientation: orgImage.imageOrientation)
                  previewViewLayerMode(image: image, isCameraMode: false)
                  
//                  recognizeTextInImage(image)
              }
    }
  }
  
        @IBAction func actionCameraCapture(_ sender: Any) {
            var photoSettings: AVCapturePhotoSettings
            if #available(iOS 11.0, *) {
                              photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                            } else {
                              photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecJPEG])
                            }
            photoSettings.isAutoStillImageStabilizationEnabled = true
            photoSettings.flashMode = .off
            
            // AVCapturePhotoCaptureDelegate
            self.stillImageOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    @IBAction func savePhotoPressed(_ sender: Any) {
        
       
//        guard  let recognizedPassportExpiryText = UserDefaults.standard.string(forKey: "recognizedPassportExpiryText"),
//               detectedBarcode != "",
//               recognizedPassportExpiryText != ""
//        else{
//            //   let alert = UIAlertController(title: "Retsport ake Photo", message: "No useful information detected.", preferredStyle: .alert)
//            let alert = UIAlertController(title: "Please try again.", message: "Hold the ID close and ensure the image is clear", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//            return
//            
//        }
        
           /*  guard UserDefaults.standard.string(forKey: "recognizedPassportExpiryText") != nil  else{
              //   let alert = UIAlertController(title: "Retsport ake Photo", message: "No useful information detected.", preferredStyle: .alert)
                 let alert = UIAlertController(title: "Please try again.", message: "Hold the ID close and ensure the image is clear", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 present(alert, animated: true, completion: nil)
                 return
                 
             }*/
        
        //        UIImageWriteToSavedPhotosAlbum(croppedImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        //            let imageData = capturedImageView.image!.pngData() as NSData?
        
        let imageData = capturedImageView.image!.jpeg(.medium) as NSData?
        
        // Make sure to unwrap the optional UIImage properly
        //            if let image = capturedImageView.image {
        //                recognizeTextInImage(image)
        //            } else {
        //                print("Image is nil")
        //            }
        //newphotoview
        self.defaults.set(imageData, forKey: "backimage")
        
        
        strBase641 = imageData!.base64EncodedString(options: .lineLength64Characters)
//        print("strBase641 lineLength64Characters",strBase641)
        self.defaults.set(strBase641, forKey: "strBase641")
        
        
        
        //
        //
        //                    let showAlert = UIAlertController(title: "Please take a selfie holding your ID", message: nil, preferredStyle: .alert)
        //
        //                    let imageView = UIImageView(frame: CGRect(x: 15, y: 65, width: 250, height: 230))
        //                    imageView.image = UIImage(named: "selfie")// Your image here...
        //                    showAlert.view.addSubview(imageView)
        //                    let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 350)
        //                    let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280)
        //                    showAlert.view.addConstraint(height)
        //                    showAlert.view.addConstraint(width)
        //                    showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        //                        // your actions here...
        //                        print("urlss","ttttt")
        //                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //                              let vc: Photo3ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "photo3") as! Photo3ViewController
        //                              self.navigationController?.pushViewController(vc, animated: true)
        //
        //                    }))
        //                    self.present(showAlert, animated: true, completion: nil)
        //            //
        
        
        //
        //            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //            let vc: Photo3ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "photo3") as! Photo3ViewController
        //            self.navigationController?.pushViewController(vc, animated: true)
        
        
        // new design
        /*
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails1VC") as! RegisterIdDetails1VC
                self.navigationController?.pushViewController(nextViewController, animated: true)
        */
        
        // old latest Design
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViedionewViewController") as! ViedionewViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
       // let seconds = 4.0
        //DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
        
        
      /*  if let newOrExistCustStr = UserDefaults.standard.string(forKey: "neworexistcuststr") {
            print("newOrExistCustStr",newOrExistCustStr)
            if newOrExistCustStr == "B" {
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let vc: RegisternewenhViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisternewenhViewController") as! RegisternewenhViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let vc: RegisterViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerr") as! RegisterViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let vc: RegisterViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerr") as! RegisterViewController
            self.navigationController?.pushViewController(vc, animated: true)
            print("Value not found for existing register")
        }*/
        
   // }
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let vc: OCRphotoPreviewVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OCRphotoPreviewVC") as! OCRphotoPreviewVC
//        self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                
                let alertController = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { (alert: UIAlertAction!) in
                    self.previewViewLayerMode(image: nil, isCameraMode: true)
                }))
                present(alertController, animated: true)
            } else {
                let alertController = UIAlertController(title: "Saved", message: "Captured guided image saved successfully.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { (alert: UIAlertAction!) in
                    self.previewViewLayerMode(image: nil, isCameraMode: true)
                }))
                present(alertController, animated: true)
            }
        }
        @IBAction func cancelPhotoPressed(_ sender: Any) {
            previewViewLayerMode(image: nil, isCameraMode: true)
        }
    func detectBarcodes(from image: UIImage, completion: @escaping ([String]?) -> Void) {
        // Convert UIImage to CGImage
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }
        
        // Create a barcode detection request
        let barcodeRequest = VNDetectBarcodesRequest { request, error in
            if let error = error {
                print("Failed to detect barcodes: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Extract barcode values
            var barcodeValues = [String]()
            for result in request.results as? [VNBarcodeObservation] ?? [] {
                if let payload = result.payloadStringValue {
                    barcodeValues.append(payload)
                }
            }
            
            completion(barcodeValues)
        }
        
        // Create a request handler
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        do {
            // Perform the request
            try requestHandler.perform([barcodeRequest])
        } catch {
            print("Failed to perform request: \(error.localizedDescription)")
            completion(nil)
        }
    }

}
extension Photo2ViewController:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func recognizeTextInImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else {
            print("Unable to get CGImage from UIImage")
            return
        }
        UserDefaults.standard.removeObject(forKey: "recognizedPassportNumber")
        UserDefaults.standard.removeObject(forKey: "recognizedSerialNumber")
        UserDefaults.standard.removeObject(forKey: "recognizedPassportExpiryText")
        
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { [weak self] (request, error) in
            if let error = error {
                print("Error recognizing text: \(error.localizedDescription)")
                return
            }
            
            self?.processRecognizedText(request)
        }
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Failed to perform text recognition request: \(error.localizedDescription)")
        }
    }
    
    func processRecognizedText(_ request: VNRequest) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            print("No text found")
            return
        }
        
        var passportNumber: String?
        var serialNumber: String?
        var dates = [Date]()
        
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        for observation in observations {
            guard let bestCandidate = observation.topCandidates(1).first else { continue }
            let text = bestCandidate.string
            print("Found text: \(text)")
            
            // Extract passport number
            let passportNumberPattern = "\\bU\\d{7}\\b"
            if let numberRange = text.range(of: passportNumberPattern, options: .regularExpression) {
                passportNumber = String(text[numberRange])
                print("Passport Number: \(passportNumber!)")
                UserDefaults.standard.set(passportNumber, forKey: "recognizedPassportNumber")
            }
            
            // Extract serial number
            let serialNumberPattern = "\\b\\d{14}\\b"
            if let serialRange = text.range(of: serialNumberPattern, options: .regularExpression) {
                serialNumber = String(text[serialRange])
                print("Serial Number: \(serialNumber!)")
                UserDefaults.standard.set(serialNumber, forKey: "recognizedSerialNumber")
            }
            
            // Extract expiry date
            let expiryPattern = "\\b(\\d{2}/\\d{2}/\\d{4})\\b"
            if let expiryRange = text.range(of: expiryPattern, options: .regularExpression) {
                let dateStr = String(text[expiryRange])
                if let date = dateFormatter.date(from: dateStr) {
                    dates.append(date)
                }
            }
        }
        
        if dates.count == 1 {
            self.expiryDate = dateFormatter.string(from: dates[0])
            if let expiry = self.expiryDate {
                UserDefaults.standard.set(expiry, forKey: "recognizedPassportExpiryText")
                print("Expiry date found: \(expiry)")
            }
        } else {
//            let alert = UIAlertController(title: "No expiry date found", message: "Please try again.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
            
        }
        
        // Check if all required information is found
        if let recognizedPassportNumber = UserDefaults.standard.string(forKey: "recognizedPassportNumber"),
           let recognizedSerialNumber = UserDefaults.standard.string(forKey: "recognizedSerialNumber"),
           let recognizedExpiryText = UserDefaults.standard.string(forKey: "recognizedExpiryText") {
            print("Recognized Passport Number: \(recognizedPassportNumber)")
            print("Recognized Serial Number: \(recognizedSerialNumber)")
            print("Recognized Expiry Date: \(recognizedExpiryText)")
        } else {
//            let alert = UIAlertController(title: "Incomplete data", message: "Please try again.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
        }
    }
}

