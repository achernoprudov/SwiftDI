//
//  DependencyProvider.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

protocol DependencyProvider {
    func provide(by injector: Injector) -> Any
}
