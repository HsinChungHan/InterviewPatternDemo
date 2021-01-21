//
//  FlowViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

class FlowViewController: UIViewController {

    var vm = FlowVCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        let label = VCIdLabel()
        label.setLabel(name: "FlowVC", frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        view.addSubview(label)
        
        vm.bindableUserIsFilled.bind { [weak self] (isUserInfoFilled) in
            // post userinformation API
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let inputNameVC = InputUserNameViewController()
        present(inputNameVC, animated: true)
        inputNameVC.flowDelegate = self
    }
}


// MARK: - InputUserNameViewController
extension FlowViewController: InputUserNameViewControllerFlowDelegate {
    
    func inputUserNameViewControllerFlowDelegateGoToInputAddressVC(_ inputUserNameViewController: InputUserNameViewController, name: String) {
        let inputAddressVC = InputUserAddressViewController()
        inputAddressVC.flowDatasource = self
        vm.setUserName(name: name)
        inputUserNameViewController.present(inputAddressVC, animated: true)
        inputAddressVC.flowDelegate = self
    }
}


// MARK: - InputUserAddressViewController
extension FlowViewController: InputUserAddressViewControllerFlowDelegate {
    
    func inputUserAddressViewControllerFlowDelegateToLoginVC(_ inputUserAddressViewController: InputUserAddressViewController, address: String) {
        let loginVC = LoginViewController()
        vm.setUserAddress(address: address)
        inputUserAddressViewController.present(loginVC, animated: true)
        loginVC.flowDelegate = self
    }
}


extension FlowViewController: InputUserAddressViewControllerFlowDatasource {
    
    func inputUserAddressViewControllerFlowDatasourceName(_ inputUserAddressViewController: InputUserAddressViewController) -> String {
        return vm.user.name ?? ""
    }
}


// MARK: - LoginViewController
extension FlowViewController: LoginViewControllerFlowDelegate {
    
    func loginViewControllerFlowDelegateGoToProductVC(_ loginViewController: LoginViewController, loginType: LoginType) {
        let productVC = ProductViewController()
        vm.setUserLoginType(loginType: loginType)
        productVC.flowDatasource = self
        loginViewController.present(productVC, animated: true)
        productVC.flowDelegate = self
    }
}


// MARK: - ProductViewController
extension FlowViewController: ProductViewControllerFlowDelegate {
    
    func findPresentedVCs() -> [UIViewController] {
        var vcs = [UIViewController]()
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                vcs.append(topController)
            }
        }
        return vcs
    }
    
    func productViewControllerFlowDelegateGoToRootPage(_ productViewController: ProductViewController) {
        let presentedVCs = findPresentedVCs()
        for vc in presentedVCs {
            vc.dismiss(animated: true)
        }
    }
    
    func productViewControllerFlowDelegateGoBack(_ productViewController: ProductViewController) {
        productViewController.dismiss(animated: true)
    }
}

extension FlowViewController: ProductViewControllerFlowDatasource {
    func productViewControllerFlowDatasourceUser(_ productViewController: ProductViewController) -> User {
        return vm.user
    }
}
