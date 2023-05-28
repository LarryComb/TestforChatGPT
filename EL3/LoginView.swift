//
//  LoginView.swift
//  EL3
//
//  Created by LARRY COMBS on 5/15/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import CryptoKit
//import Crypto
import AuthenticationServices

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginErrorMessage = ""
    @State private var hasLoginError = false
    @State private var userIsLoggedIn = false
    @State private var isTextGreen = false
    @State private var textColor = Color.blue
    @State private var enableNotifications = false
    

    
    
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    
    var loginCallback : (String) -> ()
    @Environment(\.colorScheme) var colorScheme
    
    func logoutHandler() -> Void {
        do {
            try Auth.auth().signOut()
            userIsLoggedIn = false;
            email = ""
            password = ""
        }
        catch {
            print(error.localizedDescription)
            
        }
    }
    
    func deleteAccountHandler() -> Void {
        Auth.auth().currentUser?.delete()
        userIsLoggedIn = false
        email = ""
        password = ""
        
    }
    
    
    
    
    //@StateObject private var loginData = AppleLoginData()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                
                if userIsLoggedIn {
                    ContentView()
                        .navigationBarHidden(false)
                        .navigationTitle("ChatMate")
                        .foregroundColor(isTextGreen ? .green : .blue)
                        .padding()
                        .toolbar {
                            HStack {
                                
                                
                                NavigationLink("Settings", destination: SettingsView(isTextGreen: $isTextGreen, textColor: $textColor, isDarkMode: $isDarkMode, enableNotifications: $enableNotifications, onLogout: logoutHandler, onDelete: deleteAccountHandler))
                                    .foregroundColor(isTextGreen ? .green : .blue)
                                
                                // NavigationLink("Settings", destination: SettingsView(isTextGreen: $isTextGreen, textColor: $textColor))
                                
                                
                                
                                //                                NavigationLink("Logout", destination: Button("Logout"){
                                //                                        logoutHandler()
                                //
                                //                                })
                                //                                .foregroundColor(isTextGreen ? .green : .blue)
                                //
                                //                                NavigationLink("Delete Account", destination: Button("Delete Account") {
                                //                                    deleteAccountHandler()
                                //                                })
                                //                                .foregroundColor(isTextGreen ? .green : .blue)
                                
                            }
                        }
                    
                    
                } else {
                    content
                        .foregroundColor(isTextGreen ? .green : .blue)
                        .navigationBarHidden(true)
                        .navigationTitle("Errorifviewable")
                    
                }
            }
        }
    }
    
    
    var content: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
            
            VStack {
                Text("ChatMate")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(isTextGreen ? .green : .blue)
                TextField("email", text: $email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.25))
                    .cornerRadius(10)
                    .textCase(.lowercase)
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.25))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                
                
                Button(action: {
                    // authenticate User
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        // handle the result and error here
                        hasLoginError = error != nil
                        loginErrorMessage = error?.localizedDescription ?? ""
                        if let _ = result?.user {
                            // User has successfully logged in
                            userIsLoggedIn = true
                        }
                    }
                }) {
                    Text("Login")
                        .foregroundColor(.green)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    // register User
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        // handle the result and error here
                        hasLoginError = error != nil
                        loginErrorMessage = error?.localizedDescription ?? ""
                        if let _ = result?.user {
                            // User has successfully registered and logged in
                            userIsLoggedIn = true
                        }
                    }
                }) {
                    Text("Register")
                        .foregroundColor(.green)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                SignInWithAppleButton(.signIn) { request in
                                    // requesting parameters from apple login
                                    //let nonce = randomNonceString()
                                    request.requestedScopes = [.email, .fullName]
                                    //request.nonce = sha256(nonce)
                                } onCompletion: { result in
                                    // getting error or success…
                                    switch result {
                                    case .success(let authResults):
                                        print("Success")
                                        // Do Login with Firebase
                                        guard let credential = authResults.credential as? ASAuthorizationAppleIDCredential else {
                                            print("Error with Firebase")
                                            return
                                        }
                                        // Authenticate with Firebase using the credential
                                       // loginData.authenticate(credential: credential)
                                            
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                .foregroundColor(.green)
                                .frame(width: 300, height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                //.signInWithAppleButtonStyle(colorScheme == .dark ? .black : .white)
                            }
                        }
        
        .navigationBarHidden(true)
        .alert(isPresented: $hasLoginError) {
            Alert(title: Text("Error"), message: Text(loginErrorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
}
