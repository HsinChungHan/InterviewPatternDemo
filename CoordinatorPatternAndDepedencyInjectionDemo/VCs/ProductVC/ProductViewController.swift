//
//  ProductViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

//MARK: - Flow Delegate
protocol ProductViewControllerFlowDelegate: NSObject {
    
    func productViewControllerFlowDelegateGoBack(_ productViewController: ProductViewController)
    func productViewControllerFlowDelegateGoToRootPage(_ productViewController: ProductViewController)
}


//MARK: - Flow Datasource
protocol ProductViewControllerFlowDatasource: NSObject {
    func productViewControllerFlowDatasourceUser(_ productViewController: ProductViewController) -> User
}


class ProductViewController: UIViewController {
    
    weak var flowDelegate: ProductViewControllerFlowDelegate?
    weak var flowDatasource: ProductViewControllerFlowDatasource?
    
    var viewModel = ProductVCViewModel()
    
    lazy var naviLabel = makeNaviLabel()
    lazy var goToButton = makeGoToButton()
    lazy var goToRootButton = makeGoToRootButton()
    lazy var membershipLabel = makeMembershipLabelLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)

        view.addSubview(naviLabel)
        view.addSubview(goToButton)
        view.addSubview(goToRootButton)
        view.addSubview(membershipLabel)
        
        setVMUser()
        bindVMProperties()
        viewModel.checkUserLoginTypeToDecideFollowEvents()
    }
}


// MARK: - Lazy Initialization
extension ProductViewController {
    
    func makeNaviLabel() -> VCIdLabel {
        let label = VCIdLabel()
        label.setLabel(name: "ProductVC", frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        return label
    }
    
    func makeGoToButton() -> SwitchVCButton {
        let button = SwitchVCButton()
        button.setButton(destVCName: "Last Page", frame: CGRect(x: 10, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 20, height: 30))
        button.addTarget(self, action: #selector(goToButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }
    
    @objc func goToButtonPressed(sender: SwitchVCButton) {
        flowDelegate?.productViewControllerFlowDelegateGoBack(self)
    }
    
    func makeGoToRootButton() -> SwitchVCButton {
        let button = SwitchVCButton()
        button.setButton(destVCName: "Root Page", frame: CGRect(x: 10, y: UIScreen.main.bounds.height/2 + 40, width: UIScreen.main.bounds.width - 20, height: 30))
        button.addTarget(self, action: #selector(goToRootButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }
    
    @objc func goToRootButtonPressed(sender: SwitchVCButton) {
        flowDelegate?.productViewControllerFlowDelegateGoToRootPage(self)
    }
    
    func makeMembershipLabelLabel() -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: UIScreen.main.bounds.height/2 + 80, width: UIScreen.main.bounds.width - 20, height: 30)
        label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }
    
    func setVMUser() {
        guard let flowDatasource = flowDatasource else {
            fatalError("FlowDatasource is nil!")
        }
        let user = flowDatasource.productViewControllerFlowDatasourceUser(self)
        viewModel.setUser(user: user)
    }
    
    func bindVMProperties() {
        viewModel.bindableText.bind(observer: {[weak self] (text) in
            guard let self = self, let text = text else { return }
            self.membershipLabel.text = text
        })
    }
}
