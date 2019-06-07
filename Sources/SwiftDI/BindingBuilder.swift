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
    var singleton: Bool
    var lazy: Bool

    init(injector: Injector, type: T.Type) {
        self.injector = injector
        self.type = type
        tag = injector.config.tag
        singleton = injector.config.singleton
        `lazy` = injector.config.lazy
    }

    /// Set tag to dependency
    open func tag(_ tag: String) -> BindingBuilder {
        self.tag = tag
        return self
    }

    /// Set dependency to be singleton
    open func singleton(_ flag: Bool) -> BindingBuilder {
        singleton = flag
        return self
    }

    /// Declare dependency for lazy providing.
    /// If flag is `false` dependency always be a singleton.
    open func lazy (_ flag: Bool) -> BindingBuilder {
        `lazy` = flag
        return self
    }

    /// Require provide `binding` clodure for dependency.
    /// in `binding` there are injector that could provide cross dependencies.
    /// Function finalize binding process.
    open func with(_ binding: @escaping (Injector) -> T) {
        injector.bind(builder: self, with: binding)
    }
}
