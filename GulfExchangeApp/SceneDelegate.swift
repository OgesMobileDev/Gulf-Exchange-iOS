//
//  SceneDelegate.swift
//  GulfExchangeApp
//
//  Created by test on 20/06/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let defaults = UserDefaults.standard
    var isFirstLaunch = true

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let check = isKeyPresentInUserDefaults(key: "appLang")
        isFirstLaunch = true
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
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("App became active again")
        if isFirstLaunch {
                    print("Fresh launch")
                    isFirstLaunch = false
                } else {
                    print("Returning from background")
                    if let backgroundTime = UserDefaults.standard.value(forKey: "AppBackgroundTime") as? Date {
                        let timeDifference = Date().timeIntervalSince(backgroundTime)
                        print("App was inactive for \(timeDifference) seconds")
                        let loggedIn = (UserDefaults.standard.object(forKey: "isLoggedIN") as? Bool) ?? false
                        if loggedIn{
                            if timeDifference > 10 * 60 { // 10 minutes
                                // Call session timeout API here
                                APIManager.shared.fetchToken { token in
                                    guard let accessToken = token else { return }
                                    APIManager.shared.updateSession(sessionType: "2", accessToken: accessToken) { responseCode in
                                        print("Session timed out, API called: \(responseCode)")
                                        // Handle logout UI here if needed
                                        // Show an alert before logging out
                                        DispatchQueue.main.async {
                                            self.showSessionTimeoutAlert(responseCode: responseCode)
                                        }
                                        
                                        //                            if responseCode == "S333" {
                                        //                                self.handleSessionErrorLogout()
                                        //                            } else {
                                        //                                self.handleSessionErrorLogout()
                                        //                            }
                                    }
                                }
                            }else {
                                
                                if let app = UIApplication.shared as? CustomApplication {
                                    app.startSessionTimer()
                                }
                            }
                        }
                        
                    }
                    defaults.removeObject(forKey: "AppBackgroundTime")
                }
        
        // Check how long the app was inactive
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("Scene moved to background")
        let loggedIn = (UserDefaults.standard.object(forKey: "isLoggedIN") as? Bool) ?? false
        if loggedIn{
            UserDefaults.standard.set(Date(), forKey: "AppBackgroundTime")
        }else{
            UserDefaults.standard.removeObject(forKey: "AppBackgroundTime")
        }
        
    }
    
    func handleSessionErrorLogout() {
        // Biometric Check
        let biometricEnabled = defaults.string(forKey: "biometricenabled") == "biometricenabled"
        
        if !biometricEnabled {
            // Clear sensitive data
            defaults.set("", forKey: "USERID")
            defaults.set("", forKey: "PASSW")
            defaults.set("", forKey: "PIN")
            defaults.set("", forKey: "REGNO")
        }
        //        if ((self.defaults.string(forKey: "biometricenabled")?.isEmpty) != nil)
        //        {
        //
        //        }
        //        else
        //        {
        //            self.defaults.set("", forKey: "USERID")
        //            self.defaults.set("", forKey: "PASSW")
        //            self.defaults.set("", forKey: "PIN")
        //            self.defaults.set("", forKey: "REGNO")
        //        }
        
        // Set logout flag
        defaults.set("logoutbiometrc", forKey: "logoutbiometrc")
        defaults.set(false, forKey: "isLoggedIN")
        
        // Access the rootViewController
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
           let rootViewController = window.rootViewController {
            
            // If the rootViewController is a UINavigationController
            if let navigationController = rootViewController as? UINavigationController {
                
                // Check if MainLoginViewController exists in stack
                for controller in navigationController.viewControllers {
                    if let tabController = controller as? MainLoginViewController {
                        navigationController.popToViewController(tabController, animated: true)
                        return
                    }
                }
                
                // If not, push MainLoginViewController
                let storyBoard = UIStoryboard(name: "Main10", bundle: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                navigationController.pushViewController(nextViewController, animated: true)
                
            } else {
                // If root is not NavigationController, present login directly
                let storyBoard = UIStoryboard(name: "Main10", bundle: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
                rootViewController.present(nextViewController, animated: true, completion: nil)
            }
        }
    }
    
    func showSessionTimeoutAlert(responseCode: String) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window,
              let rootViewController = window.rootViewController else {
            return
        }
        
        let alertController = UIAlertController(title: "Session Expired",
                                                message: "Your session has expired. Please login again",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if responseCode == "S333" {
                self.handleSessionErrorLogout()
            } else {
                self.handleSessionErrorLogout()
            }
        }
        
        alertController.addAction(okAction)
        rootViewController.present(alertController, animated: true, completion: nil)
    }
}

