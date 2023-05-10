//
//  SettingsView.swift
//  EL3
//
//  Created by LARRY COMBS on 5/9/23.
//

import SwiftUI
import Combine
import FirebaseAuth

struct SettingsView: View {
    @Binding var isTextGreen: Bool
    @Binding var textColor: Color
    @Binding var isDarkMode: Bool
    @Binding var enableNotifications: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var loginErrorMessage = ""
    @State private var hasLoginError = false
    @State private var userIsLoggedIn = false
    //@State private var enableNotifications = false

   // @Binding var show: Bool

    var body: some View {
        VStack {
            
            Toggle(isOn: $isDarkMode) {
                Text("Dark Mode Setting")
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                
            }
            .padding()
            Toggle(isOn: $isTextGreen) {
                Text("Toggle Text Color")
                    .foregroundColor(isTextGreen ? .green : .blue)
            }
            .padding()
            
            Toggle(isOn: $enableNotifications) {
                Text("Enable Notifications")
                    .foregroundColor(enableNotifications ? .green : .red)
            }
            .padding()

            NavigationLink("Logout", destination: Button("Logout"){
                do {
                    try Auth.auth().signOut()
                    userIsLoggedIn = false
                    email = ""
                    password = ""
                }
                catch {
                    print(error.localizedDescription)

                }
            })
             .padding(.top, 20)
            NavigationLink("Delete Account", destination: Button("Delete Account"){
                do {
                    try Auth.auth().currentUser?.delete()
                    userIsLoggedIn = false
                    email = ""
                    password = ""
                } catch {
                    print(error.localizedDescription)
                }

            })
            .padding(.top, 20)
            Spacer()
        }
        .navigationTitle("Settings")
        .onChange(of: isTextGreen) { newValue in
            textColor = newValue ? .green : .blue // changed to blue
        }
        
        
    }

}







