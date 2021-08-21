//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Артём on 11.08.2021.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
