//
//  Basket.swift
//  GBShop
//
//  Created by Артём on 15.09.2021.
//

import Foundation
import Alamofire

class Basket: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    private let baseUrl = URL(string: "https://boiling-anchorage-93413.herokuapp.com/")
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Basket: BasketRequestFactory {
    func addToBasket(productId: Int, quantity: Int,
                     completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = AddToBasket(baseUrl: baseUrl,
                                       quantity: quantity,
                                       productId: productId)
        request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteFromBasket(productId: Int,
                          completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = DeleteFromBasket(baseUrl: baseUrl,
                                            productId: productId)
        request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Basket {
    struct AddToBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addToBasket"
        
        let quantity: Int
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId,
                "quantity": quantity
            ]
        }
    }
    
    struct DeleteFromBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteFromBasket"
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}
