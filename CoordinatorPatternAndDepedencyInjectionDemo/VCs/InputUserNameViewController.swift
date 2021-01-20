//
//  ProductViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

protocol InputUserNameViewControllerFlowDelegate: AnyObject {
    func inputUserNameViewControllerFlowDelegateGoToInputAddressVC(_ inputUserNameViewController: InputUserNameViewController, name: String)
}

class InputUserNameViewController: UIViewController {

    weak var flowDelegate: InputUserNameViewControllerFlowDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        let label = VCIdLabel()
        label.setLabel(name: "UserName", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(label)
        
        let goToButton = SwitchVCButton()
        goToButton.setButton(destVCName: "InputAddressVC", frame: CGRect(x: 50, y: 250, width: 300, height: 20))
        goToButton.addTarget(self, action: #selector(goToButtonPressed), for: .touchUpInside)
        view.addSubview(goToButton)
    }

    @objc func goToButtonPressed(sender: SwitchVCButton) {
        let name = "Hsin"
        flowDelegate?.inputUserNameViewControllerFlowDelegateGoToInputAddressVC(self, name: name)
    }
}
