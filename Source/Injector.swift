//
//  Injector.swift
//  SwiftDI
//
//  Created by Андрей Чернопрудов on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

open class Injector {
    
    // MARK: - Instance variables
    
    private var parent: Injector?
    private var dependencies: [InjectorKey : InjectProvider] = [:]
    
    // MARK: - Open
    
    public init(parent: Injector? = nil) {
        self.parent = parent
    }
    
    open func bind<T>(_ type: T.Type) -> BindingBuilder<T> {
        return BindingBuilder(injector: self, type: type)
    }
    
    open func resolve<T>(_ type: T.Type, tag: String = "") -> T {
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
    
    open func resolveSafe<T>(_ type: T.Type, tag: String = "") -> T? {
        let key = InjectorKey(type: type, tag: tag)
        if let provider = dependencies[key] {
            return provider.provide(by: self) as? T
        }
        return parent?.resolve(type, tag: tag)
    }
    
   // MARK: - Public
    
    func bind<T>(builder: BindingBuilder<T>, with binding: @escaping (Injector) -> T) {
        let key = InjectorKey(type: builder.type, tag: builder.tag)
        let provider = InjectProvider(singleton: builder.singleton) { binding($0) as Any }
        dependencies[key] = provider
    }
}
