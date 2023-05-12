//
//  CatalogViewController.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 12.05.2023.
//

import UIKit
import SnapKit

final class CatalogViewController: UIViewController {
    private var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var filterImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "filterButton")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var searchImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "searchButton")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.titleView = logoImageView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: filterImageView.image, style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchImageView.image, style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .black
//        configureConstraints()
    }
    
    private func configureConstraints() {
        
    }
}
