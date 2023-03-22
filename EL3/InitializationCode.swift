//
//  larry.swift
//  EL3
//
//  Created by LARRY COMBS on 3/12/23.
//

import SwiftUI
import Firebase
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    
   
}

 @main
 struct EL3App: App {
     @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
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
