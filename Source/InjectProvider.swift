//
//  InjectProvider.swift
//  SwiftDI
//
//  Created by Андрей Чернопрудов on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

class InjectProvider {
    
    let singleton: Bool
    let binding: (Injector) -> Any
    
    var instance: Any?
    
    init(singleton: Bool, binding: @escaping (Injector) -> Any) {
        self.singleton = singleton
        self.binding = binding
    }
    
    func provide(by injector: Injector) -> Any {
        if let saved = self.instance {
            return saved
        }
        let instance = binding(injector)
        if singleton {
            self.instance = instance
        }
        return instance
    }
}
