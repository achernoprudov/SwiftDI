//
//  DependencyStorageType.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

/// Type of the depednencies store syncronization
///
/// - simple: no syncronization between threads but faster performance
/// - concurrent: allows multithreading but block threads on write with concurrent queue
/// - serial: uses serial queue for syncronization
/// - nsLock: uses `DefaultThreadLock` for syncronization. Based on `NSLock`
/// - spinLock: uses `SpinThreadLock` for syncronization. Based on `OS_SPINLOCK_INIT`
/// - unfairLock: uses `UnfairThreadLock` for syncronization. Based on `os_unfair_lock_s`
public enum DependencyStorageType {
    case simple, concurrent, serialQueue, nsLock, spinLock

    @available(OSX 10.12, iOS 10.0, *)
    case unfairLock
}

extension DependencyStorageType: CaseIterable {
    public typealias AllCases = [DependencyStorageType]

    public static var allCases: AllCases {
        let common: AllCases = [.simple, .concurrent, .serialQueue, .nsLock, .spinLock]
        if #available(OSX 10.12, iOS 10.0, *) {
            return common + [.unfairLock]
        }
        return common
    }
}
