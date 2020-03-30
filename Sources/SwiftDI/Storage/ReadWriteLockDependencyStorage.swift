//
//  ReadWriteLockDependencyStorage.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation

class ReadWriteLockDependencyStorage: DependencyStorageProtocol {
    // MARK: - Instance variables

    private let lock: ReadWriteLock
    private var dependencies: [DependencyKey: DependencyProvider] = [:]

    init(lock: ReadWriteLock) {
        self.lock = lock
    }

    // MARK: - Public

    func fetchProvider(by key: DependencyKey) -> DependencyProvider? {
        lock.readLock()
        let provider = dependencies[key]
        lock.unlock()
        return provider
    }

    func save(_ provider: DependencyProvider, for key: DependencyKey) {
        lock.writeLock()
        dependencies[key] = provider
        lock.unlock()
    }

    func keys() -> Set<DependencyKey> {
        lock.readLock()
        let keys = Set(dependencies.keys)
        lock.unlock()
        return keys
    }
}
