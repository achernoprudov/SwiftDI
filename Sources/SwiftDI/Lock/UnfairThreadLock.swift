//
//  UnfairThreadLock.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
class UnfairThreadLock: ThreadLock {
    private var unfairLock = os_unfair_lock_s()

    func lock() {
        os_unfair_lock_lock(&unfairLock)
    }

    func unlock() {
        os_unfair_lock_unlock(&unfairLock)
    }
}
