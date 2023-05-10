//
//  SettingsView.swift
//  EL3
//
//  Created by LARRY COMBS on 5/9/23.
//

import SwiftUI
import Combine


struct SettingsView: View {
    @Binding var isTextGreen: Bool
    @Binding var textColor: Color
    @Binding var isDarkMode: Bool
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
            Spacer()
        }
        .navigationTitle("Settings")
        .onChange(of: isTextGreen) { newValue in
            textColor = newValue ? .green : .blue // changed to blue
        }
        
        
    }

}

//class SettingsViewModel: ObservableObject {
//    @Published var isTextGreen = false
//}
//
//
//import SwiftUI
//
//struct SettingsView: View {
//    @EnvironmentObject var settings: SettingsViewModel
//    
//    var body: some View {
//        VStack {
//            Toggle(isOn: $settings.isTextGreen) {
//                Text("Toggle Text Color")
//                    .foregroundColor(settings.isTextGreen ? .green : .blue)
//            }
//            .padding()
//            Spacer()
//        }
//        .navigationTitle("Settings")
//    }
//}






