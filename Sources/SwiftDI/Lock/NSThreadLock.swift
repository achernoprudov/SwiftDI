//
//  NSThreadLock.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation

class NSThreadLock: ThreadLock {
    private var nsLock = NSLock()

    func lock() {
        nsLock.lock()
    }

    func unlock() {
        nsLock.unlock()
    }
}
