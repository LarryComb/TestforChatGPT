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
    @State private var loginErrorMessage = ""
    @State private var hasLoginError = false
    var onLogout : () -> Void
    var onDelete : () -> Void
    @Environment(\.presentationMode) var presentationMode

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
            
//            Toggle(isOn: $enableNotifications) {
//                Text("Enable Notifications")
//                    .foregroundColor(enableNotifications ? .green : .red)
//            }
//            .padding()
            
            
            Button("Logout") {
                onLogout()
                
            }
            .foregroundColor(isTextGreen ? .green : .blue)
    
            .padding(.top, 20)

                        Button("Delete Account") {
                            Auth.auth().currentUser?.delete()
                            onDelete()
                            presentationMode.wrappedValue.dismiss() // Dismiss the view and return to the previous view
                        }
                        .foregroundColor(isTextGreen ? .green : .blue)
                        .padding(.top, 20)

                        Spacer()
        }
        .navigationTitle("Settings")
        .onChange(of: isTextGreen) { newValue in
            textColor = newValue ? .green : .blue // changed to blue
        }
        

    }

}







