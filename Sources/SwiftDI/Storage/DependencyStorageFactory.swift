//
//  DependencyStorageFactory.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation

class DependencyStorageFactory {
    static let `default` = DependencyStorageFactory()

    private init() {
    }

    func build(by type: DependencyStorageType) -> DependencyStorageProtocol {
        switch type {
        case .concurrent:
            return ConcurrentQueueDependencyStorage()
        case .serialQueue:
            return SerialQueueDependencyStorage()
        case .simple:
            return SimpleDependencyStorage()
        case .nsLock:
            let threadLock = NSThreadLock()
            return ThreadLockDependencyStorage(lock: threadLock)
        case .spinLock:
            let threadLock = SpinThreadLock()
            return ThreadLockDependencyStorage(lock: threadLock)
        case .unfairLock:
            if #available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
                let threadLock = UnfairThreadLock()
                return ThreadLockDependencyStorage(lock: threadLock)
            } else {
                preconditionFailure("Unfair lock is unavailable")
            }
        case .readWriteLock:
            let lock = ReadWriteLock()
            return ReadWriteLockDependencyStorage(lock: lock)
        }
    }
}
