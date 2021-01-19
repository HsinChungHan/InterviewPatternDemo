//
//  VCIdLable.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//


import UIKit

protocol BasicLabel {
    var bgColor: UIColor { get }
    var myTextColor: UIColor { get }
}

extension BasicLabel where Self: UILabel {
    func setLabel(name: String, frame: CGRect) -> Void {
        backgroundColor = bgColor
        self.frame = frame
        text = name
        textColor = myTextColor
    }
}

class VCIdLabel: UILabel, BasicLabel {
    var myTextColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    let bgColor: UIColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
}
