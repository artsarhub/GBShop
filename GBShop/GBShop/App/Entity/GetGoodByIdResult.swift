//
//  GetGoodByIdResult.swift
//  GBShop
//
//  Created by Артём on 22.08.2021.
//

import Foundation

struct GetGoodByIdResult: Decodable {
    let result: Int
    let productName: String
    let productPrice: Int
    let productDescription: String
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
    }
}
