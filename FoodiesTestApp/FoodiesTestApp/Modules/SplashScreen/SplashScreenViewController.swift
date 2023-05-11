//
//  SplashScreenViewController.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 11.05.2023.
//

import UIKit
import SnapKit

final class SplashScreenViewController: UIViewController {
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "foodiesIcon")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        view.backgroundColor = UIColor(red: 0.945, green: 0.329, blue: 0.071, alpha: 1)
    }
    
    private func configureConstraints() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            //$0.height.width.equalToSuperview()
            $0.top.equalToSuperview().inset(370)
            $0.leading.trailing.equalToSuperview().inset(99)
            $0.bottom.equalToSuperview().inset(370)
        }
    }
}
