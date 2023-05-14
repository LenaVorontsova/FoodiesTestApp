//
//  CatalogPresenter.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 12.05.2023.
//

import UIKit

protocol CatalogPresenting {
    var categories: [Category] { get set }
    var products: [Product] {get set }
    var selectedCategory: String { get set }
    func loadData()
}

final class CatalogPresenter: CatalogPresenting {
    var categories = [Category]()
    var products = [Product]()
    var selectedCategory: String = ""
    weak var controller: UIViewController?
    
    func loadData() {
        self.getInfoCategories()
        self.getInfoProducts()
    }
    
    private func getInfoCategories() {
        self.categories = Category.previewData
    }
    
    private func getInfoProducts() {
        self.products = Product.previewData
    }
}
