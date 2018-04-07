//
//  InjectorKey.swift
//  SwiftDI
//
//  Created by Андрей Чернопрудов on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

struct InjectorKey {
    let type: Any.Type
    let tag: String
}

extension InjectorKey: Hashable, Equatable {
    var hashValue: Int {
        return ObjectIdentifier(type).hashValue ^ tag.hashValue
    }
}

func ==(lhs: InjectorKey, rhs: InjectorKey) -> Bool {
    return lhs.type == rhs.type
        && lhs.tag == rhs.tag
}

