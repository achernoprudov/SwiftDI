//
//  InjectProvider.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//
@available(*, deprecated, message: "Use DependencyProvider instead")
class InjectProvider {
    let singleton: Bool
    let binding: (Injector) -> Any
    var instance: Any?

    /// Builder for lazy dependencies
    init(singleton: Bool, binding: @escaping (Injector) -> Any) {
        self.singleton = singleton
        self.binding = binding
    }

    /// Builder for non lazy dependency
    init(instance: Any) {
        singleton = true
        self.instance = instance
        binding = { _ in instance }
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
