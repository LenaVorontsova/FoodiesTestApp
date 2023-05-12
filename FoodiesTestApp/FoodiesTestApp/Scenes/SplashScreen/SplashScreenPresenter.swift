//
//  SplashScreenPresenter.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 12.05.2023.
//

import UIKit

protocol SplashScreenPresenting {
    var splashScreenVC: UIViewController? { get set }
    func showCatalogScreen()
}

final class SplashScreenPresenter: SplashScreenPresenting {
    weak var splashScreenVC: UIViewController?
    
    func showCatalogScreen() {
        let catalogVC = CatalogViewController()
        catalogVC.modalPresentationStyle = .fullScreen
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.splashScreenVC?.navigationController?.pushViewController(catalogVC, animated: false)
            self.splashScreenVC?.dismiss(animated: false)
//            self.splashScreenVC?.present(catalogVC, animated: false)
        }
    }
}
