//
//  BindingBuilder+Parametrized.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

private extension Injector {
    /// Resolves parameter for binding
    func rp<P>(_ type: P.Type) -> P {
        if type.self is Injector.Type {
            return self as! P
        }
        return resolve(P.self)
    }
}

public extension BindingBuilder {
    func with<P1, P2>(_ binding: @escaping ((P1, P2)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3>(_ binding: @escaping ((P1, P2, P3)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self))
            return binding(params)
        }
    }
}
