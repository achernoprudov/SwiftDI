//
//  AppDelegate.swift
//  Notes
//
//  Created by Andrey Chernoprudov on 15/06/2019.
//

import SwiftDI
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    // MARK: - Instance variables

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    lazy var injector: Injector = buildAppInjector()

    // MARK: - Public

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let rootAssembly = RootAssembly(injector: injector)
        let viewController = rootAssembly.build()

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }

    // MARK: - Private

    private func buildAppInjector() -> Injector {
        let injector = Injector()

        // MARK: - App dependencies

        injector.bind(NoteRepositoryProtocol.self)
            .scope(.singleton)
            .with(NoteRepository.init)

        injector.bind(RouterProtocol.self)
            .scope(.singleton)
            .with(Router.init)

        return injector
    }
}
