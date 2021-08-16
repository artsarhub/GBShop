//
//  RegisterUserResult.swift
//  GBShop
//
//  Created by Артём on 16.08.2021.
//

import Foundation

struct RegisterUserResult: Decodable {
    let result: Int
    let userMessage: String
}
