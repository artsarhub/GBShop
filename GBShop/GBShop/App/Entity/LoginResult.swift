//
//  LoginResult.swift
//  GBShop
//
//  Created by Артём on 11.08.2021.
//

import Foundation

struct LoginResult: Decodable {
    let result: Int
    let user: User
    let authToken: String
}
