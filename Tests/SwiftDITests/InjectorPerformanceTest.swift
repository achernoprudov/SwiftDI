//
//  InjectorPerformanceTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import XCTest

@testable import SwiftDI

@available(OSX 10.15, iOS 13.0, *)
class InjectorPerformanceTest: XCTestCase {
    var injector: Injector!

    lazy var measureOptions: XCTMeasureOptions = {
        let options = XCTMeasureOptions.default
        options.iterationCount = 100
        return options
    }()

    override func setUp() {
        super.setUp()
        let config = Injector.Config(
            tag: "",
            scope: DependencyScope.prototype,
            storage: .readWriteLock
        )
        injector = Injector(config: config)
    }

    func test_weakScope_resolve() {
        DispatchQueue.global(qos: .utility).sync {
            injector.bind(String.self)
                .scope(.weak)
                .with("foo")
        }

        measure(options: measureOptions) {
            _ = injector.resolve(String.self)
        }
    }

    func test_singletonScope_resolve() {
        DispatchQueue.global(qos: .utility).sync {
            injector.bind(String.self)
                .scope(.singleton)
                .with("foo")
        }

        measure(options: measureOptions) {
            _ = injector.resolve(String.self)
        }
    }

    func test_prototypeScope_resolve() {
        DispatchQueue.global(qos: .utility).sync {
            injector.bind(String.self)
                .scope(.prototype)
                .with("foo")
        }

        measure(options: measureOptions) {
            _ = injector.resolve(String.self)
        }
    }

    func test_constantInOneInjector() {
        DispatchQueue.global(qos: .utility).sync {
            let values = (0..<100).map { "value#\($0)" }
            values.forEach { value in
                injector.bind(String.self)
                    .tag(value)
                    .with { value }
            }
        }

        injector.bind(String.self).with("foo")
        measure(options: measureOptions) {
            _ = injector.resolve(String.self)
        }
    }

    func test_resolveThroughHierarchy() {
        var last: Injector?

        DispatchQueue.global(qos: .utility).sync {
            injector.bind(String.self).with("foo")

            last = (0..<100).reduce(injector) { (inj, _) -> Injector in
                inj!.plus()
            }
        }

        measure(options: measureOptions) {
            _ = last!.resolve(String.self)
        }
    }

    func test_bind1000dependencies() {
        let values = (0..<1000).map { "value#\($0)" }

        injector.bind(String.self).with("foo")
        measure(options: measureOptions) {
            values.forEach { value in
                injector.bind(String.self)
                    .tag(value)
                    .with(value)
            }
        }
    }

    func test_resolve1000dependencies() {
        let values = (0..<1000).map { "value#\($0)" }
        DispatchQueue.global(qos: .utility).sync {
            values.forEach { value in
                injector.bind(String.self)
                    .tag(value)
                    .with(value)
            }
        }

        measure(options: measureOptions) {
            values.forEach { value in
                _ = injector.resolve(String.self, tag: value)
            }
        }
    }
}
