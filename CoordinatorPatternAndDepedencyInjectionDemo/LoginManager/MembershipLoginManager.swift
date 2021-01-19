//
//  MembershipLoginManager.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation

class MembershipLoginManager: NSObject {
    static let shared = MembershipLoginManager()
    
    var mockUserInformation: String? = nil
    
    func doEmailLogin() {
        mockUserInformation = "Hsin, age is 18, email"
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

extension MembershipLoginManager: LoginViewControllerDataSource {
    
    func loginViewControllerGetUserInformation(_ loginViewController: LoginViewController, handle: (String) -> Void) {
        let userInformation = getUserInfomationFromServer()
        handle(userInformation)
    }
}

extension MembershipLoginManager: LoginViewControllerDelegate {
    
    func loginViewControllerDoLogIn(_ loginViewController: LoginViewController, loginType: LoginType) {
        switch loginType {
        case .EmailLogin:
            doEmailLogin()
        default:
            break
        }
    }
}
