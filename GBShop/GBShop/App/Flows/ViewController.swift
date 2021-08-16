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
        changeUserData()
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
            case .success(let login):
                print(login)
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
                          credit_card: "9872389-2424-234224-234",
                          bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let login):
                print(login)
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
                            credit_card: "9872389-2424-234224-234",
                            bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
