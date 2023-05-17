//
//  ProductCardTableViewController.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 16.05.2023.
//

import UIKit
import SnapKit

final class ProductCardTableViewController: UIViewController {
    private var productImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "productImage")
        image.contentMode = .scaleToFill
        return image
    }()
    private var productName: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    private var productDescription: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.numberOfLines = 10
        return label
    }()
    private var infoTableView: UITableView = {
        var table = UITableView()
        return table
    }()
    private var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private var cartButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(red: 0.945, green: 0.329, blue: 0.071, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    private let labels = ["Вес", "Энерг. ценность", "Белки", "Жиры", "Углеводы"]
    var product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoTableView.delegate = self
        self.infoTableView.dataSource = self
        self.infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.tableId)
        self.view.backgroundColor = .white
        
        self.configureConstraints()
        addTitles(product: self.product)
    }
    
    func addTitles(product: Product) {
        productName.text = product.name
        productDescription.text = product.description
        cartButton.setTitle("В корзину за \(product.price_current/100) ₽", for: .normal)
    }
    
    private func configureConstraints() {
        view.addSubview(productImage)
        view.addSubview(productName)
        view.addSubview(infoTableView)
        view.addSubview(productDescription)
        view.addSubview(backgroundView)
        backgroundView.addSubview(cartButton)
        productImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        productName.snp.makeConstraints {
            $0.top.equalTo(productImage.safeAreaLayoutGuide.snp.bottom).offset(ProductCardConstants.productNameTop)
            $0.leading.trailing.equalToSuperview().inset(ProductCardConstants.productNameLead)
        }
        productDescription.snp.makeConstraints {
            $0.top.equalTo(productName.safeAreaLayoutGuide.snp.bottom).offset(ProductCardConstants.productDescriptionTop)
            $0.leading.trailing.equalToSuperview().inset(ProductCardConstants.productNameLead)
        }
        infoTableView.snp.makeConstraints {
            $0.top.equalTo(productDescription.safeAreaLayoutGuide.snp.bottom).offset(ProductCardConstants.infoTableViewTop)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(backgroundView.safeAreaLayoutGuide.snp.top)
        }
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(infoTableView.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-ProductCardConstants.backgroundViewBottom)
        }
        cartButton.snp.makeConstraints {
            $0.width.equalTo(ProductCardConstants.cartButtonWidth)
            $0.height.equalTo(ProductCardConstants.cartButtonHeight)
            $0.top.bottom.equalToSuperview().inset(ProductCardConstants.cartButtonTop)
            $0.leading.trailing.equalToSuperview().inset(ProductCardConstants.productNameLead)
        }
    }
}

extension ProductCardTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.tableId,
                                                        for: indexPath) as? InfoTableViewCell else {
            return UITableViewCell()
        }
        cell.labelText.text = labels[indexPath.row]
        if indexPath.row == 0 {
            cell.productData.text = "\(product.measure) \(product.measure_unit)"
        } else if indexPath.row == 1 {
            cell.productData.text = "\(product.energy_per_100_grams) ккал"
        } else if indexPath.row == 2 {
            cell.productData.text = "\(product.proteins_per_100_grams) г"
        } else if indexPath.row == 3 {
            cell.productData.text = "\(product.fats_per_100_grams) г"
        } else if indexPath.row == 4 {
            cell.productData.text = "\(product.carbohydrates_per_100_grams) г"
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
