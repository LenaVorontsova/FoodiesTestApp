//
//  ProductCartViewController.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 17.05.2023.
//

import UIKit
import SnapKit

final class ProductCartViewController: UIViewController {
    private var productTableView: UITableView = {
        var table = UITableView()
        return table
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
    var products: [Product]
    
    init(products: [Product]) {
        self.products = products
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Корзина"
        self.productTableView.dataSource = self
        self.productTableView.delegate = self
        self.productTableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.tableId)
        
        self.configureConstraints()
    }
    
    private func configureConstraints() {
        view.addSubview(productTableView)
        view.addSubview(cartView)
        cartView.addSubview(cartButton)
        productTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(CatalogConstants.catalogBottom)
        }
        cartView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(CatalogConstants.cartTop)
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
}

extension ProductCartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.tableId,
                                                        for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        cell.productName.text = products[indexPath.row].name
        cell.productCount.text = "1"
        cell.productName.text = "\(products[indexPath.row].price_current/100) ₽"
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
