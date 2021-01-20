//
//  PinkoiMemberShip.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation
class PinkoiMembership: MembershipTransmitter {
    override func confirm(loginType: LoginType, failure: ((LoginType) -> ())) {
        if loginType == .PinkoiLogin {
            //have specific event for members who use pinkoi login
            print("Welcome, using pinkoi login")
        } else {
            //not use pinkoi login, transmit to next responder
            super.confirm(loginType: loginType, failure: failure)
        }
    }
}
