//
//  NoteListAssembly.swift
//  Nimble
//
//  Created by Andrey Chernoprudov on 15/06/2019.
//

import SwiftDI
import UIKit

class NoteListAssembly {
    // MARK: - Aliases

    // MARK: - Instance variables

    private let injector: Injector

    // MARK: - Public

    init(injector: Injector) {
        self.injector = injector
    }

    func build() -> UIViewController {
        let controller = NoteListViewController()

        return controller
    }
}
