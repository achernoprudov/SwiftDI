//
//  ProviderCache.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

protocol ProviderCache: class {
    var dependency: Any? { get }

    func save(_ dependency: Any)
}

class SingletonScopeCache: ProviderCache {
    var dependency: Any?

    func save(_ dependency: Any) {
        self.dependency = dependency
    }
}

class NoCache: ProviderCache {
    let dependency: Any? = nil

    func save(_ dependency: Any) {
    }
}

class WeakScopeCache: ProviderCache {
    private weak var _dependency: AnyObject?

    var dependency: Any? { return _dependency }

    func save(_ dependency: Any) {
        _dependency = dependency as AnyObject
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
