//
//  OCRReadingVC.swift
//  GulfExchangeApp
//
//  Created by macbook on 16/05/2024.
//  Copyright © 2024 Oges. All rights reserved.
//

import UIKit
import Vision

class OCRReadingVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    var qidNo:String?
    var expiryDate: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //newbackbtn
        let custmBackBtn = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .done, target: self, action: #selector(Backbtnaction))
        self.navigationItem.leftBarButtonItem  = custmBackBtn
        
        //self.recognizeTextInImage(UIImage(named: "dummyIDImg")!)
        // Protect ScreenShot
        
    }
    
   
    @objc func Backbtnaction()
    {
        let nextViewController  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    @IBAction func scanDocumentOnClick(_ sender: Any) {
        openCamera()
        
    }
    @IBAction func skipOCR(_ sender: Any) {
        let vc: RegisterViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerr") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func openCamera() {
        // Check if the camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            // If the camera is not available (e.g., in a simulator), show an alert
            let alert = UIAlertController(title: "Camera not available", message: "This device has no camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    // UIImagePickerControllerDelegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            // Do something with the image (e.g., save it, display it, etc.)
            // For demonstration, we just dismiss the picker
            print("Image captured: \(image)")
            // Perform OCR on the captured image
            self.recognizeTextInImage(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func recognizeTextInImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else {
            print("Unable to get CGImage from UIImage")
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { [weak self] (request, error) in
            if let error = error {
                print("Error recognizing text: \(error.localizedDescription)")
                return
            }
            
            self?.processRecognizedText(request)
        }
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Failed to perform text recognition request: \(error.localizedDescription)")
        }
    }
    
    func processRecognizedText(_ request: VNRequest) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            print("No text found")
            return
        }
        
        var numbers = [String]()
        var found11DigitNumber = false
        var dates = [Date]()
               
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        for observation in observations {
            guard let bestCandidate = observation.topCandidates(1).first else { continue }
            print("Found text: \(bestCandidate.string)")
            
            let text = bestCandidate.string
            
            // Extract 11-digit number
            let numberPattern = "\\b\\d{11}\\b"
            if let numberRange = text.range(of: numberPattern, options: .regularExpression) {
                let number = String(text[numberRange])
                numbers.append(number)
                found11DigitNumber = true
            }
            
            // Extract expiry date
    
           /* let expiryPattern = "\\b(\\d{2}/\\d{2}/\\d{4})\\b"
            if let expiryRange = text.range(of: expiryPattern, options: .regularExpression) {
                let expiry = String(text[expiryRange])
                self.expiryDate = expiry
            }*/
            
            let expiryPattern = "\\b(\\d{2}/\\d{2}/\\d{4})\\b"
                        if let expiryRange = text.range(of: expiryPattern, options: .regularExpression) {
                            let dateStr = String(text[expiryRange])
                            if let date = dateFormatter.date(from: dateStr) {
                                dates.append(date)
                            }
                        }
        }
        
        if found11DigitNumber {
            let numberString = numbers.joined(separator: "\n")
            UserDefaults.standard.set(numberString, forKey: "recognizedText")
            print("numberStringnumberString",numberString)
           
        } else {
            openCamera()
            let alert = UIAlertController(title: "No 11-digit number found", message: "Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        if dates.count == 2 {
                    let sortedDates = dates.sorted()
                    self.expiryDate = dateFormatter.string(from: sortedDates[1])
                    
                    if let expiry = self.expiryDate {
                        UserDefaults.standard.set(expiry, forKey: "recognizedExpiryText")
                        print("Expiry date found: \(expiry)")
                    }
                } else {
                    let alert = UIAlertController(title: "No expiry date found", message: "Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
        
//        if let expiry = self.expiryDate {
//            UserDefaults.standard.set(expiry, forKey: "recognizedExpiryText")
//            print("expiryexpiry",expiry)
//           
//        } else {
//            let alert = UIAlertController(title: "No expiry date found", message: "Please try again.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//        }
        
        // Check if both the 11-digit number and expiry date are found
        if found11DigitNumber && self.expiryDate != nil {
            
            if let recognizedText = UserDefaults.standard.string(forKey: "recognizedText"),
               let recognizedExpiryText = UserDefaults.standard.string(forKey: "recognizedExpiryText") {
                print("Recognized Text: \(recognizedText)")
                print("Recognized Expiry Date: \(recognizedExpiryText)")
                
                DispatchQueue.main.async {
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let vc: RegisterViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerr") as! RegisterViewController
                    
                    vc.str_id_no = recognizedText
                    vc.qidexpdatestr = recognizedExpiryText
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
           
        }
    }
}
