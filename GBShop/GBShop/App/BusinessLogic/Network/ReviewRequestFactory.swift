//
//  ReviewRequestFactory.swift
//  GBShop
//
//  Created by Артём on 06.09.2021.
//

import Foundation
import Alamofire

protocol ReviewRequestFactory {
    func getReviews(pageNumber: Int,
                    productId: Int,
                    completionHandler: @escaping (AFDataResponse<[ProductReview]>) -> Void)
    func addReview(productId: Int,
                   authorId: Int,
                   starsCount: Int,
                   description: String,
                   completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)
    func deleteReview(productId: Int,
                      authorId: Int,
                      completionHandler: @escaping (AFDataResponse<DeleteReviewResult>) -> Void)
}

