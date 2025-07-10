//
//  GolalitaSearchVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 20/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
enum selectedDropDown {
    case category
    case country
}

class GolalitaSearchVC: UIViewController {
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var categoryDropDownBtn: UIButton!
    @IBOutlet weak var countryDropDownBtn: UIButton!
    @IBOutlet var textFieldViews: [UIView]!
    @IBOutlet weak var categoreyDropDownView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var countryDropDownView: UIView!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var selCountryLbl: UILabel!
    
    let dropDownTableView = UITableView()
    let transparentView = UIView()
//    var searchCategoryItems = stockSearchCategoryItems
    //    var searchCategoryItems = GolalitaApiManager.shared.merchantCategories
    var categories:[MerchantCategory] = [MerchantCategory(error: "", id: 0, name: "All", imageURL: "", imageURL2: "", selected: false)]
    //
    var dropdownC:Bool = false
    var dropdownN:Bool = false
    //    var selectedCatDropDownItems:[SearchCategory] = []
    var selectedCatDropDownItems:[MerchantCategory] = []
    var dropdown:selectedDropDown = .category
    var currentSMPage: SideMenuSelection = .search
    var selectedCountry = ""
    var searchCountryList:[CountryList] = []
    var selectedCountryCode = 0
    let sideMenu = Bundle.main.loadNibNamed("GolalitaSideMenuView", owner: GolalitaHomeVC.self, options: nil)?.first as! GolalitaSideMenu
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        getLang()
        sideMenu.delegate = self
        searchResultTableView.isHidden = true
        searchResultTableView.isUserInteractionEnabled = true
        searchResultTableView.showsVerticalScrollIndicator = false
        getCountryList()
        self.categoryCollectionView?.register(UINib.init(nibName: "CategorySelectionCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CategorySelectionCollectionViewCell")
        self.dropDownTableView.register(UINib.init(nibName: "CategoryDropDownTableViewCell", bundle: .main), forCellReuseIdentifier: "CategoryDropDownTableViewCell")
        self.dropDownTableView.register(UINib.init(nibName: "CountryDropDownTableViewCell", bundle: .main), forCellReuseIdentifier: "CountryDropDownTableViewCell")
        self.searchResultTableView.register(UINib.init(nibName: "SearchResultsTableViewCell", bundle: .main), forCellReuseIdentifier: "SearchResultsTableViewCell")
        dropDownTableView.delegate = self
        dropDownTableView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        addNavbar()
        SetView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    @IBAction func sideMenuBtnTapped(_ sender: Any) {
        if searchResultTableView.isHidden == false{
            
            searchResultTableView.isHidden = true
            
            backBtn.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        }else{
            sideMenu.frame = CGRect.init(x:0,y:0,width:UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            sideMenu.alpha = 0.0
            sideMenu.setdata()
            view.addSubview(sideMenu)
            print("SendMoneyView")
            UIView.animate(withDuration: 0.3, animations: {
                self.sideMenu.alpha = 1.0
            })
            
            print("sideMenuBtnTapped")
        }
        
    }
    @IBAction func categoryDropDownBtnTapped(_ sender: Any) {
        dropdown = .category
        if dropdownN == true{
            dropdownN.toggle()
        }
        if dropdownC{
            removeTransparentView(frames: categoreyDropDownView.frame)
        }else{
            addTransparentView(frames: categoreyDropDownView.frame)
        }
        dropdownC.toggle()
        
    }
    @IBAction func countryDropDownBtnTapped(_ sender: Any) {
        dropdown = .country
        if dropdownC == true{
            dropdownC.toggle()
        }
        if dropdownN{
            removeTransparentView(frames: countryDropDownView.frame)
        }else{
            addTransparentView(frames: countryDropDownView.frame)
        }
        dropdownN.toggle()
    }
    @IBAction func resetBtnTapped(_ sender: Any) {
        resetTFData()
        searchTF.becomeFirstResponder()
    }
    @IBAction func searchBtnTapped(_ sender: Any) {
        var selectedCategoryId:[Int] = []
        var searchTxt = ""
        selectedCategoryId.removeAll()
        if ((searchTF.text?.isEmpty) != nil){
            searchTxt = searchTF.text ?? ""
        }
        if selectedCatDropDownItems.isEmpty || selectedCatDropDownItems[0].id == 0{
            selectedCategoryId.removeAll()
        }else{
            for i in selectedCatDropDownItems{
                selectedCategoryId.append(i.id)
            }
        }
        
        print(" search text - \(searchTxt)\n categories - \(selectedCategoryId) \n country - \(selectedCountry)\n")
        
        getSearchResults(searchTxt: searchTxt, selectedCategoryId: selectedCategoryId, selectedCountry: selectedCountryCode)
        //        let selectedCategories =
        
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
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is GolalitaHomeVC {
                    self.navigationController?.popToViewController(viewController, animated: true)
                    return
                }
            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
   
    
    
    
    func SetView(){
        //        categories[0] = MerchantCategory(id: 0, name: "ALL", imageURL: "", imageURL2: "", selected: false)
        if let aCategories = GolalitaApiManager.shared.merchantCategories{
            for i in 0..<(aCategories.count){
                categories.append(aCategories[i])
            }
        }
        let placeholderText = "Merchant Name. . ."
        let placeholderColor = UIColor.rgba(128, 142, 168, 1)
        searchTF.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        selCountryLbl.text = "Countries . . ."
        countryDropDownBtn.setTitle("", for: .normal)
        categoryDropDownBtn.setTitle("", for: .normal)
        backBtn.setTitle("", for: .normal)
        for TFviews in textFieldViews{
            addShadow(view: TFviews)
        }
        
    }
    func resetTFData(){
        searchTF.text = nil
        selCountryLbl.text = "Countries . . ."
        selectedCountry = ""
        selectedCountryCode = 0
//        searchCategoryItems = stockSearchCategoryItems
        selectedCatDropDownItems.removeAll()
        dropDownTableView.reloadData()
        categoryCollectionView.reloadData()
        for i in 0..<categories.count{
            categories[i].selected = false
        }
    }
    
    
    func addTransparentView(frames:CGRect){
        var divCount = 0
        switch dropdown {
        case .category:
            divCount = 10
            dropDownTableView.isScrollEnabled = true
        case .country:
            divCount = 6
            dropDownTableView.isScrollEnabled = true
            dropDownTableView.showsVerticalScrollIndicator = false
        }
        
        let window = UIApplication.shared.keyWindow
        
        dropDownTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + 35, width: frames.width, height:0)
        dropDownTableView.layer.borderWidth = 1
        dropDownTableView.layer.borderColor = UIColor.rgba(207, 225, 214, 1).cgColor
        dropDownTableView.layer.cornerRadius = 5
        dropDownTableView.separatorStyle = .none
        
        self.view.addSubview(dropDownTableView)
        dropDownTableView.reloadData()
        
        UIView.animate(withDuration:0.4,delay:0,usingSpringWithDamping:1,initialSpringVelocity:1,options: .curveEaseInOut,animations:{
            self.dropDownTableView.frame = CGRect(x: frames.origin.x, y:frames.origin.y + 50, width: frames.width,height: +CGFloat(divCount * 40))
        },completion: nil)
    }
    func removeTransparentView(frames:CGRect){
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations:{
            self.dropDownTableView.frame = CGRect(x:frames.origin.x, y:frames.origin.y + 35, width: frames.width,height: 0)
        },completion: nil)
        
    }
    func ShowSearchResults(){
        searchResultTableView.reloadData()
        searchResultTableView.isHidden = false
        backBtn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        resetTFData()
    }
    //Api Calls
    //MARK: - Api Calls
    func getCountryList(){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        //        let url = "https://golalita.com/go/api/gulfexc/category/merchant/lists"
        let params: Parameters = [
            "params": [
                "token": token,
                "fields":"['id','name','code']"
            ]
        ]
        AF.request(GLCountryList, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                        print("getNewMerchant Response - \(response) - \n")
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
                    GolalitaApiManager.shared.updateCountryList(from: data)
                    self.searchCountryList.removeAll()
                    self.searchCountryList = GolalitaApiManager.shared.countryList ?? []
                } else {
                    print("Error: No data in response")
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    
    func getSearchResults(searchTxt:String, selectedCategoryId:[Int], selectedCountry:Int){
        let token = GolalitaApiManager.shared.userToken
        print("Token - \(token) - \n")
        //        let url = "https://golalita.com/go/api/gulfexc/category/merchant/lists"
        var params: Parameters = [:]
        if selectedCountry == 0 {
            params = [
                "params": [
                    "token": token,
                    //                "x_online_store": null,
                    "category_id":selectedCategoryId,
                    "merchant_name":searchTxt,
                ]
            ]
        }else{
            params = [
                "params": [
                    "token": token,
                    //                "x_online_store": null,
                    "category_id":selectedCategoryId,
                    "merchant_name":searchTxt,
                    "country_id":selectedCountry
                ]
            ]
        }
        AF.request(GLGetAllMerchants, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            //            print("getNewMerchant Response - \(response) - \n")
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
                    GolalitaApiManager.shared.updateMerchantSearchDetails(from: data)
                    //                    print(GolalitaApiManager.shared.newMerchants)
                    self.ShowSearchResults()
                    
                } else {
                    print("Error: No data in response")
                }
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
    }
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



extension GolalitaSearchVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dropDownTableView{
            if dropdown == .category{
                return categories.count
            }else{
                return searchCountryList.count
            }
        }else{
            return GolalitaApiManager.shared.merchantSearch?.count ?? 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == dropDownTableView{
            if dropdown == .category{
                let cell = dropDownTableView.dequeueReusableCell(withIdentifier: "CategoryDropDownTableViewCell", for: indexPath) as! CategoryDropDownTableViewCell
                cell.setApiData(data: categories[indexPath.row])
                cell.selectionBtn.tag = indexPath.row
                return cell
            }else{
                let cell = dropDownTableView.dequeueReusableCell(withIdentifier: "CountryDropDownTableViewCell", for: indexPath) as! CountryDropDownTableViewCell
                cell.selectionBtn.isHidden = true
                cell.setData(data: searchCountryList[indexPath.row])
                return cell
            }
        }else{
            let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "SearchResultsTableViewCell", for: indexPath) as! SearchResultsTableViewCell
            cell.viewMoreBtn.tag = indexPath.row
            cell.viewMoreBtn.addTarget(self, action: #selector(searchViewMoreTapped), for: .touchUpInside)
            cell.setApiData(data: GolalitaApiManager.shared.merchantSearch?[indexPath.row])
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if tableView == dropDownTableView{
            if dropdown == .country{
                selectedCountry = searchCountryList[indexPath.row].name
                selectedCountryCode = searchCountryList[indexPath.row].id
//                selectedCountry = searchCountryItems[indexPath.row].title
                selCountryLbl.text = selectedCountry
                
                removeTransparentView(frames: countryDropDownView.frame)
            }else if dropdown == .category{
                setCategoryTableViewSelection(index: indexPath.row)
                dropDownTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
//        else{
//            let merchantID = GolalitaApiManager.shared.merchantSearch?[indexPath.row].merchantID
//            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            let vc: GLMerchantDetailsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLMerchantDetailsVC") as! GLMerchantDetailsVC
//            vc.merchantID = merchantID ?? 0
//            self.navigationController?.pushViewController(vc, animated: true)
//            print("merchant Tapped \(indexPath.row)")
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == dropDownTableView{
            return 40
        }else{
            return 150
        }
        
    }
    /*
     
     */
    @objc func countryTapped(sender: UIButton){
        selectedCountry = searchCountryList[sender.tag].name
        selectedCountryCode = searchCountryList[sender.tag].id
//        print(searchCountryItems[sender.tag].title)
    }
    @objc func searchViewMoreTapped(sender: UIButton){
        let merchantID = GolalitaApiManager.shared.merchantSearch?[sender.tag].merchantID
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let vc: GLMerchantDetailsVC = UIStoryboard.init(name: "Dummy", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLMerchantDetailsVC") as! GLMerchantDetailsVC
        vc.merchantID = merchantID ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        print("merchant Tapped \(sender.tag)")
    }
    
    func setCategoryTableViewSelection(index: Int){
        selectedCatDropDownItems.removeAll()
        categories[index].selected.toggle()
        let selection = categories[0].selected
        if index == 0{
            
            print("\nselection - \(selection)")
            for i in 0..<(categories.count){
                categories[i].selected = selection
                let row = i
                let indexPath = IndexPath(row: row, section: 0)
                dropDownTableView.reloadRows(at: [indexPath], with: .automatic)
            }
            if selection{
                selectedCatDropDownItems.append(categories[0])
            }else{
                selectedCatDropDownItems.removeAll()
            }
        }else{
            if categories[index].selected == false && categories[0].selected == true {
                categories[0].selected = false
                let indexPath = IndexPath(row: 0, section: 0)
                dropDownTableView.reloadRows(at: [indexPath], with: .automatic)
            }
            selectedCatDropDownItems = categories.filter { $0.selected }
        }
        categoryCollectionView.reloadData()
        removeTransparentView(frames: categoreyDropDownView.frame)
        dropdownC.toggle()
    }
    
}
extension GolalitaSearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            if selectedCatDropDownItems.count == 0 {
                return 1
            }else{
                return selectedCatDropDownItems.count
            }
        }else{
            return 1
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategorySelectionCollectionViewCell", for: indexPath) as! CategorySelectionCollectionViewCell
        if selectedCatDropDownItems.count == 0 {
            cell.setDefaultData()
            return cell
        }else{
            cell.setdata(data: selectedCatDropDownItems[indexPath.item])
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectedCatDropDownItems.count == 0 {
            return CGSize(width: 150, height: 50)
        }else{
            let text = selectedCatDropDownItems[indexPath.item].name // Assuming 'titles' is an array of strings
            let font = UIFont.systemFont(ofSize: 15) // Use your label's font
            
            let labelWidth = text.size(withAttributes: [NSAttributedString.Key.font: font]).width
            let cellWidth = labelWidth + 40 // 30 for imageView, 16 for padding
            
            return CGSize(width: cellWidth, height: 50) // Adjust height as needed
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCatDropDownItems.count == 0 {
            collectionView.deselectItem(at: indexPath, animated: true)
        }else{
            setCategoryCollectionViewSelection(index: indexPath.item)
        }
    }
    func setCategoryCollectionViewSelection(index: Int){
        let currentID = selectedCatDropDownItems[index].id
        selectedCatDropDownItems.remove(at: index)
        if currentID != 0{
            for i in 0..<categories.count {
                if categories[i].id == currentID {
                    categories[i].selected = false
                    break // Exit the loop once the match is found and updated
                }
            }
        }else{
            categories[0].selected.toggle()
            let selection = categories[0].selected
            for i in 0..<(categories.count){
                categories[i].selected = selection
            }
        }
        dropDownTableView.reloadData()
        categoryCollectionView.reloadData()
    }
}


extension GolalitaSearchVC: GolalitaSideMenuDelegate{
    func GolalitaSideMenu(_ vc: GolalitaSideMenu, action: SideMenuSelection) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "MainGolalita", bundle:nil)
        switch action {
        case .home:
            if currentSMPage != .home{
                if let viewControllers = self.navigationController?.viewControllers {
                    for viewController in viewControllers {
                        if viewController is GolalitaHomeVC {
                            self.navigationController?.popToViewController(viewController, animated: true)
                            break
                        }
                    }
                }else{
                    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GolalitaHomeVC") as! GolalitaHomeVC
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
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



