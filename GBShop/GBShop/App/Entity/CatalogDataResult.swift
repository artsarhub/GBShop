//
//  CatalogDataResult.swift
//  GBShop
//
//  Created by Артём on 22.08.2021.
//

import Foundation

struct CatalogDataResult: Decodable {
    let productId: Int
    let productName: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "id_product"
        case productName = "product_name"
        case price = "price"
    }
}
