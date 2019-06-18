//
//  Router.swift
//  Nimble
//
//  Created by Andrey Chernoprudov on 18/06/2019.
//

import UIKit

protocol RouterProtocol {
    func bind(_ controller: UINavigationController)
}

class Router: RouterProtocol {
    // MARK: - Instance variables

    private weak var controller: UINavigationController?

    // MARK: - Public

    func bind(_ controller: UINavigationController) {
        self.controller = controller
    }
}
