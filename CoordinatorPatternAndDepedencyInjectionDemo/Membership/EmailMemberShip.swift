//
//  EmailMemberShip.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation
class EmailMembership: MembershipTransmitter {
    override func confirm(loginType: LoginType, success: ((LoginType) -> Void), failure: ((LoginType) -> Void)) {
        if loginType == .EmailLogin {
            //have specific event for members who use email login
            success(loginType)
        } else {
            //not use email login, transmit to next responder
            super.confirm(loginType: loginType, success: success, failure: failure)
        }
    }
}
