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
        if let saved = instance {
            return saved
        }
        let resolved = binding(injector)
        if singleton {
            instance = resolved
        }
        return resolved
    }
}
