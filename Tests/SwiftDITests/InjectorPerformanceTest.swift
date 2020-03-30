//
//  InjectorPerformanceTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import XCTest

@testable import SwiftDI

@available(OSX 10.15, *)
class InjectorPerformanceTest: XCTestCase {
    var injector: Injector!

    lazy var measureOptions: XCTMeasureOptions = {
        let options = XCTMeasureOptions.default
        options.iterationCount = 100
        return options
    }()

    override func setUp() {
        super.setUp()
        injector = Injector()
    }

    func test_singleInject() {
        let expected = "hello world"
        injector.bind(String.self)
            .with { expected }

        measure(options: measureOptions) {
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
        measure(options: measureOptions) {
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

        measure(options: measureOptions) {
            _ = last!.resolve(String.self)
        }
    }
}
