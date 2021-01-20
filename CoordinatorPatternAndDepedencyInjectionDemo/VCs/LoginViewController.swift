//
//  LoginViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

enum LoginType: String {
    case FacebookLogin = "Facebook"
    case TwitterLogin = "Twitter"
    case PinkoiLogin = "Pinkoi"
    case EmailLogin = "Email"
    
    
}

// MARK: - Depenancy Injection Demo
protocol LoginViewControllerDataSource: NSObject {
    func loginViewControllerGetUserInformation(_ loginViewController: LoginViewController, handle: (String) -> Void)
}

protocol LoginViewControllerDelegate: NSObject {
    func loginViewControllerDoLogIn(_ loginViewController: LoginViewController, loginType: LoginType)
}

//MARK: - Coordinator Pattern
protocol LoginViewControllerFlowDelegate: NSObject {
    func loginViewControllerFlowDelegateGoToProductVC(_ loginViewController: LoginViewController, loginType: LoginType)
}

class LoginViewController: UIViewController {
    weak var socialLoginDataSource: LoginViewControllerDataSource?
    weak var socialLoginDelegate: LoginViewControllerDelegate?
    
    weak var membershipLoginDataSource: LoginViewControllerDataSource?
    weak var membershipLoginDelegate: LoginViewControllerDelegate?
    
    weak var flowDelegate: LoginViewControllerFlowDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        // social login
        socialLoginDataSource = SocialLoginManager.shared
        socialLoginDelegate = SocialLoginManager.shared

        socialLoginDelegate?.loginViewControllerDoLogIn(self, loginType: .TwitterLogin)
        socialLoginDataSource?.loginViewControllerGetUserInformation(self, handle: { (userInfomation) in
//            print("userInfomation: \(userInfomation)")
        })
        
        
        // membership login
        membershipLoginDataSource = MembershipLoginManager.shared
        membershipLoginDelegate = MembershipLoginManager.shared
        
        membershipLoginDelegate?.loginViewControllerDoLogIn(self, loginType: .EmailLogin)
        membershipLoginDataSource?.loginViewControllerGetUserInformation(self, handle: { (userInfomation) in
//            print("userInfomation: \(userInfomation)")
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        let label = VCIdLabel()
        label.setLabel(name: "LoginVC", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(label)
        
        let goToButton = SwitchVCButton()
        goToButton.setButton(destVCName: "ProductVC", frame: CGRect(x: 50, y: 250, width: 300, height: 20))
        goToButton.addTarget(self, action: #selector(goToButtonPressed), for: .touchUpInside)
        view.addSubview(goToButton)
    }

    @objc func goToButtonPressed(sender: SwitchVCButton) {
        flowDelegate?.loginViewControllerFlowDelegateGoToProductVC(self, loginType: .EmailLogin)
    }
}
