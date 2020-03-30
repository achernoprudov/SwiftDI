//
//  ReadWriteLock.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation

class ReadWriteLock {
    private var lock = pthread_rwlock_t()
    private var attr = pthread_rwlockattr_t()

    init() {
        pthread_rwlock_init(&lock, &attr)
    }

    func readLock() {
        pthread_rwlock_rdlock(&lock)
    }

    func writeLock() {
        pthread_rwlock_wrlock(&lock)
    }

    func unlock() {
        pthread_rwlock_unlock(&lock)
    }
}
