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

// MARK: - Bindings with various parameters

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

    func with<P1, P2, P3, P4>(_ binding: @escaping ((P1, P2, P3, P4)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3, P4, P5>(_ binding: @escaping ((P1, P2, P3, P4, P5)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self), i.rp(P5.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3, P4, P5, P6>(_ binding: @escaping ((P1, P2, P3, P4, P5, P6)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self), i.rp(P5.self), i.rp(P6.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3, P4, P5, P6, P7>(_ binding: @escaping ((P1, P2, P3, P4, P5, P6, P7)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self), i.rp(P5.self), i.rp(P6.self), i.rp(P7.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3, P4, P5, P6, P7, P8>(_ binding: @escaping ((P1, P2, P3, P4, P5, P6, P7, P8)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self), i.rp(P5.self), i.rp(P6.self), i.rp(P7.self), i.rp(P8.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3, P4, P5, P6, P7, P8, P9>(_ binding: @escaping ((P1, P2, P3, P4, P5, P6, P7, P8, P9)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self), i.rp(P5.self), i.rp(P6.self), i.rp(P7.self), i.rp(P8.self), i.rp(P9.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3, P4, P5, P6, P7, P8, P9, P10>(_ binding: @escaping ((P1, P2, P3, P4, P5, P6, P7, P8, P9, P10)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self), i.rp(P5.self), i.rp(P6.self), i.rp(P7.self), i.rp(P8.self), i.rp(P9.self), i.rp(P10.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11>(_ binding: @escaping ((P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self), i.rp(P5.self), i.rp(P6.self), i.rp(P7.self), i.rp(P8.self), i.rp(P9.self), i.rp(P10.self), i.rp(P11.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12>(_ binding: @escaping ((P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self), i.rp(P5.self), i.rp(P6.self), i.rp(P7.self), i.rp(P8.self), i.rp(P9.self), i.rp(P10.self), i.rp(P11.self), i.rp(P12.self))
            return binding(params)
        }
    }

    func with<P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13>(_ binding: @escaping ((P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13)) -> T) {
        injector.bind(builder: self) { i in
            let params = (i.rp(P1.self), i.rp(P2.self), i.rp(P3.self), i.rp(P4.self), i.rp(P5.self), i.rp(P6.self), i.rp(P7.self), i.rp(P8.self), i.rp(P9.self), i.rp(P10.self), i.rp(P11.self), i.rp(P12.self), i.rp(P13.self))
            return binding(params)
        }
    }
}
