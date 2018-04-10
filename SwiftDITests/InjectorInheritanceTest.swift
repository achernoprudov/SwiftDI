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
    
    var parent: Injector!
    var injector: Injector!
    
    override func setUp() {
        super.setUp()
        parent = Injector()
        injector = parent.plus()
    }
    
    func test_resolve_parentDependency_byType() {
        let expected = "Hello observer"
        parent.bind(String.self)
            .with { _ in expected }
        
        let result = injector.resolve(String.self)
        XCTAssertEqual(expected, result)
    }
    
    func test_resolve_parentDependency_byTag() {
        let expected = "Hello observer"
        let tagValue = "some tag"
        parent.bind(String.self)
            .tag(tagValue)
            .with { _ in expected }
        
        let result = injector.resolve(String.self, tag: tagValue)
        XCTAssertEqual(expected, result)
    }
    
    func test_resolve_childDependency() {
        let expected = "Hello observer"
        injector.bind(String.self)
            .with { _ in expected }
        
        let result = parent.resolveSafe(String.self)
        XCTAssertNil(result)
    }
}
