//
//  InjectViaWrapperTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 25.04.2020.
//

import Nimble
import Quick

@testable import SwiftDI

class InjectViaWrapperTest: QuickSpec {
    private static var customInjector: Injector!

    override func spec() {
        beforeEach {
            Injector.default = Injector()
        }

        afterEach {
            Injector.default = Injector()
            Self.customInjector = nil
        }

        it("inject with default injector and tag") {
            struct TestStruct {
                @Inject
                var value: String
            }

            // prepare
            let expectedValue = "foo"
            Injector.default.bind(String.self).with(expectedValue)

            // actions
            let testStruct = TestStruct()

            // assertions
            expect(testStruct.value) == expectedValue
        }

        it("inject with default injector and custom tag tag") {
            // prepare
            let expectedValue = "foo"

            struct TestStruct {
                @Inject(tag: "bar")
                var value: String
            }

            Injector.default.bind(String.self)
                .tag("bar")
                .with(expectedValue)

            // actions
            let testStruct = TestStruct()

            // assertions
            expect(testStruct.value) == expectedValue
        }

        it("inject with custom injector") {
            // prepare
            Self.customInjector = Injector()
            let expectedValue = "foo"

            Self.customInjector.bind(String.self)
                .with(expectedValue)

            struct TestStruct {
                @Inject(injector: InjectViaWrapperTest.customInjector)
                var value: String
            }

            // actions
            let testStruct = TestStruct()

            // assertions
            expect(testStruct.value) == expectedValue
        }

        it("inject with custom injector") {
            // prepare
            Self.customInjector = Injector()
            let expectedValue = "foo"

            Self.customInjector.bind(String.self)
                .with(expectedValue)

            struct TestStruct {
                @Inject(injector: InjectViaWrapperTest.customInjector)
                var value: String
            }

            // actions
            let testStruct = TestStruct()

            // assertions
            expect(testStruct.value) == expectedValue
        }
    }
}
