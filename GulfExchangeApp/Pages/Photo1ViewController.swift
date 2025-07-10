//
//  Photo1ViewController.swift
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
class Photo1ViewController: UIViewController,AVCapturePhotoCaptureDelegate{
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var cameraBaseView: UIView!
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
    var strBase64:String!
    let defaults = UserDefaults.standard
    
    var qidNo:String?
    var expiryDate: String?
    var dob: String?
    var nationality: String?
    var rotationAngle: CGFloat = 0
    var viewFrame = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "recognizedQidText")
        UserDefaults.standard.removeObject(forKey: "recognizedExpiryText")
        UserDefaults.standard.removeObject(forKey: "recognizedDOB")
        UserDefaults.standard.removeObject(forKey: "recognizedName")
        UserDefaults.standard.removeObject(forKey: "recognizedNationality")
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        addPreviewView()
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("register", comment: "")
       
      //  recognizeTextInImage(UIImage(named: "pic1")!)
    }

    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        // Protect ScreenShot
//               ScreenShield.shared.protect(view: self.mainStackView)
               
               // Protect Screen-Recording
               ScreenShield.shared.protectFromScreenRecording()
       
//        captureSession.sessionPreset = .medium
        addPreviewView()
        setupCamera()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addPreviewView()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Check orientation and perform layout adjustments if needed
        
        rotateViewForCurrentOrientation(pview: previewView)
//        setupCamera()
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else if UIDevice.current.orientation.isPortrait {
            print("Portrait")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
//    screen rotation
    func addPreviewView(){
        rotateViewForCurrentOrientation(pview: previewView)
        previewView.layer.backgroundColor = UIColor.red.cgColor
        cameraBaseView.layer.backgroundColor = UIColor.green.cgColor
        previewView.removeConstraints(previewView.constraints)
        cameraBaseView.addSubview(previewView)
        cameraBaseView.layer.masksToBounds = true
        cameraBaseView.clipsToBounds = true
        previewView.layer.masksToBounds = true
        previewView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                previewView.widthAnchor.constraint(equalTo: cameraBaseView.widthAnchor),
                previewView.heightAnchor.constraint(equalTo: cameraBaseView.heightAnchor),
                previewView.centerXAnchor.constraint(equalTo: cameraBaseView.centerXAnchor),
                previewView.centerYAnchor.constraint(equalTo: cameraBaseView.centerYAnchor)
               ])
    }
    
    func rotateViewForCurrentOrientation(pview:UIView) {
            let orientation = UIDevice.current.orientation
            
//            var viewFrame = CGRect.zero

            switch orientation {
            case .landscapeLeft:
                rotationAngle = -(.pi / 2) // Rotate 90 degrees to the right
                // Update frame to cover half of the landscape screen height
                viewFrame = CGRect(x: 0, y: 0, width: view.bounds.height, height: view.bounds.width - 250)
            case .landscapeRight:
                rotationAngle = .pi / 2 // Rotate 90 degrees to the left
                // Update frame to cover half of the landscape screen height
                viewFrame = CGRect(x: 0, y: 0, width: view.bounds.height, height: view.bounds.width - 250)
            case .portrait:
                rotationAngle = 0
                // Update frame to cover half of the portrait screen height
                viewFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 250)
            case .portraitUpsideDown:
                rotationAngle = .pi // Rotate 180 degrees
                // Update frame to cover half of the portrait screen height
                viewFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 250)
            default:
                rotationAngle = 0
                viewFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            }

       
        cameraBaseView.frame = viewFrame
            UIView.animate(withDuration: 0.3) {
                pview.transform = CGAffineTransform(rotationAngle: self.rotationAngle)
                pview.removeConstraints(pview.constraints)
                self.cameraBaseView.addSubview(pview)
                pview.translatesAutoresizingMaskIntoConstraints = false
                if self.rotationAngle == 0{
                    NSLayoutConstraint.activate([
                        pview.widthAnchor.constraint(equalTo: self.cameraBaseView.widthAnchor),
                        pview.heightAnchor.constraint(equalTo: self.cameraBaseView.heightAnchor),
                        pview.centerXAnchor.constraint(equalTo:self.cameraBaseView.centerXAnchor),
                        pview.centerYAnchor.constraint(equalTo: self.cameraBaseView.centerYAnchor)
                    ])
                    
                }else{
                    
                  NSLayoutConstraint.activate([
                    pview.widthAnchor.constraint(equalTo: self.cameraBaseView.heightAnchor),
                    pview.heightAnchor.constraint(equalTo: self.cameraBaseView.widthAnchor),
                    pview.centerXAnchor.constraint(equalTo:self.cameraBaseView.centerXAnchor),
                    pview.centerYAnchor.constraint(equalTo: self.cameraBaseView.centerYAnchor)
                   ])
                    
                }
                     
//                self.previewView.frame = self.cameraBaseView.bounds
//                self.cameraBaseView.addSubview(self.previewView)
//                self.previewView.frame = viewFrame
            }
        
        }

    func setupCamera(){
        captureSession = AVCaptureSession()
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
    
    func setupCameraPreview() {
            
          
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
                DispatchQueue.main.async {
                    self.rotateViewForCurrentOrientation(pview: self.previewView)
                    let imageView = self.setupGuideLineArea()
                    self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                    self.videoPreviewLayer.videoGravity = .resizeAspectFill
//                    self.videoPreviewLayer.connection?.videoOrientation = .portrait
                    
                    self.previewView.addSubview(imageView)
                    imageView.frame = self.previewView.bounds
                    self.cropImageRect = imageView.frame
                    
//                    self.rotateViewForCurrentOrientation(view: )
                   
                   
                    self.videoPreviewLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 250)
                    self.videoPreviewLayer.backgroundColor = UIColor.blue.cgColor
//                    self.videoPreviewLayer.frame.origin = self.previewView.frame.origin
//                    self.videoPreviewLayer.frame = self.cameraBaseView.bounds
                    self.videoPreviewLayer.frame.origin = self.viewFrame.origin
                    self.cameraBaseView.layer.addSublayer(self.videoPreviewLayer)
                }
            }
        }
        
        func setupGuideLineArea() -> UIImageView {
            
            let edgeInsets:UIEdgeInsets = UIEdgeInsets.init(top: 22, left: 22, bottom: 22, right: 22)
            
            let resizableImage = (UIImage(named: "guideImage")?.resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch))
            rotateViewForCurrentOrientation(pview: previewView)
            let imageSize = CGSize(width: cameraBaseView.frame.size.width, height: cameraBaseView.frame.size.height)
            cropImageRectCorner = [.allCorners]
            
            let imageView = UIImageView(image: resizableImage)
            imageView.frame.size = imageSize
            imageView.center = CGPoint(x: cameraBaseView.bounds.midX, y: cameraBaseView.bounds.midY);
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
                   
//                   recognizeTextInImage(image)
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
//            guard UserDefaults.standard.string(forKey: "recognizedQidText") != nil else{
//                let alert = UIAlertController(title: "Please try again." , message: "QID not captured.Please hold the ID close and ensure the image is correct", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//                return
//                
//            }
            
            
            
    //        UIImageWriteToSavedPhotosAlbum(croppedImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            let imageData = capturedImageView.image!.jpeg(.medium) as NSData?
            //let imageData = capturedImageView.image!.pngData() as NSData?
//            let imageDataHigh = capturedImageView.image!.jpeg(.high) as NSData?
            
//            print("image high - \n \(imageDataHigh)\n image med - \n\(imageData)")
            // Make sure to unwrap the optional UIImage properly
//            if let image = capturedImageView.image {
//                recognizeTextInImage(image)
//            } else {
//                print("Image is nil")
//            }
            //newphotoview
            
            self.defaults.set(imageData, forKey: "frontimage")
            
            strBase64 = imageData!.base64EncodedString(options: .lineLength64Characters)
            
            self.defaults.set(strBase64, forKey: "strBase64")
            
            
           // let seconds = 4.0
           // DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                // Put your code which should be executed with a delay here
                
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let vc: Photo2ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "photo2") as! Photo2ViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            //}
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
    
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    
    

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension Photo1ViewController:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func recognizeTextInImage(_ image: UIImage) {
        
        UserDefaults.standard.removeObject(forKey: "recognizedQidText")
        UserDefaults.standard.removeObject(forKey: "recognizedExpiryText")
        UserDefaults.standard.removeObject(forKey: "recognizedDOB")
        UserDefaults.standard.removeObject(forKey: "recognizedName")
        UserDefaults.standard.removeObject(forKey: "recognizedNationality")
        
        
        guard let cgImage = image.cgImage else {
            print("Unable to get CGImage from UIImage")
            return
        }
        
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
        var combinedText = ""
          for observation in observations {
              guard let bestCandidate = observation.topCandidates(1).first else { continue }
              combinedText += bestCandidate.string + " "
          }
        var numbers = [String]()
        var found11DigitNumber = false
        var dates = [Date]()
        var name: String?
        var nationality:String?
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        for observation in observations {
            guard let bestCandidate = observation.topCandidates(1).first else { continue }
            print("Found text: \(bestCandidate.string)")
            
            let text = bestCandidate.string
            
            // Extract 11-digit number
            let numberPattern = "\\b\\d{11}\\b"
            if let numberRange = text.range(of: numberPattern, options: .regularExpression) {
                let number = String(text[numberRange])
                numbers.append(number)
                found11DigitNumber = true
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
        
        // Extract name
        if let nameRange = combinedText.range(of: "Name: (.+)", options: .regularExpression) {
            let nameMatch = String(combinedText[nameRange])
            name = nameMatch.replacingOccurrences(of: "Name: ", with: "")
        }

       
        // Extract nationality from combined text
        
//        if let nationalityRange = combinedText.range(of: "Occupation:\\s*(.*$)", options: .regularExpression) {
//            let nationalityMatch = String(combinedText[nationalityRange])
//            nationality = nationalityMatch.replacingOccurrences(of: "Occupation:", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
//        }
//        if let range = combinedText.range(of: "Occupation:\\s*(\\S+)", options: .regularExpression) {
//            // Extract the matched nationality
//            nationality = combinedText[range].replacingOccurrences(of: "Occupation:", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
//            print("Extracted nationality: \(nationality)") // Output: INDIA
//        } else {
//            print("Nationality not found")
//        }

        if let nationalityRange = combinedText.range(of: "Nationality: ([A-Z]+)", options: .regularExpression) {
        let nationalityMatch = String(combinedText[nationalityRange])
        nationality = nationalityMatch.replacingOccurrences(of: "Nationality: ", with: "")
            
            print("Extracted nationality: \(nationality)")
            UserDefaults.standard.set(nationality, forKey: "nationalityName")
            UserDefaults.standard.set(nationality, forKey: "nationality")
        }else if let nationalityRange = combinedText.range(of: "Nationality ([A-Z]+)", options: .regularExpression) {
            let nationalityMatch = String(combinedText[nationalityRange])
            nationality = nationalityMatch.replacingOccurrences(of: "Nationality ", with: "")
                
                print("Extracted nationality \(nationality)")
                UserDefaults.standard.set(nationality, forKey: "nationalityName")
                UserDefaults.standard.set(nationality, forKey: "nationality")
        }
        
        
        if let nationalityRange = combinedText.range(of: "Occupation: ([A-Z]+)", options: .regularExpression) {
        let nationalityMatch = String(combinedText[nationalityRange])
        nationality = nationalityMatch.replacingOccurrences(of: "Occupation: ", with: "")
            
            print("Extracted nationality O: \(nationality)")
            UserDefaults.standard.set(nationality, forKey: "nationalityName")
            UserDefaults.standard.set(nationality, forKey: "nationality")
    } else  if let nationalityRange = combinedText.range(of: "Occupation ([A-Z]+)", options: .regularExpression) {
        let nationalityMatch = String(combinedText[nationalityRange])
        nationality = nationalityMatch.replacingOccurrences(of: "Occupation ", with: "")
            
            print("Extracted nationality O \(nationality)")
            UserDefaults.standard.set(nationality, forKey: "nationalityName")
            UserDefaults.standard.set(nationality, forKey: "nationality")
    }
    
        if found11DigitNumber {
            let numberString = numbers.joined(separator: "\n")
            UserDefaults.standard.set(numberString, forKey: "recognizedQidText")
            print("numberStringnumberString",numberString)
           
        } else {
          
            let alert = UIAlertController(title: "No 11-digit number found", message: "Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        // Assuming the first date found is DOB and the second is Expiry
            if dates.count >= 2 {
                let sortedDates = dates.sorted()
                dob = dateFormatter.string(from: sortedDates[0])
                self.expiryDate = dateFormatter.string(from: sortedDates[1])
                
                if let dob = dob {
                    UserDefaults.standard.set(dob, forKey: "recognizedDOB")
                    print("DOB found: \(dob)")
                }
                
                if let expiry = self.expiryDate {
                    UserDefaults.standard.set(expiry, forKey: "recognizedExpiryText")
                    print("Expiry date found: \(expiry)")
                }
            } else {
                let alert = UIAlertController(title: "Dates not found", message: "Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
      
        
        // Save and print extracted information
           if let name = name {
               UserDefaults.standard.set(name, forKey: "recognizedName")
               print("Name: \(name)")
           }
        
        if let nationality = nationality {
            UserDefaults.standard.set(nationality, forKey: "recognizedNationality")
            print("Nationality: \(nationality)")
        }
     
        if let nationality = nationality {
            UserDefaults.standard.set(nationality, forKey: "recognizedNationality")
            print("Nationality: \(nationality)")
        }
        
        // Check if both the 11-digit number and expiry date are found
                
        
        if found11DigitNumber && self.expiryDate != nil {
            
            if let recognizedText = UserDefaults.standard.string(forKey: "recognizedQidText"),
               let recognizedExpiryText = UserDefaults.standard.string(forKey: "recognizedExpiryText") {
                print("Recognized Text: \(recognizedText)")
                print("Recognized Expiry Date: \(recognizedExpiryText)")
                
              
                
            }
           
        }
    }
}

extension String {
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map { String(self[Range($0.range, in: self)!]) }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
