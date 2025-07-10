//
//  TakePhoto1ViewController.swift
//  GulfExchangeApp
//
//  Created by test on 21/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

extension UIImageView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

class TakePhoto1ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }

       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        let imageSize = CGSize(width: previewView.frame.size.width-50, height: 200)
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
                   }          }
      }
  

    @IBAction func actionCameraCapture(_ sender: Any) {
        var photoSettings: AVCapturePhotoSettings
        
      if #available(iOS 11.0, *) {
        photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
      } else {
        photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecJPEG])
      }
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.flashMode = .auto
        
        // AVCapturePhotoCaptureDelegate
        self.stillImageOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    @IBAction func savePhotoPressed(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(croppedImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            
            let alertController = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert: UIAlertAction!) in
                self.previewViewLayerMode(image: nil, isCameraMode: true)
            }))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Saved", message: "Captured guided image saved successfully.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert: UIAlertAction!) in
                self.previewViewLayerMode(image: nil, isCameraMode: true)
            }))
            present(alertController, animated: true)
        }
    }
    @IBAction func cancelPhotoPressed(_ sender: Any) {
        previewViewLayerMode(image: nil, isCameraMode: true)
    }
    
}
