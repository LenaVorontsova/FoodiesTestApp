//
//  SplashScreenBuilder.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 12.05.2023.
//

import UIKit

enum SplashScreenBuilder {
    static func build(presenter: SplashScreenPresenting) -> UIViewController {
        var presenter: SplashScreenPresenting = SplashScreenPresenter()
        let vc = SplashScreenViewController(presenter: presenter)
        presenter.splashScreenVC = vc
        return vc
    }
}
