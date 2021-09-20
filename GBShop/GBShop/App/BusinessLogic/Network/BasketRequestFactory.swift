//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Артём on 15.09.2021.
//

import Foundation
import Alamofire

protocol BasketRequestFactory: AbstractRequestFactory {
    func addToBasket(productId: Int,
                     quantity: Int,
                     completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void)
    func deleteFromBasket(productId: Int,
                          completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void)
}
