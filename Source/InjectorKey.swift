//
//  InjectorKey.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

struct InjectorKey: Hashable, Equatable {
    
    // MARK: - Instance variables
    
    let type: Any.Type
    let tag: String
    
    // MARK: - Public
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
        hasher.combine(tag)
    }
    
    static func == (lhs: InjectorKey, rhs: InjectorKey) -> Bool {
        return lhs.type == rhs.type
            && lhs.tag == rhs.tag
    }
}
