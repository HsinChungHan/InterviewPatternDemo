//
//  ProductViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

//MARK: - Flow Delegate
protocol InputUserNameViewControllerFlowDelegate: AnyObject {
    func inputUserNameViewControllerFlowDelegateGoToInputAddressVC(_ inputUserNameViewController: InputUserNameViewController, name: String)
}


class InputUserNameViewController: UIViewController {

    weak var flowDelegate: InputUserNameViewControllerFlowDelegate?
    
    lazy var naviLabel = makeNaviLabel()
    lazy var goToButton = makeGoToButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)

        view.addSubview(naviLabel)
        view.addSubview(goToButton)
    }
}


// MARK: - Lazy Initialization
extension InputUserNameViewController {
    
    func makeNaviLabel() -> VCIdLabel {
        let label = VCIdLabel()
        label.setLabel(name: "UserName", frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        return label
    }
    
    func makeGoToButton() -> SwitchVCButton {
        let button = SwitchVCButton()
        button.setButton(destVCName: "InputAddressVC", frame: CGRect(x: 10, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 20, height: 30))
        button.addTarget(self, action: #selector(goToButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }
    
    @objc func goToButtonPressed(sender: SwitchVCButton) {
        let name = "Hsin"
        flowDelegate?.inputUserNameViewControllerFlowDelegateGoToInputAddressVC(self, name: name)
    }
}
