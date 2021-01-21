//
//  MemebershipTransmitter.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation

class MembershipTransmitter {
    
    var nextTransmitter: MembershipTransmitter?
    
    required init() {}
    
    func confirm(loginType: LoginType, success:((LoginType) -> Void), failure: ((LoginType) -> Void)) {
        if nextTransmitter != nil {
            nextTransmitter?.confirm(loginType: loginType, success: success, failure: failure)
        }else {
            print("Reach to tail of responder chain，no one can handle \(loginType.rawValue) event!")
            failure(loginType)
        }
    }
    
    class func createChain() -> MembershipTransmitter? {
        let transmitterClasses: [MembershipTransmitter.Type] = [
            SocailMembership.self,
            PinkoiMembership.self,
            EmailMembership.self
        ]
        
        var responderNode: MembershipTransmitter?
        for transmitterClass in transmitterClasses {
            let currentNode = responderNode
            responderNode = transmitterClass.init()
            responderNode?.nextTransmitter = currentNode
        }
        return responderNode
    }
}
