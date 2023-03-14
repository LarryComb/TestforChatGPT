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
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    
    var loginCallback : (String) -> ()
    
    var body: some View {
        NavigationStack {
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
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.25))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login"){
                        //authenticateUser(email: email, password: password)
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
    
    /*
     func authenticateUser(username: String, password: String) {
     if username.lowercased() == "larry" {
     wrongUsername = 0
     if password.lowercased() == "1234" {
     wrongPassword = 0
     loginCallback("derpderpderpderp");
     } else {
     wrongPassword = 2
     }
     } else {
     wrongUsername = 2
     }
     }
     // This code does work
     
     Auth.auth().signIn(withEmail: email, password: password) { result, error in
         guard error == nil else {
             //show account creation
             showCreateAccount(email: email, password: password)
             return
         }
         
         
     }
     
     FirebaseAuth()Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self] results, error in
         guard let strongSelf = self else {
             
             return
         }
         guard error == nil else {
             //show account creation
             strongSelf.showCreateAccount(email: email, password: password)
             return
         }
         print("You are signed in")
         //strongSelf.lable.isHidden = true
         strongSelf.username.isHidden = true
         strongSelf.password.isHidden = true
         //strongSelf.loginCallback.isHidden = true
     })
     */
     
    
    
    
    struct LoginView: View {
        @State private var email = ""
        @State private var password = ""
        
        var body: some View {
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button("Sign In") {
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        // handle the result and error here
                    }
                }
            }
        }
    }
     
    
 
    
    
    
    func showCreateAccount(email: String, password: String){
        let alert = UIAlertController(title: "Create Account",
                                      message: "Would You Like To Create An Account",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Create Account",
                                      style: .default,
                                      handler: {_ in
            Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
                
                
            })
            
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: {_ in
            
        }))
        
        
      //  present(alert, animated: true)
    }
    

}






//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

