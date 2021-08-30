//
//  Catalog.swift
//  GBShop
//
//  Created by Артём on 22.08.2021.
//

import Foundation
import Alamofire

class Catalog: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    private let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Catalog: CatalogRequestFactory {
    func getCatalogData(pageNumber: Int,
                        categoryId: Int,
                        completionHandler: @escaping (AFDataResponse<[CatalogDataResult]>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = GetCatalogData(baseUrl: baseUrl, pageNumber: pageNumber, categoryId: categoryId)
        request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getGoodById(productId: Int,
                     completionHandler: @escaping (AFDataResponse<GetGoodByIdResult>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = GetGoodById(baseUrl: baseUrl, productId: productId)
        request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Catalog {
    struct GetCatalogData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        
        let pageNumber: Int
        let categoryId: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": categoryId
            ]
        }
    }
    
    struct GetGoodById: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "getGoodById.json"
        
        let productId: Int
        var parameters: Parameters? {
            return ["id_product": productId]
        }
    }
}
