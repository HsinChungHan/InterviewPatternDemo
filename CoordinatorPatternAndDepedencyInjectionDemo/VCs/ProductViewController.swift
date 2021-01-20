//
//  ProductViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

class ProductViewController: UIViewController {

    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        let label = VCIdLabel()
        label.setLabel(name: "ProductVC", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(label)
        print(user?.description())
    }
}
