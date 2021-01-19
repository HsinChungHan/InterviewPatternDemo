//
//  LoginViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

enum LoginType {
    case FacebookLogin
    case TwitterLogin
    case PinkoiLogin
    case EmailLogin
}

// -MARK: Depenancy Injection Demo
protocol LoginViewControllerDataSource: NSObject {
    func loginViewControllerGetUserInformation(_ loginViewController: LoginViewController, handle: (String) -> Void)
}

protocol LoginViewControllerDelegate: NSObject {
    func loginViewControllerDoLogIn(_ loginViewController: LoginViewController, loginType: LoginType)
}

class LoginViewController: UIViewController {
    weak var socialLoginDataSource: LoginViewControllerDataSource?
    weak var socialLoginDelegate: LoginViewControllerDelegate?
    
    weak var membershipLoginDataSource: LoginViewControllerDataSource?
    weak var membershipLoginDelegate: LoginViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        // social login
        socialLoginDataSource = SocialLoginManager.shared
        socialLoginDelegate = SocialLoginManager.shared

        socialLoginDelegate?.loginViewControllerDoLogIn(self, loginType: .TwitterLogin)
        socialLoginDataSource?.loginViewControllerGetUserInformation(self, handle: { (userInfomation) in
            print("userInfomation: \(userInfomation)")
        })
        
        
        // membership login
        membershipLoginDataSource = MembershipLoginManager.shared
        membershipLoginDelegate = MembershipLoginManager.shared
        
        membershipLoginDelegate?.loginViewControllerDoLogIn(self, loginType: .EmailLogin)
        membershipLoginDataSource?.loginViewControllerGetUserInformation(self, handle: { (userInfomation) in
            print("userInfomation: \(userInfomation)")
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
