//
//  ProductVCViewModel.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation

class ProductVCViewModel {
    var user: User?
    
    func setUser(user: User) {
        self.user = user
    }
    
    var bindableText = Bindable<String>(value: nil)
    
    func checkUserLoginTypeToDecideFollowEvents() {
        guard let loginType = user?.loginType else {
            fatalError("User login type is nil!")
        }
        if let responderNode = MembershipTransmitter.createChain() {
            responderNode.confirm(loginType: loginType) { (loginType) in
                let text = "Welcome you use \(loginType.rawValue)!"
                bindableText.setValue(value: text)
            } failure: { (loginType) in
                let text = "No one can handle \(loginType.rawValue) event!"
                bindableText.setValue(value: text)
            }
        }
    }
}


