//
//  SpinThreadLock.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation

class SpinThreadLock: ThreadLock {
    private var spinLock = OS_SPINLOCK_INIT

    func lock() {
        OSSpinLockLock(&spinLock)
    }

    func unlock() {
        OSSpinLockUnlock(&spinLock)
    }
}
