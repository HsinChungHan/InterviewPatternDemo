//
//  VCIdLable.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//


import UIKit

protocol BasicLabel {
    var bgColor: UIColor { get }
    var txtColor: UIColor { get }
    var txtAlignment: NSTextAlignment { get }
}

extension BasicLabel where Self: UILabel {
    func setLabel(name: String, frame: CGRect) -> Void {
        backgroundColor = bgColor
        self.frame = frame
        text = name
        textColor = txtColor
        textAlignment = txtAlignment
    }
}

class VCIdLabel: UILabel, BasicLabel {
    let txtAlignment: NSTextAlignment = .center
    var txtColor: UIColor = .black
    var bgColor: UIColor = .lightGray
}
