//
//  ProductViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

protocol ProductViewControllerFlowDelegate: AnyObject {
    func productViewControllerFlowDelegateGoToCart(_ productViewController: ProductViewController, items: [String])
}

class ProductViewController: UIViewController {

    weak var flowDelegate: ProductViewControllerFlowDelegate?
    var welcomeWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        let label = VCIdLabel()
        label.setLabel(name: "ProductVC", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(label)
        print("ProductVC welcomeWord = \(welcomeWord)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let items = ["iphone12", "airpods", "iPad"]
        flowDelegate?.productViewControllerFlowDelegateGoToCart(self, items: items)
    }
}
