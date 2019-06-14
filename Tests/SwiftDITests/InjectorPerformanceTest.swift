//
//  InjectorPerformanceTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import XCTest

@testable import SwiftDI

class InjectorPerformanceTest: XCTestCase {
    var injector: Injector!

    override func setUp() {
        super.setUp()
        injector = Injector()
    }

    func test_singleInject() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }
        measure {
            _ = injector.resolve(String.self)
        }
    }

    func test_constantInOneInjector() {
        let values = (0..<100).map { "value#\($0)" }
        values.forEach { value in
            injector.bind(String.self)
                .tag(value)
                .with { value }
        }

        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }
        measure {
            _ = injector.resolve(String.self)
        }
    }

    func test_hierarchy() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }

        let last = (0..<100).reduce(injector) { (inj, _) -> Injector in
            inj!.plus()
        }

        measure {
            _ = last!.resolve(String.self)
        }
    }
}
