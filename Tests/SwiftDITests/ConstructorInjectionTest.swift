//
//  ConstructorInjectionTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

import Nimble
import Quick

@testable import SwiftDI

class ConstructorInjectionTest: QuickSpec {
    override func spec() {
        var injector: Injector!

        beforeEach {
            injector = Injector()
        }

        describe("bind") {
            it("void constructor", closure: {
                struct Foo {
                }

                injector.bind(Foo.self)
                    .with(Foo.init)

                let result = injector.resolveSafe(Foo.self)

                expect(result).toNot(beNil())
            })

            describe("one parameter constuctor", closure: {
                struct Foo {
                    let foo: String
                }
                let expectedString = "hello world"

                beforeEach {
                    injector.bind(String.self)
                        .with { expectedString }
                }

                it("explicitly", closure: {
                    injector.bind(Foo.self)
                        .with(Foo.init(foo:))

                    let result = injector.resolve(Foo.self)

                    expect(result.foo) == expectedString
                })

                it("implicitly", closure: {
                    injector.bind(Foo.self)
                        .with(Foo.init)

                    let result = injector.resolve(Foo.self)

                    expect(result.foo) == expectedString
                })
            })

            it("injector in constructor", closure: {
                struct Foo {
                    let injector: Injector
                }

                injector.bind(Foo.self)
                    .with(Foo.init)

                let result = injector.resolve(Foo.self)

                expect(result.injector).to(beIdenticalTo(injector))
            })

            describe("three parameters constructor", closure: {
                struct Foo {
                    let foo: String
                    let num: Int
                    let bool: Bool
                }
                let expectedString = "hello world"
                let expectedNum = 32
                let expectedBool = true

                beforeEach {
                    injector.bind(String.self)
                        .with { expectedString }

                    injector.bind(Int.self)
                        .with { expectedNum }

                    injector.bind(Bool.self)
                        .with { expectedBool }
                }

                it("explicitly", closure: {
                    injector.bind(Foo.self)
                        .with(Foo.init(foo:num:bool:))

                    let result = injector.resolve(Foo.self)
                    expect(result.foo) == expectedString
                    expect(result.num) == expectedNum
                    expect(result.bool) == expectedBool
                })

                it("implicitly", closure: {
                    injector.bind(Foo.self)
                        .with(Foo.init)

                    let result = injector.resolve(Foo.self)
                    expect(result.foo) == expectedString
                    expect(result.num) == expectedNum
                    expect(result.bool) == expectedBool
                })

            })
        }
    }
}
