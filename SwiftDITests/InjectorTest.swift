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
    struct Foo {
        let foo: String
    }
    
    var injector: Injector!
    
    override func setUp() {
        super.setUp()
        injector = Injector()
    }
    
    func test_resolve_byType() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { _ in expected }
        
        let result = injector.resolve(String.self)
        XCTAssertEqual(expected, result)
    }
    
    func test_resolve_byTag() {
        let stringTag = "tag"
        let expected = "hello world"
        injector.bind(String.self)
            .tag(stringTag)
            .with { _ in expected }
        
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
            .with { _ in expected1 }
        injector.bind(String.self)
            .tag(tagValue2)
            .with { _ in expected2 }
        
        let result1 = injector.resolve(String.self, tag: tagValue1)
        let result2 = injector.resolve(String.self, tag: tagValue2)
        XCTAssertEqual(expected1, result1)
        XCTAssertEqual(expected2, result2)
    }
    
    func test_resolve_singleton() {
        injector.bind(Date.self)
            .singleton(true)
            .with { _ in Date() }
        
        let result1 = injector.resolve(Date.self)
        let result2 = injector.resolve(Date.self)
        
        XCTAssertEqual(result1, result2)
    }
    
    func test_resolve_notSingleton() {
        injector.bind(Date.self)
            .singleton(false)
            .with { _ in Date() }
        
        let result1 = injector.resolve(Date.self)
        let result2 = injector.resolve(Date.self)
        
        XCTAssertNotEqual(result1, result2)
    }
    
    func test_resolve_inBind() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { _ in expected }

        injector.bind(Foo.self)
            .with { i in Foo(foo: i.resolve(String.self)) }
        
        let result = injector.resolve(Foo.self)
        XCTAssertEqual(result.foo, expected)
    }
}
