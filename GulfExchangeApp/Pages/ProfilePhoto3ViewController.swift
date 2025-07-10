//
//  ProfilePhoto3ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 15/05/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation


class ProfilePhoto3ViewController: UIViewController,AVCapturePhotoCaptureDelegate {
    
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

    
    var selfielabelphotostr:String = ""
    
    var photovcyesstr:String = ""
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var strBase642:String!
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
        
        
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.title = NSLocalizedString("profile", comment: "")
        
        
        let showAlert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
                
                        let imageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 255, height: 260))
                        imageView.image = UIImage(named: "selfie")// Your image here...
                        showAlert.view.addSubview(imageView)
                        let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 350)
                        let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280)
                        showAlert.view.addConstraint(height)
                        showAlert.view.addConstraint(width)
                
                     let label = UILabel(frame: CGRect(x: 15, y: 255, width: 350, height: 60))
                     label.text = "Please take a selfie holding your ID"
                     label.font = label.font.withSize(16)
                     label.numberOfLines = 0
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

                }))
                self.present(showAlert, animated: true, completion: nil)

        
       
    }
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
        //let imageData = capturedImageView.image!.pngData() as NSData?
      let imageData = capturedImageView.image!.jpeg(.low) as NSData?
                   
                   strBase642 = imageData!.base64EncodedString(options: .lineLength64Characters)
                   
                   self.defaults.set(strBase642, forKey: "strBase642photo2")
        
        selfielabelphotostr = "  Selfie With ID Selected"
        self.defaults.set(selfielabelphotostr, forKey: "selfielabelphotostr")
        
        
        
        for controller in self.navigationController!.viewControllers as Array {
                             if controller.isKind(of: ProfileViewController.self) {
                                 self.navigationController!.popToViewController(controller, animated: true)
                                 break
                             }
                         }
//
//
//        let alertController = UIAlertController(title: "Selfie with ID selected", message: "", preferredStyle: .alert)
//
//          // Create the actions
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//              UIAlertAction in
//              NSLog("OK Pressed")
//
//            //self.navigationController?.popViewController(animated: true)//oneviewwcontroller direct
//   for controller in self.navigationController!.viewControllers as Array {
//                        if controller.isKind(of: ProfileViewController.self) {
//                            self.navigationController!.popToViewController(controller, animated: true)
//                            break
//                        }
//                    }
//
//
//
//          }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//              UIAlertAction in
//              NSLog("Cancel Pressed")
//          }

          // Add the actions
//          alertController.addAction(okAction)
//          //alertController.addAction(cancelAction)
//
//          // Present the controller
//        self.present(alertController, animated: true, completion: nil)
        
        
        
        
        
        //self.navigationController?.popViewController(animated: true)//oneviewwcontroller direct
//for controller in self.navigationController!.viewControllers as Array {
//                    if controller.isKind(of: ProfileViewController.self) {
//                        self.navigationController!.popToViewController(controller, animated: true)
//                        break
//                    }
//                }
//
        
//                   self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//                   let vc: RegisterPage1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "reg1") as! RegisterPage1ViewController
//                   self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func cancelPhotoPressed(_ sender: Any) {
         previewViewLayerMode(image: nil, isCameraMode: true)
    }
    @IBAction func switchCamBtn(_ sender: Any) {
        switchCamera()
    }
    func switchCamera(){
        //Change camera source
        if let session = captureSession {
            //Remove existing input
            guard let currentCameraInput: AVCaptureInput = session.inputs.first else {
                return
            }

            //Indicate that some changes will be made to the session
            session.beginConfiguration()
            session.removeInput(currentCameraInput)

            //Get new input
            var newCamera: AVCaptureDevice! = nil
            if let input = currentCameraInput as? AVCaptureDeviceInput {
                if (input.device.position == .back) {
                    newCamera = cameraWithPosition(position: .front)
                } else {
                    newCamera = cameraWithPosition(position: .back)
                }
            }

            //Add input to session
            var err: NSError?
            var newVideoInput: AVCaptureDeviceInput!
            do {
                newVideoInput = try AVCaptureDeviceInput(device: newCamera)
            } catch let err1 as NSError {
                err = err1
                newVideoInput = nil
            }

            if newVideoInput == nil || err != nil {
                print("Error creating capture device input: \(err?.localizedDescription)")
            } else {
                session.addInput(newVideoInput)
            }

            //Commit all the configuration changes at once
            session.commitConfiguration()
        }
    }
    // Find a camera with the specified AVCaptureDevicePosition, returning nil if one is not found
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        for device in discoverySession.devices {
            if device.position == position {
                return device
            }
        }

        return nil
    }
    
    
}
