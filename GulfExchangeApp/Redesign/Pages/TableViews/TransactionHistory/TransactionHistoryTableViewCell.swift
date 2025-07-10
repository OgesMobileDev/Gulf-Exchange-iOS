//
//  TransactionHistoryTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 30/10/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

class TransactionHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var transactionTypeLbl1: UILabel!
    @IBOutlet weak var transactionTypeLbl: UILabel!
    @IBOutlet weak var dateLbl1: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusLbl1: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var trackLbl: UILabel!
    @IBOutlet weak var trackBtn: UIButton!
    @IBOutlet weak var trackViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var youPaidLbl: UILabel!
    @IBOutlet weak var paidAmntLbl: UILabel!
    @IBOutlet weak var recivedLbl: UILabel!
    @IBOutlet weak var recivedAmnt: UILabel!
    @IBOutlet weak var sendBgView: UIView!
    @IBOutlet weak var downloadBgView: UIView!
    @IBOutlet weak var detailsBgView: UIView!
    @IBOutlet weak var sendViewWidth: NSLayoutConstraint!
    @IBOutlet weak var downloadViewWidth: NSLayoutConstraint!
    @IBOutlet weak var detailsViewWidth: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var imgBgView: UIView!
    @IBOutlet weak var sendAgainLbl: UILabel!
    @IBOutlet weak var downloadLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var userNameTrailingConstraint: NSLayoutConstraint!
    
    var transactions:MyTransactions!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ScreenShield.shared.protect(view: self.userNameLbl)
        ScreenShield.shared.protect(view: self.transactionTypeLbl)
        ScreenShield.shared.protect(view: self.transactionTypeLbl1)
        ScreenShield.shared.protect(view: self.dateLbl)
        ScreenShield.shared.protect(view: self.dateLbl1)
        ScreenShield.shared.protect(view: self.statusLbl)
        ScreenShield.shared.protect(view: self.statusLbl1)
        ScreenShield.shared.protect(view: self.paidAmntLbl)
        ScreenShield.shared.protect(view: self.youPaidLbl)
        ScreenShield.shared.protect(view: self.recivedAmnt)
        ScreenShield.shared.protect(view: self.recivedLbl)
        ScreenShield.shared.protect(view: self.sendAgainLbl)
        ScreenShield.shared.protect(view: self.downloadLbl)
        ScreenShield.shared.protect(view: self.detailsLbl)
        ScreenShield.shared.protect(view: self.trackLbl)
        setViews()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setViews(){
        
        baseView.clipsToBounds = true
        trackBtn.setTitle("", for: .normal)
        sendBtn.setTitle("", for: .normal)
        downloadBtn.setTitle("", for: .normal)
        detailsBtn.setTitle("", for: .normal)
        
        trackLbl.text = NSLocalizedString("track2", comment: "")
        transactionTypeLbl1.text = NSLocalizedString("transactionType", comment: "")
        dateLbl1.text = NSLocalizedString("date1", comment: "")
        statusLbl1.text = NSLocalizedString("Status", comment: "")
        youPaidLbl.text = NSLocalizedString("youPaid", comment: "")
        paidAmntLbl.text = NSLocalizedString("track2", comment: "")
        recivedLbl.text = NSLocalizedString("theyReceived", comment: "")
        sendAgainLbl.text = NSLocalizedString("sendAgain", comment: "")
        downloadLbl.text = NSLocalizedString("download", comment: "")
        detailsLbl.text = NSLocalizedString("details", comment: "")
        
        adjustTrackViewWidth()
        let width = UIScreen.main.bounds.width
        print("width - \(width)")
        let subViewWidth = (width - 32) / 3
        print("subViewWidth - \(subViewWidth)")
        sendViewWidth.constant = subViewWidth
        downloadViewWidth.constant = subViewWidth
        detailsViewWidth.constant = subViewWidth
        applyGradient(to: trackView, topColor: UIColor.rgba(198, 23, 30, 1), bottomColor: UIColor.rgba(93, 0, 24, 1))
    }
    func setMyTransaction(transaction:MyTransactions) {
        transactions = transaction
        
        let dateString = transaction.transactionDate
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateLbl.text = transaction.transactionDate
        if let date = inputFormatter.date(from: dateString) {
            // Step 2: Convert the Date object to the desired format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd-MMM-yy, h:mm a"
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let formattedDateString = outputFormatter.string(from: date)
            print(formattedDateString) // "14-Oct-24, 2:25 PM"
            dateLbl.text = formattedDateString
        }
        let paymentAmt = "\(transaction.payinCurrency): \(transaction.payinAmount)"
        let reciveAmt = "\(transaction.payoutCurrency): \(transaction.payoutAmount)"
        
        if transaction.paymentStatus == "PAYMENT PROCESSED SUCCESSFULLY" || transaction.paymentStatus == "SUCCESS"{
            statusLbl.text = "SUCCESS"
            statusLbl.textColor = UIColor.rgba(0, 136, 62, 1)
            statusImg.image = UIImage(named: "t_done")
        }else if (transaction.paymentStatus == "PAYMENT FAILED" || transaction.paymentStatus == "PAYMENT CANCELED"){
            statusLbl.text = transaction.paymentStatus
            statusLbl.textColor = UIColor.rgba(227, 5, 13, 1)
            statusImg.image = UIImage(named: "t_failed")
        }else if (transaction.paymentStatus == "INITIATED" ){
            statusLbl.text = transaction.paymentStatus
            statusLbl.textColor = UIColor.rgba(244, 133, 2, 1)
            statusImg.image = UIImage(named: "t_pending")
        }else{
            statusLbl.text = transaction.paymentStatus
            statusLbl.textColor = UIColor.rgba(139, 139, 139, 1)
            statusImg.image = UIImage(named: "")
        }
        transactionTypeLbl.text = transaction.deliveryOption
        
        paidAmntLbl.text = paymentAmt
        recivedAmnt.text = reciveAmt
        userNameLbl.text = transaction.beneficiaryName
        imgBgView.isHidden = true
//        configureAvatar(for: "User Name", in:imgBgView )
        createAvatar(username: transaction.beneficiaryName , view: imgBgView, font: 20)
    }
    func adjustTrackViewWidth() {
            guard let text = trackLbl.text else { return }
            
            // Calculate the label's text width
            let labelFont = trackLbl.font ?? UIFont.systemFont(ofSize: 17)
            let textWidth = text.size(withAttributes: [NSAttributedString.Key.font: labelFont]).width
            
            // Add image width and padding (adjust as needed)
            let imageWidth: CGFloat = 20
            let padding: CGFloat = 21 // Adjust padding as needed
            
            // Update the width constraint of trackView
            trackViewWidthConstraint.constant = textWidth + imageWidth + padding
        userNameTrailingConstraint.constant = textWidth + imageWidth + padding + 25
            // Animate the layout change
            UIView.animate(withDuration: 0.3) {
                self.contentView.layoutIfNeeded()
                self.trackView.clipsToBounds = true
            }
        }
}
