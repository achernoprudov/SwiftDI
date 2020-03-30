//
//  DependencyStorageTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Nimble
import Quick

@testable import SwiftDI

class DependencyStorageTest: QuickSpec {
    override func spec() {
        var providerCache: ProviderCache!

        beforeEach {
            providerCache = ProviderCacheFactory.default.cache(for: .weak)
        }

        describe("storage") {
            for storageType in DependencyStorageType.allCases {
                var storage: DependencyStorageProtocol!

                beforeEach {
                    storage = DependencyStorageFactory.default.build(by: storageType)
                }

                describe("\(storageType)") {
                    it("save provider") {
                        let provider = DependencyProvider(cache: providerCache) { _ in "foo" }
                        let key = DependencyKey(type: String.self, tag: "foo")
                        storage.save(provider, for: key)
                    }

                    it("fetch unexsisting provider") {
                        let key = DependencyKey(type: String.self, tag: "foo")
                        let provider = storage.fetchProvider(by: key)

                        expect(provider).to(beNil())
                    }

                    it("fetch existing provider") {
                        let expectedProvider = DependencyProvider(cache: providerCache) { _ in "foo" }
                        let key = DependencyKey(type: String.self, tag: "foo")
                        storage.save(expectedProvider, for: key)

                        let provider = storage.fetchProvider(by: key)

                        expect(provider) === expectedProvider
                    }

                    it("fetch keys") {
                        let expectedProvider = DependencyProvider(cache: providerCache) { _ in "foo" }
                        let key = DependencyKey(type: String.self, tag: "foo")
                        storage.save(expectedProvider, for: key)

                        let keys = storage.keys()

                        expect(keys).toNot(beEmpty())
                        expect(keys).to(contain(key))
                    }
                }
            }
        }
    }
}
