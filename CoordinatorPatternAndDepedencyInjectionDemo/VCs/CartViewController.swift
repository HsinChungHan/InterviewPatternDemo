//
//  CartViewController.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

class CartViewController: UIViewController {

    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        let label = VCIdLabel()
        label.setLabel(name: "CartVC", frame: CGRect(x: 200, y: 200, width: 100, height: 20))
        view.addSubview(label)
        print("CartVC items = \(items)")
    }

}
