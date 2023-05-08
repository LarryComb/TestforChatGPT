//
//  LoginView.swift
//  EL3
//
//  Created by LARRY COMBS on 3/7/23.
//

//import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginErrorMesage = ""
    @State private var hasLoginError = false
    @State private var userIsLoggedIn = false
    
    var loginCallback : (String) -> ()
    
    var body: some View {
        NavigationView {
            VStack {
                if userIsLoggedIn {
                    ContentView()
                        .navigationBarHidden(false)
                        .navigationTitle("ChatMate")
                        .foregroundColor(.green)
                        .padding()
                        .toolbar {
                            HStack {
                                NavigationLink("Settings", destination: Button("Settings"){
                                
                                    print("Hello")
                                        
                                    
                                    
                                })
                                
                                
                                
                                NavigationLink("Logout", destination: Button("Logout"){
                                    do {
                                        try Auth.auth().signOut()
                                        userIsLoggedIn = false
                                        email = ""
                                        password = ""
                                    }
                                    catch {
                                        // whatever for now
                                        
                                    }
                                })
                                
                                
                                NavigationLink("Delete Account", destination: Button("Delete Account"){
                                    do {
                                        try Auth.auth().currentUser?.delete()
                                        userIsLoggedIn = false
                                        email = ""
                                        password = ""
                                    } catch {
                                        // handle error
                                    }
                                    
                                })
                                
                            }
                        }
                                               
                } else {
                    content
                        .navigationBarHidden(true)
                        .navigationTitle("ChatMate")
                        .foregroundColor(.blue)
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
                    .foregroundColor(.green)
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
                        loginErrorMesage = error?.localizedDescription ?? ""
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
                        loginErrorMesage = error?.localizedDescription ?? ""
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
            }
        }
        .navigationBarHidden(true)        
        .alert(isPresented: $hasLoginError) {
            Alert(title: Text("Error"), message: Text(loginErrorMesage), dismissButton: .default(Text("OK")))
        }
    }
}
    
 



/*
 func deleteUserAccount() {
     let user = Auth.auth().currentUser

     user?.delete { error in
         if let err = error {
             if let errorCode = AuthErrorCode(rawValue: error!._code) {
                 switch errorCode {
                     case .requiresRecentLogin:
                         self.isReauthenticatedRequired = true
                     default:
                         print(err)
                 }
             }
         } else {
             self.isReauthenticatedRequired = false
             self.isLoggedIn = false
             self.session = nil
         }
     }
 }
 
 
 // this works but it has two warnings
 
 Button("Delete Account") {
     do {
         try Auth.auth().currentUser?.delete()
         userIsLoggedIn = false
         email = ""
         password = ""
     }
       catch {
         // whatever for now

     }
 }
}
} else {
    content
        .navigationBarHidden(true)
        .navigationTitle("login")
    
}
 
 //Working Delete button
 
 Button("Delete Account", role: .destructive) {
     if let user = Auth.auth().currentUser {
         user.delete { error in
             if let error = error {
                 // handle error
             } else {
                 userIsLoggedIn = false
                 email = ""
                 password = ""
             }
         }
     }
 }

 
 Button("Delete Account", role: .destructive) {
 
         do {
             try Auth.auth().currentUser?.delete()
             userIsLoggedIn = false
             email = ""
             password = ""
         } catch {
             // handle error
         }
    }
 }
} else {
 content
     .navigationBarHidden(true)
     .navigationTitle("ChatMate")
     .foregroundColor(.blue)
     .textCase(.lowercase)
     .padding()
 

}
 
 Button("Delete Account", role: .destructive) {
     if let user = Auth.auth().currentUser {
         user.delete { error in
             if let error = error {
                 // handle error
             } else {
                 userIsLoggedIn = false
                 email = ""
                 password = ""
             }
         }
     }
 }

 
 */




