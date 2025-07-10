//
//  checkCameraPermission.swift
//  GulfExchangeApp
//
//  Created by RAHUL on 16/06/2025.
//  Copyright © 2025 Oges. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

func checkCameraPermissionAndSetup(from viewController: UIViewController, onGranted: @escaping () -> Void) {
    let status = AVCaptureDevice.authorizationStatus(for: .video)

    switch status {
    case .authorized:
        onGranted()

    case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    onGranted()
                } else {
                    showCameraPermissionAlert(from: viewController)
                }
            }
        }

    case .denied, .restricted:
        showCameraPermissionAlert(from: viewController)

    @unknown default:
        break
    }
}

private func showCameraPermissionAlert(from viewController: UIViewController) {
    let alert = UIAlertController(
        title: "Camera Access Needed",
        message: "Please enable camera access in Settings to scan your ID.",
        preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                viewController.navigationController?.popViewController(animated: true)
            })
    alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
        if let settingsURL = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    })
    viewController.present(alert, animated: true)
}
