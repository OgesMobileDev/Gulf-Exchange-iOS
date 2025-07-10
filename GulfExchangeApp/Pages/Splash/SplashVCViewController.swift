//
//  SplashVCViewController.swift
//  GulfExchangeApp
//
//  Created by Philip on 29/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
//import MediaPlayer
import AVFoundation
import AVKit

class SplashVCViewController: UIViewController {
    
    var player: AVPlayer?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.removeObject(forKey: "AppBackgroundTime")
        self.navigationController?.isNavigationBarHidden = true
      if #available(iOS 13.0, *) {
        self.view.overrideUserInterfaceStyle = .light
      } else {
        // Fallback on earlier versions
      }
        self.loadVideo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        defaults.set(false, forKey: "isLoggedIN")
        defaults.removeObject(forKey: "AppBackgroundTime")
        APIManager.shared.fetchToken { token in
            if let accessToken = token {
                APIManager.shared.updateSession(sessionType: "2", accessToken: accessToken) { responseCode in
                    print("Session Timeout API called, ResponseCode: \(responseCode)")
                    
                }
            }
        }
    }
    private func loadVideoOld() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        } catch { }

        let path = Bundle.main.path(forResource: "landing_page", ofType:"mp4")

        player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)

        NotificationCenter.default.addObserver(self,
                                                      selector: #selector(playerItemDidReachEnd),
                                                                name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                                object: nil) // Add observer

        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        playerLayer.zPosition = -1

        self.view.layer.addSublayer(playerLayer)

        player?.seek(to: CMTime.zero)
        player?.play()
        
    }
    private func loadVideo() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        } catch {
            print("Failed to set audio session category: \(error)")
        }

        guard let path = Bundle.main.path(forResource: "landing_page", ofType: "mp4") else {
            print("Video not found!")
            return
        }

        player = AVPlayer(url: NSURL(fileURLWithPath: path) as URL)
        let playerLayer = AVPlayerLayer(player: player)

        // Add observer specific to this player's item
        if let playerItem = player?.currentItem {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(playerItemDidReachEnd),
                name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                object: playerItem // Listen only to this player's item
            )
        }

        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        playerLayer.zPosition = -1

        self.view.layer.addSublayer(playerLayer)

        player?.seek(to: CMTime.zero)
        player?.play()
    }

    @objc func playerItemDidReachEnd(notification: NSNotification) {
        
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationItem.hidesBackButton = true
        
        if (UserDefaults.standard.string(forKey: "appLang") != nil){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main11", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LanguageSelectorViewController") as! LanguageSelectorViewController
            nextViewController.isFromSettings = false
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "trial", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPinPasswordViewController") as! ResetPinPasswordViewController
//        LanguageSelectorViewController
        
        
        /*
        if (UserDefaults.standard.string(forKey: "appLang") != nil){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(initialViewController, animated: true)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Lang") as! SelectLanguageViewController
          initialViewController.isFromSettings = false
            self.navigationController?.pushViewController(initialViewController, animated: true)
        }*/
    }
    // Remove Observer
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    deinit {
        if let playerItem = player?.currentItem {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        }
    }


}
