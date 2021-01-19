//
//  LoginManager.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation

class SocialLoginManager: NSObject {
    static let shared = SocialLoginManager()
    
    var mockUserInformation: String? = nil
    
    func doFacebookLogin() {
        mockUserInformation = "Hsin, age is 18, Facebook"
    }
    
    func doTwitterLogin() {
        mockUserInformation = "Hsin, age is 18, Twitter"
    }
    
    func doPinkoiLogin() {
        mockUserInformation = "Hsin, age is 18, Pinkoi"
    }
    
    func getUserInfomationFromServer() -> String {
        return getUserInfomation { (userInformation) -> Bool in
            return userInformation != nil
        }
    }
    
    fileprivate func getUserInfomation(handle: (String?) -> Bool) -> String {
        var result = ""
        if handle(mockUserInformation) {
            result = mockUserInformation!
        }
        return result
    }
}

extension SocialLoginManager: LoginViewControllerDataSource {
    
    func loginViewControllerGetUserInformation(_ loginViewController: LoginViewController, handle: (String) -> Void) {
        let userInformation = getUserInfomationFromServer()
        handle(userInformation)
    }
}

extension SocialLoginManager: LoginViewControllerDelegate {
    
    func loginViewControllerDoLogIn(_ loginViewController: LoginViewController, loginType: LoginType) {
        switch loginType {
        case .FacebookLogin:
            doFacebookLogin()
        case .TwitterLogin:
            doTwitterLogin()
        case .PinkoiLogin:
            doPinkoiLogin()
        default:
            break
        }
    }
}
