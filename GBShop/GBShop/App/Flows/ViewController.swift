//
//  ViewController.swift
//  GBShop
//
//  Created by Артём on 08.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        login()
//        logout()
//        registerUser()
//        changeUserData()
//        getCatalogData()
//        getGoodById()
    }
    
    func login() {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logout(userId: 123) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func registerUser() {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.registerUser(userId: 123,
                          username: "Somebody",
                          password: "mypassword",
                          email: "some@some.ru",
                          gender: "m",
                          creditCard: "9872389-2424-234224-234",
                          bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let registerUser):
                print(registerUser)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func changeUserData() {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.changeUserData(userId: 123,
                            username: "Somebody",
                            password: "mypassword",
                            email: "some@some.ru",
                            gender: "m",
                            creditCard: "9872389-2424-234224-234",
                            bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let changeUserData):
                print(changeUserData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCatalogData() {
        let catalog = requestFactory.makeCatalogRequestFactory()
        catalog.getCatalogData(pageNumber: 1,
                               categoryId: 1) { response in
            switch response.result {
            case .success(let catalogData):
                print(catalogData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getGoodById() {
        let catalog = requestFactory.makeCatalogRequestFactory()
        catalog.getGoodById(productId: 123) { response in
            switch response.result {
            case .success(let goodById):
                print(goodById)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
