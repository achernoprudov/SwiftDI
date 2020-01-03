//
//  AppRouter.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 03.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import SwiftDI
import SwiftUI

protocol AppRouterProtocol {
}

class AppRouter: AppRouterProtocol {
    // MARK: - Instance variables

    private let injector: Injector

    // MARK: - Public

    init(injector: Injector) {
        self.injector = injector
    }

    func chatsList() -> some View {
        let scopeBuilder = ChatListScopeBuilder(injector: injector)
        let injector = scopeBuilder.build()

        return ChatListView(viewModel: injector.resolve())
    }

    func chat(for chat: Chat) -> some View {
        let scopeBuilder = ChatScopeBuilder(injector: injector, chat: chat)
        let injector = scopeBuilder.build()

        return ChatView(viewModel: injector.resolve())
    }
}
