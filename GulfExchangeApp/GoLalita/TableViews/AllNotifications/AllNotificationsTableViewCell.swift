//
//  AllNotificationsTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 22/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class AllNotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var notificationTitleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//    addShadow(view: baseView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(){
        let dateTimeString = "2024-07-15T12:34:56"

        // Split the string by the "T" separator
        let dateTimeComponents = dateTimeString.split(separator: " ")

        if dateTimeComponents.count == 2 {
            dateLbl.text = String(dateTimeComponents[0])
            timeLbl.text = String(dateTimeComponents[1])

//            print("Date: \(datePart)")
//            print("Time: \(timePart)")
        } else {
            print("Invalid date-time format.")
        }
    }
    
    func setNotificationData(data:NotificationList?){
       // urlToImg(urlString: data?.merchantLogo ?? "", to: imageView)
        notificationTitleLbl.text = data?.description
        subTitleLbl.text = data?.notification_type
        
        let dateTimeString = data?.date
        
        

        // Split the string by the "T" separator
       
        let dateTimeComponents = dateTimeString!.split(separator: " ")

        if dateTimeComponents.count == 2 {
            dateLbl.text = String(dateTimeComponents[0])
            timeLbl.text = String(dateTimeComponents[1])

            // Optionally, you can print the results to verify
            print("Date: \(dateTimeComponents[0])")
            print("Time: \(dateTimeComponents[1])")
        } else {
            print("Invalid date-time format.")
        }

    }
    

    
}
