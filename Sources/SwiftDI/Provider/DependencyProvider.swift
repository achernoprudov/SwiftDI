//
//  DependencyProvider.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

class DependencyProvider {
    private let cache: ProviderCache
    private let builder: DependencyBuilder

    init(
        cache: ProviderCache,
        builder: DependencyBuilder
    ) {
        self.cache = cache
        self.builder = builder
    }

    func provide(by injector: Injector) -> Any {
        if let cached = cache.dependency {
            return cached
        }
        let dependency = builder.build(with: injector)
        cache.save(dependency)
        return dependency
    }
}
