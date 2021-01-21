//
//  LoginViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

// MARK: - LoginType
enum LoginType: String {
    
    case FacebookLogin = "Facebook"
    case TwitterLogin = "Twitter"
    case PinkoiLogin = "Pinkoi"
    case EmailLogin = "Email"
    case Dummy = "Dummy Login"
}


// MARK: - Depenancy Injection Demo - an middleware between LoginManager and LoginViewController
protocol LoginViewControllerDataSource: NSObject {
    
    func loginViewControllerGetUserInformation(_ loginViewController: LoginViewController, handle: (String) -> Void)
}


protocol LoginViewControllerDelegate: NSObject {
    
    func loginViewControllerDoLogIn(_ loginViewController: LoginViewController, loginType: LoginType)
}


//MARK: - Coordinator Pattern Flow Delegate
protocol LoginViewControllerFlowDelegate: NSObject {
    
    func loginViewControllerFlowDelegateGoToProductVC(_ loginViewController: LoginViewController, loginType: LoginType)
}


class LoginViewController: UIViewController {
    
    weak var socialLoginDataSource: LoginViewControllerDataSource?
    weak var socialLoginDelegate: LoginViewControllerDelegate?
    
    weak var membershipLoginDataSource: LoginViewControllerDataSource?
    weak var membershipLoginDelegate: LoginViewControllerDelegate?
    
    weak var flowDelegate: LoginViewControllerFlowDelegate?
    
    lazy var naviLabel = makeNaviLabel()
    lazy var goToButton = makeGoToButton()
    
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
        
        view.addSubview(naviLabel)
        view.addSubview(goToButton)
    }
}


// MARK: - Lazy Initialization
extension LoginViewController {
    
    func makeNaviLabel() -> VCIdLabel {
        let label = VCIdLabel()
        label.setLabel(name: "LoginVC", frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        return label
    }
    
    func makeGoToButton() -> SwitchVCButton {
        let button = SwitchVCButton()
        button.setButton(destVCName: "ProductVC", frame: CGRect(x: 10, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 20, height: 30))
        button.addTarget(self, action: #selector(goToButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }
    
    @objc func goToButtonPressed(sender: SwitchVCButton) {
        flowDelegate?.loginViewControllerFlowDelegateGoToProductVC(self, loginType: .Dummy)
    }
}
