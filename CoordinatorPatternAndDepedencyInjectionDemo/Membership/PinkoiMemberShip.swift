//
//  PinkoiMemberShip.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation

class PinkoiMembership: MembershipTransmitter {
    
    override func confirm(loginType: LoginType, success: ((LoginType) -> Void), failure: ((LoginType) -> Void)) {
        if loginType == .PinkoiLogin {
            //have specific event for members who use pinkoi login
            success(loginType)
        } else {
            //not use pinkoi login, transmit to next responder
            super.confirm(loginType: loginType, success: success, failure: failure)
        }
    }
}
