//
//  InjectorLeakingTest.swift
//  Nimble
//
//  Created by Andrey Chernoprudov on 15/06/2019.
//

import Nimble
import Quick

@testable import SwiftDI

class InjectorLeakingTest: QuickSpec {
    override func spec() {
        describe("injector") {
            it("is not leaking", closure: {
                let leakTest = LeakTest {
                    let injector = Injector()

                    return [injector]
                }

                expect(leakTest).toNot(leak())
            })

            it("and dependency are not leaking", closure: {
                class Foo {
                }

                let leakTest = LeakTest {
                    let injector = Injector()
                    injector.bind(Foo.self).with(Foo.init)

                    let foo: Foo = injector.resolve()

                    return [injector, foo]
                }

                expect(leakTest).toNot(leak())
            })

            describe("with dependency to itself", closure: {
                class Bar {
                    let injector: Injector

                    init(injector: Injector) {
                        self.injector = injector
                    }
                }

                it("and singleton scope is leaking", closure: {
                    let leakTest = LeakTest {
                        let injector = Injector()
                        injector.bind(Bar.self)
                            .scope(.singleton)
                            .with(Bar.init)

                        let bar: Bar = injector.resolve()

                        return [injector, bar]
                    }

                    expect(leakTest).to(leak())
                })

                it("and prototype scope is not leaking", closure: {
                    let leakTest = LeakTest {
                        let injector = Injector()
                        injector.bind(Bar.self)
                            .scope(.prototype)
                            .with(Bar.init)

                        let bar: Bar = injector.resolve()

                        return [injector, bar]
                    }

                    expect(leakTest).toNot(leak())
                })

                it("and weak scope is not leaking", closure: {
                    let leakTest = LeakTest {
                        let injector = Injector()
                        injector.bind(Bar.self)
                            .scope(.weak)
                            .with(Bar.init)

                        let bar: Bar = injector.resolve()

                        return [injector, bar]
                    }

                    expect(leakTest).toNot(leak())
                })
            })
        }
    }
}
