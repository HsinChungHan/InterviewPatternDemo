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
    var viewModel: ProductVCViewModel
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: ProductVCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    let idLabel = VCIdLabel()
    let goToButton = SwitchVCButton()
    let goToRootButton = SwitchVCButton()
    let membershipLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        
        idLabel.setLabel(name: "ProductVC", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(idLabel)
        
        goToButton.setButton(destVCName: "Last Page", frame: CGRect(x: 50, y: 250, width: 300, height: 20))
        goToButton.addTarget(self, action: #selector(goToButtonPressed), for: .touchUpInside)
        view.addSubview(goToButton)
        
        goToRootButton.setButton(destVCName: "Root Page", frame: CGRect(x: 50, y: 300, width: 300, height: 20))
        goToRootButton.addTarget(self, action: #selector(goToRootButtonPressed), for: .touchUpInside)
        view.addSubview(goToRootButton)
        
        membershipLabel.frame = CGRect(x: 30, y: 350, width: 300, height: 20)
        membershipLabel.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        membershipLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(membershipLabel)
        
        viewModel.bindableText.bind(observer: {[weak self] (text) in
            guard let self = self, let text = text else {
                return
            }
            self.membershipLabel.text = text
        })
        viewModel.checkUserLoginTypeToDecideFollowEvents()
    }

    @objc func goToButtonPressed(sender: SwitchVCButton) {
        flowDelegate?.productViewControllerFlowDelegateGoBack(self)
    }
    
    @objc func goToRootButtonPressed(sender: SwitchVCButton) {
        flowDelegate?.productViewControllerFlowDelegateGoToRootPage(self)
    }
}
