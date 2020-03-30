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
        private static var defaultStorageType: DependencyStorageType {
            if #available(OSX 10.12, iOS 10.0, *) {
                return .unfairLock
            }
            return .nsLock
        }

        public static let `default`: Config = Config(
            tag: "",
            scope: .weak,
            storage: defaultStorageType
        )

        /// Default dependency tag
        public var tag: String
        /// Default dependency scope
        public var scope: DependencyScope
        /// Dependency storage type.
        public var storage: DependencyStorageType
    }
}
