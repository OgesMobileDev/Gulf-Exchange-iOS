//
//  CircularProgressBar.swift
//  GulfExchangeApp
//
//  Created by macbook on 08/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class CircularProgressBar: UIView {
    
    // Define the layers
    private var baseLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var timer: Timer?
    private var currentProgress: CGFloat = 1.0  // Start from full (1.0)
    // Initial setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        // Define the circular path
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 6, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        // Configure base layer (background circle)
        baseLayer.path = circularPath.cgPath
        baseLayer.strokeColor = UIColor.clear.cgColor
        baseLayer.lineWidth = 2
        baseLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(baseLayer)
        
        // Configure progress layer (progress circle)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.rgba(198, 23, 30, 1).cgColor
        progressLayer.lineWidth = 2
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0  // Start with no progress
        layer.addSublayer(progressLayer)
    }
    
    // Method to start the 1-minute countdown animation
    func start1MinuteCountdown() {
        // Reset the progress layer to start from empty
        progressLayer.strokeEnd = 0
        
        // Create the animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 31
        animation.fromValue = 1
        animation.toValue = 0
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        // Apply animation to the progress layer
        progressLayer.strokeEnd = 0
        progressLayer.add(animation, forKey: "1MinuteCountdown")
    }
    // Method to start the countdown with 1-second animations
    func start1secondCountdown() {
        // Reset progress and start the timer
        currentProgress = 1.0
        progressLayer.strokeEnd = currentProgress
        timer?.invalidate()  // Stop any previous timer
        
        // Start a timer that fires every second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(animateProgress1), userInfo: nil, repeats: true)
    }
    func timerInvalidate() {
            // Stop the timer if it’s active
            timer?.invalidate()
            timer = nil
            
            // Remove the animation from the progress layer
            progressLayer.removeAnimation(forKey: "1MinuteCountdown")
            
            // Reset strokeEnd if needed
            progressLayer.strokeEnd = 0  // or 0, depending on how you want to reset
        }
    @objc private func animateProgress1() {
        // Reset the progress layer to start from empty
        progressLayer.strokeEnd = 0
        
        // Create the animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1  // 60 seconds for a 1-minute countdown
        animation.fromValue = 1
        animation.toValue = 0
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        // Apply animation to the progress layer
        progressLayer.strokeEnd = 0
        progressLayer.add(animation, forKey: "1MinuteCountdown")
    }
    @objc private func animateProgress() {
        // Calculate the new progress by reducing by 1/60 each second
        let newProgress = currentProgress - (1.0 / 60.0)
        
        // Animate the progress layer's strokeEnd from current to new progress
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = currentProgress
        animation.toValue = newProgress
        animation.duration = 1.0  // Animate over 1 second
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        // Update the progress layer
        progressLayer.strokeEnd = newProgress
        progressLayer.add(animation, forKey: "progressAnim")
        
        // Update current progress
        currentProgress = newProgress
        
        // Stop the timer when progress reaches 0
        if currentProgress <= 0 {
            timer?.invalidate()
            timer = nil
        }
    }
}

