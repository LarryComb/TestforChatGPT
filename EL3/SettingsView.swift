//
//  SettingsView.swift
//  EL3
//
//  Created by LARRY COMBS on 5/9/23.
//

import SwiftUI


struct SettingsView: View {
    @Binding var isTextGreen: Bool
    @Binding var textColor: Color
    
    var body: some View {
        VStack {
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


//struct SettingsView: View {
//    @Binding var isTextGreen: Bool
//    var body: some View {
//        VStack {
//            Toggle(isOn: $isTextGreen) {
//                Text("Toggle Text Color")
//                    .foregroundColor(isTextGreen ? .green : .blue)
//            }
//            .padding()
//            Spacer()
//        }
//        .navigationTitle("Settings")
//    }
//}

