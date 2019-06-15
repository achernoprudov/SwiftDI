//
//  DependencyScope.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

/// How much dependency lives.
///
/// - singleton: only one depeendency for injector
/// - prototype: each time new dependency
/// - weak: dependency stored as weak reference and uses same until at least one object has reference to it
public enum DependencyScope {
    case singleton, prototype, weak
}
