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
    var productsFilter: [Product] {get set }
    var selectedCategory: Int? { get set }
    func loadData()
    func updateSelectedCategory()
}

final class CatalogPresenter: CatalogPresenting {
    var categories = [Category]()
    var productsFilter = [Product]()
    var products = [Product]()
    var selectedCategory: Int?
    weak var controller: CatalogViewController?
    
    func loadData() {
        self.getInfoCategories()
        self.getInfoProducts()
    }
    
    private func getInfoCategories() {
        self.categories = Category.previewData
    }
    
    private func getInfoProducts() {
        self.products = Product.previewData
        self.productsFilter = self.products
    }
    
    func updateSelectedCategory() {
        if let categoryId = selectedCategory {
            productsFilter = products.filter( { $0.category_id == categoryId})
        } else {
            productsFilter = products
        }
    }
}
