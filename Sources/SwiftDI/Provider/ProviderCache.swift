//
//  ProviderCache.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

import Foundation

protocol ProviderCache: class {
    func save(_ dependency: Any)
    func get() -> Any?
}

class SingletonScopeCache: ProviderCache {
    var dependency: Any?

    func save(_ dependency: Any) {
        self.dependency = dependency
    }

    func get() -> Any? {
        return dependency
    }
}

class NoCache: ProviderCache {
    func save(_ dependency: Any) {
    }

    func get() -> Any? {
        return nil
    }
}

class WeakScopeCache: ProviderCache {
    private weak var dependency: AnyObject?

    func save(_ dependency: Any) {
        self.dependency = dependency as AnyObject
    }

    func get() -> Any? {
        return dependency
    }
}

class ProviderCacheFactory {
    static let `default` = ProviderCacheFactory()

    func cache(for scope: DependencyScope) -> ProviderCache {
        switch scope {
        case .prototype:
            return NoCache()
        case .singleton:
            return SingletonScopeCache()
        case .weak:
            return WeakScopeCache()
        }
    }
}
