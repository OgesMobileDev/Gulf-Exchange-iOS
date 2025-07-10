//
//  AlertView.swift
//  GulfExchangeApp
//
//  Created by test on 15/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit

class AlertView: UIView{
    static let instance = AlertView()
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var msgLbl: UITextView!
    @IBOutlet weak var img: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        Commoninit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    private func Commoninit()
    {
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        alertView.layer.cornerRadius = 10
        okBtn.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.15, alpha: 1.00)
        okBtn.layer.cornerRadius = 15
    }
    enum AlertType {
        case success
        case failure
        case attention
        case info
    }
    func showAlert(msg:String, action:AlertType) {
        
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
            self.parentView.isOpaque = false;
            self.parentView.backgroundColor = UIColor.lightGray
            alertView.backgroundColor = UIColor.white
            msgLbl.backgroundColor = UIColor.white
            msgLbl.textColor = UIColor.black
        } else {
            // Fallback on earlier versions
        }

        
        
        msgLbl.text = msg
        UIApplication.shared.keyWindow?.addSubview(parentView)
        if(action == .success)
        {
            self.img.image = UIImage(named: "green_tick")
        }
        else if(action == .failure)
        {
            self.img.image = UIImage(named: "error")
        }
        else if(action == . attention)
        {
            self.img.image = UIImage(named: "attention")
        }
        else if(action == .info)
        {
            self.img.image = UIImage(named: "info_green")
        }
        
    }
    @IBAction func okBtn(_ sender: Any) {
//        guard let url = URL(string: "http://www.smartinfotec.com") else { return }
//        UIApplication.shared.open(url)
        parentView.removeFromSuperview()
    }
}
