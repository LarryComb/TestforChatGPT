//
//  LoginView.swift
//  EL3
//
//  Created by LARRY COMBS on 3/7/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginErrorMessage = ""
    @State private var hasLoginError = false
    @State private var userIsLoggedIn = false
    @State private var isTextGreen = false
    @State private var textColor = Color.blue
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var loginCallback : (String) -> ()

    var body: some View {
        NavigationView {
            VStack {
                if userIsLoggedIn {
                    ContentView()
                        .navigationBarHidden(false)
                        .navigationTitle("ChatMate")
                        .foregroundColor(.blue)
                        .padding()
                        .toolbar {
                            HStack {


                                NavigationLink("Settings", destination: SettingsView(isTextGreen: $isTextGreen, textColor: $textColor, isDarkMode: $isDarkMode))


                               // NavigationLink("Settings", destination: SettingsView(isTextGreen: $isTextGreen, textColor: $textColor))



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
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $hasLoginError) {
            Alert(title: Text("Error"), message: Text(loginErrorMessage), dismissButton: .default(Text("OK")))
        }
    }



}
    
 

//import Foundation
//import SwiftUI
//import Firebase
//import FirebaseAuth
//
//struct LoginView: View {
//    @State private var email = ""
//    @State private var password = ""
//    @State private var loginErrorMessage = ""
//    @State private var hasLoginError = false
//    @State private var userIsLoggedIn = false
//
//    var loginCallback : (String) -> ()
//
//    @EnvironmentObject var settings: SettingsViewModel
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                if userIsLoggedIn {
//                    Text("ChatMate")
//                        .navigationBarHidden(false)
//                        .navigationTitle("ChatMate")
//                        .foregroundColor(settings.isTextGreen ? .green : .blue)
//                        .padding()
//                        .toolbar {
//                            HStack {
//                                NavigationLink("Settings", destination: SettingsView())
//                                NavigationLink("Logout", destination: Button("Logout"){
//                                    do {
//                                        try Auth.auth().signOut()
//                                        userIsLoggedIn = false
//                                        email = ""
//                                        password = ""
//                                    }
//                                    catch {
//                                        print(error.localizedDescription)
//                                    }
//                                })
//
//                                NavigationLink("Delete Account", destination: Button("Delete Account"){
//                                    do {
//                                        try Auth.auth().currentUser?.delete()
//                                        userIsLoggedIn = false
//                                        email = ""
//                                        password = ""
//                                    } catch {
//                                        print(error.localizedDescription)
//                                    }
//                                })
//                            }
//                        }
//                } else {
//                    VStack {
//                        Text("ChatMate")
//                            .font(.largeTitle)
//                            .bold()
//                            .padding()
//                            .foregroundColor(settings.isTextGreen ? .green : .blue)
//
//                        TextField("Email", text: $email)
//                            .padding()
//                            .frame(width: 300, height: 50)
//                            .background(Color.gray.opacity(0.5))
//                            .cornerRadius(10)
//                            .autocapitalization(.none)
//
//                        SecureField("Password", text: $password)
//                            .padding()
//                            .frame(width: 300, height: 50)
//                            .background(Color.gray.opacity(0.5))
//                            .cornerRadius(10)
//                            .autocapitalization(.none)
//
//                        Button(action: {
//                            // User authentication process
//                            Auth.auth().signIn(withEmail: email, password: password) { result, error in
//                                hasLoginError = error != nil
//                                loginErrorMessage = error?.localizedDescription ?? ""
//                                if let _ = result?.user {
//                                    userIsLoggedIn = true
//                                }
//                            }
//                        }) {
//                            Text("Login")
//                                .foregroundColor(.white)
//                                .frame(width: 300, height: 50)
//                                .background(Color.blue)
//                                .cornerRadius(10)
//                        }
//
//                        Button(action: {
//                            // User registration process
//                            Auth.auth().createUser(withEmail: email, password: password) { result, error in
//                                hasLoginError = error != nil
//                                loginErrorMessage = error?.localizedDescription ?? ""
//                                if let _ = result?.user {
//                                    userIsLoggedIn = true
//                                }
//                            }
//                        }) {
//                            Text("Register")
//                                .foregroundColor(.white)
//                                .frame(width: 300, height: 50)
//                                .background(Color.blue)
//                                .cornerRadius(10)
//                        }
//
//                        if hasLoginError {
//                            Text(loginErrorMessage)
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}





