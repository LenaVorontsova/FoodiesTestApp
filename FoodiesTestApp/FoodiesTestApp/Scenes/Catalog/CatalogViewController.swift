//
//  CatalogViewController.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 12.05.2023.
//

import UIKit
import SnapKit

var whichCellSelect : String = ""

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
    private var categoriesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    let numberOfItems = 1000
    private let presenter: CatalogPresenting
    
    init(presenter: CatalogPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.titleView = logoImageView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: filterImageView.image, style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchImageView.image, style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        setupViews()
        configureConstraints()
        self.presenter.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let indexPathCat = IndexPath(row: categoriesCollectionView.numberOfSections, section: 0)
        self.categoriesCollectionView.scrollToItem(at: indexPathCat, at: .left, animated: false)
    }
    
    private func setupViews() {
        self.categoriesCollectionView.showsHorizontalScrollIndicator = false
        self.categoriesCollectionView.dataSource = self
        self.categoriesCollectionView.delegate = self
        self.categoriesCollectionView.register(CategoriesCollectionViewCell.self,
                                               forCellWithReuseIdentifier: CategoriesCollectionViewCell.collectionId)
    }
    
    private func configureConstraints() {
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
            $0.leading.trailing.equalToSuperview().inset(CategoriesCellConstants.insets)
            $0.bottom.equalToSuperview().inset(672)
        }
    }
}

extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            if collectionView.isEqual(categoriesCollectionView) {
//                whichCellSelect = presenter.categories[indexPath.row % presenter.categories.count].strCategory
//                presenter.updateSelectedCategory(whichCellSelect)
//            }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCollectionViewCell.collectionId,
            for: indexPath) as? CategoriesCollectionViewCell else {
            return UICollectionViewCell()
        }
        if presenter.categories.count != 0 {
            cell.collectionLabel.text = presenter.categories[indexPath.row].name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = presenter.categories[indexPath.row % presenter.categories.count].name
        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        let itemSize = item.size(withAttributes: [.font: font])
        let size = CGSize(
            width: itemSize.width.rounded(.up) + 24 + 24,
            height: itemSize.height.rounded(.up) + 12 + 12
        )
                return size
//        return CGSize(
//            width: 83,
//            height: 40)
    }
}
