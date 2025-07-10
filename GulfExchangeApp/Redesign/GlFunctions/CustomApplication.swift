import UIKit

class CustomApplication: UIApplication {
    static let sessionTimeoutDuration: TimeInterval = 10 * 60 // 10 minutes
    var loggedIN:Bool = false
    private var timer: Timer?
    let defaults = UserDefaults.standard
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        // Reset timer when user interacts
        if event.allTouches?.contains(where: { $0.phase == .began }) == true {
            let loggedIn = (UserDefaults.standard.object(forKey: "isLoggedIN") as? Bool) ?? false
            if loggedIn{
                if loggedIN{
                    resetSessionTimer()
                }
            }
        }
    }
    
    private func resetSessionTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: CustomApplication.sessionTimeoutDuration, target: self, selector: #selector(sessionTimedOut), userInfo: nil, repeats: false)
    }
    
    @objc private func sessionTimedOut() {
        loggedIN = false
        print("Session Timed Out! Calling session timeout API...")
        // Call your session timeout API here
        APIManager.shared.fetchToken { token in
            if let accessToken = token {
                APIManager.shared.updateSession(sessionType: "2", accessToken: accessToken) { responseCode in
                    print("Session Timeout API called, ResponseCode: \(responseCode)")
                    self.timer?.invalidate()
                    // Show an alert before logging out
                                      DispatchQueue.main.async {
                                          self.showSessionTimeoutAlert(responseCode: responseCode)
                                      }
//                    if responseCode == "S333" {
//                        self.handleSessionErrorLogout()
//                    } else {
//                        self.handleSessionErrorLogout()
//                    }
                    // Optionally log the user out or navigate to login screen
//                    DispatchQueue.main.async {
//                        // e.g., show alert or navigate to login screen
//                    }
                }
            }
        }
    }
    
    // Call this from AppDelegate when launching app
    func startSessionTimer() {
        loggedIN = true
        resetSessionTimer()
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
