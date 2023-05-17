//
//  InfoTableViewCell.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 16.05.2023.
//

import UIKit
import SnapKit

final class InfoTableViewCell: UITableViewCell {
    static let tableId = "InfoTableViewCell"
    lazy var labelText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    lazy var productData: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
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
    
    func configureConstraints() {
        contentView.addSubview(labelText)
        contentView.addSubview(productData)
        labelText.snp.makeConstraints { 
            $0.top.bottom.equalToSuperview().inset(InfoCellConstants.labelTextTop)
            $0.leading.equalToSuperview().inset(InfoCellConstants.labelTextLead)
            $0.trailing.equalToSuperview().inset(InfoCellConstants.labelTextTrail)
        }
        productData.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(InfoCellConstants.labelTextTop)
            $0.leading.equalTo(labelText.safeAreaLayoutGuide.snp.trailing).offset(-InfoCellConstants.productDataLead)
            $0.trailing.equalToSuperview().inset(InfoCellConstants.labelTextLead)
        }
    }
}
