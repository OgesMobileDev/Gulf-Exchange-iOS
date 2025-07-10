//
//  SearchResultsTableViewCell.swift
//  GulfExchangeApp
//
//  Created by macbook on 21/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var merchantTitle: UILabel!
    @IBOutlet weak var categoryImgView: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    
    
    @IBOutlet weak var ratingview: UIView!
    
    @IBOutlet weak var rateonebtn: UIButton!
    
    @IBOutlet weak var ratetwobtn: UIButton!
    
    @IBOutlet weak var ratethreebtn: UIButton!
    
    
    @IBOutlet weak var ratefourbtn: UIButton!
    
    
    @IBOutlet weak var ratefivebtn: UIButton!
    
    @IBOutlet weak var viewMoreBtn: UIButton!
    
    //private let ratingView = RatingView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewMoreBtn.setTitle("", for: .normal)
        addShadow(view: baseView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setApiData(data:MerchantDetail?){
        urlToImg(urlString: data?.merchantLogo ?? "", to: profileImgView)
        merchantTitle.text = data?.merchantName
        categoryLbl.text = data?.category
        countryLbl.text = data?.countryName
        print(data?.rating)
        
        if data?.rating == "1"
        {
            rateonebtn.isHidden = false
            ratetwobtn.isHidden = true
            ratethreebtn.isHidden = true
            ratefourbtn.isHidden = true
            ratefivebtn.isHidden = true
        }
        else if data?.rating == "2"
        {
            rateonebtn.isHidden = false
            ratetwobtn.isHidden = false
            ratethreebtn.isHidden = true
            ratefourbtn.isHidden = true
            ratefivebtn.isHidden = true
        }
        else if data?.rating == "3"
        {
            rateonebtn.isHidden = false
            ratetwobtn.isHidden = false
            ratethreebtn.isHidden = false
            ratefourbtn.isHidden = true
            ratefivebtn.isHidden = true
        }
        else if data?.rating == "4"
        {
            rateonebtn.isHidden = false
            ratetwobtn.isHidden = false
            ratethreebtn.isHidden = false
            ratefourbtn.isHidden = false
            ratefivebtn.isHidden = true
        }
        else if data?.rating == "5"
        {
            rateonebtn.isHidden = false
            ratetwobtn.isHidden = false
            ratethreebtn.isHidden = false
            ratefourbtn.isHidden = false
            ratefivebtn.isHidden = false
        }
        else
        {
            rateonebtn.isHidden = true
            ratetwobtn.isHidden = true
            ratethreebtn.isHidden = true
            ratefourbtn.isHidden = true
            ratefivebtn.isHidden = true
        }
        
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // If you're using Interface Builder, you might not need to set this up programmatically
    }
    
    func configure(with rating: Int) {
       // ratingview.setRating(rating)
    }

    
    
    
//    func configure(with rating: Int) {
//        ratingview.setRating(rating)
//      }
}
