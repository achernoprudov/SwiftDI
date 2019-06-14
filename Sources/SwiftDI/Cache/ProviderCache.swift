//
//  ProviderCache.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

protocol ProviderCache {
    var cachedDependency: Any? { get set }
}

class SingletonCache: ProviderCache {
    var cachedDependency: Any?
}

class NoCache: ProviderCache {
    var cachedDependency: Any? {
        get { return nil }
        set {}
    }
}

class SoftCache: ProviderCache {
    weak var _dependency: AnyObject?

    var cachedDependency: Any? {
        get { return _dependency }
        set { _dependency = newValue as AnyObject }
    }
}

class ProviderCacheFactory {
    static let `default` = ProviderCacheFactory()

    func cache(for lifecycle: DependencyLifecycle) -> ProviderCache {
        switch lifecycle {
        case .prototype:
            return NoCache()
        case .singleton:
            return SingletonCache()
        case .soft:
            return SoftCache()
        }
    }
}
