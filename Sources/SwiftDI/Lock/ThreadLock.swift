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
