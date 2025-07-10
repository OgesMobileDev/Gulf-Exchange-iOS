//
//  UIViewExtension.swift
//  GulfExchangeApp
//
//  Created by macbook on 05/07/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation
import UIKit
 
class DottedBorderView: UIView {
    private var borderLayer: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        addDottedBorder()
    }

    private func addDottedBorder() {
        // Remove any existing border layer
        borderLayer?.removeFromSuperlayer()
        
        // Create a new shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.darkGray.cgColor // Set your desired color
        shapeLayer.lineWidth = 2 // Set your desired line width
        shapeLayer.lineDashPattern = [6, 2] // Set the dash pattern, [dash length, gap length]
        shapeLayer.fillColor = nil
        
        // Setting the path for the shape layer
        let path = CGMutablePath()
        path.addRoundedRect(in: self.bounds.insetBy(dx: shapeLayer.lineWidth / 2, dy: shapeLayer.lineWidth / 2), cornerWidth: 8, cornerHeight: 8)
        shapeLayer.path = path
        
        // Add the new shape layer
        self.layer.addSublayer(shapeLayer)
        
        // Keep a reference to the border layer
        borderLayer = shapeLayer
    }
}

//class DottedBorderView: UIView {
//    private var borderLayer: CAShapeLayer?
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        addDottedBorder()
//    }
//
//    private func addDottedBorder() {
//        // Remove any existing border layer
//        borderLayer?.removeFromSuperlayer()
//        
//        // Create a new shape layer
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.strokeColor = UIColor.black.cgColor // Set your desired color
//        shapeLayer.lineWidth = 2 // Set your desired line width
//        shapeLayer.lineDashPattern = [4, 2] // Set the dash pattern, [dash length, gap length]
//        shapeLayer.fillColor = nil
//        
//        // Setting the path for the shape layer
//        let path = CGMutablePath()
//        path.addRoundedRect(in: self.bounds.insetBy(dx: shapeLayer.lineWidth / 2, dy: shapeLayer.lineWidth / 2), cornerWidth: 8, cornerHeight: 8)
//        shapeLayer.path = path
//        
//        // Add the new shape layer
//        self.layer.addSublayer(shapeLayer)
//        
//        // Keep a reference to the border layer
//        borderLayer = shapeLayer
//    }
//}
