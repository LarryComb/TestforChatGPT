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
     @AppStorage("isDarkMode") var isDarkMode: Bool = false

     var body: some Scene {
         WindowGroup {
                 LoginView(loginCallback: captureToken(token:))
                 .preferredColorScheme(isDarkMode ? .dark : .light)
         }

     }

     func captureToken(token: String)
     {

     }
 }


//@main
//struct EL3App: App {
//   
//    @StateObject var settings = SettingsViewModel()
//
//    var body: some Scene {
//        WindowGroup {
//            LoginView()
//                .environmentObject(settings)
//        }
//    }
//}
