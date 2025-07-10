//
//  ProfilePhoto1ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 15/05/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ProfilePhoto1ViewController: UIViewController,AVCapturePhotoCaptureDelegate {
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
    
    var timer = Timer()

    
    var frontlabelphotostr:String = ""
    var photovcyesstr:String = ""
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var strBase64:String!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        photovcyesstr = "yes"
        self.defaults.set(photovcyesstr, forKey: "photovcyesstr")
        
//        //newbackbtn
//        let custmBackBtn = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .done, target: self, action: #selector(Backbtnaction))
//        self.navigationItem.leftBarButtonItem  = custmBackBtn
        
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("profile", comment: "")
       
       
    }
    
//    @objc func Backbtnaction()
//    {
//
//        print("front---","fff")
//        for controller in self.navigationController!.viewControllers as Array {
//                             if controller.isKind(of: ProfileViewController.self) {
//                                 self.navigationController!.popToViewController(controller, animated: true)
//                                 break
//                             }
//                         }
//    }
    
    
    @objc func heplVCAction(){
        
        timer.invalidate()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
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
    //        UIImageWriteToSavedPhotosAlbum(croppedImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
          let imageData = capturedImageView.image!.jpeg1(.medium) as NSData?
            //let imageData = capturedImageView.image!.pngData() as NSData?

            
            strBase64 = imageData!.base64EncodedString(options: .lineLength64Characters)
            
            self.defaults.set(strBase64, forKey: "strBase64photo")
            
            frontlabelphotostr = "  Front ID Selected"
            self.defaults.set(frontlabelphotostr, forKey: "frontlabelphotostr")
            
            
            for controller in self.navigationController!.viewControllers as Array {
                                 if controller.isKind(of: ProfileViewController.self) {
                                     self.navigationController!.popToViewController(controller, animated: true)
                                     break
                                 }
                             }
            
            
//            let alertController = UIAlertController(title: "Front ID selected", message: "", preferredStyle: .alert)
//
//              // Create the actions
//            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//                  UIAlertAction in
//                  NSLog("OK Pressed")
//
//                //self.navigationController?.popViewController(animated: true)//oneviewwcontroller direct
//       for controller in self.navigationController!.viewControllers as Array {
//                            if controller.isKind(of: ProfileViewController.self) {
//                                self.navigationController!.popToViewController(controller, animated: true)
//                                break
//                            }
//                        }
//
//
//
//              }
    //        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
    //              UIAlertAction in
    //              NSLog("Cancel Pressed")
    //          }

              // Add the actions
//              alertController.addAction(okAction)
//              //alertController.addAction(cancelAction)
//
//              // Present the controller
//            self.present(alertController, animated: true, completion: nil)
//
//
            
        
            
            
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let vc: Photo2ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "photo2") as! Photo2ViewController
//            self.navigationController?.pushViewController(vc, animated: true)
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
    enum JPEGQuality1: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    
    

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg1(_ jpegQuality: JPEGQuality1) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
