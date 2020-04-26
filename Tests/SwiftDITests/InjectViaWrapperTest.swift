//
//  InjectViaWrapperTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 25.04.2020.
//

import Nimble
import Quick

@testable import SwiftDI

#if swift(>=4.1) && compiler(>=5.0)

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

            describe("inject") {
                it("with default injector and tag") {
                    class TestObject {
                        @Inject
                        var value: String
                    }

                    // prepare
                    let expectedValue = "foo"
                    Injector.default.bind(String.self).with(expectedValue)

                    // actions
                    let testObject = TestObject()

                    // assertions
                    expect(testObject.value) == expectedValue
                }

                it("with default injector and custom tag tag") {
                    // prepare
                    let expectedValue = "foo"

                    class TestObject {
                        @Inject(tag: "bar")
                        var value: String
                    }

                    Injector.default.bind(String.self)
                        .tag("bar")
                        .with(expectedValue)

                    // actions
                    let testObject = TestObject()

                    // assertions
                    expect(testObject.value) == expectedValue
                }

                it("with custom injector") {
                    // prepare
                    Self.customInjector = Injector()
                    let expectedValue = "foo"

                    Self.customInjector.bind(String.self)
                        .with(expectedValue)

                    class TestObject {
                        @Inject(injector: InjectViaWrapperTest.customInjector)
                        var value: String
                    }

                    // actions
                    let testObject = TestObject()

                    // assertions
                    expect(testObject.value) == expectedValue
                }

                it("with custom injector") {
                    // prepare
                    Self.customInjector = Injector()
                    let expectedValue = "foo"

                    Self.customInjector.bind(String.self)
                        .with(expectedValue)

                    class TestObject {
                        @Inject(injector: InjectViaWrapperTest.customInjector)
                        var value: String
                    }

                    // actions
                    let testObject = TestObject()

                    // assertions
                    expect(testObject.value) == expectedValue
                }
            }

            describe("optional inject") {
                it("sets dependency") {
                    class TestObject {
                        @OptionalInject
                        var value: String?
                    }

                    // prepare
                    let expectedValue = "foo"
                    Injector.default.bind(String.self).with(expectedValue)

                    // actions
                    let testObject = TestObject()

                    // assertions
                    expect(testObject.value) == expectedValue
                }

                it("sets nil") {
                    // prepare
                    class TestObject {
                        @OptionalInject
                        var value: String?
                    }

                    // actions
                    let testObject = TestObject()

                    // assertions
                    expect(testObject.value).to(beNil())
                }
            }
        }
    }

#endif
