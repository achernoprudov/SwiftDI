//
//  DependencyLifecycle.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

/// How much dependency lives.
///
/// - singleton: only one depeendency for injector
/// - prototype: each time new dependency
/// - soft: dependency same until at least one has it
public enum DependencyLifecycle {
    case singleton, prototype, soft
}
