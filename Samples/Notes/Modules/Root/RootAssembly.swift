//
//  RootAssembly.swift
//  Nimble
//
//  Created by Andrey Chernoprudov on 18/06/2019.
//

import SwiftDI
import UIKit

class RootAssembly {
    // MARK: - Instance variables

    private let injector: Injector

    private lazy var router: RouterProtocol = injector.resolve()

    // MARK: - Public

    init(injector: Injector) {
        self.injector = injector
    }

    func build() -> UIViewController {
        let listAssembly = NoteListAssembly(injector: injector)
        let rootController = listAssembly.build()
        let navigationController = UINavigationController(rootViewController: rootController)
        router.bind(navigationController)
        return navigationController
    }
}
