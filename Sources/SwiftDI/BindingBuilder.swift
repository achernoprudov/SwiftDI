//
//  BindingBuilder.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

open class BindingBuilder<T> {
    private let injector: Injector
    let type: T.Type
    var tag: String
    var lifecycle: DependencyLifecycle

    init(injector: Injector, type: T.Type) {
        self.injector = injector
        self.type = type
        tag = injector.config.tag
        lifecycle = injector.config.lifecycle
    }

    /// Set tag to dependency
    open func tag(_ tag: String) -> BindingBuilder {
        self.tag = tag
        return self
    }

    /// Set dependency to be singleton
    open func lifecycle(_ lifecycle: DependencyLifecycle) -> BindingBuilder {
        self.lifecycle = lifecycle
        return self
    }

    /// Require provide `binding` clodure for dependency.
    /// in `binding` there are injector that could provide cross dependencies.
    /// Function finalize binding process.
    open func with(_ binding: @escaping (Injector) -> T) {
        injector.bind(builder: self, with: binding)
    }
}
