//
//  BindingBuilder.swift
//  SwiftDI
//
//  Created by Андрей Чернопрудов on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

public struct BindingBuilder<T> {
    
    let injector: Injector
    let type: T.Type
    var tag: String = ""
    var singleton: Bool = false
//TODO    var lazy: Bool = true

    init(injector: Injector, type: T.Type) {
        self.injector = injector
        self.type = type
    }
    
    mutating func tag(_ tag: String) -> BindingBuilder {
        self.tag = tag
        return self
    }
    
    mutating func singleton(_ flag: Bool) -> BindingBuilder {
        self.singleton = flag
        return self
    }
    
    func with(_ binding: @escaping (Injector) -> T) {
        injector.bind(builder: self, with: binding)
    }
}
