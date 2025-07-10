//
//  GLFunctions.swift
//  GulfExchangeApp
//
//  Created by macbook on 10/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

import Kingfisher

extension UIColor {
    // Helper function to create UIColor from RGBA values
    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

func addShadow(view:UIView){
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowOpacity = 0.2
    view.layer.shadowRadius = 4
    view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
}
func removeShadow(view:UIView){
    view.layer.shadowColor = UIColor.clear.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 0)
    view.layer.shadowOpacity = 0
    view.layer.shadowRadius = 0
    view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
}

func buttonTitleSet(title:String, size: CGFloat, font: FontType) -> NSAttributedString{
    var fontName = "Poppins-Regular"
    switch font {
    case .regular:
        fontName = "Poppins-Regular"
    case .semiBold:
        fontName = "Poppins-SemiBold"
    case .bold:
        fontName = "Poppins-Bold"
    case .medium:
        fontName = "Poppins-Medium"
    }
    let titleAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size),
       ]
    let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
    return attributedTitle
}
func buttonTitleSetWithColor(title:String, size: CGFloat, font: FontType, color:UIColor) -> NSAttributedString{
    var fontName = "Poppins-Regular"
    switch font {
    case .regular:
        fontName = "Poppins-Regular"
    case .semiBold:
        fontName = "Poppins-SemiBold"
    case .bold:
        fontName = "Poppins-Bold"
    case .medium:
        fontName = "Poppins-Medium"
    }
    let titleAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size),
        .foregroundColor: color   
       ]
    let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
    return attributedTitle
}
func createAttributedString(title: String, size: CGFloat, font: FontType) -> NSAttributedString {
    let fontName: String
    switch font {
    case .regular:
        fontName = "Poppins-Regular"
    case .semiBold:
        fontName = "Poppins-SemiBold"
    case .bold:
        fontName = "Poppins-Bold"
    case .medium:
        fontName = "Poppins-Medium"
    }
    
    let customFont = UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    
    let titleAttributes: [NSAttributedString.Key: Any] = [
        .font: customFont
    ]
    
    return NSAttributedString(string: title, attributes: titleAttributes)
}
func createBarButtonItem(title: String, size: CGFloat, font: FontType) -> UIBarButtonItem {
    let attributedTitle = createAttributedString(title: title, size: size, font: font)
    
    let button = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    button.setTitleTextAttributes(attributedTitle.attributes(at: 0, effectiveRange: nil), for: .normal)
    
    return button
}
func configureButton(button: UIButton, title: String, size: CGFloat, font: FontType) {
    let attributedTitle = createAttributedString(title: title, size: size, font: font)
    button.setAttributedTitle(attributedTitle, for: .normal)
}
func configureLabel(label: UILabel, text: String, size: CGFloat, font: FontType) {
    let attributedText = createAttributedString(title: text, size: size, font: font)
    label.attributedText = attributedText
}
func createAvatar(username: String, view:UIView, font:CGFloat){
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: font, weight: .bold)
    label.textColor = .white
    
    // Set the first letter of the username
    if let firstLetter = username.first {
        label.text = String(firstLetter).uppercased()
    }
    
    // Generate a random light color
    view.backgroundColor = generateRandomLightColor()
    
    // Add label to the view
    view.addSubview(label)
    
    // Constrain the label to fill the view
    NSLayoutConstraint.activate([
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        label.widthAnchor.constraint(equalTo: view.widthAnchor),
        label.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
    
    // Make the view circular
    view.layer.cornerRadius = view.bounds.width / 2
    view.clipsToBounds = true
}
// Function to generate a random light color
func generateRandomLightColor() -> UIColor {
    let red = CGFloat.random(in: 0.7...1.0)
    let green = CGFloat.random(in: 0.7...1.0)
    let blue = CGFloat.random(in: 0.7...1.0)
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

@MainActor func loadCountryFlag(for countryCode: String, into imageView: UIImageView) {
    print("countryCode - \(countryCode)")
    
    let trimmedCode = countryCode.trimmingCharacters(in: .whitespacesAndNewlines)
        print("Trimmed countryCode - \(trimmedCode)")
    // Convert the country code to lowercase
    let lowercasedCode = trimmedCode.lowercased()
    print("lowercasedCode - \(lowercasedCode)")
    // Construct the URL with the given country code
    let flagURLString = "https://gulfexchange.com.qa/work_test/user/flags/\(lowercasedCode).png"
    
    // Ensure the URL is valid
    guard let flagURL = URL(string: flagURLString) else {
        print("Invalid URL for country code: \(countryCode)")
        imageView.image = UIImage(named: "default_image")
        return
    }
    
    // Load the image into the UIImageView using Kingfisher
    imageView.kf.setImage(with: flagURL, placeholder: UIImage(systemName: "photo")) { result in
        switch result {
        case .success(let value):
            print("Flag image loaded successfully: \(value.source.url?.absoluteString ?? "")")
        case .failure(let error):
            print("Failed to load flag image: \(error.localizedDescription)")
        }
    }
}

func setLabelWithAsterisk(label: UILabel, text: String) {
    let textColor:UIColor = UIColor.rgba(139, 139, 139, 1)
    let asteriskColor:UIColor = UIColor.rgba(198, 23, 30, 1)
    
    // Create attributes for the base text
    let baseAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: textColor
    ]
    
    // Create attributes for the asterisk
    let asteriskAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: asteriskColor
    ]
    
    // Create attributed strings for each part
    let attributedBaseText = NSAttributedString(string: text, attributes: baseAttributes)
    let attributedAsterisk = NSAttributedString(string: "*", attributes: asteriskAttributes)
    
    // Combine the two attributed strings
    let combinedAttributedString = NSMutableAttributedString()
    combinedAttributedString.append(attributedBaseText)
    combinedAttributedString.append(attributedAsterisk)
    
    // Set the label's attributed text
    label.attributedText = combinedAttributedString
}


func applyGradient(to view: UIView, topColor: UIColor, bottomColor: UIColor) {
       let gradientLayer = CAGradientLayer()
       gradientLayer.frame = view.bounds
       gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
       gradientLayer.startPoint = CGPoint(x: 0.5, y: 0) // Top-center
       gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)   // Bottom-center
       
       // Add the gradient to the view
       view.layer.insertSublayer(gradientLayer, at: 0)
}

