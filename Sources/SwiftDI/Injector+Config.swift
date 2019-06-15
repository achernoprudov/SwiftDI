//
//  Injector+Config.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 08/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

extension Injector {
    /// Config of default options for Injector dependencies
    public struct Config {
        public static let `default`: Config = Config(
            tag: "",
            lifecycle: .soft
        )

        /// Default dependency tag
        public var tag: String

        /// Default dependency lifecycle
        public var lifecycle: DependencyLifecycle
    }
}
