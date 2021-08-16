//
//  Auth.swift
//  GBShop
//
//  Created by Артём on 11.08.2021.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Auth: AuthRequestFactory {
    func registerUser(userId: Int,
                      username: String,
                      password: String,
                      email: String,
                      gender: String,
                      credit_card: String,
                      bio: String,
                      completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = RegisterUser(baseUrl: baseUrl,
                                        userId: userId,
                                        username: username,
                                        password: password,
                                        email: email,
                                        gender: gender,
                                        credit_card: credit_card,
                                        bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(userId: Int,
                        username: String,
                        password: String,
                        email: String,
                        gender: String,
                        credit_card: String,
                        bio: String,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = RegisterUser(baseUrl: baseUrl,
                                        userId: userId,
                                        username: username,
                                        password: password,
                                        email: email,
                                        gender: gender,
                                        credit_card: credit_card,
                                        bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError("Bad URL") }
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        
        let userId: Int
        var parameters: Parameters? {
            return ["id_user": userId]
        }
    }
    
    struct RegisterUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        
        let userId: Int
        let username: String
        let password: String
        let email: String
        let gender: String
        let credit_card: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "username": username,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": credit_card,
                "bio": bio
            ]
        }
    }
    
    struct ChangeUserData: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "changeUserData.json"
        
        let userId: Int
        let username: String
        let password: String
        let email: String
        let gender: String
        let credit_card: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "username": username,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": credit_card,
                "bio": bio
            ]
        }
    }
}
