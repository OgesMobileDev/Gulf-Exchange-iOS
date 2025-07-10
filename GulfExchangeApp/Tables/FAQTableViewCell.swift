//
//  FAQTableViewCell.swift
//  GulfExchangeApp
//
//  Created by test on 22/03/21.
//  Copyright © 2021 Oges. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    @IBOutlet weak var notifyMsg: UILabel!
    
    @IBOutlet var Faqquestlbl: UILabel!
    
    @IBOutlet var textvieww: UITextView!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    var notifications:Notificationn!
    var delegate: NotificationDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func deleteBtn(_ sender: Any) {
         delegate?.deleteNotification(notifyId: notifications.notifyID)
    }
    func setNotification(notification:Notificationn) {
        notifications = notification
        self.notifyMsg.text = notification.notifyMessage
        let dateTime = notification.createdOn
        let createdOn = self.convertDateFormater(dateTime)
        self.dateTime.text = createdOn
//        self.adjustUITextViewHeight(arg: self.notifyMsg)
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        return  dateFormatter.string(from: date!)

    }
    func adjustUITextViewHeight(arg : UILabel)
        {
            arg.translatesAutoresizingMaskIntoConstraints = true
            arg.sizeToFit()
        }
}
