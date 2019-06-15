//
//  LeakTest+Nimble.swift
//  Nimble
//
//  Created by Andrey Chernoprudov on 15/06/2019.
//

import Nimble

/// Predicate checks that `LeakTest` is not leaking and there is no reference cycle inside
func leak<T: LeakTest>() -> Predicate<T> {
    return Predicate { (actualExpression: Expression<T>) -> PredicateResult in
        guard let value = try actualExpression.evaluate() else {
            return PredicateResult(
                status: .fail,
                message: ExpectationMessage.expectedTo("not be nil")
            )
        }
        let leakingObjects = value.findLeakingObjects()
        if leakingObjects.isEmpty {
            return PredicateResult(
                status: .doesNotMatch,
                message: ExpectationMessage.fail("Objects are not leaked")
            )
        }
        let details = leakingObjects.joined(separator: ", ")
        return PredicateResult(
            status: .matches,
            message: ExpectationMessage.fail("Next objects are leaked:\n\(details)")
        )
    }
}
