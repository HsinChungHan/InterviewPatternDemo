//
//  EmailMemberShip.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation
class EmailMembership: MembershipTransmitter {
    override func confirm(loginType: LoginType, failure: (LoginType) -> ()) {
        if loginType == .EmailLogin {
            //have specific event for members who use email login
            print("Welcome, using email login")
        } else {
            //not use email login, transmit to next responder
            super.confirm(loginType: loginType, failure: failure)
        }
    }
}
