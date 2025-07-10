//
//  Home2TableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 10/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

protocol Home2TableViewCellDelegate:AnyObject{
    func Home2TableViewCell(_ vc: Home2TableViewCell, index: Int
    )
}
class Home2TableViewCell: UITableViewCell {
    
    weak var delegate: Home2TableViewCellDelegate?
    @IBOutlet weak var quickAccess2CollectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cardImgView: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
//    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var cardNumberLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var expLbl: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var quickAccessLbl: UILabel!
    
    var userName:String = ""
    var timer: Timer?
    
    override func awakeFromNib() {
           super.awakeFromNib()
//        ScreenShield.shared.protect(view: userNameLbl)
//        ScreenShield.shared.protect(view: seeAllBtn)
       }

       override func prepareForReuse() {
           super.prepareForReuse()
           stopUpdatingTime() // Stop any existing timer when the cell is reused
       }

    @IBAction func seeAllBtnTapped(_ sender: Any) {
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.quickAccess2CollectionView?.register(UINib.init(nibName: "QuickAccess1CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "QuickAccess1CollectionCell")
        quickAccess2CollectionView?.delegate = self
        quickAccess2CollectionView?.dataSource = self
        topView.layer.cornerRadius = 10
        topView.clipsToBounds = true
        //seeAllBtn.setAttributedTitle(buttonTitleSet(title: "See All", size: 10, font: .semiBold), for: .normal)
        seeAllBtn.tintColor = UIColor.init(named: "color_dark_red")
        
        seeAllBtn.setAttributedTitle(buttonTitleSet(title: NSLocalizedString("See All", comment: ""), size: 10, font: .semiBold), for: .normal)
//        rgba(198, 23, 30, 1)
        // Example usage
        let formattedDate = getFormattedDate()
        dayLbl.text = formattedDate
        
    }
    func setScreenshoot(){
//        ScreenShield.shared.protect(view: topView)
        ScreenShield.shared.protect(view: quickAccessLbl)
        ScreenShield.shared.protect(view: seeAllBtn)
    }
    func startUpdatingTime() {
        quickAccess2CollectionView.reloadData()
            updateCurrentTime() // Update immediately
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
    }

    func stopUpdatingTime() {
            timer?.invalidate()
            timer = nil
    }
    @objc func updateCurrentTime() {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a" // Adjust the format as needed
            formatter.locale = Locale(identifier: "en_US_POSIX")
            timeLbl.text = formatter.string(from: date)
        }
    func getFormattedDate() -> String {
        let date = Date() // Current date and time
        let formatter = DateFormatter()
        
        // Set the desired date format
        formatter.dateFormat = "EEEE d MMM"
        
        // Set locale to ensure consistent day and month names
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: date)
    }

    

    
}
extension Home2TableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QuickAccess2CollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quickAccess2CollectionView.dequeueReusableCell(withReuseIdentifier: "QuickAccess1CollectionCell", for: indexPath) as! QuickAccess1CollectionViewCell
        cell.setdata(image: QuickAccess2CollectionData[indexPath.row].image, title: QuickAccess2CollectionData[indexPath.row].title)
        cell.button.tag = indexPath.row
        cell.button?.addTarget(self, action: #selector(quickAccessTapped), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = quickAccess2CollectionView.frame.width / 3
        return CGSize(width: width, height: 85)
//        return CGSize(width: 90, height: 85)
        
        
    }
    
    @objc func quickAccessTapped(sender: UIButton){
        print(" QuickAccess Tapped \(sender.tag)")
        delegate?.Home2TableViewCell(self, index: sender.tag)
       
    }
    
}
