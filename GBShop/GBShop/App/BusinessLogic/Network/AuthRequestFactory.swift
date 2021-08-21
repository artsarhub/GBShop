//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Артём on 11.08.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(userId: Int,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
    func registerUser(userId: Int,
                      username: String,
                      password: String,
                      email: String,
                      gender: String,
                      credit_card: String,
                      bio: String,
                      completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)
    func changeUserData(userId: Int,
                        username: String,
                        password: String,
                        email: String,
                        gender: String,
                        credit_card: String,
                        bio: String,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}
