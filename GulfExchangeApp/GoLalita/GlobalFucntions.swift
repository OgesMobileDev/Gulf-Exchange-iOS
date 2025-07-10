//
//  GlobalFucntions.swift
//  GulfExchangeApp
//
//  Created by macbook on 27/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import Foundation
import UIKit

//extension UIColor {
//    // Helper function to create UIColor from RGBA values
//    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
//        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
//    }
//}
//
//func addShadow(view:UIView){
//    view.layer.shadowColor = UIColor.rgba(207, 225, 214, 1).cgColor
//    view.layer.shadowOffset = CGSize(width: 1, height: 1)
//    view.layer.shadowOpacity = 1
//    view.layer.shadowRadius = 5
//    view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
//}

func urlToImg(urlString: String,to imageView:UIImageView){
    if urlString == ""{
        print("error Url Image")
    }else{
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
}

