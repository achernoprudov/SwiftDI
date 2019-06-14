//
//  InjectorTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import XCTest
@testable import SwiftDI

class InjectorTest: XCTestCase {
    // simple test model
    class Foo: Equatable {
        let foo: String

        init(foo: String) {
            self.foo = foo
        }

        static func ==(lhs: InjectorTest.Foo, rhs: InjectorTest.Foo) -> Bool {
            return lhs.foo == rhs.foo
        }
    }

    var injector: Injector!

    override func setUp() {
        super.setUp()
        injector = Injector()
    }

    func test_resolve_implicitly() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }

        let result: String = injector.resolve()
        XCTAssertEqual(expected, result)
    }

    func test_resolve_implicitly_forced() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }

        let result: String! = injector.resolve()
        XCTAssertEqual(expected, result)
    }

    func test_resolve_byType() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }

        let result = injector.resolve(String.self)
        XCTAssertEqual(expected, result)
    }

    func test_resolve_byTag() {
        let stringTag = "tag"
        let expected = "hello world"
        injector.bind(String.self)
            .tag(stringTag)
            .with { expected }

        let result = injector.resolve(String.self, tag: stringTag)
        XCTAssertEqual(expected, result)
    }

    func test_resolve_few_equalByType_differentByTag() {
        let tagValue1 = "tag1"
        let tagValue2 = "tag2"
        let expected1 = "hello world"
        let expected2 = "hello hell"

        injector.bind(String.self)
            .tag(tagValue1)
            .with { expected1 }
        injector.bind(String.self)
            .tag(tagValue2)
            .with { expected2 }

        let result1 = injector.resolve(String.self, tag: tagValue1)
        let result2 = injector.resolve(String.self, tag: tagValue2)
        XCTAssertEqual(expected1, result1)
        XCTAssertEqual(expected2, result2)
    }

    func test_resolve_singleton() {
        injector.bind(Date.self)
            .lifecycle(.singleton)
            .with { Date() }

        let result1 = injector.resolve(Date.self)
        let result2 = injector.resolve(Date.self)

        XCTAssertEqual(result1, result2)
    }

    func test_resolve_prototype() {
        injector.bind(Date.self)
            .lifecycle(.prototype)
            .with { Date() }

        let result1 = injector.resolve(Date.self)
        let result2 = injector.resolve(Date.self)

        XCTAssertNotEqual(result1, result2)
    }

    func test_resolve_soft_negative() {
        injector.bind(Foo.self)
            .lifecycle(.soft)
            .with { Foo(foo: UUID().description) }

        var result1 = ""

        autoreleasepool {
            result1 = injector.resolve(Foo.self).foo
        }
        let result2 = injector.resolve(Foo.self).foo

        XCTAssertNotEqual(result1, result2)
    }

    func test_resolve_soft_positive() {
        injector.bind(Foo.self)
            .lifecycle(.soft)
            .with { Foo(foo: Date().description) }

        let foo1 = injector.resolve(Foo.self)
        let foo2 = injector.resolve(Foo.self)

        XCTAssertEqual(foo1, foo2)
    }

    func test_resolve_inBind() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }

        injector.bind(Foo.self)
            .with { (i: Injector) in Foo(foo: i.resolve(String.self)) }

        let result = injector.resolve(Foo.self)
        XCTAssertEqual(result.foo, expected)
    }

    func test_resolve_constructor() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }

        injector.bind(Foo.self)
            .with(Foo.init(foo:))

        let result = injector.resolve(Foo.self)
        XCTAssertEqual(result.foo, expected)
    }
}
