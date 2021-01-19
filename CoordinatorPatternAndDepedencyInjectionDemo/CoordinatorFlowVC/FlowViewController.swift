//
//  FlowViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

class FlowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        let label = VCIdLabel()
        label.setLabel(name: "FlowVC", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(label)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let loginVC = LoginViewController()
        present(loginVC, animated: true)
        loginVC.flowDelegate = self
    }
}

extension FlowViewController: LoginViewControllerFlowDelegate {
    func loginViewControllerFlowDelegateGoToProductVC(_ loginViewController: LoginViewController, loginType: LoginType) {
        var welcomeStr = ""
        switch loginType {
        case .EmailLogin:
            welcomeStr = "You use email login!"
        default:
            welcomeStr = "I don't care you!"
        }
        let productVC = ProductViewController()
        productVC.welcomeWord = welcomeStr
        loginViewController.present(productVC, animated: true)
        productVC.flowDelegate = self
    }
}

extension FlowViewController: ProductViewControllerFlowDelegate {
    func productViewControllerFlowDelegateGoToCart(_ productViewController: ProductViewController, items: [String]) {
        let cartVC = CartViewController()
        cartVC.items = items
        productViewController.present(cartVC, animated: true)
    }
}
