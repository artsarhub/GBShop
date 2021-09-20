//
//  Review.swift
//  GBShop
//
//  Created by Артём on 06.09.2021.
//

import Foundation
import Alamofire

class Review: AbstractRequestFactory {
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

extension Review: ReviewRequestFactory {
    func getReviews(pageNumber: Int,
                    productId: Int,
                    completionHandler: @escaping (AFDataResponse<[ProductReview]>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = GetReviews(baseUrl: baseUrl,
                                      pageNumber: pageNumber,
                                      productId: productId)
        request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addReview(productId: Int,
                   authorId: Int,
                   starsCount: Int,
                   description: String,
                   completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let productReview = ProductReview(productId: productId,
                                          authorId: authorId,
                                          starsCount: starsCount,
                                          description: description)
        let requestModel = AddReview(baseUrl: baseUrl,
                                     productReview: productReview)
        request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteReview(productId: Int,
                      authorId: Int,
                      completionHandler: @escaping (AFDataResponse<DeleteReviewResult>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = DeleteReview(baseUrl: baseUrl,
                                        productId: productId,
                                        authorId: authorId)
        request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Review {
    struct GetReviews: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getReviews"
        
        let pageNumber: Int
        let productId: Int
        var parameters: Parameters? {
            return [
                "product_id": productId,
                "page_number": pageNumber
            ]
        }
    }
    
    struct AddReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addReview"
        
        let productReview: ProductReview
        var parameters: Parameters? {
            return [
                "product_id": productReview.productId,
                "author_id": productReview.authorId,
                "stars_count": productReview.starsCount,
                "description": productReview.description
            ]
        }
    }
    
    struct DeleteReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteReview"
        
        let productId: Int
        let authorId: Int
        var parameters: Parameters? {
            return [
                "author_id": authorId,
                "product_id": productId
            ]
        }
    }
}
