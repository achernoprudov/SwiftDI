//
//  ConstructorInjectionTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 14/06/2019.
//  Copyright © 2019 Little Stars. All rights reserved.
//

import XCTest
@testable import SwiftDI

class ConstructorInjectionTest: XCTestCase {
    var injector: Injector!

    override func setUp() {
        super.setUp()
        injector = Injector()
    }

    func test_bind_voidConstructor() {
        struct Foo {
        }

        injector.bind(Foo.self)
            .with(Foo.init)

        let result = injector.resolveSafe(Foo.self)
        XCTAssertNotNil(result)
    }

    func test_bind_oneParamConstructor_explicit() {
        struct Foo {
            let foo: String
        }

        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }

        injector.bind(Foo.self)
            .with(Foo.init(foo:))

        let result = injector.resolve(Foo.self)
        XCTAssertEqual(result.foo, expected)
    }

    func test_bind_oneParamConstructor_implicit() {
        struct Foo {
            let foo: String
        }

        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }

        injector.bind(Foo.self)
            .with(Foo.init)

        let result = injector.resolve(Foo.self)
        XCTAssertEqual(result.foo, expected)
    }

    func test_bind_injectorInConstructor() {
        struct Foo {
            let injector: Injector
        }

        injector.bind(Foo.self)
            .with(Foo.init(injector:))

        let result = injector.resolve(Foo.self)
        XCTAssertTrue(result.injector === injector)
    }

    func test_bind_threeParamsConstructor_explicit() {
        struct Foo {
            let foo: String
            let num: Int
            let bool: Bool
        }

        let expectedString = "hello world"
        injector.bind(String.self)
            .with { expectedString }

        let expectedNum = 32
        injector.bind(Int.self)
            .with { expectedNum }

        let expectedBool = true
        injector.bind(Bool.self)
            .with { expectedBool }

        injector.bind(Foo.self)
            .with(Foo.init(foo:num:bool:))

        let result = injector.resolve(Foo.self)
        XCTAssertEqual(result.foo, expectedString)
    }

    func test_bind_threeParamsConstructor_implicit() {
        struct Foo {
            let foo: String
            let num: Int
            let bool: Bool
        }

        let expectedString = "hello world"
        injector.bind(String.self)
            .with { expectedString }

        let expectedNum = 32
        injector.bind(Int.self)
            .with { expectedNum }

        let expectedBool = true
        injector.bind(Bool.self)
            .with { expectedBool }

        injector.bind(Foo.self)
            .with(Foo.init)

        let result = injector.resolve(Foo.self)
        XCTAssertEqual(result.foo, expectedString)
    }
}
