//
//  ThreadLock.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation

protocol ThreadLock {
    func lock()
    func unlock()
}

@available(OSX 10.12, iOS 10.0, *)
class UnfairThreadLock: ThreadLock {
    private var unfairLock = os_unfair_lock_s()

    func lock() {
        os_unfair_lock_lock(&unfairLock)
    }

    func unlock() {
        os_unfair_lock_unlock(&unfairLock)
    }
}

class NSThreadLock: ThreadLock {
    private var nsLock = NSLock()

    func lock() {
        nsLock.lock()
    }

    func unlock() {
        nsLock.unlock()
    }
}

class SpinThreadLock: ThreadLock {
    private var spinLock = OS_SPINLOCK_INIT

    func lock() {
        OSSpinLockLock(&spinLock)
    }

    func unlock() {
        OSSpinLockUnlock(&spinLock)
    }
}
