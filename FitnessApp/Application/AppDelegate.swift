//
//  AppDelegate.swift
//  FitnessApp
//
//  Created by Jane Strashok on 29.06.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        signOutOldUser()
        Style.customizeNavBar()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}

extension AppDelegate{
    func signOutOldUser(){
        guard let _ = UserDefaults.standard.value(forKey: "isNewuser") else {
            do {
                UserDefaults.standard.set(true, forKey: "isNewuser")
                try Auth.auth().signOut()
            } catch{}
            return
        }
    }
}

