//
//  InjectorKeysTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Nimble
import Quick

@testable import SwiftDI

class InjectorKeysTest: QuickSpec {
    override func spec() {
        var injector: Injector!
        var childInjector: Injector!

        beforeEach {
            injector = Injector()
            childInjector = injector.plus()
        }

        describe("keys") {
            it("returns empty set by default") {
                let keys = injector.keys()

                expect(keys).to(beEmpty())
            }

            it("returs dependency key set") {
                injector.bind(String.self).with("foo")

                let keys = injector.keys()

                expect(keys).toNot(beEmpty())
                expect(keys).to(beAnInstanceOf(Set<DependencyKey>.self))
            }

            describe("returns parent dependency key") {
                it("by type") {
                    injector.bind(String.self).with("foo")

                    let keys = childInjector.keys()
                    expect(keys).toNot(beEmpty())
                }

                it("by type and tag") {
                    let tagValue = "some tag"
                    injector.bind(String.self)
                        .tag(tagValue)
                        .with("foo")

                    let keys = childInjector.keys()
                    expect(keys).toNot(beEmpty())

                    let key = keys.first!
                    expect(key.tag) == tagValue
                }

                it("by type") {
                    injector.bind(String.self).with("foo")

                    let keys = childInjector.keys()
                    expect(keys).toNot(beEmpty())
                }
            }

            it("returns overrided parent dependency key") {
                injector.bind(String.self).with("foo")
                childInjector.bind(String.self).with("bar")

                let keys = childInjector.keys()
                expect(keys).to(haveCount(1))
            }

            it("returns two different keys with same type but different tags") {
                injector.bind(String.self).tag("1").with("foo")
                injector.bind(String.self).tag("2").with("bar")

                let keys = injector.keys()
                expect(keys).to(haveCount(2))
            }

            it("of child injector is not considered") {
                childInjector.bind(String.self).with("foo")

                let result = injector.keys()

                expect(result).to(beEmpty())
            }
        }
    }
}
