//
//  FlowViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

class FlowViewController: UIViewController {

    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        let label = VCIdLabel()
        label.setLabel(name: "FlowVC", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(label)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let inputNameVC = InputUserNameViewController()
        present(inputNameVC, animated: true)
        inputNameVC.flowDelegate = self
    }
}

extension FlowViewController: InputUserNameViewControllerFlowDelegate {
    func inputUserNameViewControllerFlowDelegateGoToInputAddressVC(_ inputUserNameViewController: InputUserNameViewController, name: String) {
        let inputAddressVC = InputUserAddressViewController()
        inputAddressVC.name = name
        user.name = name
        inputUserNameViewController.present(inputAddressVC, animated: true)
        inputAddressVC.flowDelegate = self
    }
}

extension FlowViewController: InputUserAddressViewControllerFlowDelegate {
    func inputUserAddressViewControllerFlowDelegateToLoginVC(_ inputUserAddressViewController: InputUserAddressViewController, address: String) {
        let loginVC = LoginViewController()
        user.address = address
        inputUserAddressViewController.present(loginVC, animated: true)
        loginVC.flowDelegate = self
    }
}

extension FlowViewController: LoginViewControllerFlowDelegate {
    func loginViewControllerFlowDelegateGoToProductVC(_ loginViewController: LoginViewController, loginType: LoginType) {
        let productVC = ProductViewController()
        user.loginType = loginType
        productVC.user = user
        loginViewController.present(productVC, animated: true)
    }
}
