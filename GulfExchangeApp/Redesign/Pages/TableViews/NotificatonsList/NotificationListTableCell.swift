//
//  NotificationListTableCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

class NotificationListTableCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tapForMoreLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ScreenShield.shared.protect(view: self.titleLbl)
        ScreenShield.shared.protect(view: self.timeLbl)
        ScreenShield.shared.protect(view: self.tapForMoreLbl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func formatDate(from dateString: String) -> String {
        // Step 1: Parse the date string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  // Format based on API response
        dateFormatter.timeZone = TimeZone.current
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid date"
        }
        
        // Step 2: Calculate the difference from the current date
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            // If the date is today, return the time only
            dateFormatter.dateFormat = "h:mm a"  // Show time in 12-hour format, e.g., "2:15 PM"
            return dateFormatter.string(from: date)
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            // Calculate the number of days and months between the dates
            let components = calendar.dateComponents([.day, .month], from: date, to: Date())
            
            if let months = components.month, months > 0 {
                // If the date is more than a month ago
                return "\(months) month\(months > 1 ? "s" : "") ago"
            } else if let days = components.day, days > 0 {
                // If the date is more than yesterday but less than a month ago
                return "\(days) day\(days > 1 ? "s" : "") ago"
            }
        }
        
        return "Unknown date"
    }

    func setNotification(notification:Notificationn){
        let time = notification.createdOn
        let displayDate = formatDate(from: time)
        timeLbl.text = displayDate
        titleLbl.text = notification.notifyMessage
    }
}
