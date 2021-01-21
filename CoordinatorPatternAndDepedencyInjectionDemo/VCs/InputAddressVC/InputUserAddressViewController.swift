//
//  CartViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

//MARK: - Flow Delegate
protocol InputUserAddressViewControllerFlowDelegate: AnyObject {
    
    func inputUserAddressViewControllerFlowDelegateToLoginVC(_ inputUserAddressViewController: InputUserAddressViewController, address: String)
}


protocol InputUserAddressViewControllerFlowDatasource: AnyObject {
    
    func inputUserAddressViewControllerFlowDatasourceName(_ inputUserAddressViewController: InputUserAddressViewController) -> String
}


class InputUserAddressViewController: UIViewController {
    
    weak var flowDelegate: InputUserAddressViewControllerFlowDelegate?
    weak var flowDatasource: InputUserAddressViewControllerFlowDatasource?
    
    lazy var naviLabel = makeNaviLabel()
    lazy var nameLabel = makeNameLabel()
    lazy var goToButton = makeGoToButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        view.addSubview(naviLabel)
        view.addSubview(nameLabel)
        view.addSubview(goToButton)
    }
}


// MARK: - Lazy Initialization
extension InputUserAddressViewController {
    
    func makeNaviLabel() -> VCIdLabel {
        let label = VCIdLabel()
        label.setLabel(name: "UserAddress", frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        return label
    }
    
    func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: UIScreen.main.bounds.height/2 - 40, width: UIScreen.main.bounds.width - 20, height: 30)
        label.textAlignment = .center
        let userName = flowDatasource?.inputUserAddressViewControllerFlowDatasourceName(self) ?? ""
        label.text = "Welcom \(userName)"
        return label
    }
    
    func makeGoToButton() -> SwitchVCButton {
        let button = SwitchVCButton()
        button.setButton(destVCName: "LoginVC", frame: CGRect(x: 10, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 20, height: 30))
        button.addTarget(self, action: #selector(goToButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }
    
    @objc func goToButtonPressed(sender: SwitchVCButton) {
        let address = "Taipei, Taiwan"
        flowDelegate?.inputUserAddressViewControllerFlowDelegateToLoginVC(self, address: address)
    }
}
