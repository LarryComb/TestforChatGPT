//
//  EL3App.swift
//  EL3
//
//  Created by LARRY COMBS on 1/9/23.
//

import SwiftUI

@main
struct EL3App: App {
    @State private var firebaseToken = ""
    
    var body: some Scene {
        WindowGroup {
            if firebaseToken.isEmpty {
                LoginView(loginCallback: captureToken(token:))
            } else {
                ContentView()
            }
        }
    }
    
    func captureToken(token: String)
    {
        firebaseToken = token
    }
}
