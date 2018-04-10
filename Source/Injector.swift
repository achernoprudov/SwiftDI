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
    private var dependencies: [InjectorKey : InjectProvider] = [:]
    
    // MARK: - Open
    
    /// Constructor for Injector
    ///
    /// - Parameters:
    ///   - parent: parent injector
    ///   - config: config with default options for bindings
    public init(parent: Injector? = nil, config: Config = .default) {
        self.parent = parent
        self.config = config
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
        let key = InjectorKey(type: type, tag: tag)
        if let provider = dependencies[key] {
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
    
    /// Resolve dependency in Injector in safe way.
    /// Could not fall with error but could be nil.
    ///
    /// - Parameters:
    ///   - type: dependency type
    ///   - tag: dependency tag
    /// - Returns: resolved dependency
    open func resolveSafe<T>(_ type: T.Type, tag: String = "") -> T? {
        let key = InjectorKey(type: type, tag: tag)
        if let provider = dependencies[key] {
            return provider.provide(by: self) as? T
        }
        return parent?.resolve(type, tag: tag)
    }
    
    /// Open child injector
    ///
    /// - Returns: child injector
    open func plus() -> Injector {
        return Injector(parent: self)
    }
    
   // MARK: - Public
    
    func bind<T>(builder: BindingBuilder<T>, with binding: @escaping (Injector) -> T) {
        let key = InjectorKey(type: builder.type, tag: builder.tag)
        let provider = builder.lazy
            ? InjectProvider(singleton: builder.singleton) { binding($0) as Any }
            : InjectProvider(instance: binding(self) as Any)
        dependencies[key] = provider
    }
}
