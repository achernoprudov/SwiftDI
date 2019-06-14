//
//  LazyDependencyProvider.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

enum Lifecycle {
    case singleton, prototype, soft
}

class LazyDependencyProvider: DependencyProvider {
    let lifecycle: Lifecycle

    func provide(by injector: Injector) -> Any {
    }
}
