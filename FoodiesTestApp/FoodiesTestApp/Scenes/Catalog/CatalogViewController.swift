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
    private var categoriesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private var catalogCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private var cartView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    private var cartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.945, green: 0.329, blue: 0.071, alpha: 1)
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "cartIcon"), for: .normal)
        return button
    }()
    let numberOfItems = 1000
    private var presenter: CatalogPresenting
    var totalProductPrice = 0
    var productsInCart: [Product] = []
    
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
        
        self.setupViews()
        self.configureConstraints()
        self.presenter.loadData()
        
        cartButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let indexPathCat = IndexPath(row: categoriesCollectionView.numberOfSections, section: 0)
        self.categoriesCollectionView.scrollToItem(at: indexPathCat, at: .left, animated: false)
        
        let indexPathCatalog = IndexPath(row: catalogCollectionView.numberOfSections, section: 0)
        self.catalogCollectionView.scrollToItem(at: indexPathCatalog, at: .bottom, animated: false)
    }
    
    private func setupViews() {
        self.categoriesCollectionView.showsHorizontalScrollIndicator = false
        self.categoriesCollectionView.dataSource = self
        self.categoriesCollectionView.delegate = self
        self.categoriesCollectionView.register(CategoriesCollectionViewCell.self,
                                               forCellWithReuseIdentifier: CategoriesCollectionViewCell.collectionId)
        
        self.catalogCollectionView.showsVerticalScrollIndicator = true
        self.catalogCollectionView.dataSource = self
        self.catalogCollectionView.delegate = self
        self.catalogCollectionView.register(CatalogCollectionViewCell.self,
                                               forCellWithReuseIdentifier: CatalogCollectionViewCell.collectionId)
    }
    
    private func configureConstraints() {
        view.addSubview(categoriesCollectionView)
        view.addSubview(catalogCollectionView)
        view.addSubview(cartView)
        cartView.addSubview(cartButton)
        categoriesCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(CatalogConstants.categoriesTop)
            $0.leading.trailing.equalToSuperview().inset(CategoriesCellConstants.insets)
            $0.bottom.equalToSuperview().inset(CatalogConstants.categoriesBottom)
        }
        catalogCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoriesCollectionView.safeAreaLayoutGuide.snp.bottom).offset(CatalogConstants.categoriesTop)
            $0.leading.trailing.equalToSuperview().inset(CategoriesCellConstants.insets)
            $0.bottom.equalToSuperview().inset(CatalogConstants.catalogBottom)
        }
        cartView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(CatalogConstants.cartViewTop)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(CatalogConstants.catalogBottom)
        }
        cartButton.snp.makeConstraints {
            $0.width.equalTo(CatalogConstants.cartButtonWidth)
            $0.height.equalTo(CatalogConstants.cartButtonHeight)
            $0.top.bottom.equalToSuperview().inset(CatalogConstants.catalogBottom)
            $0.leading.trailing.equalToSuperview().inset(CatalogConstants.cartButtonInsets)
        }
    }
    
    func reloadData() {
        self.catalogCollectionView.reloadData()
    }
    
    @objc
    func openCart(_ sender: UIButton) {
        let productCartVC = ProductCartViewController(products: productsInCart)
        productCartVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(productCartVC, animated: true)
    }
    
    @objc
    func deleteProductFromCart(_ sender: UIButton) {
        let indexPath = IndexPath(item: sender.tag, section: 0)
        let product = presenter.productsFilter[indexPath.item]
        totalProductPrice -= Int(product.price_current/100)
        cartButton.setTitle("\(totalProductPrice) ₽", for: .normal)
        if totalProductPrice == 0 {
            cartView.isHidden = true
        }
    }
    
    @objc
    func addProductToCart(_ sender: UIButton) {
        let indexPath = IndexPath(item: sender.tag, section: 0)
        let product = presenter.productsFilter[indexPath.item]
        totalProductPrice += product.price_current/100
        cartView.isHidden = false
        cartButton.setTitle("\(totalProductPrice) ₽", for: .normal)
        productsInCart.append(presenter.productsFilter[indexPath.item])
    }
}

extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.isEqual(categoriesCollectionView) {
            presenter.selectedCategory = presenter.categories[indexPath.row].id
            presenter.updateSelectedCategory()
            reloadData()
        } else {
            let productCardVC = ProductCardTableViewController(product: presenter.products[indexPath.row])
            productCardVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(productCardVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.isEqual(categoriesCollectionView) {
            return presenter.categories.count
        } else {
            return presenter.productsFilter.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.isEqual(categoriesCollectionView) {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoriesCollectionViewCell.collectionId,
                for: indexPath) as? CategoriesCollectionViewCell else {
                return UICollectionViewCell()
            }
            if presenter.categories.count != 0 {
                cell.collectionLabel.text = presenter.categories[indexPath.row].name
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CatalogCollectionViewCell.collectionId,
                for: indexPath) as? CatalogCollectionViewCell else {
                return UICollectionViewCell()
            }
            if presenter.products.count != 0 {
                cell.productName.text = presenter.productsFilter[indexPath.row].name
                cell.productMeasure.text = "\(presenter.productsFilter[indexPath.row].measure) \(presenter.productsFilter[indexPath.row].measure_unit)"
                cell.productPriceButton.setTitle("\(presenter.productsFilter[indexPath.row].price_current/100) ₽", for: .normal)
                cell.productPriceButton.addTarget(self, action: #selector(addProductToCart), for: .touchUpInside)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.isEqual(categoriesCollectionView) {
            let item = presenter.categories[indexPath.row % presenter.categories.count].name
            let font = UIFont.systemFont(ofSize: 14, weight: .medium)
            let itemSize = item.size(withAttributes: [.font: font])
            let size = CGSize(
                width: itemSize.width.rounded(.up) + 24 + 24,
                height: itemSize.height.rounded(.up) + 12 + 12
            )
            return size
        } else {
            return CGSize(width: 167.5, height: 290)
        }
    }
}
