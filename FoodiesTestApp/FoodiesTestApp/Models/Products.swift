//
//  Products.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 14.05.2023.
//

import Foundation

struct Product: Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let image: String
    let price_current: Int
    let price_old: Int?
    let category_id: Int
    let measure: Int
    let measure_unit: String
    let energy_per_100_grams: Double
    let proteins_per_100_grams: Double
    let fats_per_100_grams: Double
    let carbohydrates_per_100_grams: Double
    let tag_ids: [Int?]
}

extension Product {
    static var previewData: [Product] {
        let previewDataURL = Bundle.main.url(forResource: "Products", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        let jsonDecoder = JSONDecoder()
        
        let apiResponse = try! jsonDecoder.decode([Product].self, from: data)
        return apiResponse
    }
}
