//
//  CartTableViewCell.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 17.05.2023.
//

import UIKit
import SnapKit

final class CartTableViewCell: UITableViewCell {
    static let tableId = "CartTableViewCell"
    private var productImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "productImage")
        image.contentMode = .scaleToFill
        return image
    }()
    var productName: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    var productCount: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    var productPrice: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        configureConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
        contentView.addSubview(productCount)
        contentView.addSubview(productPrice)
        productImage.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(CartConstants.productImageTop)
            $0.trailing.equalToSuperview().inset(CartConstants.productImageTrail)
        }
        productName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(CartConstants.productImageTop)
            $0.leading.equalTo(productImage.safeAreaLayoutGuide.snp.trailing).offset(CartConstants.productImageTop)
            $0.trailing.equalToSuperview().inset(CartConstants.productImageTop)
        }
        productCount.snp.makeConstraints {
            $0.top.equalTo(productName.safeAreaLayoutGuide.snp.bottom).inset(CartConstants.productCountTop)
            $0.leading.equalTo(productImage.safeAreaLayoutGuide.snp.trailing).offset(CartConstants.productImageTop)
            $0.trailing.equalToSuperview().inset(CartConstants.productCountTrail)
            $0.bottom.equalToSuperview().inset(CartConstants.productCountBottom)
        }
        productPrice.snp.makeConstraints {
            $0.top.equalToSuperview().inset(CartConstants.productPriceTop)
            $0.leading.equalTo(productCount.safeAreaLayoutGuide.snp.trailing).offset(CartConstants.productPriceLead)
//            $0.trailing.equalToSuperview().inset(CartConstants.productPriceTrail)
            $0.bottom.equalToSuperview().inset(CartConstants.productCountBottom)
        }
    }
}
