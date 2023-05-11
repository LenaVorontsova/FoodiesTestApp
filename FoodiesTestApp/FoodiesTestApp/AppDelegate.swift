//
//  AppDelegate.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 11.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var startService: StartService?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        startService = StartService(window: window)
        return true
    }

}

