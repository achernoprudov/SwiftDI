//
//  InjectorConcurrencyTest.swift
//  Nimble
//
//  Created by Andrey Chernoprudov on 21/06/2019.
//

import Foundation
import Nimble
import Quick

@testable import SwiftDI

@available(OSX 10.12, *)
class InjectorConcurrencyTest: QuickSpec {
    class Counter {
        private let queue = DispatchQueue(label: "counter.", qos: .default, attributes: .concurrent)
        private var _count = 0

        var count: Int {
            return queue.sync { _count }
        }

        func increment() {
            queue.sync(flags: .barrier) {
                _count += 1
            }
        }
    }

    override func spec() {
        var injector: Injector!

        beforeEach {
            let config = Injector.Config(
                tag: "",
                scope: DependencyScope.prototype,
                storage: .readWriteLock
            )
            injector = Injector(config: config)
        }
        it("thread safety of the singleton dependency") {
            let counter = Counter()
            let group = DispatchGroup()

            injector.bind(Counter.self).with(counter)
            injector.bind(Foo.self)
                .scope(.singleton)
                .with(Foo.init)

            class Foo {
                init(counter: Counter) {
                    counter.increment()
                }
            }

            for _ in 0...100_000 {
                group.enter()

                DispatchQueue.global().async {
                    _ = injector.resolve(Foo.self)
                    group.leave()
                }
            }

            let result = group.wait(timeout: DispatchTime.now() + 5)
            expect(result).to(equal(.success))

            expect(counter.count).to(equal(1))
        }

        it("thread safety of the bind operation") {
            let group = DispatchGroup()

            for index in 0...1000 {
                group.enter()

                DispatchQueue.global().async {
                    let value = "\(index)"

                    injector.bind(String.self)
                        .tag(value)
                        .with(value)

                    DispatchQueue.global().async {
                        let resolved = injector.resolveSafe(String.self, tag: value)
                        expect(resolved) == value

                        group.leave()
                    }
                }
            }

            let result = group.wait(timeout: DispatchTime.now() + 5)
            expect(result).to(equal(.success))
        }

        it("thread safety of the bind with resolving") {
            class Foo {
                init(foo: String) {
                }
            }

            let group = DispatchGroup()

            group.enter()

            DispatchQueue.global().async {
                injector.bind(String.self).with("value")

                DispatchQueue.global().async {
                    injector.bind(Foo.self)
                        .with(Foo.init)

                    DispatchQueue.global().async {
                        let resolved = injector.resolveSafe(Foo.self)
                        expect(resolved).toNot(beNil())
                        group.leave()
                    }
                }
            }

            let result = group.wait(timeout: DispatchTime.now() + 5)
            expect(result).to(equal(.success))
        }
    }
}
