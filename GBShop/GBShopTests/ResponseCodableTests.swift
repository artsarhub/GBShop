//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by Артём on 21.08.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ResponseCodableTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://failUrl")
    var errorParser: ErrorParserStub!
    
    private let requestFactory = RequestFactory()
    
    struct PostStub: Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }
    
    enum ApiErrorStub: Error {
        case fatalError
    }
    
    struct ErrorParserStub: AbstractErrorParser {
        func parse(_ result: Error) -> Error {
            return ApiErrorStub.fatalError
        }
        
        func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
            return error
        }
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        errorParser = ErrorParserStub()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        errorParser = nil
    }
    
    func testShouldDownloadAndParse() {
        let errorParser = ErrorParserStub()
        
        AF
            .request("https://jsonplaceholder.typicode.com/posts/1")
            .responseCodable(errorParser: errorParser) {(response: DataResponse<PostStub, AFError>) in
                switch response.result {
                case .success(_): break
                case .failure: XCTFail()
                }
                self.expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoginResult() {
        let auth = requestFactory.makeAuthRequestFatory(customErrorParser: errorParser)
        let equivalentResult = LoginResult(result: 1,
                                           user: GBShop.User(id: 123,
                                                             login: "geekbrains",
                                                             name: "John",
                                                             lastname: "Doe"),
                                           authToken: "some_authorizaion_token")
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login): XCTAssertEqual(equivalentResult, login)
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testLogoutResult() {
        let auth = requestFactory.makeAuthRequestFatory(customErrorParser: errorParser)
        let equivalentResult = LogoutResult(result: 1)
        auth.logout(userId: 123) { response in
            switch response.result {
            case .success(let logout): XCTAssertEqual(equivalentResult, logout)
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testRegisterUserResult() {
        let auth = requestFactory.makeAuthRequestFatory(customErrorParser: errorParser)
        let equivalentResult = RegisterUserResult(result: 1, userMessage: "Регистрация прошла успешно!")
        auth.registerUser(userId: 123,
                          username: "Somebody",
                          password: "mypassword",
                          email: "some@some.ru",
                          gender: "m",
                          creditCard: "9872389-2424-234224-234",
                          bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let registerUser): XCTAssertEqual(equivalentResult, registerUser)
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testChangeUserDataResult() {
        let auth = requestFactory.makeAuthRequestFatory(customErrorParser: errorParser)
        let equivalentResult = ChangeUserDataResult(result: 1)
        auth.changeUserData(userId: 123,
                            username: "Somebody",
                            password: "mypassword",
                            email: "some@some.ru",
                            gender: "m",
                            creditCard: "9872389-2424-234224-234",
                            bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let changeUserData): XCTAssertEqual(equivalentResult, changeUserData)
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testGetCatalogDataResult() {
        let catalog = requestFactory.makeCatalogRequestFactory(customErrorParser: errorParser)
        let equivalentResult = [
            CatalogDataResult(productId: 123, productName: "Ноутбук", price: 45600),
            CatalogDataResult(productId: 456, productName: "Мышка", price: 1000)
        ]
        catalog.getCatalogData(pageNumber: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let catalogData): XCTAssertEqual(equivalentResult, catalogData)
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testGetGoodByIdResult() {
        let catalog = requestFactory.makeCatalogRequestFactory(customErrorParser: errorParser)
        let equivalentResult = GetGoodByIdResult(result: 1,
                                                 productName: "Ноутбук",
                                                 productPrice: 45600,
                                                 productDescription: "Мощный игровой ноутбук")
        catalog.getGoodById(productId: 1) { response in
            switch response.result {
            case .success(let goodById): XCTAssertEqual(equivalentResult, goodById)
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
    }
    
}

// MARK: - Equtable Ext

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.lastname == rhs.lastname
            && lhs.login == rhs.login
    }
}

extension LoginResult: Equatable {
    public static func == (lhs: LoginResult, rhs: LoginResult) -> Bool {
        return lhs.result == rhs.result
            && lhs.authToken == rhs.authToken
            && lhs.user == rhs.user
    }
}

extension LogoutResult: Equatable {
    public static func == (lhs: LogoutResult, rhs: LogoutResult) -> Bool {
        return lhs.result == rhs.result
    }
}

extension RegisterUserResult: Equatable {
    public static func == (lhs: RegisterUserResult, rhs: RegisterUserResult) -> Bool {
        return lhs.result == rhs.result
            && lhs.userMessage == rhs.userMessage
    }
}

extension ChangeUserDataResult: Equatable {
    public static func == (lhs: ChangeUserDataResult, rhs: ChangeUserDataResult) -> Bool {
        return lhs.result == rhs.result
    }
}

extension CatalogDataResult: Equatable {
    public static func == (lhs: CatalogDataResult, rhs: CatalogDataResult) -> Bool {
        return lhs.productName == rhs.productName
            && lhs.productId == rhs.productId
            && lhs.price == rhs.price
    }
}

extension GetGoodByIdResult: Equatable {
    public static func == (lhs: GetGoodByIdResult, rhs: GetGoodByIdResult) -> Bool {
        return lhs.result == rhs.result
            && lhs.productName == rhs.productName
            && lhs.productDescription == rhs.productDescription
            && lhs.productPrice == rhs.productPrice
    }
}
