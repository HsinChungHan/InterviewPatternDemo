//
//  CartViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

protocol InputUserAddressViewControllerFlowDelegate: AnyObject {
    func inputUserAddressViewControllerFlowDelegateToLoginVC(_ inputUserAddressViewController: InputUserAddressViewController, address: String)
}

class InputUserAddressViewController: UIViewController {
    weak var flowDelegate: InputUserAddressViewControllerFlowDelegate?
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        let label = VCIdLabel()
        label.setLabel(name: "UserAddress", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(label)
        print("User name is \(name)")
        
        let goToButton = SwitchVCButton()
        goToButton.setButton(destVCName: "LoginVC", frame: CGRect(x: 50, y: 250, width: 300, height: 20))
        goToButton.addTarget(self, action: #selector(goToButtonPressed), for: .touchUpInside)
        view.addSubview(goToButton)
    }

    @objc func goToButtonPressed(sender: SwitchVCButton) {
        let address = "Taipei, Taiwan"
        flowDelegate?.inputUserAddressViewControllerFlowDelegateToLoginVC(self, address: address)
    }
}
