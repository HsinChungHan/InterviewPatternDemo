//
//  Bindable.swift
//  CoordinatorPatternAndDepedencyInjectionDemo
//
//  Created by Chung Han Hsin on 2021/1/20.
//

import Foundation
class Bindable<T> {
    
    private var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    private var observer: ((_ value: T?) -> Void)?
    
    init(value: T?) {
        self.value = value
    }
    
    func bind(observer: @escaping(_ value: T?) -> Void) {
        self.observer = observer
    }
    
    func setValue(value: T?) {
        self.value = value
    }
}
