//
//  Inject.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 25.04.2020.
//

@propertyWrapper
public struct Inject<Value> {
    // MARK: - Instance variables

    let dependency: Value

    // MARK: - Public

    public init(injector: Injector = .default, tag: String? = nil) {
        let dependencyTag = tag ?? injector.config.tag
        dependency = injector.resolve(Value.self, tag: dependencyTag)
    }

    public var wrappedValue: Value {
        return dependency
    }
}
