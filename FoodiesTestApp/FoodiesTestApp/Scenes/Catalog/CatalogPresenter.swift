//
//  CatalogPresenter.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 12.05.2023.
//

import UIKit

protocol CatalogPresenting {
    var categories: [Category] { get set }
    var selectedCategory: String { get set }
    func loadData()
}

final class CatalogPresenter: CatalogPresenting {
    private var categoriesTest: [Category] = []
    var categories = [Category]()
    var selectedCategory: String = ""
    weak var controller: UIViewController?
    
    func loadData() {
        self.getInfoCategories()
    }
    
    private func getInfoCategories() {
        categories = Category.previewData
    }
}
