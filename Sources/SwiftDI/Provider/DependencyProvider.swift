//
//  DependencyProvider.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

import Foundation

class DependencyProvider {
    typealias DependencyBuilder = (Injector) -> Any

    private let cache: ProviderCache
    private let builder: DependencyBuilder
    private let lock = NSRecursiveLock()

    init(
        cache: ProviderCache,
        builder: @escaping DependencyBuilder
    ) {
        self.cache = cache
        self.builder = builder
    }

    func provide(by injector: Injector) -> Any {
        lock.lock()
        if let cached = cache.get() {
            lock.unlock()
            return cached
        }
        let dependency = builder(injector)
        cache.save(dependency)
        lock.unlock()
        return dependency
    }
}
