//
//  SerialQueueDependencyStorage.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation

class SerialQueueDependencyStorage: DependencyStorageProtocol {
    // MARK: - Instance variables

    private let queue = DispatchQueue(label: "com.littlestars.SwiftDI.storage.serial")
    private var dependencies: [DependencyKey: DependencyProvider] = [:]

    // MARK: - Public

    func fetchProvider(by key: DependencyKey) -> DependencyProvider? {
        return queue.sync {
            dependencies[key]
        }
    }

    func save(_ provider: DependencyProvider, for key: DependencyKey) {
        queue.sync(flags: .barrier) {
            dependencies[key] = provider
        }
    }

    func keys() -> Set<DependencyKey> {
        return Set(dependencies.keys)
    }
}
