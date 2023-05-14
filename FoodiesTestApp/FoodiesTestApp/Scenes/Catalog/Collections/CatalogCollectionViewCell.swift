//
//  CatalogCollectionViewCell.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 14.05.2023.
//

import UIKit
import SnapKit

final class CatalogCollectionViewCell: UICollectionViewCell {
    static let collectionId = "CatalogCollectionViewCell"
    
    lazy var productImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "productImage")
        image.contentMode = .scaleToFill
        return image
    }()
    lazy var productName: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    lazy var productMeasure: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    lazy var productPriceButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 8
//        button.setTitle("000", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        contentView.layer.cornerRadius =  8
        contentView.layer.masksToBounds = true
            
        configureContstrains()
    }
    
    private func configureContstrains() {
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
        contentView.addSubview(productMeasure)
        contentView.addSubview(productPriceButton)
        productImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(120)
        }
        productName.snp.makeConstraints {
            $0.top.equalTo(productImage.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        productMeasure.snp.makeConstraints {
            $0.top.equalTo(productName.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        productPriceButton.snp.makeConstraints {
            $0.width.equalTo(143)
            $0.height.equalTo(40)
            $0.top.equalTo(productMeasure.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
