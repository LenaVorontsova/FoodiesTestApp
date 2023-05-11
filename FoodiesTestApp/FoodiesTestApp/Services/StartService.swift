//
//  StartService.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 11.05.2023.
//

import UIKit

final class StartService {
    var window: UIWindow?
        
    init(window: UIWindow) {
        self.window = window
        configureWindow()
    }
    
    func configureWindow() {
        if let win = window {
            win.rootViewController = SplashScreenViewController()
            win.makeKeyAndVisible()
        }
    }
}
