//
//  FlowVCViewModel.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/21.
//

import Foundation

class FlowVCViewModel {
    
    var user = User()
    lazy var bindableUserIsFilled = Bindable<Bool>.init(value: user.isFilled)
    
    func setUserName(name: String) {
        user.name = name
        bindableUserIsFilled.setValue(value: user.isFilled)
    }
    
    func setUserAddress(address: String) {
        user.address = address
        bindableUserIsFilled.setValue(value: user.isFilled)
    }
    
    func setUserLoginType(loginType: LoginType) {
        user.loginType = loginType
        bindableUserIsFilled.setValue(value: user.isFilled)
    }
}
