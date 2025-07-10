//
//  UIViewExtension.swift
//  GulfExchangeApp
//
//  Created by macbook on 05/07/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation
 
//
//class ScreenShieldd {
//    static let shared = ScreenShieldd()
//
//    private var shieldView: UIView?
//
//    // Method to protect a specific view from screen captures
//    func protect(view: UIView) {
//        let shieldView = UIView(frame: view.bounds)
//        shieldView.backgroundColor = .clear // Transparent background
//        view.addSubview(shieldView)
//        self.shieldView = shieldView
//    }
//
//    // Method to remove the shield view
//    func removeProtection() {
//        shieldView?.removeFromSuperview()
//        shieldView = nil
//    }
//}


import UIKit
 

protocol ScreenshotPrevention: AnyObject {
    var overlayView: UIView? { get set }
    func enableScreenshotPrevention()
    func disableScreenshotPrevention()
}

extension ScreenshotPrevention where Self: UIViewController {

    func enableScreenshotPrevention() {
        // Create overlay view
        let overlay = UIView(frame: UIScreen.main.bounds)
        overlay.backgroundColor = .clear
        self.overlayView = overlay

        // Add overlay view above all other views
        if let overlayView = overlayView {
            self.view.addSubview(overlayView)
            self.view.bringSubviewToFront(overlayView)
        }
    }

    func disableScreenshotPrevention() {
        // Remove overlay view
        overlayView?.removeFromSuperview()
        overlayView = nil
    }
}
