//
//  RegisterVideo1VC.swift
//  GulfExchangeApp
//
//  Created by macbook on 24/01/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON
import ScreenShield

class RegisterVideo1VC: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordBtnView: UIView!
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel! // Timer Label
    @IBOutlet weak var videoPreviewBase: UIView!
    @IBOutlet weak var videoPreview: UIImageView!
    
    @IBOutlet weak var transparentView: UIView!
    
    // Video Recording Properties
    var captureSession: AVCaptureSession!
    var videoOutput: AVCaptureMovieFileOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var recordedVideoURL: URL?
    var compressedVideoURL: URL?
    var player: AVPlayer?
    var timer: Timer?
    var timerCount = 3
    var base64String:String = ""
    var token:String = ""
    var referenceNo:String = ""
    let defaults = UserDefaults.standard
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var touchBlockerView: UIView?
    
    var reference:String = ""
    var proof:String = ""
    var additionalProof:String = ""
    var faceProof:String = ""
    var accessToken:String = ""
    var verificationVideo:String = ""
    var verificationReport:String = ""
    var fullName:String = ""
    var dob:String = ""
    var expiryDate:String = ""
    var documentNumber:String = ""
    var fullNameNative:String = ""
    var nationality:String = ""
    
    var strBase64:String = ""
    var strBase641:String = ""
    var strBase64Selfie:String = ""
    
    var verificationType:VerificationFlow = .register
    
    var idImageFrontData: Data?
    var idImageBackData: Data?
    var idImageSelfieVideoData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentView.clipsToBounds = true
        addOvalMaskOverlay()
        titleLbl.text = NSLocalizedString("Take a selfie while holding your ID.", comment: "")
        recordButton.setTitle("", for: .normal)
        videoPreview.isHidden = true
        videoPreviewBase.isHidden = true
        addNavbar()
        previewView.clipsToBounds = true
        retakeButton.isHidden = true
        okButton.isHidden = true
        timerLabel.isHidden = true
        setupCamera()
        updateUIForRecording()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
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
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        startTimer()
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory() + "SelfieVideo.mov")
        if FileManager.default.fileExists(atPath: tempURL.path) {
            try? FileManager.default.removeItem(at: tempURL)
        }
        videoOutput.startRecording(to: tempURL, recordingDelegate: self)
    }
    @IBAction func retakeButtonTapped(_ sender: UIButton) {
        resetRecording()
        updateUIForRecording()
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        guard let videoURL = recordedVideoURL else { return }
        do {
            // Usage
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("compressed_video.mp4")
//            let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("compressedVideo.mp4")
            compressVideoToMaxSize(inputURL: videoURL, outputURL: tempURL, maxSizeInMB: 30.0) { compressedURL in
                if let compressedURL = compressedURL {
                    do{
                        let videoData = try Data(contentsOf: compressedURL)
                        let base64String = videoData.base64EncodedString()
                        print("converted compressed video to Base64")
                        self.defaults.set(base64String, forKey: "strBase64video")
                        self.idImageSelfieVideoData = videoData
//                        self.navigateToLoading()
                        DispatchQueue.main.async {
                            self.removeActivityIndicator()
                            self.navigateToLoading()
                        }
                    }catch{
                        print("Error converting video to Base64: \(error)")
                    }
                    
                    
                }
            }
        }
        
        
//        guard let videoURL = recordedVideoURL else { return }
//        do {
//            
//            let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("compressed_video.mp4")
//            
//            compressVideo(inputURL: videoURL, outputURL: outputURL, maxSizeInMB: 3.0) { compressedURL in
//                if let url = compressedURL {
//                    do{
//                        let videoData = try Data(contentsOf: url)
//                        let base64String = videoData.base64EncodedString()
//                        print("converted compressed video to Base64")
//                        self.defaults.set(base64String, forKey: "strBase64video")
//                    }catch{
//                        print("Error converting video to Base64: \(error)")
//                    }
//                } else {
//                    print("Compression failed")
//                }
//            }
//        }
        
//        guard let videoURL = recordedVideoURL else { return }
//        do {
//            let videoData = try Data(contentsOf: videoURL)
//            let base64String = videoData.base64EncodedString()
//            //                    print("Base64 Encoded Video: \(base64String)")
//            print("converted video to Base64")
//            self.defaults.set(base64String, forKey: "strBase64video")
//            self.strBase64Selfie = base64String
//        } catch {
//            print("Error converting video to Base64: \(error)")
//        }
        
        
        
        //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        //        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterReviewVC") as! RegisterReviewVC
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
        
//        print("navigateToLoading")
//        navigateToLoading()
        
//        getToken()
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
    @objc func previewTapped() {
        guard let videoURL = recordedVideoURL else { return }
        
        // Initialize the player
        player = AVPlayer(url: videoURL)
        
        // Ensure the playerLayer is recreated for the current video
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = previewView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        
        // Remove existing sublayers (if any) and add the new playerLayer
        previewView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        previewView.layer.addSublayer(playerLayer)
        self.videoPreview.isHidden = true
        self.videoPreviewBase.isHidden = true
        // Play the video
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )
        
        player?.play()
    }
    
    @objc func videoDidFinishPlaying() {
        print("Video playback finished.")
        
        // Unhide video preview or any other actions
        videoPreview.isHidden = false
        videoPreviewBase.isHidden = false
        
        // Optionally, remove the observer if it's specific to this playback
        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )
    }
    func navigateToLoading(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterLoadingVC") as! RegisterLoadingVC
        nextViewController.strBase64 = self.strBase64
        nextViewController.strBase641 = self.strBase641
        nextViewController.strBase64Selfie = self.strBase64Selfie
        nextViewController.verificationType = self.verificationType
        nextViewController.idImageBackData = self.idImageBackData
        nextViewController.idImageFrontData = self.idImageFrontData
        nextViewController.idImageSelfieVideoData = self.idImageSelfieVideoData
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func addOvalMaskOverlay() {
        let overlay = OvalMaskView(frame: view.bounds)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        transparentView.addSubview(overlay)

        // Constraints to make the overlay cover the entire screen
        NSLayoutConstraint.activate([
            overlay.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor),
            overlay.topAnchor.constraint(equalTo: transparentView.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor)
        ])
    }

    
    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoInput) else {
            print("Error: Unable to access camera")
            return
        }
        
        captureSession.addInput(videoInput)
        
        videoOutput = AVCaptureMovieFileOutput()
        guard captureSession.canAddOutput(videoOutput) else {
            print("Error: Unable to add video output")
            return
        }
        captureSession.addOutput(videoOutput)
        previewView.subviews.forEach { $0.removeFromSuperview() }
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = previewView.bounds
        previewView.layer.addSublayer(videoPreviewLayer)
        
        captureSession.startRunning()
    }
    func startTimer() {
        timerCount = 3
        timerLabel.text = "00:03"
        timerLabel.isHidden = false
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timerCount -= 1
            self.timerLabel.text = "00:0\(self.timerCount)"
            if self.timerCount == 0 {
                self.timer?.invalidate()
                self.timerLabel.isHidden = true
                self.videoOutput.stopRecording()
                //                    guard let videoURL = self.recordedVideoURL else { return }
                //                            do {
                //                                let videoData = try Data(contentsOf: videoURL)
                //                                let base64String = videoData.base64EncodedString()
                //            //                    print("Base64 Encoded Video: \(base64String)")
                //                                self.defaults.set(base64String, forKey: "strBase64video")
                //                            } catch {
                //                                print("Error converting video to Base64: \(error)")
                //                            }
                self.updateUIForPlayback()
            }
        }
    }
    
    func resetRecording() {
        if let player = player {
            player.pause()
            self.player = nil
        }
        videoPreview.isHidden = true
        videoPreviewBase.isHidden = true
        recordedVideoURL = nil
        previewView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        previewView.layer.addSublayer(videoPreviewLayer)
    }
    
    func updateUIForRecording() {
        transparentView.isHidden = false
        recordButton.isHidden = false
        recordBtnView.isHidden = false
        retakeButton.isHidden = true
        okButton.isHidden = true
        timerLabel.text = ""
    }
    
    func updateUIForPlayback() {
        //            displayThumbnail()
        transparentView.isHidden = true
        recordButton.isHidden = true
        recordBtnView.isHidden = true
        retakeButton.isHidden = false
        okButton.isHidden = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(previewTapped))
        videoPreviewBase.addGestureRecognizer(tapGesture)
        //            videoPreview.addGestureRecognizer(tapGesture)
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
//            let image1 = UIImage(named: "r_selfie_img")
            return image
        } catch {
            print("Error generating thumbnail: \(error)")
            let image = UIImage(named: "dummy_video_preview")
            return image
        }
    }
    

    func compressVideoToMaxSize(inputURL: URL, outputURL: URL, maxSizeInMB: Double, completion: @escaping (URL?) -> Void) {
        let maxSizeInBytes = Int(maxSizeInMB * 1024 * 1024) // Convert MB to Bytes
        let asset = AVAsset(url: inputURL)

        // Ensure output URL is valid
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: outputURL.path) {
            do {
                try fileManager.removeItem(at: outputURL)
            } catch {
                print("Error deleting existing file: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }

        // Choose best preset for compression
        let presets = AVAssetExportSession.exportPresets(compatibleWith: asset)
        let preset = presets.contains(AVAssetExportPresetMediumQuality) ? AVAssetExportPresetMediumQuality : AVAssetExportPresetLowQuality

        guard let exportSession = AVAssetExportSession(asset: asset, presetName: preset) else {
            print("Failed to create export session")
            completion(nil)
            return
        }

        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        exportSession.shouldOptimizeForNetworkUse = true

        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                do {
                    let attributes = try fileManager.attributesOfItem(atPath: outputURL.path)
                    if let fileSize = attributes[.size] as? NSNumber, fileSize.intValue <= maxSizeInBytes {
                        print("Compressed Video Size: \(Double(fileSize.intValue) / 1024.0 / 1024.0) MB")
                        completion(outputURL)
                    } else {
                        print("Video exceeds size limit. Try lowering the quality.")
                        completion(nil)
                    }
                } catch {
                    print("Error checking file size: \(error.localizedDescription)")
                    completion(nil)
                }
            case .failed:
                print("Video compression failed: \(exportSession.error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            case .cancelled:
                print("Video compression cancelled.")
                completion(nil)
            default:
                break
            }
        }
    }

    
    func compressVideo(inputURL: URL, outputURL: URL, maxSizeInMB: Double, completion: @escaping (URL?) -> Void) {
        let asset = AVAsset(url: inputURL)
        
        guard let videoTrack = asset.tracks(withMediaType: .video).first else {
            print("No video track found")
            completion(nil)
            return
        }
        
        // Calculate target bitrate (Max Size / Duration)
        let duration = CMTimeGetSeconds(asset.duration)
        let targetBitrate = (maxSizeInMB * 8_000_000) / duration // Convert MB to bits
        
        let videoSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: videoTrack.naturalSize.width,
            AVVideoHeightKey: videoTrack.naturalSize.height,
            AVVideoCompressionPropertiesKey: [
                AVVideoAverageBitRateKey: targetBitrate,
                AVVideoProfileLevelKey: AVVideoProfileLevelH264High40
            ]
        ]
        
        let reader: AVAssetReader
        let writer: AVAssetWriter
        
        do {
            reader = try AVAssetReader(asset: asset)
            writer = try AVAssetWriter(outputURL: outputURL, fileType: .mp4)
        } catch {
            print("Error creating reader/writer: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        
        let videoOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: nil)

        
        reader.add(videoOutput)
        
        let videoInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)

        
        videoInput.expectsMediaDataInRealTime = false
        writer.add(videoInput)
        
        writer.startWriting()
        reader.startReading()
        writer.startSession(atSourceTime: .zero)
        
        videoInput.requestMediaDataWhenReady(on: DispatchQueue.global()) {
            while videoInput.isReadyForMoreMediaData {
                if let sampleBuffer = videoOutput.copyNextSampleBuffer() {
                    videoInput.append(sampleBuffer)
                } else {
                    videoInput.markAsFinished()
                    writer.finishWriting {
                        do {
                            let fileAttributes = try FileManager.default.attributesOfItem(atPath: outputURL.path)
                            if let fileSize = fileAttributes[.size] as? NSNumber {
                                let videoSizeInBytes = fileSize.intValue
                                let videoSizeInKB = Double(videoSizeInBytes) / 1024.0
                                let videoSizeInMB = videoSizeInKB / 1024.0
                                print("converted Video Size: \(videoSizeInMB) MB)")
                            }
                        } catch {
                            print("Failed to get video file size: \(error.localizedDescription)")
                        }
                        completion(outputURL)
                    }
                    break
                }
            }
        }
    }
    
    func activityIndicator(_ title: String) {
        // Remove any existing components
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        touchBlockerView?.removeFromSuperview()
        
        // Create and configure the touch blocker view
        touchBlockerView = UIView(frame: view.bounds)
        touchBlockerView?.backgroundColor = UIColor(white: 0, alpha: 0.1) // Slightly transparent background
        touchBlockerView?.isUserInteractionEnabled = true // Intercept all touches
        view.addSubview(touchBlockerView!)
        
        // Configure the activity indicator and its label
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(
            x: view.frame.midX - strLabel.frame.width / 2,
            y: view.frame.midY - strLabel.frame.height / 2,
            width: 160,
            height: 46
        )
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    func removeActivityIndicator() {
        effectView.removeFromSuperview()
        touchBlockerView?.removeFromSuperview()
        touchBlockerView = nil
    }
    
    /*func activityIndicator(_ title: String) {
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
    }*/
    func convertDateFormat(from dateString: String) -> String? {
        let inputDateFormat = "yyyy-MM-dd"
        let outputDateFormat = "dd-MM-yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        dateFormatter.dateFormat = outputDateFormat
        return dateFormatter.string(from: date)
    }
    
    func saveData(){
        self.defaults.removeObject(forKey: "shufti_reference")
        self.defaults.removeObject(forKey: "shufti_photo1")
        self.defaults.removeObject(forKey: "shufti_photo2")
        self.defaults.removeObject(forKey: "shufti_access_token")
        self.defaults.removeObject(forKey: "shufti_video")
        self.defaults.removeObject(forKey: "shufti_verification_report")
        self.defaults.removeObject(forKey: "name_en")
        self.defaults.removeObject(forKey: "shufti_dob")
        self.defaults.removeObject(forKey: "dob")
        self.defaults.removeObject(forKey: "shufti_id_exp_date")
        self.defaults.removeObject(forKey: "id_exp_date")
        self.defaults.removeObject(forKey: "id_no")
        self.defaults.removeObject(forKey: "name_ar")
        self.defaults.removeObject(forKey: "shufti_nationality")
        let dob1 = convertDateFormat(from: self.dob)
        let expiryDate1 = convertDateFormat(from: self.expiryDate)
        self.defaults.set(dob1, forKey: "dob")
        self.defaults.set(expiryDate1, forKey: "id_exp_date")
        self.defaults.set(self.reference, forKey: "shufti_reference")
        self.defaults.set(self.proof, forKey: "shufti_photo1")
        self.defaults.set(self.additionalProof, forKey: "shufti_photo2")
        self.defaults.set(self.accessToken, forKey: "shufti_access_token")
        self.defaults.set(self.verificationVideo, forKey: "shufti_video")
        self.defaults.set(self.verificationReport, forKey: "shufti_verification_report")
        self.defaults.set(self.fullName, forKey: "name_en")
        self.defaults.set(self.dob, forKey: "shufti_dob")
        self.defaults.set(self.expiryDate, forKey: "shufti_id_exp_date")
        self.defaults.set(self.documentNumber, forKey: "id_no")
        self.defaults.set(self.fullNameNative, forKey: "name_ar")
        self.defaults.set(self.nationality, forKey: "shufti_nationality")
        
        print("reference",reference,"\n")
        print("proof",proof,"\n")
        print("additionalProof",additionalProof,"\n")
        print("accessToken",accessToken,"\n")
        print("verificationVideo",verificationVideo,"\n")
        print("verificationReport",verificationReport,"\n")
        print("fullName",fullName,"\n")
        print("dob",dob,"\n")
        print("expiryDate",expiryDate,"\n")
        print("documentNumber",documentNumber,"\n")
        print("fullNameNative",fullNameNative,"\n")
        print("nationality",nationality,"\n")
        navigate()
    }
    func navigate(){
        let isRegisteredCust =  defaults.string(forKey: "neworexistcuststr") ?? ""
        if isRegisteredCust == "B"{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetailsOld1VC") as! RegisterIdDetailsOld1VC
            self.navigationController?.pushViewController(nextViewController, animated: true)

        }else if isRegisteredCust == "N"{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "MainReg", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterIdDetails1VC") as! RegisterIdDetails1VC
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    
    //MARK: - API Calls
    
    func getToken() {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "oauth/token?grant_type=" + auth_grant_type + "&username=" + auth_username + "&password=" + auth_password
        
        let str_encode_val = auth_client_id + ":" + auth_client_secret
        let encodedValue = str_encode_val.data(using: .utf8)?.base64EncodedString()
        let headers:HTTPHeaders = ["Authorization" : "Basic \(encodedValue ?? "")"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("response",response)
            //self.effectView.removeFromSuperview()
            self.removeActivityIndicator()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let token:String = myresult!["access_token"].string!
                print("token  ",token)
                self.getReferenceId(access_token: token)
                break
            case .failure:
                break
            }
            
        })
    }
    func getReferenceId(access_token:String) {
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = ge_api_url_new + "utilityservice/referenceGeneration"
        let params:Parameters =  ["device":"IOS"]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(access_token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("resp",response)
            //self.effectView.removeFromSuperview()
            self.removeActivityIndicator()
            switch response.result{
            case .success:
                let myResult = try? JSON(data: response.data!)
                let responseCode = myResult!["responseCode"].stringValue
                
                if(responseCode == "200")
                {
                    let referenceNo = myResult!["referenceNo"].stringValue
                    self.referenceNo = referenceNo
                    self.redirectShuftiPro(referenceNo: referenceNo)
                }
                else{
                    
                }
                break
            case .failure:
                break
            }
            
            
        })
    }
    
    func redirectShuftiPro(referenceNo:String){
        /*
         secret key - asyyQCtOpKUIj2LPgkmcv46n4v6L8wov
         client ID - bd9666ed913a4224a5df94a20364375cd5720553f8d3b48cf9f6c626e0a82c9a
         */
        let originalString = "bd9666ed913a4224a5df94a20364375cd5720553f8d3b48cf9f6c626e0a82c9a:asyyQCtOpKUIj2LPgkmcv46n4v6L8wov"
        if let data = originalString.data(using: .utf8) {
            let base64EncodedString = data.base64EncodedString()
            print("Base64 Encoded String: \(base64EncodedString)")
            self.base64String = base64EncodedString
        }
        if !base64String.isEmpty{
            self.getShuftiToken(referenceNo: referenceNo, num: 1)
        }
        
    }
    
    func getShuftiToken(referenceNo:String, num: Int){
        print("getShuftiToken referenceNo",referenceNo)
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = shuftiproApi + "get/access/token"
        let headers:HTTPHeaders = ["Authorization" : "Basic \(base64String )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("resp",response)
            //self.effectView.removeFromSuperview()
            self.removeActivityIndicator()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let token:String = myresult!["access_token"].string!
                print("getShuftiToken",token)
                if num == 1{
                    self.navigateShufti(token: token, referenceNo: referenceNo)
                }
                if num == 2{
                    self.checkStatus(token: token, referenceNo: referenceNo)
                }
                break
            case .failure:
                break
            }
            
            
        })
    }
    
    func navigateShufti(token: String, referenceNo: String){
        let strBase64 = defaults.string(forKey: "strBase64")
        let strBase641 = defaults.string(forKey: "strBase641")
        let strBase64Selfie = defaults.string(forKey: "strBase64video")
        
        self.activityIndicator(NSLocalizedString("loading", comment: ""))
        let url = shuftiproApi
        
        let params:Parameters = [
            "reference": referenceNo,
            "country": "",
            "language": "en",
            //            "redirect_url": "https://info.ogesinfotech.com",
            "email": "",
            "verification_mode": "any",
            "allow_persistentidv": "1",
            "show_feedback_form": "0",
            "face": [
                "proof": strBase64Selfie,
                "check_duplicate_request": 0 // Pass 1 or 0, 1 for true and 0 for false.
            ],
            "document": [
                "proof": strBase64,
                "additional_proof": strBase641,
                "backside_proof_required": "1",
                "process_only_ocr": "1", // Uncommented
                "fetch_enhanced_data": "1", // Uncommented
                "verification_instructions": [ // Uncommented
                    "allow_screenshot": "1", // Uncommented
                    "allow_scanned": "1" // Uncommented
                                             ],
                "supported_types": ["id_card"], // Pass the type of cards need to validate.
                "document_number": "",
                "allow_offline": "0",
                "allow_online": "1",
                "age": "",
                "name": "",
                "dob": "",
                "issue_date": "",
                "expiry_date": "",
                "nationality": "",
                "arabic_name": "",
                "occupation": ""
            ]
            
        ]
        
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("navigateShufti response",response)
            //self.effectView.removeFromSuperview()
            self.removeActivityIndicator()
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let event:String = myresult!["event"].stringValue
                if event == "verification.declined"{
                    let declined_reason = myresult!["declined_reason"].stringValue
                    showAlert(title: "Error ", message: "\(declined_reason)\n Try again.")
                }else if event == "verification.accepted"{
                    self.getShuftiToken(referenceNo: referenceNo, num: 2)
                }
                break
            case .failure:
                break
            }
            
            
        })
        
    }
    
    // verification success
    
    func checkStatus(token: String, referenceNo: String){
        let url = shuftiproApi + "status"
        let params:Parameters =  [
            "reference": referenceNo
        ]
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(token )"]
        
        IDVerificationBaseVC.AlamoFireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("checkStatus Response",response)
            
            switch response.result{
            case .success(let value):
                // Safely parse the response as a dictionary
                if let json = value as? [String: Any] {
                    // Extract fields from the root level
                    let reference = json["reference"] as? String ?? ""
                    self.reference = reference
                    if let proofs = json["proofs"] as? [String: Any],
                       let document = proofs["document"] as? [String: Any]{
                        let proof = document["proof"] as? String ?? ""
                        self.proof = proof
                        let additional_proof = document["additional_proof"] as? String ?? ""
                        self.additionalProof = additional_proof
                    }
                    if let proofs = json["proofs"] as? [String: Any],
                       let face = proofs["face"] as? [String: Any]{
                        let faceProof = face["proof"] as? String ?? ""
                        self.faceProof = faceProof
                    }
                    if let proofs = json["proofs"] as? [String: Any]{
                        let access_token = proofs["access_token"] as? String ?? ""
                        self.accessToken = access_token
//                        let verification_video = proofs["verification_video"] as? String ?? ""
//                        self.verificationVideo = verification_video
                        let verification_report = proofs["verification_report"] as? String ?? ""
                        self.verificationReport = verification_report
                    }
                    
                    if let additional_data = json["additional_data"] as? [String: Any],
                       let document = additional_data["document"] as? [String: Any],
                       let proof = document["proof"] as? [String: Any]{
                        let document_number = proof["document_number"] as? String ?? ""
                        self.documentNumber = document_number
                        let dob = proof["dob"] as? String ?? ""
                        self.dob = dob
                        let expiry_date = proof["expiry_date"] as? String ?? ""
                        self.expiryDate = expiry_date
                        let full_name = proof["full_name"] as? String ?? ""
                        self.fullName = full_name
                        let full_name_native = proof["full_name_native"] as? String ?? ""
                        self.fullNameNative = full_name_native
                        let nationality = proof["nationality"] as? String ?? ""
                        self.nationality = nationality
                    }
                    self.saveData()
                }
                break
            case .failure:
                break
            }
            
            
        })
    }
    
}
extension RegisterVideo1VC: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if error == nil {
            
            recordedVideoURL = outputFileURL
            print("Recording finished: \(outputFileURL)")
            
            // Generate the thumbnail
            if let thumbnailImage = generateThumbnail(for: outputFileURL) {
                // Display the thumbnail on the previewView
                DispatchQueue.main.async {
                    //                           let imageView = UIImageView(image: thumbnailImage)
                    //                           imageView.frame = self.previewView.bounds
                    //                           imageView.contentMode = .scaleAspectFill
                    //                           imageView.clipsToBounds = true
                    
                    // Remove any existing subviews before adding the thumbnail
                    self.videoPreview.isHidden = false
                    self.videoPreviewBase.isHidden = false
                    self.videoPreview.contentMode = .scaleAspectFill
                    self.videoPreview.image = thumbnailImage
                    //                           self.previewView.subviews.forEach { $0.removeFromSuperview() }
                    //                           self.previewView.addSubview(imageView)
                }
            }
            
            if let videoURL = recordedVideoURL {
                do {
                    let fileAttributes = try FileManager.default.attributesOfItem(atPath: videoURL.path)
                    if let fileSize = fileAttributes[.size] as? NSNumber {
                        let videoSizeInBytes = fileSize.intValue
                        let videoSizeInKB = Double(videoSizeInBytes) / 1024.0
                        let videoSizeInMB = videoSizeInKB / 1024.0
                        print("Video Size: \(videoSizeInMB) MB)")
                    }
                } catch {
                    print("Failed to get video file size: \(error.localizedDescription)")
                }
            } else {
                print("Video URL is nil")
            }
        } else {
            print("Recording error: \(error!)")
        }
    }
}




class OvalMaskView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Full-screen path
        let fullScreenPath = UIBezierPath(rect: bounds)

        // Oval cutout path (adjust x, y, width, and height accordingly)
        let ovalWidth: CGFloat = bounds.width * 0.7
        let ovalHeight: CGFloat = ovalWidth * 1.3
        let ovalX = (bounds.width - ovalWidth) / 2
        let ovalY = (bounds.height - ovalHeight) / 3

        let ovalPath = UIBezierPath(ovalIn: CGRect(x: ovalX, y: ovalY, width: ovalWidth, height: ovalHeight))

        // Append the oval path to the full-screen path
        fullScreenPath.append(ovalPath)
        fullScreenPath.usesEvenOddFillRule = true

        // Set the dark background color
        context.setFillColor(UIColor.black.withAlphaComponent(0.6).cgColor)
        context.setBlendMode(.normal)
        context.addPath(fullScreenPath.cgPath)
        context.fillPath(using: .evenOdd)
    }
}
