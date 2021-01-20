//
//  ProductVCViewModel.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation

class ProductVCViewModel {
    var user: User?
    
    func checkUserLoginTypeToDecideFollowEvents() {
        guard let loginType = user?.loginType else {
            fatalError("User login type is nil!")
        }
        
        if let responderNode = MembershipTransmitter.createChain() {
            responderNode.confirm(loginType: loginType) { (loginType) in
                print("No one can handle \(loginType.rawValue) event!")
            }
        }
    }
}
