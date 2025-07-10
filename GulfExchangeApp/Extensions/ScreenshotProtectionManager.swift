//
//  ScreenshotProtectionManager.swift
//  GulfExchangeApp
//
//  Created by macbook on 03/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class ScreenshotProtectionManager {
    static let shared = ScreenshotProtectionManager()
    
    private var protectionView: UIView?
    
    private init() {}
    
    func enableScreenshotProtection() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
        // Remove existing protection view if present
        protectionView?.removeFromSuperview()
        
        let protectionView = UIView(frame: window.bounds)
        protectionView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Semi-transparent overlay
        window.addSubview(protectionView)
        window.bringSubviewToFront(protectionView)
        
        self.protectionView = protectionView
        
        // Add observer to handle screen changes (e.g., rotation)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProtectionViewFrame), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    func showProtectionOverlay() {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            
            // Remove existing protection view if present
            protectionView?.removeFromSuperview()
            
            // Create a new protection view
            let protectionView = UIView(frame: window.bounds)
            protectionView.backgroundColor = UIColor.white // Or any color that suits your design
            protectionView.tag = 9999 // Assign a tag for easy identification
            
            window.addSubview(protectionView)
            window.bringSubviewToFront(protectionView)
            
            self.protectionView = protectionView
        }
    func hideProtectionOverlay() {
            protectionView?.removeFromSuperview()
            protectionView = nil
        }
    func disableScreenshotProtection() {
        protectionView?.removeFromSuperview()
        protectionView = nil
        
        // Remove observer
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func updateProtectionViewFrame() {
        protectionView?.frame = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.bounds ?? .zero
    }
}



class WarningBanner: UIView {
    static let shared = WarningBanner()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupBanner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBanner() {
        self.backgroundColor = UIColor.rgba(198, 23, 30, 1)
        self.alpha = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.text = "Screenshots are not allowed."
        label.textColor = .white
        label.textAlignment = .center
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    func show(in view: UIView) {
        self.frame = CGRect(x: 0, y: -50, width: view.frame.width, height: 50)
        view.addSubview(self)
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            self.frame.origin.y = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0
                self.frame.origin.y = -50
            }, completion: { _ in
                self.removeFromSuperview()
            })
        }
    }
}


extension UIView {
    func makeSecure() {
        DispatchQueue.main.async {
            let field = UITextField()
            field.isSecureTextEntry = true
            self.addSubview(field)
            field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.layer.superlayer?.addSublayer(field.layer)
            field.layer.sublayers?.first?.addSublayer(self.layer)
        }
    }
}
