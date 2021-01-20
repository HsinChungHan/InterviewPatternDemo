//
//  SocialMemberShip.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation

class SocailMembership: MembershipTransmitter {
    override func confirm(loginType: LoginType, failure: (LoginType) -> ()) {
        if loginType == .FacebookLogin || loginType == .TwitterLogin {
            //have specific event for members who use social login
            print("Welcome, using social login")
        } else {
            //not use social login, transmit to next responder
            super.confirm(loginType: loginType, failure: failure)
        }
    }
}
