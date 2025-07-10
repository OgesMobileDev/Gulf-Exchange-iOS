//
//  CustomCalendar.swift
//  GulfExchangeApp
//
//  Created by test on 25/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import Foundation
import UIKit
protocol SetCalendar {
    func PutDate (dateVal:String)
    
}
class CustomCalendar: NSObject {
    var calendarDelegate:SetCalendar? = nil
    let datepicker : UIDatePicker = UIDatePicker()
    let toolbar = UIToolbar();
    func ShowCalendar(xpos:Int,ypos:Int,targetController:UIViewController){
        
       datepicker.frame = CGRect(x:xpos, y:ypos, width: 300, height: 200)
       // datepicker.backgroundColor = .lightGray
      //  datepicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: 300, height: 200)
        datepicker.datePickerMode = .date
        //datepicker.backgroundColor = UIColor.black
        datepicker.setValue(UIColor.white, forKeyPath: "textColor")
        datepicker.setValue(0.8, forKeyPath: "alpha")
        
      
        if #available(iOS 13.4, *) {
            datepicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datepicker.backgroundColor = UIColor.darkGray
        datepicker.setValue(UIColor.orange, forKeyPath: "textColor")
    
        
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor.lightGray
       let spaceButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donedatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
       
        toolbar.setItems([spaceButton1,doneButton,spaceButton], animated: false)
        toolbar.frame = CGRect(x: xpos, y: ypos+165, width: 300, height: 35)
           datepicker.addTarget(self, action:  #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        targetController.view.addSubview(datepicker)
        targetController.view.addSubview(toolbar)
    }
    
    @objc func donedatePicker(){
        
    self.datepicker.removeFromSuperview()
    self.toolbar.removeFromSuperview()
    }
    @objc func datePickerValueChanged(_ sender: UIDatePicker)  {
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format
        dateFormatter.dateFormat = "dd-MM-YYYY"
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
       
        calendarDelegate?.PutDate(dateVal: selectedDate)
     
    }
    
    func DateToString(date:Date) -> String {
        var currentDateTime = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
       let stringdate = "\(dateFormatter.string(from: currentDateTime))"
        return stringdate
       
    }

}
