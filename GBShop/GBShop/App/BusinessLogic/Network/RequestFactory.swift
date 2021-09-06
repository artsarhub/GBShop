//
//  RequestFactory.swift
//  GBShop
//
//  Created by Артём on 11.08.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeAuthRequestFatory(customErrorParser: AbstractErrorParser) -> AuthRequestFactory {
        return Auth(errorParser: customErrorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeCatalogRequestFactory() -> CatalogRequestFactory {
        let errorParser = makeErrorParser()
        return Catalog(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeCatalogRequestFactory(customErrorParser: AbstractErrorParser) -> CatalogRequestFactory {
        return Catalog(errorParser: customErrorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
