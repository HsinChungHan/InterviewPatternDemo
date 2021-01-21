//
//  SwitchVCButton.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import UIKit

protocol BasicButton {
    var bgColor: UIColor { get }
    var myTextColor: UIColor { get }
}

extension BasicButton where Self: UIButton {
    func setButton(destVCName: String, frame: CGRect) {
        backgroundColor = bgColor
        setTitle("go to \(destVCName)", for: .normal)
        self.frame = frame
    }
}

class SwitchVCButton: UIButton, BasicButton {
    var bgColor: UIColor = UIColor.red
    var myTextColor: UIColor = UIColor.white
}
