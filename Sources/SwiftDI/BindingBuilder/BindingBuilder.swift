//
//  BindingBuilder.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

open class BindingBuilder<T> {
    let injector: Injector
    let type: T.Type
    var tag: String
    var lifecycle: DependencyLifecycle

    init(injector: Injector, type: T.Type) {
        self.injector = injector
        self.type = type
        tag = injector.config.tag
        lifecycle = injector.config.lifecycle
    }

    /// Set dependency tag
    open func tag(_ tag: String) -> BindingBuilder {
        self.tag = tag
        return self
    }

    /// Set dependency lifecycle
    open func lifecycle(_ lifecycle: DependencyLifecycle) -> BindingBuilder {
        self.lifecycle = lifecycle
        return self
    }

    /// Require provide `binding` clodure for dependency.
    /// in `binding` there are injector that could provide cross dependencies.
    /// Function finalize binding process.
    open func with<P>(_ binding: @escaping (P) -> T) {
        switch P.self {
        case is Void.Type:
            injector.bind(builder: self) { _ in binding(() as! P) }
        case is Injector.Type:
            injector.bind(builder: self) { injector in binding(injector as! P) }
        default:
            injector.bind(builder: self) { injector in binding(injector.resolve(P.self)) }
        }
    }
}
