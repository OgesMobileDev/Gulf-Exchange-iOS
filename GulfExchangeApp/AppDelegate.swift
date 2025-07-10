//
//  AppDelegate.swift
//  GulfExchangeApp
//
//  Created by test on 20/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager
import Firebase
import FirebaseCore

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
weak var screen : UIView? = nil
    // rotation
    var restrictRotation: UIInterfaceOrientationMask = .all // Default rotation behavior for the app

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return restrictRotation
    }
    // rotation
    func sharedInstance() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //comentedjailbreak
        //jailbreak
//        if  detectJailbreak() {
//                // Exit the app if a jailbroken device is detected
//                exit(0)
//            }
//
//
//        //new
//       if isJailbroken() {
//                    // Perform actions when a jailbroken device is detected
//                    // For example, you might display an alert or restrict functionalities
//                    showJailbreakDetectedAlert()
//                }

        
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardToolbarManager.shared.isEnabled = true
        
        FirebaseApp.configure()
        let check = isKeyPresentInUserDefaults(key: "appLang")
        
//        ScreenshotProtectionManager.shared.enableScreenshotProtection()
        protectAgainstScreenshots()
//        if(check)
//        {
//            let view : LoginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
//            let navigationController = UINavigationController(rootViewController: view)
//            self.window?.rootViewController = navigationController
//            self.window?.rootViewController = view
//        }
//        else
//        {
//            let view : SelectLanguageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Lang") as! SelectLanguageViewController
//            let navigationController = UINavigationController(rootViewController: view)
//            self.window?.rootViewController = navigationController
//        }
        return true
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    private func protectAgainstScreenshots() {
           // Add observer to handle screen capture notifications
           NotificationCenter.default.addObserver(self, selector: #selector(handleScreenCaptureNotification), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
       }
       @objc private func handleScreenCaptureNotification() {
//            Handle the screenshot event, for example, by displaying a warning or logging
//           if let topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
//               let alert = UIAlertController(title: "Warning", message: "Screenshots are not allowed in this app.", preferredStyle: .alert)
//               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//               topController.present(alert, animated: true, completion: nil)
//           }
////           screen shot error
//           ScreenshotProtectionManager.shared.showProtectionOverlay()
//
//           // Optionally, hide the overlay after a short delay
//           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//               ScreenshotProtectionManager.shared.hideProtectionOverlay()
//           }
//           if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
//                  WarningBanner.shared.show(in: window)
//              }
           
           print("Screenshot detected!")
       }
    //newww
    
    func blurScreen(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
        screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        screen?.addSubview(blurBackground)
        blurBackground.frame = (screen?.frame)!
        window?.addSubview(screen!)
    }
    func removeBlurScreen() {
        screen?.removeFromSuperview()
    }
    

    // MARK: UISceneSession Lifecycle

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
//        ScreenshotProtectionManager.shared.disableScreenshotProtection()
        blurScreen()
    }
    
    
    //jaibreaketection
    //new
    func showJailbreakDetectedAlert() {
           let alertController = UIAlertController(title: "Jailbreak Detected", message: "This app cannot be used on a jailbroken device.", preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
               // Handle action if needed
               exit(0)
           }))
           
           if let rootViewController = window?.rootViewController {
               rootViewController.present(alertController, animated: true, completion: nil)
           }
       }
    
    //jailbreak
    
    func detectJailbreak() -> Bool {
        #if arch(i386) || arch(x86_64)
            // The app is running on the simulator, so it's not jailbroken
            return false
        #else
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
               fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
               fileManager.fileExists(atPath: "/bin/bash") ||
               fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
               fileManager.fileExists(atPath: "/etc/apt") ||
               fileManager.fileExists(atPath: "/private/var/lib/apt/") ||
                fileManager.fileExists(atPath:  "/Applications/FakeCarrier.app") ||
                fileManager.fileExists(atPath:  "/Applications/blackra1n.app") ||
                fileManager.fileExists(atPath:  "/Applications/IntelliScreenX.app") ||
                fileManager.fileExists(atPath:  "/Applications/MxTube.app") ||
                fileManager.fileExists(atPath:  "/Applications/terminal.app") ||
                fileManager.fileExists(atPath:  "/Applications/MewSeek.app") ||
                fileManager.fileExists(atPath:  "/Applications/OmniStat.app") ||
                fileManager.fileExists(atPath:  "/Applications/Poof.app") ||
                fileManager.fileExists(atPath:  "/Applications/Terminal.app") ||
                fileManager.fileExists(atPath:  "/Applications/iFile.app") ||
                fileManager.fileExists(atPath:  "/Applications/Activator.app") ||
                fileManager.fileExists(atPath:  "/usr/bin/cycript") ||
                fileManager.fileExists(atPath:  "/usr/bin/ssh") ||
                fileManager.fileExists(atPath:  "/Applications/checkra1n.app") ||
                fileManager.fileExists(atPath:  "/var/binpack") ||
                fileManager.fileExists(atPath:  "/var/lib/dpkg/info/checkra1n.list") ||
                fileManager.fileExists(atPath:  "/usr/bin/checkra1n") ||
                fileManager.fileExists(atPath:  "/var/cache/apt") ||
                fileManager.fileExists(atPath:  "/var/lib/cydia") ||
                fileManager.fileExists(atPath:  "/var/tmp/cydia.log") ||
                fileManager.fileExists(atPath:  "/private/var/mobile/Library/SBSettings") ||
                fileManager.fileExists(atPath:  "/private/etc/dpkg/origins/debian") ||
                fileManager.fileExists(atPath:  "/private/var/lib/cydia/metadata.plist") ||
                fileManager.fileExists(atPath:  "/private/var/mobile/Library/Preferences/com.saurik.CyDelete.plist") ||
                fileManager.fileExists(atPath:  "/private/var/stash") ||
                fileManager.fileExists(atPath:  "/private/var/lib/dpkg/info") ||
                fileManager.fileExists(atPath:  "/private/var/lib/dpkg/status") ||
                fileManager.fileExists(atPath:  "/private/var/root/Media/Cydia") ||
                fileManager.fileExists(atPath:  "/private/var/root/Media/Cydia/AutoInstall") ||
                fileManager.fileExists(atPath:  "/private/var/mobile/Media/BootLogo") ||
                fileManager.fileExists(atPath:  "/private/var/mobile/Media/Firmware") ||
                fileManager.fileExists(atPath:  "/usr/bin/sshd") ||
                fileManager.fileExists(atPath:  "/etc/ssh/sshd_config") ||
                fileManager.fileExists(atPath:  "/usr/libexec/ssh-keysign") ||
                fileManager.fileExists(atPath:  "/bin/su") ||
                fileManager.fileExists(atPath:  "/var/lib/apt") ||
                fileManager.fileExists(atPath:  "/var/lib/cydia") ||
                fileManager.fileExists(atPath:  "/etc/apt/sources.list.d") ||
                fileManager.fileExists(atPath:  "/etc/apt/sources.list.d/cydia.list") ||
                fileManager.fileExists(atPath:  "/System/Library/Caches/apticket.der") ||
                fileManager.fileExists(atPath:  "/System/Library/Caches/com.apple.dyld/dyld_shared_cache_armv7s") ||
                fileManager.fileExists(atPath:  "/Library/Frameworks/CydiaSubstrate.framework") ||
                fileManager.fileExists(atPath:  "/Library/PreferenceBundles") ||
                fileManager.fileExists(atPath:  "/Library/PreferenceLoader/Preferences") ||
                fileManager.fileExists(atPath:  "/Library/MobileSubstrate/DynamicLibraries/Veency.plist") ||
                fileManager.fileExists(atPath:  "/Library/MobileSubstrate/DynamicLibraries/Activator.dylib") ||
                fileManager.fileExists(atPath:  "/usr/libexec/ssh-keysign")
        
            

        
        
        
        {
                // Jailbreak-related files or paths found
                return true
            }
            return false
        #endif
    }
    
    func isJailbroken() -> Bool {
        #if arch(i386) || arch(x86_64)
            // The app is running on a simulator, which isn't jailbroken
            return false
        #else
            let fileManager = FileManager.default
            let jailbreakPaths = [
                "/private/var/lib/apt",
                "/Applications/Cydia.app",
                "/Applications/RockApp.app",
                "/Applications/Icy.app",
                "/Applications/WinterBoard.app",
                "/Applications/SBSettings.app",
                "/Applications/blackra1n.app",
                "/Applications/IntelliScreen.app",
                "/Applications/Snoop-itConfig.app",
                "/bin/sh",
                "/usr/libexec/sftp-server",
                "/usr/libexec/ssh-keysign",
                "/Library/MobileSubstrate/MobileSubstrate.dylib",
                "/bin/bash",
                "/usr/sbin/sshd",
                "/etc/apt",
                "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                "/Applications/FakeCarrier.app",
                "/Applications/blackra1n.app",
                "/Applications/IntelliScreenX.app",
                "/Applications/MxTube.app",
                "/Applications/terminal.app",
                "/Applications/MewSeek.app",
                "/Applications/OmniStat.app",
                "/Applications/Poof.app",
                "/Applications/Terminal.app",
                "/Applications/iFile.app",
                "/Applications/Activator.app",
                "/usr/bin/cycript",
                "/usr/bin/ssh",
                "/Applications/checkra1n.app",
                "/var/binpack",
                "/var/lib/dpkg/info/checkra1n.list",
                "/usr/bin/checkra1n",
                "/var/cache/apt",
                "/var/lib/cydia",
                "/var/tmp/cydia.log",
                "/private/var/mobile/Library/SBSettings",
                "/private/etc/dpkg/origins/debian",
                "/private/var/lib/cydia/metadata.plist",
                "/private/var/mobile/Library/Preferences/com.saurik.CyDelete.plist",
                "/private/var/stash",
                "/private/var/lib/dpkg/info",
                "/private/var/lib/dpkg/status",
                "/private/var/root/Media/Cydia",
                "/private/var/root/Media/Cydia/AutoInstall",
                "/private/var/mobile/Media/BootLogo",
                "/private/var/mobile/Media/Firmware",
                "/usr/bin/sshd",
                "/etc/ssh/sshd_config",
                "/usr/libexec/ssh-keysign",
                "/bin/su",
                "/var/lib/apt",
                "/var/lib/cydia",
                "/etc/apt/sources.list.d",
                "/etc/apt/sources.list.d/cydia.list",
                "/System/Library/Caches/apticket.der",
                "/System/Library/Caches/com.apple.dyld/dyld_shared_cache_armv7s",
                "/Library/Frameworks/CydiaSubstrate.framework",
                "/Library/PreferenceBundles",
                "/Library/PreferenceLoader/Preferences",
                "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                "/Library/MobileSubstrate/DynamicLibraries/Activator.dylib"

            ]

            for path in jailbreakPaths {
                if fileManager.fileExists(atPath: path) {
                    return true
                }
            }
            return false
        #endif
    }


    
    
    

    func applicationDidBecomeActive(_ application: UIApplication) {
//        ScreenshotProtectionManager.shared.enableScreenshotProtection()
        removeBlurScreen()
        /*if let app = application as? CustomApplication {
               app.startSessionTimer()
           }
        print("App became active again")
            // Check how long the app was inactive
            if let backgroundTime = UserDefaults.standard.value(forKey: "AppBackgroundTime") as? Date {
                let timeDifference = Date().timeIntervalSince(backgroundTime)
                print("App was inactive for \(timeDifference) seconds")
                
                if timeDifference > 600 { // 10 minutes
                    // Call session timeout API here
                    APIManager.shared.fetchToken { token in
                        guard let accessToken = token else { return }
                        APIManager.shared.updateSession(sessionType: "2", accessToken: accessToken) { responseCode in
                            print("Session timed out, API called: \(responseCode)")
                            // Handle logout UI here if needed
                        }
                    }
                }
            }*/
    }
   
    

}

