//
//  uygulama2App.swift
//  uygulama2
//
//  Created by Eda Gencay on 13.05.2024.
//

import SwiftUI

import Firebase


@main
struct uygulama2App: App {
    
    init() {
            FirebaseApp.configure()
        }
        
    
    
    
    
    var body: some Scene {
        WindowGroup {
            WelcomePage()
        }
    }
    
}
/*class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}*/
