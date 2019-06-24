//
//  Injector.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

open class Injector {
    // MARK: - Instance variables

    let config: Config

    private let parent: Injector?
    private let storage: DependencyStorageProtocol

    // MARK: - Open

    /// Constructor for Injector
    ///
    /// - Parameters:
    ///   - parent: parent injector
    ///   - config: config with default options for bindings
    public init(parent: Injector? = nil, config: Config = .default) {
        self.parent = parent
        self.config = config

        switch config.storage {
        case .concurrent:
            storage = ConcurrentDependencyStorage()
        case .simple:
            storage = SimpleDependencyStorage()
        }
    }

    /// Start binding process
    ///
    /// - Parameter type: type of binding dependency. Could be an protocol
    /// - Returns: builder that help bind another parameters in fluent way
    open func bind<T>(_ type: T.Type) -> BindingBuilder<T> {
        return BindingBuilder(injector: self, type: type)
    }

    /// Resolve dependency in Injector.
    /// Could be fall with error if Injector(or all parents) have not dependency.
    /// For safe resolving use `resolveSafe`
    ///
    /// - Parameters:
    ///   - type: dependency type
    ///   - tag: dependency tag
    /// - Returns: resolved dependency
    open func resolve<T>(_ type: T.Type = T.self, tag: String = "") -> T {
        let key = DependencyKey(type: type, tag: tag)
        if let provider = storage.fetchProvider(by: key) {
            let dependency = provider.provide(by: self)
            guard let result = dependency as? T else {
                let subjectType = Mirror(reflecting: dependency).subjectType
                preconditionFailure("Provided object has wrong type. Expected '\(type)' but was \(subjectType)")
            }
            return result
        }
        guard let p = parent else {
            preconditionFailure("Cant find any parent Injector that could provide '\(type)' with tag='\(tag)'")
        }
        return p.resolve(type, tag: tag)
    }

    /// Resolve implicit optional dependency in Injector.
    /// Could be fall with error if Injector(or all parents) have not dependency.
    /// For safe resolving use `resolveSafe`
    ///
    /// - Parameters:
    ///   - tag: dependency tag
    /// - Returns: resolved dependency
    open func resolve<T>(_ tag: String = "") -> T? {
        return resolve(T.self, tag: tag)
    }

    /// Resolve dependency in Injector in safe way.
    /// Could not fall with error but could be nil.
    ///
    /// - Parameters:
    ///   - type: dependency type
    ///   - tag: dependency tag
    /// - Returns: resolved dependency
    open func resolveSafe<T>(_ type: T.Type, tag: String = "") -> T? {
        let key = DependencyKey(type: type, tag: tag)
        if let provider = storage.fetchProvider(by: key) {
            return provider.provide(by: self) as? T
        }
        return parent?.resolveSafe(type, tag: tag)
    }

    /// Open child injector
    ///
    /// - Returns: child injector
    open func plus() -> Injector {
        return Injector(parent: self)
    }

    // MARK: - Public

    func bind<R>(builder: BindingBuilder<R>, with binding: @escaping (Injector) -> R) {
        let key = DependencyKey(type: builder.type, tag: builder.tag)
        let cache = ProviderCacheFactory.default.cache(for: builder.scope)
        let provider = DependencyProvider(cache: cache, builder: binding)

        storage.save(provider, for: key)
    }
}
