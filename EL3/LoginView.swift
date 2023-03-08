//
//  LoginView.swift
//  EL3
//
//  Created by LARRY COMBS on 3/7/23.
//

//import Foundation
import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loggedIn = false
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Button(action: {
                // Here you would typically implement your own authentication logic to validate the entered credentials.
                // For the purpose of this example, we'll just assume that the credentials are valid if both fields are non-empty.
                if !username.isEmpty && !password.isEmpty {
                    loggedIn = true
                }
            }) {
                Text("Log In")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 20)
            .alert(isPresented: $loggedIn) {
                Alert(title: Text("Login Successful"), message: Text("You have successfully logged in."), dismissButton: .default(Text("OK"), action: {
                    // Once the user is logged in, we navigate to the ContentView.
                    // To do this, we push a new view onto the navigation stack.
                    self.navigateToContentView()
                }))
            }
        }
        .padding()
        .navigationBarTitle("Log In")
    }
    
    private func navigateToContentView() {
        let contentView = ContentView()
        let navController = UINavigationController(rootViewController: UIHostingController(rootView: contentView))
        UIApplication.shared.windows.first?.rootViewController = navController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
