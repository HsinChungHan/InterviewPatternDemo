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
    
    func description() -> String {
        return "name is \(name ?? "None"), address is \(address ?? "None"), loginType is \(loginType?.rawValue ?? "None")"
    }
    
}
