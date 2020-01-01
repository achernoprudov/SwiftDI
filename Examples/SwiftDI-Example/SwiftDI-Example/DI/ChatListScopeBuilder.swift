//
//  ChatListScopeBuilder.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 Naumen. All rights reserved.
//

import SwiftDI

struct ChatListScopeBuilder {
    let injector: Injector

    func build() -> Injector {
        let chatListScopeInjector = injector.plus()

        chatListScopeInjector.bind(ChatListViewModel.self)
            .with(ChatListViewModel.init(repository:))

        return chatListScopeInjector
    }
}
