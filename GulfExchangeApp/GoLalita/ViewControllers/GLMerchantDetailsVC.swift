//
//  GLMerchantDetailsVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 29/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GLMerchantDetailsVC: UIViewController {
    
    @IBOutlet var emptyBtns: [UIButton]!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var merchantNameLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var timingLbl: UILabel!
    @IBOutlet weak var validTillLbl: UILabel!
    @IBOutlet weak var supportTxtView: UITextView!
    //    @IBOutlet weak var supportLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    
    
    @IBOutlet weak var offerRlbl: UILabel!
    @IBOutlet weak var offerLlbl: UILabel!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    var colorcode:String = ""
    
    var currentSMPage: SideMenuSelection = .none
    let sideMenu = Bundle.main.loadNibNamed("GolalitaSideMenuView", owner: GolalitaHomeVC.self, options: nil)?.first as! GolalitaSideMenu
    var merchantDetails:MerchantDetail?
    var merchantBanner:[Banner]?
    var merchantID = 0
    var autoScrollTimer: Timer?
    var currentIndex: Int = 0
    let layouts = UICollectionViewFlowLayout()
    var longitude:Double = 0.0
    var latitude:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        addNavbar()
        validTillLbl.isHidden = true
        setupTextView(textView: supportTxtView)
        getMerchantDetails(token: GolalitaApiManager.shared.userProfile?.token ?? "")
        self.bannerCollectionView?.register(UINib.init(nibName: "merchantBannerCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "merchantBannerCollectionViewCell")
        bannerCollectionView?.delegate = self
        bannerCollectionView?.dataSource = self
        sideMenu.delegate = self
        layouts.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        layouts.estimatedItemSize = CGSize(width: width, height: 250)
        
        self.offerRlbl.isHidden  = true
        self.offerLlbl.isHidden  = true
       // pageController.pageIndicatorTintColor = .gray
       // pageController.currentPageIndicatorTintColor = .black

                // Add pageControl to the view
       // pageController.translatesAutoresizingMaskIntoConstraints = false
               // view.addSubview(pageController)
        
        //        startAutoScroll()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        startAutoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        merchantBanner?.removeAll()
        stopAutoScroll()
    }
    
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        sideMenu.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        sideMenu.alpha = 0.0
        sideMenu.setdata()
        view.addSubview(sideMenu)
        UIView.animate(withDuration: 0.3, animations: {
            self.sideMenu.alpha = 1.0
        })
        print("sideMenuBtnTapped")
    }
    
    @IBAction func locationBtnTapped(_ sender: Any) {
//        let latitude: String = "37.7749" // Example latitude
//        let longitude: String = "-122.4194" // Example longitude
//        print(latitude)
        openGoogleMaps(latitude: latitude, longitude: longitude)
    }
    
    func setView(){
        for buttn in emptyBtns{
            buttn.setTitle("", for: .normal)
        }
    }
    func setupTextView(textView:UITextView) {
        let text = "Enjoy! Please contact support@golalita.com if you have any questions."
        
        let attributedString = NSMutableAttributedString(string: text)
        let emailRange = (text as NSString).range(of: "support@golalita.com")
       
        // Add the mailto link attribute
        attributedString.addAttribute(.link, value: "mailto:support@golalita.com", range: emailRange)
        
        textView.attributedText = attributedString
        textView.isEditable = false
        textView.isSelectable = true
        textView.dataDetectorTypes = [.link]
        textView.linkTextAttributes = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = UIColor.rgba(40, 40, 40, 1)
        // Optional: Disable scrolling and make it behave like a UILabel
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
    }
    func openGoogleMaps(latitude: Double, longitude: Double) {
        if let url = URL(string: "comgooglemaps://?q=\(latitude),\(longitude)&zoom=14&views=traffic") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback to opening in the browser if the Google Maps app is not installed
                if let webUrl = URL(string: "https://www.google.com/maps?q=\(latitude),\(longitude)&zoom=14") {
                    UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    
    func addNavbar(){
        self.navigationController?.isNavigationBarHidden = false
        if let backImage = UIImage(named: "back_arrow") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 20)).image { _ in
                backImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
            }
            let backButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(customBackButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "faq 1"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        self.navigationItem.title = "Golalita Rewards"
    }
    @objc func heplVCAction(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: HelpVC = UIStoryboard.init(name: "Main11", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getMerchantDetails(token:String) {
        print("Token - \(token) - \n")
        if merchantID == 0 || token == ""{
            print("invalid token or id")
        }else{
            let params: Parameters = [
                "params": [
                    "token": token,
                    //                "x_online_store": null,
                    //                "category_id":null,
                    //                "merchant_name":null,
                    "merchant_id": merchantID
                ]
            ]
            AF.request(GLGetAllMerchants, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                print("getMerchantDetails Response - \(response) - \n")
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                          let result = jsonResponse["result"] as? [String: Any],
                               let error = result["error"] as? String {
                                
                                // Check if the error is "Invalid User Token"
                                if error == "Invalid User Token" {
                                    self.showAlertHome(title: "Error", message: "Your session has expired. Please return to the home page")
                                } else {
                                    print("No problem with the response")
                                    // Handle other cases here if needed
                                }
                            }
                        } catch {
                            print("Error parsing JSON: \(error.localizedDescription)")
                        }
                        GolalitaApiManager.shared.updateMerchantDetails(from: data)
                        
                            self.setApiData(merchantDetails: GolalitaApiManager.shared.merchantDetails)
                            self.bannerCollectionView.reloadData()
                            //                        self.startAutoScroll()
                            
                            print("self.merchantBanner?.count ?? 0: \(self.merchantBanner?.count ?? 0)")
                            self.pageController.numberOfPages = self.merchantBanner?.count ?? 0
                            self.pageController.currentPage = 0
                        
                    } else {
                        print("Error: No data in response")
                    }
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            })
        }
        
    }

    func setApiData(merchantDetails:MerchantDetail?){
//        validTillLbl.text = "Valid till: --"
        merchantBanner = GolalitaApiManager.shared.merchantDetails?.banners
        latitude = merchantDetails?.partnerLatitude ?? 0.00
        longitude = merchantDetails?.partnerLongitude ?? 0.00
        urlToImg(urlString: merchantDetails?.merchantLogo ?? "", to: logoImage)
        titleLbl.text = merchantDetails?.category
        merchantNameLbl.text = merchantDetails?.merchantName
        categoryLbl.text = merchantDetails?.category
        countryLbl.text = merchantDetails?.countryName
        if let openFrom = merchantDetails?.openFrom, let openTill = merchantDetails?.openTill {
            let openHours = "\(openFrom) - \(openTill)"
            timingLbl.text = openHours
        } else {
            timingLbl.text = "Hours not available" // Handle the case where values are nil
        }
        
        
//        colorcode = (merchantDetails?.ribbonText)!
//        print("colorcodevv - \(colorcode) - \n")
        if merchantDetails?.ribbonPosition == "right"
        {
            self.offerRlbl.isHidden  = false
            //self.offerRlbl.backgroundColor = UIColor(hex: "#1cc3a3")
            self.offerRlbl.backgroundColor = UIColor(hex: (merchantDetails?.ribbonColor) ?? "")
        }
        else
        {
            self.offerLlbl.isHidden  = false
            self.offerLlbl.backgroundColor = UIColor(hex: (merchantDetails?.ribbonColor) ?? "")
        }
        
        self.offerRlbl.text = merchantDetails?.ribbonText
        self.offerLlbl.text = merchantDetails?.ribbonText
        
        
        
       
        
        
    }
    
    
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideTonext), userInfo: nil, repeats: true)
        //        autoScrollTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(scrollCollectionView), userInfo: nil, repeats: true)
        //        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    @objc func slideTonext(){
        print("scroll")
        print(merchantBanner?.count ?? 100)
        if currentIndex < (merchantBanner?.count ?? 1) - 1
        {
            currentIndex = currentIndex + 1
        }else{
            currentIndex = 0
        }
        print(currentIndex)
        //        pageControllerOne.currentPage = currentcellIndex
        bannerCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .left, animated: true)
        
//        self.pageController.numberOfPages = self.merchantBanner?.count ?? 0
//        self.pageController.currentPage = 0
//        
//        if self.self.self.merchantBanner?.isEmpty == true
//                                    {
//                                       //self.pageController.isHidden = true
//                                        self.pageController.numberOfPages = 0
//                                    }
    }
    
    @objc func scrollCollectionView() {
        let visibleItems = bannerCollectionView.indexPathsForVisibleItems
        guard let currentItemIndex = visibleItems.first else { return }
        print(currentItemIndex)
        print(visibleItems)
        // Calculate the desired content offset based on your scrolling logic
        //        let contentOffset = CGPoint(x: bannerCollectionView.contentOffset.x + 10, y: 0)
        //        let nextIndex = currentIndex + 1
        //        let numberOfItems = merchantBanner?.count ?? 0
        //        currentIndex = nextIndex < numberOfItems ? nextIndex : 0
        //        bannerCollectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .left, animated: true)
    }
    
    @objc func scrollToNextItem() {
        let numberOfItems = merchantBanner?.count ?? 0
        
        let nextIndex = currentIndex + 1
        currentIndex = nextIndex < numberOfItems ? nextIndex : 0
        
        let nextIndexPath = IndexPath(item: currentIndex, section: 0)
        bannerCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        currentIndex += 1
    }
    //    @objc func scrollToNextItem() {
    //        let visibleItems = bannerCollectionView.indexPathsForVisibleItems
    //        guard let currentItemIndex = visibleItems.first else { return }
    //
    //        let nextItemIndex = IndexPath(item: currentItemIndex.item + 1, section: currentItemIndex.section)
    //        print("+1 out \n")
    //        // Check if the next item exists
    //        if nextItemIndex.item < merchantBanner?.count ?? 0 {
    //            // Scroll to the next item to the right
    //            print(" scroll out \n")
    //            bannerCollectionView.scrollToItem(at: nextItemIndex, at: .centeredHorizontally, animated: true)
    //        } else {
    //            print("0 out \n")
    //            // If we're at the last item, loop back to the first item
    //            let firstItemIndex = IndexPath(item: 0, section: currentItemIndex.section)
    //            bannerCollectionView.scrollToItem(at: firstItemIndex, at: .centeredHorizontally, animated: true)
    //        }
    //    }
    /*
     Enjoy! Please contact support@golalita.com if you have any concern.
     */
    
    func showAlert(title: String, message: String){
        let commonAlert = UIAlertController(title:title, message:message, preferredStyle:.alert)
        let okAction = UIAlertAction(title:"OK", style: .cancel)
        commonAlert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(commonAlert, animated: true, completion: nil)
    }
    func showAlertHome(title: String, message: String) {
        let commonAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            // Navigate to HomeViewController
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main10", bundle:nil)
            if let viewControllers = self.navigationController?.viewControllers {
                for viewController in viewControllers {
                    if viewController is CustomTabController {
                        self.navigationController?.popToViewController(viewController, animated: true)
                        break
                    }
                }
            }else{
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomTabController") as! CustomTabController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        
        commonAlert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(commonAlert, animated: true, completion: nil)
    }

    
    
}

extension GLMerchantDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        merchantBanner?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "merchantBannerCollectionViewCell", for: indexPath) as! merchantBannerCollectionViewCell
        cell.setData(data: merchantBanner?[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 250)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleIndexPath = bannerCollectionView.indexPathsForVisibleItems.first
        currentIndex = visibleIndexPath?.item ?? 0
    }
    
}








extension GLMerchantDetailsVC: GolalitaSideMenuDelegate{
    func GolalitaSideMenu(_ vc: GolalitaSideMenu, action: SideMenuSelection) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainGolalita", bundle:nil)
        switch action {
        case .home:
            if currentSMPage != .home{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaHomeVC") as! GolalitaHomeVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .profile:
            if currentSMPage != .profile{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaProfileVC") as! GolalitaProfileVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .card:
            if currentSMPage != .card{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaCardsVC") as! GolalitaCardsVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .offers:
            if currentSMPage != .offers{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaOffersVC") as! GolalitaOffersVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .search:
            if currentSMPage != .search{
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaSearchVC") as! GolalitaSearchVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        case .none:
            print("Error None selected for sidemenu delegate")
        }
    }
    
    
}


extension UIColor {
    convenience init(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        if hex.count != 6 {
            self.init(white: 1.0, alpha: 1.0)
            return
        }
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}



