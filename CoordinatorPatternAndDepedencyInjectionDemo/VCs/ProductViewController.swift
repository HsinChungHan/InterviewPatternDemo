//
//  ProductViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

protocol ProductViewControllerFlowDelegate: NSObject {
    func productViewControllerFlowDelegateGoBack(_ productViewController: ProductViewController)
    func productViewControllerFlowDelegateGoToRootPage(_ productViewController: ProductViewController)
}

class ProductViewController: UIViewController {
    
    weak var flowDelegate: ProductViewControllerFlowDelegate?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        let label = VCIdLabel()
        label.setLabel(name: "ProductVC", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(label)
        print(user?.description())
        
        let goToButton = SwitchVCButton()
        goToButton.setButton(destVCName: "Last Page", frame: CGRect(x: 50, y: 250, width: 300, height: 20))
        goToButton.addTarget(self, action: #selector(goToButtonPressed), for: .touchUpInside)
        view.addSubview(goToButton)
        
        let goToRootButton = SwitchVCButton()
        goToRootButton.setButton(destVCName: "Root Page", frame: CGRect(x: 50, y: 300, width: 300, height: 20))
        goToRootButton.addTarget(self, action: #selector(goToRootButtonPressed), for: .touchUpInside)
        view.addSubview(goToRootButton)
    }

    @objc func goToButtonPressed(sender: SwitchVCButton) {
        flowDelegate?.productViewControllerFlowDelegateGoBack(self)
    }
    
    @objc func goToRootButtonPressed(sender: SwitchVCButton) {
        flowDelegate?.productViewControllerFlowDelegateGoToRootPage(self)
    }
}
