//
//  DependencyKey.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

public struct DependencyKey: Hashable, Equatable {
    // MARK: - Instance variables

    public let type: Any.Type
    public let tag: String

    public init(type: Any.Type, tag: String) {
        self.type = type
        self.tag = tag
    }

    // MARK: - Public

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
        hasher.combine(tag)
    }

    public static func ==(lhs: DependencyKey, rhs: DependencyKey) -> Bool {
        return lhs.type == rhs.type
            && lhs.tag == rhs.tag
    }
}
