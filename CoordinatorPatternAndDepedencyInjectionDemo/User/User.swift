//
//  User.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation

protocol BasicObject {
    
    func description() -> String
}

struct User: BasicObject {
    
    var name: String?
    var address: String?
    var loginType: LoginType?
    var isFilled: Bool {
        return (name != nil) && (address != nil) && (loginType != nil)
    }
    
    func description() -> String {
        return "name is \(name ?? "None"), address is \(address ?? "None"), loginType is \(loginType?.rawValue ?? "None")"
    }
    
}
