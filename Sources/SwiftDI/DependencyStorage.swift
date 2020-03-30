//
//  DependencyStorage.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 21/06/2019.
//

import Foundation

/// Type of the depednencies store
///
/// - simple: no syncronization between threads but faster performance
/// - concurrent: allow multithreading but block threads on write
public enum DependencyStorageType {
    case simple, concurrent
}

protocol DependencyStorageProtocol {
    func fetchProvider(by key: DependencyKey) -> DependencyProvider?

    func save(_ provider: DependencyProvider, for key: DependencyKey)

    func keys() -> Set<DependencyKey>
}

class SimpleDependencyStorage: DependencyStorageProtocol {
    // MARK: - Instance variables

    private var dependencies: [DependencyKey: DependencyProvider] = [:]

    // MARK: - Public

    func fetchProvider(by key: DependencyKey) -> DependencyProvider? {
        return dependencies[key]
    }

    func save(_ provider: DependencyProvider, for key: DependencyKey) {
        dependencies[key] = provider
    }

    func keys() -> Set<DependencyKey> {
        return Set(dependencies.keys)
    }
}

class ConcurrentDependencyStorage: DependencyStorageProtocol {
    // MARK: - Instance variables

//    private let queue = DispatchQueue(label: "com.littlestars.SwiftDI.storage.concurrent")
    private var dependencies: [DependencyKey: DependencyProvider] = [:]
    let lock = NSLock()

    // MARK: - Public

    func fetchProvider(by key: DependencyKey) -> DependencyProvider? {
        lock.lock()
        defer {
            lock.unlock()
        }
        return dependencies[key]
    }

    func save(_ provider: DependencyProvider, for key: DependencyKey) {
        lock.lock()
        dependencies[key] = provider
        lock.unlock()
    }

    func keys() -> Set<DependencyKey> {
        lock.lock()
        defer {
            lock.unlock()
        }
        return Set(dependencies.keys)
    }
}
