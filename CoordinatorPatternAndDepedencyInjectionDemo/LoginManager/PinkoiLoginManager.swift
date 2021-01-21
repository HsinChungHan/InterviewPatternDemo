//
//  PinkoiLoginManager.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation

class PinkoiLoginManager: NSObject {
    
    static let shared = PinkoiLoginManager()
    
    var mockUserInformation: String? = nil
    
    func doPinkoiLogin() {
        mockUserInformation = "Hsin, age is 18, pinkoi"
    }
    
    func getUserInfomationFromServer() -> String {
        return getUserInfomation { (userInformation) -> Bool in
            return userInformation != nil
        }
    }
    
    fileprivate func getUserInfomation(handle: (String?) -> Bool) -> String {
        var userInfomation = ""
        if handle(mockUserInformation) {
            userInfomation = mockUserInformation!
        }
        return userInfomation
    }
}

extension PinkoiLoginManager: LoginViewControllerDataSource {
    
    func loginViewControllerGetUserInformation(_ loginViewController: LoginViewController, handle: (String) -> Void) {
        let userInformation = getUserInfomationFromServer()
        handle(userInformation)
    }
}

extension PinkoiLoginManager: LoginViewControllerDelegate {
    
    func loginViewControllerDoLogIn(_ loginViewController: LoginViewController, loginType: LoginType) {
        switch loginType {
        case .PinkoiLogin:
            doPinkoiLogin()
        default:
            break
        }
    }
}
