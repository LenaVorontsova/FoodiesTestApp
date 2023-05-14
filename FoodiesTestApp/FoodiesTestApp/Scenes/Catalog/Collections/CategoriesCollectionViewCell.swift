//
//  CategoriesCollectionViewCell.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 12.05.2023.
//

import UIKit
import SnapKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    static let collectionId = "CategoriesCollectionViewCell"
    
    lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? UIColor(red: 0.945, green: 0.329, blue: 0.071, alpha: 1) : .clear
            self.collectionLabel.textColor = isSelected ? .white : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius =  8
        contentView.layer.masksToBounds = true
            
        configureContstrains()
    }
        
    private func configureContstrains() {
        addSubview(collectionLabel)
        collectionLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(CategoriesCellConstants.topAndBottom)
            $0.leading.trailing.equalToSuperview().inset(CategoriesCellConstants.insets-3)
        }
    }
}
