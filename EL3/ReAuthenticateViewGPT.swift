//
//  ReAuthenticateViewGPT.swift
//  EL3
//
//  Created by LARRY COMBS on 3/11/23.
//
//This is the code from ChatGPT 
/*
import SwiftUI
import FirebaseCore

struct ContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button("Login") {
                authenticateUser(email: email, password: password)
            }
        }
    }
    
    func authenticateUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error authenticating user: \(error.localizedDescription)")
            } else {
                isLoggedIn = true
                print("User authenticated successfully!")
            }
        }
    }
}
*/
