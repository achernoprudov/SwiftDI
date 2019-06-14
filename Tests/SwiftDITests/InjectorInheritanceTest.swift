//
//  InjectorInheritanceTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import XCTest
@testable import SwiftDI

class InjectorInheritanceTest: XCTestCase {
    var injector: Injector!
    var childInjector: Injector!

    override func setUp() {
        super.setUp()
        injector = Injector()
        childInjector = injector.plus()
    }

    func test_resolve_parentDependency_byType() {
        let expected = "Hello observer"
        injector.bind(String.self)
            .with { expected }

        let result = childInjector.resolve(String.self)
        XCTAssertEqual(expected, result)
    }

    func test_resolve_parentDependency_byTag() {
        let expected = "Hello observer"
        let tagValue = "some tag"
        injector.bind(String.self)
            .tag(tagValue)
            .with { expected }

        let result = childInjector.resolve(String.self, tag: tagValue)
        XCTAssertEqual(expected, result)
    }

    func test_resolve_childDependency() {
        let expected = "Hello observer"
        childInjector.bind(String.self)
            .with { expected }

        let result = injector.resolveSafe(String.self)
        XCTAssertNil(result)
    }

    func test_resolve_unexistent_parentDependency() {
        let result = childInjector.resolveSafe(String.self)
        XCTAssertNil(result)
    }
}
