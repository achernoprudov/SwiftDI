//
//  InjectorTest.swift
//  SwiftDITests
//
//  Created by Андрей Чернопрудов on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import XCTest
@testable import SwiftDI

class InjectorTest: XCTestCase {
    
    var injector: Injector!
    
    override func setUp() {
        super.setUp()
        injector = Injector()
    }
    
    func test_resolveByType() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { _ in expected }
        
        let result = injector.resolve(String.self)
        XCTAssertEqual(expected, result)
    }
    
    func test_resolveByTag() {
        let stringTag = "tag"
        let expected = "hello world"
        injector.bind(String.self)
            .tag(stringTag)
            .with { _ in expected }
        
        let result = injector.resolve(String.self, tag: stringTag)
        XCTAssertEqual(expected, result)
    }
    
}
