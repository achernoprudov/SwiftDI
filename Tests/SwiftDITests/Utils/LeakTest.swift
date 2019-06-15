//
//  LeakTest.swift
//  Nimble
//
//  Created by Andrey Chernoprudov on 15/06/2019.
//

import Foundation

/// Based on https://github.com/leandromperez/specleaks
/// Allow to test class or modules for leaks
class LeakTest {
    // MARK: - Aliases

    typealias LeakConstructor = () -> [AnyObject]

    // MARK: - Instance variables

    private let constructor: LeakConstructor

    // MARK: - Public

    init(_ constructor: @escaping LeakConstructor) {
        self.constructor = constructor
    }

    func isLeaking() -> Bool {
        return !findLeakingContainers().isEmpty
    }

    func findLeakingObjects() -> [String] {
        return findLeakingContainers().map { container in
            container.objectDescription
        }
    }

    // MARK: - Private

    private func findLeakingContainers() -> [LeakTestContainer] {
        var containers: [LeakTestContainer] = []

        autoreleasepool {
            for object in constructor() {
                let container = LeakTestContainer(objectDescription: "\(object)")
                container.reference = object
                containers.append(container)
            }
        }

        return containers.filter { $0.isLeaking }
    }
}

private class LeakTestContainer {
    // MARK: - Instance variables

    let objectDescription: String
    weak var reference: AnyObject? = nil

    var isLeaking: Bool {
        return reference != nil
    }

    // MARK: - Public

    init(objectDescription: String) {
        self.objectDescription = objectDescription
    }
}
