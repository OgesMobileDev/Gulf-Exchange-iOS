//
//  ChangeSecurityQuestionsVC.swift
//  GulfExchangeApp
//
//  Created by Philip on 30/07/20.
//  Copyright © 2020 Oges. All rights reserved.
//

import UIKit

class ChangeSecurityQuestionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var securityQuesTxt: UITextField!
    @IBOutlet var answerTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var pinTxt: UITextField!
    @IBOutlet var showEyePasswordBtn: UIButton!
    @IBOutlet var showPinEyeBTn: UIButton!
    @IBOutlet var questionTVw: UITableView!
    @IBOutlet var popUp: UIView!
    
    var iconClickPassWd = true
    var iconClickPin = true

    override func viewDidLoad() {
        super.viewDidLoad()
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let appLang = appleLanguages.count > 0 ? appleLanguages[0] : "en"
        if appLang == "ar" || appLang == "ur" {
           securityQuesTxt.textAlignment = .right
           answerTxt.textAlignment = .right
           passwordTxt.textAlignment = .right
           pinTxt.textAlignment = .right
        } else {
           securityQuesTxt.textAlignment = .left
           answerTxt.textAlignment = .left
           passwordTxt.textAlignment = .left
            pinTxt.textAlignment = .left
        }
        questionTVw.delegate = self
        questionTVw.dataSource = self
        self.title = "Change Security Questions"
        let custmHelpBtn = UIBarButtonItem(image: UIImage(named: "helpDummyImg.png"), style: .done, target: self, action: #selector(heplVCAction))
        self.navigationItem.rightBarButtonItem  = custmHelpBtn
        // Do any additional setup after loading the view.
    }
//MARK:- Button Action
    @objc func heplVCAction(){
        let vc: Help1ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Help1ViewControllerID") as! Help1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func showSecurityQuestions(_ sender: Any) {
        showCountryPopUp()
    }
    @IBAction func showPassword(_ sender: Any) {
        if iconClickPassWd == true{
            passwordTxt.isSecureTextEntry = false
            showEyePasswordBtn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
            iconClickPassWd = false

        } else {
            passwordTxt.isSecureTextEntry = true
            showEyePasswordBtn.setImage(UIImage(named: "password_show_eye"), for: .normal)
            iconClickPassWd = true

        }

    }
    @IBAction func showPin(_ sender: Any) {
        if iconClickPin == true{
            pinTxt.isSecureTextEntry = false
            showPinEyeBTn.setImage(UIImage(named: "password_hide_eye"), for: .normal)
            iconClickPin = false

        } else {
            pinTxt.isSecureTextEntry = true
            showPinEyeBTn.setImage(UIImage(named: "password_show_eye"), for: .normal)
            iconClickPin = true

        }

    }
    @IBAction func saveDetails(_ sender: Any) {
    }
    
    @IBAction func closeQuesPopUp(_ sender: Any) {
        self.popUp.removeFromSuperview()
    }
//MARK:- TableView delegate & datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChangeQuestionTableViewCell
        return cell
    }
    
//MARK:- Userdefined functions
    func showCountryPopUp(){
            self.view.addSubview(popUp)
        popUp.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
            popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            popUp.alpha = 0
            UIView.animate(withDuration: 0.4){
                self.popUp.alpha = 1
                self.popUp.transform = CGAffineTransform.identity
            }
        
    }
}
