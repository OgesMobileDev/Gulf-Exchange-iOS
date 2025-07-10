//
//  ImagePopupView.swift
//  GulfExchangeApp
//
//  Created by macbook on 30/12/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import ScreenShield

class ImagePopupView: UIView {

    @IBOutlet weak var popupVideoView: UIView!
    @IBOutlet weak var contentBaseView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        ScreenShield.shared.protect(view: popupVideoView)
    }
    func setView(base64String: String){
        contentBaseView.clipsToBounds = true
        
        // Decode the base64 string to get the video data
        guard let videoData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            print("Failed to decode Base64 string.")
            return
        }
        
        // Save the video data to a temporary file
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempVideoURL = tempDirectory.appendingPathComponent("tempVideo.mp4")
        
        do {
            try videoData.write(to: tempVideoURL)
            print("Video file saved to: \(tempVideoURL)")
        } catch {
            print("Failed to save video file: \(error)")
            return
        }
        popupVideoView.isHidden = false
        // Create the AVPlayer instance with the video URL
        let player = AVPlayer(url: tempVideoURL)
        
        // Create a player layer to display the video
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = contentBaseView.bounds // Set the player layer frame (you can adjust it as needed)
        playerLayer.videoGravity = .resizeAspectFill // Optionally adjust the aspect ratio
        
        // Add the player layer to the current view
        self.contentBaseView.layer.addSublayer(playerLayer)
        
        // Start playback
        player.play()
        
        // Add observer for playback completion
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            print("Video playback completed.")
            
            // Optionally, reset the video to the beginning
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                // Your function call here
//                let data = ["player": true] as [String : Any]
//                NotificationCenter.default.post(name: playerFinishNotification, object: nil, userInfo: data)
//            }
//
            player.seek(to: .zero) // Reset the video to the beginning
        }
        
        // Optionally, you can add a custom UI to close the video (like a button) or perform other actions when the video ends.
    }
    
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
}
