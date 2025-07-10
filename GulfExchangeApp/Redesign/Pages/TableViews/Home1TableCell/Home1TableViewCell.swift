//
//  Home1TableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 10/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import ScreenShield

class Home1TableViewCell: UITableViewCell {

    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var quickAccessLbl: UILabel!
    @IBOutlet weak var welcomeCollectionView: UICollectionView!
    @IBOutlet weak var QuickAccess1CollectionView: UICollectionView!
    var isWelcome:Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        ScreenShield.shared.protect(view: welcomeCollectionView)
        ScreenShield.shared.protect(view: quickAccessLbl)
        ScreenShield.shared.protect(view: welcomeLbl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.welcomeCollectionView?.register(UINib.init(nibName: "WelcomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "WelcomeCollectionCell")
        welcomeCollectionView?.delegate = self
        welcomeCollectionView?.dataSource = self
        self.QuickAccess1CollectionView?.register(UINib.init(nibName: "QuickAccess1CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "QuickAccess1CollectionCell")
        QuickAccess1CollectionView?.delegate = self
        QuickAccess1CollectionView?.dataSource = self
    }
    func setData(){
        QuickAccess1CollectionView.reloadData()
    }
}
extension Home1TableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == welcomeCollectionView{
            return 3
        }else{
            return  QuickAccess1CollectionData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == welcomeCollectionView{
            let cell = welcomeCollectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionCell", for: indexPath) as! WelcomeCollectionViewCell
            cell.setData()
            return cell
        }
        else {
            let cell = QuickAccess1CollectionView.dequeueReusableCell(withReuseIdentifier: "QuickAccess1CollectionCell", for: indexPath) as! QuickAccess1CollectionViewCell
            cell.setdata(image: QuickAccess1CollectionData[indexPath.row].image, title: QuickAccess1CollectionData[indexPath.row].title)
            cell.button.tag = indexPath.row
            cell.button?.addTarget(self, action: #selector(quickAccessTapped), for: .touchUpInside)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == welcomeCollectionView{
            return CGSize(width: welcomeCollectionView.frame.width, height: welcomeCollectionView.frame.height)
        }else{
            let width = QuickAccess1CollectionView.frame.width / 3
            return CGSize(width: width, height: 85)
//            return CGSize(width: 90, height: 90)
        }
        
    }
    
    @objc func quickAccessTapped(sender: UIButton){
        print(" QuickAccess Tapped \(sender.tag)")
    }
}
