//
//  LoginViewModel.swift
//  EL3
//
//  Created by LARRY COMBS on 5/29/23.
//

import SwiftUI
import CryptoKit
import AuthenticationServices
import Firebase

class LoginViewModel: ObservableObject{
    
    @Published var nonce = ""
    @AppStorage("Login_Status") var log_Status = false
    
    func authenticate(credential: ASAuthorizationAppleIDCredential){
            
        //getting Token
        guard let token = credential.identityToken else {
            print("Error with Firebase")
            return
        }
        
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("Error with Token")
            return
        }
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
            
            if let error = err {
                print(error.localizedDescription)
            }
            
            //User successfully logged into Firebase
            print("Logged In Success")
            //Directing user to Home Page
            withAnimation(.easeOut) {
                self.log_Status = true
            }
            
        }
    }

}

@available(iOS 13, *)
 func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

    

 func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  var randomBytes = [UInt8](repeating: 0, count: length)
  let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
  if errorCode != errSecSuccess {
    fatalError(
      "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
    )
  }

  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

  let nonce = randomBytes.map { byte in
    // Pick a random character from the set, wrapping around if needed.
    charset[Int(byte) % charset.count]
  }

  return String(nonce)
}

    
