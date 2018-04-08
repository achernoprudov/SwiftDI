//
//  BindingBuilder.swift
//  SwiftDI
//
//  Created by Андрей Чернопрудов on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

open class BindingBuilder<T> {
    
    private let injector: Injector
    let type: T.Type
    var tag: String = ""
    var singleton: Bool = false
//TODO    var lazy: Bool = true

    init(injector: Injector, type: T.Type) {
        self.injector = injector
        self.type = type
    }
    
    open func tag(_ tag: String) -> BindingBuilder {
        self.tag = tag
        return self
    }
    
    open func singleton(_ flag: Bool) -> BindingBuilder {
        self.singleton = flag
        return self
    }
    
    open func with(_ binding: @escaping (Injector) -> T) {
        injector.bind(builder: self, with: binding)
    }
}
