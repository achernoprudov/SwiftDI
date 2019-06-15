//
//  InjectorInheritanceTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 07/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import Nimble
import Quick

@testable import SwiftDI

class InjectorInheritanceTest: QuickSpec {
    override func spec() {
        var injector: Injector!
        var childInjector: Injector!

        beforeEach {
            injector = Injector()
            childInjector = injector.plus()
        }

        describe("resolve") {
            describe("parent dependency", closure: {
                it("by type", closure: {
                    let expected = "Hello observer"
                    injector.bind(String.self)
                        .with { expected }

                    let result = childInjector.resolve(String.self)

                    expect(result) == expected
                })

                it("by tag", closure: {
                    let expected = "Hello observer"
                    let tagValue = "some tag"
                    injector.bind(String.self)
                        .tag(tagValue)
                        .with { expected }

                    let result = childInjector.resolve(String.self, tag: tagValue)

                    expect(result) == expected
                })
            })

            it("child dependency", closure: {
                let expected = "Hello observer"
                childInjector.bind(String.self)
                    .with { expected }

                let result = injector.resolveSafe(String.self)

                expect(result).to(beNil())
            })

            it("unexistent dependency", closure: {
                let result = childInjector.resolveSafe(String.self)

                expect(result).to(beNil())
            })
        }
    }
}
