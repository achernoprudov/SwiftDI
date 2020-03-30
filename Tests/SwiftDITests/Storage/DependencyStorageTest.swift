//
//  DependencyStorageTest.swift
//  SwiftDITests
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

import Foundation
import Nimble
import Quick

@testable import SwiftDI

class DependencyStorageTest: QuickSpec {
    static var nonThreadSafeStorageTypes: Set<DependencyStorageType> {
        return Set([.simple])
    }

    override func spec() {
        var providerCache: ProviderCache!

        beforeEach {
            providerCache = ProviderCacheFactory.default.cache(for: .weak)
        }

        func buildProvider(with value: String) -> DependencyProvider {
            return DependencyProvider(cache: providerCache) { _ in value }
        }

        describe("storage") {
            for storageType in DependencyStorageType.allCases {
                var storage: DependencyStorageProtocol!

                beforeEach {
                    storage = DependencyStorageFactory.default.build(by: storageType)
                }

                describe("\(storageType)") {
                    it("save provider") {
                        let provider = buildProvider(with: "foo")
                        let key = DependencyKey(type: String.self, tag: "foo")
                        storage.save(provider, for: key)
                    }

                    it("fetch unexsisting provider") {
                        let key = DependencyKey(type: String.self, tag: "foo")
                        let provider = storage.fetchProvider(by: key)

                        expect(provider).to(beNil())
                    }

                    it("fetch existing provider") {
                        let expectedProvider = buildProvider(with: "foo")
                        let key = DependencyKey(type: String.self, tag: "foo")
                        storage.save(expectedProvider, for: key)

                        let provider = storage.fetchProvider(by: key)

                        expect(provider) === expectedProvider
                    }

                    it("fetch keys") {
                        let expectedProvider = buildProvider(with: "foo")
                        let key = DependencyKey(type: String.self, tag: "foo")
                        storage.save(expectedProvider, for: key)

                        let keys = storage.keys()

                        expect(keys).toNot(beEmpty())
                        expect(keys).to(contain(key))
                    }

                    if !Self.nonThreadSafeStorageTypes.contains(storageType) {
                        it("thread safety of the save and fetch operations") {
                            let group = DispatchGroup()

                            for index in 0...1000 {
                                group.enter()

                                DispatchQueue.global().async {
                                    let value = "\(index)"
                                    let expectedProvider = buildProvider(with: value)
                                    let key = DependencyKey(type: String.self, tag: value)

                                    storage.save(expectedProvider, for: key)

                                    DispatchQueue.global().async {
                                        let fetchedProvider = storage.fetchProvider(by: key)
                                        expect(fetchedProvider) === expectedProvider

                                        group.leave()
                                    }
                                }
                            }

                            let result = group.wait(timeout: DispatchTime.now() + 5)
                            expect(result).to(equal(.success))
                        }
                    }
                }
            }
        }
    }
}
