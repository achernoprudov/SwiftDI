//
//  InstantDependencyProvider.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

class InstantDependencyProvider: DependencyProvider {
    private let dependency: Any

    func provide(by injector: Injector) -> Any {
        return dependency
    }
}
