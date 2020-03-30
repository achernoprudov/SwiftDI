//
//  ThreadLockDependencyStorage.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation

class ThreadLockDependencyStorage: DependencyStorageProtocol {
    // MARK: - Instance variables

    private let lock: ThreadLock
    private var dependencies: [DependencyKey: DependencyProvider] = [:]

    init(lock: ThreadLock) {
        self.lock = lock
    }

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
