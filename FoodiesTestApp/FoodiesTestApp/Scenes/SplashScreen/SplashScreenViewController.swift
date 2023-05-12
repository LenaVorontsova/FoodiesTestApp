//
//  SplashScreenViewController.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 11.05.2023.
//

import UIKit
import SnapKit

final class SplashScreenViewController: UIViewController {
    private let presenter: SplashScreenPresenting
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "foodiesIcon")
        return image
    }()
    
    init(presenter: SplashScreenPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        view.backgroundColor = UIColor(red: 0.945, green: 0.329, blue: 0.071, alpha: 1)
        presenter.showCatalogScreen()
        
    }
    
    private func configureConstraints() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SplashScreenConstants.topAndBottom)
            $0.leading.trailing.equalToSuperview().inset(SplashScreenConstants.insets)
            $0.bottom.equalToSuperview().inset(SplashScreenConstants.topAndBottom)
        }
    }
}
