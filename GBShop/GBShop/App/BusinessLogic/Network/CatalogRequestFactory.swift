//
//  CatalogRequestFactory.swift
//  GBShop
//
//  Created by Артём on 22.08.2021.
//

import Foundation
import Alamofire

protocol CatalogRequestFactory {
    func getCatalogData(pageNumber: Int,
                        categoryId: Int,
                        completionHandler: @escaping (AFDataResponse<[CatalogDataResult]>) -> Void)
    func getGoodById(productId: Int,
                     completionHandler: @escaping (AFDataResponse<GetGoodByIdResult>) -> Void)
}
