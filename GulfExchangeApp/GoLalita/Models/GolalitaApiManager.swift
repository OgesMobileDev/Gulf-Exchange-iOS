//
//  GetTokenAPI.swift
//  GulfExchangeApp
//
//  Created by macbook on 27/08/2024.
//  Copyright © 2024 Oges. All rights reserved.
//
import Foundation
import CommonCrypto
import CryptoKit
import Security
//import CryptoSwift

// Singleton class to manage the user profile
class GolalitaApiManager {
    static let shared = GolalitaApiManager()
    
    private init() {}  // Ensure this class cannot be instantiated from outside
    
    var userProfile: UserProfileToken?
    var merchantCategories: [MerchantCategory]?
    var newMerchants: [Merchant]?
    var allMerchants: [MerchantDetail]?
    var merchantSearch: [MerchantDetail]?
    var merchantList: [MerchantDetail]?
    var merchantDetails:MerchantDetail?
    var UserCardProfile: UserProfileModel?
    var allOffersList:[OffersDetailsList]?
    var promocodeOffersList:[OffersDetailsList]?
    var b1g1OffersList:[OffersDetailsList]?
    var discountOffersList:[OffersDetailsList]?
    var offerDetails:[OffersDetails]?
    var Notification: [NotificationList]?
    var countryList:[CountryList]?
    var allOffersCombined:[OffersDetailsList] = []
    var userToken:String = ""
    // Function to update the user profile
    func updateUserProfile(from data: Data) {
        do {
            let userProfileResponse = try JSONDecoder().decode(UserProfileResponse.self, from: data)
            self.userProfile = userProfileResponse.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateCategory(from data: Data){
        do {
            let categoryResponse = try JSONDecoder().decode(MerchantCategoryResponse.self, from: data)
            self.merchantCategories = categoryResponse.result
            
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateUserCardData(from data: Data) {
        do {
            let userProfileResponse = try JSONDecoder().decode(UserProfileModelResponse.self, from: data)
            self.UserCardProfile = userProfileResponse.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateNewMerchant(from data: Data){
        do {
            print("success")
            let newMerchantResponse = try JSONDecoder().decode(NewMerchantResponse.self, from: data)
            self.newMerchants = newMerchantResponse.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateNotification(from data: Data){
        do {
            print("success")
            let newMerchantResponse = try JSONDecoder().decode(NotificationMessage.self, from: data)
            self.Notification = newMerchantResponse.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    
    
    func updateAllMerchant(from data: Data){
        do {
            print("success")
            let allMerchantResponse = try JSONDecoder().decode(AllMerchantResponse.self, from: data)
            self.allMerchants = allMerchantResponse.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateCategorySearch(from data: Data){
        do {
            print("success")
            let allMerchantResponse = try JSONDecoder().decode(AllMerchantResponse.self, from: data)
            self.merchantList = allMerchantResponse.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateMerchantDetails(from data: Data) {
        do {
            print("success")
            let allMerchantResponse = try JSONDecoder().decode(AllMerchantResponse.self, from: data)
            self.merchantDetails = allMerchantResponse.result[0]
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateAllOffers(from data: Data) {
        do {
            print("success")
            let allOffersList = try JSONDecoder().decode(AllOffersResponse.self, from: data)
            // Assuming your array is of type [OffersDetailsList]
//            let filteredArray = allOffersList.result.filter { (($0.xOfferType?.isEmpty) == nil) }
            let filteredArray = allOffersList.result.filter { !["", "0", "false"].contains($0.xOfferType) }

            self.allOffersList = filteredArray
//            allOffersList.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateAllOffersPromocode(from data: Data) {
        do {
            print("success")
            let allOffersList = try JSONDecoder().decode(AllOffersResponse.self, from: data)
            self.promocodeOffersList = allOffersList.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateAllOffersB1G1(from data: Data) {
        do {
            print("success")
            let allOffersList = try JSONDecoder().decode(AllOffersResponse.self, from: data)
            self.b1g1OffersList = allOffersList.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateAllOffersDiscount(from data: Data) {
        do {
            print("success")
            let allOffersList = try JSONDecoder().decode(AllOffersResponse.self, from: data)
            self.discountOffersList = allOffersList.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateOfferDetails(from data: Data) {
        do {
            print("success")
            let offerDetails = try JSONDecoder().decode(OfferDetailsResponse.self, from: data)
            self.offerDetails = offerDetails.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateAllOfferDetails(){
        allOffersList?.removeAll()
        allOffersCombined.removeAll()
        
        if let promocodeOffersList = promocodeOffersList {
            allOffersCombined.append(contentsOf: promocodeOffersList)
        }

        if let b1g1OffersList = b1g1OffersList {
            allOffersCombined.append(contentsOf: b1g1OffersList)
        }

        if let discountOffersList = discountOffersList {
            allOffersCombined.append(contentsOf: discountOffersList)
        }
        print(allOffersCombined)
        allOffersList = allOffersCombined
    }
    func updateMerchantSearchDetails(from data: Data){
        do {
            print("success")
            let allMerchantResponse = try JSONDecoder().decode(AllMerchantResponse.self, from: data)
            self.merchantSearch = allMerchantResponse.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func updateCountryList(from data: Data){
        do {
            print("success")
            let countryListResponse = try JSONDecoder().decode(CountryListResponse.self, from: data)
            self.countryList = countryListResponse.result
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    func clearAll(){
        userToken = ""
        userProfile = nil
        merchantCategories?.removeAll()
        newMerchants?.removeAll()
        allMerchants?.removeAll()
        merchantSearch?.removeAll()
        merchantList?.removeAll()
        merchantDetails = nil
        UserCardProfile = nil
        allOffersCombined.removeAll()
        allOffersList?.removeAll()
        promocodeOffersList?.removeAll()
        b1g1OffersList?.removeAll()
        discountOffersList?.removeAll()
        offerDetails?.removeAll()
        Notification?.removeAll()
        countryList?.removeAll()
    }
}








//MARK: Password Encryption

// Method to generate a 32-character AES key (256-bit)
func getKey(_ key: String) -> Data? {
    var keyPadded = key
    if keyPadded.count < 32 {
        keyPadded = keyPadded.padding(toLength: 32, withPad: " ", startingAt: 0)
    } else if keyPadded.count > 32 {
        keyPadded = String(keyPadded.prefix(32))
    }
    return keyPadded.data(using: .utf8)
}

// Method to encrypt the plaintext
func encrypt(plaintext: String, key: String) -> String? {
    guard let keyData = getKey(key) else { return nil }
    
    // Generate a random 16-byte (128-bit) IV
    var iv = Data(count: kCCBlockSizeAES128)
    _ = iv.withUnsafeMutableBytes { ivBytes in
        SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBytes)
    }

    let ivBytes = [UInt8](iv)
    let ivPtr = UnsafeRawPointer(ivBytes)

    guard let data = plaintext.data(using: .utf8) else { return nil }
    
    // Prepare buffers
    let bufferSize = data.count + kCCBlockSizeAES128
    var buffer = Data(count: bufferSize)
    
    // Perform encryption
    var numBytesEncrypted: size_t = 0
    let cryptStatus = buffer.withUnsafeMutableBytes { bufferBytes in
        data.withUnsafeBytes { dataBytes in
            keyData.withUnsafeBytes { keyBytes in
                CCCrypt(
                    CCOperation(kCCEncrypt),
                    CCAlgorithm(kCCAlgorithmAES),
                    CCOptions(kCCOptionPKCS7Padding),
                    keyBytes.baseAddress, kCCKeySizeAES256,
                    ivPtr,
                    dataBytes.baseAddress, data.count,
                    bufferBytes.baseAddress, bufferSize,
                    &numBytesEncrypted
                )
            }
        }
    }

    if cryptStatus == kCCSuccess {
        // Combine IV and encrypted data
        let encryptedData = buffer.prefix(numBytesEncrypted)
        let encryptedDataWithIv = iv + encryptedData
        
        // Encode to Base64
        return encryptedDataWithIv.base64EncodedString()
    } else {
        return nil
    }
}


func encryptStringss(_ plaintext: String, withKey key: String, iv: Data) -> String {
    // Convert the key and plaintext to Data
    guard let keyData = key.data(using: .utf8), let plaintextData = plaintext.data(using: .utf8) else {
        return ""
    }

    // Prepare output buffer
    let outputLength = plaintextData.count + kCCBlockSizeAES128
    var output = Data(count: outputLength)
//    let iv = generateRandomIV(length: 16)
    // Perform encryption
    var numBytesEncrypted = 0
    let cryptStatus = keyData.withUnsafeBytes { keyBytes in
        iv.withUnsafeBytes { ivBytes in
            plaintextData.withUnsafeBytes { dataBytes in
                output.withUnsafeMutableBytes { outputBytes in
                    CCCrypt(
                        CCOperation(kCCEncrypt),                  // Operation
                        CCAlgorithm(kCCAlgorithmAES),             // Algorithm
                        CCOptions(kCCOptionPKCS7Padding),         // Options
                        keyBytes.baseAddress, kCCKeySizeAES256,   // Key and key length
                        ivBytes.baseAddress,                      // IV
                        dataBytes.baseAddress, plaintextData.count, // Data and data length
                        outputBytes.baseAddress, outputLength,    // Output buffer
                        &numBytesEncrypted
                        // Number of bytes encrypted
                    )
                }
            }
        }
    }

    // Check if encryption was successful
    if cryptStatus == kCCSuccess {
        // Combine IV and encrypted data
        let encryptedData = output[..<numBytesEncrypted]
        print("encrypted data \(encryptedData.base64EncodedString())")
        let encryptedDataWithIV = iv + encryptedData

        // Base64 encode the combined data
        let encryptedBase64 = encryptedDataWithIV.base64EncodedString()
        return encryptedBase64
    } else {
        // Encryption failed
        return ""
    }
}

func generateRandomIV(length: Int) -> Data? {
    var iv = Data(count: length)
    let result = iv.withUnsafeMutableBytes {
        SecRandomCopyBytes(kSecRandomDefault, length, $0.baseAddress!)
    }
    return result == errSecSuccess ? iv : nil
}

func hexStringToData(hex: String) -> Data {
    var data = Data()
    var startIndex = hex.startIndex
    while startIndex < hex.endIndex {
        let endIndex = hex.index(startIndex, offsetBy: 2)
        let byteString = hex[startIndex..<endIndex]
        if let byte = UInt8(byteString, radix: 16) {
            data.append(byte)
        }
        startIndex = endIndex
    }
    return data
}


func decryptStringss(_ encryptedBase64: String, withKey key: String, iv: Data) -> String? {
    // Decode Base64 string
    guard let decodedData = Data(base64Encoded: encryptedBase64, options: .ignoreUnknownCharacters) else {
        return nil
    }
    
    // Extract IV
    guard decodedData.count >= iv.count else {
        return nil
    }
    let extractedIV = decodedData.subdata(in: 0..<iv.count)
    
    // Separate encrypted data
    guard decodedData.count > iv.count else {
        return nil
    }
    let encryptedData = decodedData.subdata(in: iv.count..<decodedData.count)
    
    // Prepare output buffer
    let outputLength = encryptedData.count + kCCBlockSizeAES128
    var output = Data(count: outputLength)
    
    // Perform decryption
    var numBytesDecrypted = 0
    let cryptStatus = key.data(using: .utf8)?.withUnsafeBytes { keyBytes in
        extractedIV.withUnsafeBytes { ivBytes in
            encryptedData.withUnsafeBytes { dataBytes in
                output.withUnsafeMutableBytes { outputBytes in
                    CCCrypt(
                        CCOperation(kCCDecrypt), // Operation
                        CCAlgorithm(kCCAlgorithmAES), // Algorithm
                        CCOptions(kCCOptionPKCS7Padding),  // Options
                        keyBytes.baseAddress, kCCKeySizeAES256, // Key and key length
                        ivBytes.baseAddress, // IV
                        dataBytes.baseAddress, encryptedData.count, // Data and data length
                        outputBytes.baseAddress, outputLength, // Output buffer
                        &numBytesDecrypted // Number of bytes decrypted
                    )
                }
            }
        }
    }
    
    // Check if decryption was successful
    if let cryptStatus = cryptStatus {
        if cryptStatus == kCCSuccess {
            let decryptedData = output[..<numBytesDecrypted]
            return String(data: decryptedData, encoding: .utf8)
        } else {
            return nil
        }
    }
    return nil
}



