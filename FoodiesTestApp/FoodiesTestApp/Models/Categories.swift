//
//  Categories.swift
//  FoodiesTestApp
//
//  Created by Lena Vorontsova on 14.05.2023.
//

import Foundation

struct Category: Codable, Equatable, Identifiable {
    let id: Int
    let name: String
}

extension Category {
    static var previewData: [Category] {
        let previewDataURL = Bundle.main.url(forResource: "Categories", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        let jsonDecoder = JSONDecoder()
//        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode([Category].self, from: data)
        return apiResponse
    }
}
