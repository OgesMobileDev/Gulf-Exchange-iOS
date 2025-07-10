//
//  OTPView.swift
//  GulfExchangeApp
//
//  Created by macbook on 07/11/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import DigitEntryView
import ScreenShield

protocol OTPViewDelegate {
    func OTPView(_ vc: OTPView, otp:String)
    func OTPView(_ vc: OTPView, resend:Bool)
    func OTPView(_ vc: OTPView, close:Bool)
}

class OTPView: UIView, UITextFieldDelegate, DigitEntryViewDelegate{
    
    var delegate: OTPViewDelegate?
    @IBOutlet weak var screenShotView: UIView!
    @IBOutlet weak var progressBaseView: UIView!
    @IBOutlet weak var otpTitleLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var textFieldBaseView: UIView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var didntReciveLbl: UILabel!
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var resendOtpLbl: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var verifyLbl: UILabel!
    @IBOutlet weak var clearAllBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var closeImg: UIImageView!
    
    let defaults = UserDefaults.standard
    
    var timer = Timer()
    var seconds = 30
    var otpString:String = ""
    var mobNum:String = ""
    let numberOfFields = 4
    let progressBar = CircularProgressBar()
    var digitEntryView = DigitEntryView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        didntReciveLbl.text = "Didn't receive an OTP"
        //        ScreenShield.shared.protect(view: progressBaseView)
//                ScreenShield.shared.protect(view: otpTitleLbl)
//                ScreenShield.shared.protect(view: numberLbl)
        //        ScreenShield.shared.protect(view: textFieldBaseView)
//                ScreenShield.shared.protect(view: timerLbl)
//                ScreenShield.shared.protect(view: didntReciveLbl)
//                ScreenShield.shared.protect(view: resendOtpLbl)
//                ScreenShield.shared.protect(view: verifyLbl)
//                ScreenShield.shared.protect(view: textFieldBaseView)
        
    }
    func setView(){
        //        ScreenShield.shared.protect(view: screenShotView)
        setupOtpField()
        let attributedTitle = buttonTitleSetWithColor(title: "Clear All", size: 10, font: .regular, color: UIColor.rgba(198, 23, 30, 1))
        clearAllBtn.setAttributedTitle(attributedTitle, for: .normal)
        clearAllBtn.isHidden = true
        verifyBtn.setTitle("", for: .normal)
        resendOtpBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        resendOtpBtn.isEnabled = false
        resendOtpLbl.isHidden = true
        didntReciveLbl.isHidden = true
        seconds = 30
        startTimer()
        progressBaseView.clipsToBounds = true
        progressBar.frame = CGRect(x: progressBaseView.bounds.width - 10, y: 10, width: 20, height: 20)
        progressBaseView.addSubview(progressBar)
        numberLbl.text = "Enter the verification code we just sent to your number \(mobNum)."
        
        resendOtpLbl.text = (NSLocalizedString("resend_otp", comment: ""))
        verifyLbl.text = (NSLocalizedString("Verify", comment: ""))
        
        
        
        setTxtToSpeech()
    }
    func resetView(){
        digitEntryView.removeFromSuperview()
        digitEntryView.text = ""
        progressBar.timerInvalidate()
        timer.invalidate()
        resendOtpBtn.isEnabled = false
        resendOtpLbl.isHidden = true
        didntReciveLbl.isHidden = true
        seconds = 30
        otpString.removeAll()
        
    }
    
    func setTxtToSpeech(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLblTapped(_:)))
        otpTitleLbl.isUserInteractionEnabled = true
        otpTitleLbl.addGestureRecognizer(tapGesture)
    }
    
    @objc func titleLblTapped(_ sender: UITapGestureRecognizer) {
        print("label tapped")
        if defaults.bool(forKey: "accessibilityenabled"){
            if let label = sender.view as? UILabel {
                SpeechHelper.shared.speak("otp verification", languageCode: "en")
            }
        }
    }
    
    @IBAction func resendOtpBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("resend", languageCode: "en")
        }
        
        delegate?.OTPView(self, resend: true)
        resendOtpBtn.isEnabled = false
        resendOtpLbl.isHidden = true
        didntReciveLbl.isHidden = true
        seconds = 30
        startTimer()
        
    }
    @IBAction func verifyBtnTapped(_ sender: Any) {
        
        if defaults.bool(forKey: "accessibilityenabled"){
            SpeechHelper.shared.speak("verify", languageCode: "en")
        }
        
        if otpString.count == 4{
            delegate?.OTPView(self, otp: otpString)
            print("delegate\(otpString)")
        }else{
            showAlert(title: "Error", message: "Please type the PIN properly")
        }
    }
    @IBAction func clearAllBtnTapped(_ sender: Any) {
        digitEntryView.text = ""
    }
    @IBAction func closebtnTapped(_ sender: Any) {
        delegate?.OTPView(self, close: true)
    }
    
    
    func startTimer(){
        resendOtpLbl.textColor = .gray
        timerLbl.isHidden = false
        timerLbl.text = "00.30"
        progressBar.start1MinuteCountdown()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if seconds > 0{
            seconds -= 1
            timerLbl.text = "00.\(seconds)"
        }else{
            resendOtpLbl.textColor = .black
            resendOtpBtn.isEnabled = true
            resendOtpLbl.isHidden = false
            didntReciveLbl.isHidden = false
            timerLbl.isHidden = true
            progressBar.timerInvalidate()
            timer.invalidate()
        }
        if seconds > 9{
            timerLbl.text = "00.\(seconds)"
        }else{
            timerLbl.text = "00.0\(seconds)"
        }
    }
    func setupOtpField(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.dismissKeyboard))
        toolbar.setItems([done], animated: true)
        
        digitEntryView.numberOfDigits = 4
        digitEntryView.digitColor = UIColor.black
        digitEntryView.digitFont = .systemFont(ofSize: 20)
        digitEntryView.digitCornerStyle = .radius(0)
        
        digitEntryView.digitBorderColor = UIColor.rgba(255, 229, 229, 1)
        digitEntryView.nextDigitBorderColor = UIColor.rgba(198, 23, 30, 1)
        digitEntryView.delegate = self
        digitEntryView.frame = textFieldBaseView.bounds
        digitEntryView.becomeFirstResponder()
        for subview in digitEntryView.subviews {
            if let textField = subview as? UITextField {
                textField.inputAccessoryView = toolbar
            }
        }
        ScreenShield.shared.protect(view: digitEntryView)
        textFieldBaseView.addSubview(digitEntryView)
    }
    @objc func dismissKeyboard() {
        digitEntryView.resignFirstResponder()
    }
    func digitsDidFinish(_ digitEntryView: DigitEntryView) {
        digitEntryView.resignFirstResponder()
        otpString = digitEntryView.text
        print(digitEntryView.text)
    }
    
    func digitsDidChange(_ digitEntryView: DigitEntryView) {
        print(digitEntryView.text)
        
    }
}





/*
 func addTxtField(){
 let width:CGFloat = 50
 let spacing:CGFloat = ((textFieldBaseView.frame.width - 200) / 3)
 for i in 0...3 {
 let textField = UITextField(frame: CGRect(x: CGFloat(i*(Int(width) + Int(spacing))), y: 0, width: width, height: 50))
 textField.backgroundColor = .white
 textField.textColor = .black
 textField.textAlignment = .center
 textField.keyboardType = .numberPad
 textField.borderStyle = .none
 textField.delegate = self
 textField.isSecureTextEntry = false
 textField.tag = i
 textField.layer.cornerRadius = 0
 textField.layer.borderWidth = 1
 textField.layer.borderColor = UIColor.rgba(255, 229, 229, 1).cgColor
 textFields.append(textField)
 textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
 textFieldBaseView.addSubview(textField)
 }
 }
 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 // Check if there is already a character in the text field
 let currentText = textField.text ?? ""
 
 // Only allow input if the new string will have 1 or fewer characters
 let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
 return newText.count <= 1
 // Pasting functionality
 
 }
 func textField(_ textField: UITextField, shouldPasteWith otp: String) {
 // Only allow pasting if the length of the text matches the number of fields
 if otp.count == numberOfFields {
 fillOTP(otp)
 }
 }
 
 func fillOTP(_ otp: String) {
 // Distribute each character of OTP to the text fields
 for (index, character) in otp.enumerated() {
 if index < textFields.count {
 textFields[index].text = String(character)
 textFields[index].resignFirstResponder()
 }
 }
 }
 @objc func textFieldDidChange(textField:UITextField) {
 
 let text = textField.text
 for i in 0...3{
 switch textField {
 case textFields[i]:
 if i<3{
 textFields[i+1].becomeFirstResponder()
 }else{
 textFields[i].resignFirstResponder()
 }
 default:
 break
 }
 }
 if text?.count == 0{
 
 for i in 0...3 {
 switch textField {
 case textFields[i]:
 if i>0{
 textFields[i-1].becomeFirstResponder()
 }else{
 textFields[i].becomeFirstResponder()
 }
 default:
 break
 
 }
 }
 }
 }
 */







