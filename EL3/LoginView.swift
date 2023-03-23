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
        NavigationStack {
            //if user is logged in go to contentView
            if userIsLoggedIn {
                ContentView()
            } else{
                content
            }
        }
    }
        
        var content: some View{
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
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.orange)
                    TextField("email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.25))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.25))
                        .cornerRadius(10)
                    
                    Button("Login"){
                        //authenticate User
                        Auth.auth().signIn(withEmail: email, password: password) {result, error in
                            // handle the result and error here
                            hasLoginError = error != nil;
                            loginErrorMesage = error?.localizedDescription ?? ""
                        }
                        
                    }
                    .foregroundColor(.orange)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .onAppear{
                        Auth.auth().addStateDidChangeListener{auth, user in
                            if user != nil {
                                userIsLoggedIn.toggle()
                            }
                        }
                    }
                    .alert(loginErrorMesage, isPresented: $hasLoginError) {
                        Button("OK", role: .cancel) { }
                            
                    }
                    
                    Button("Register"){
                        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
                          // handle the result and error here
                            hasLoginError = error != nil;
                            loginErrorMesage = error?.localizedDescription ?? ""
                        })
                    }
                    .foregroundColor(.orange)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .navigationBarHidden(false)
        }
        
    }
    
    
   // present(alert(isPresented: true, content: .show))
//}







//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

