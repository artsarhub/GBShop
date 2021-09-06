//
//  ProductReview.swift
//  GBShop
//
//  Created by Артём on 06.09.2021.
//

import Foundation

struct ProductReview: Codable {
    let productId: Int
    let authorId: Int
    let starsCount: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case authorId = "author_id"
        case starsCount = "stars_count"
        case description = "description"
    }
}
