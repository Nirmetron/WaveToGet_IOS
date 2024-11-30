//
//  wavetogetApp.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-14.
//

import SwiftUI
import RevenueCat
import Firebase

//    class AppDelegate: NSObject, UIApplicationDelegate {
//      func application(_ application: UIApplication,
//                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//
//        return true
//      }
//    }

@main
struct wavetogetApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        // Init RevenueCat SDK
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_ulgkkISWlnPaBFXQQhgQTrfSCTA")
        
        // Init Firebase SDK
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
    }
}
