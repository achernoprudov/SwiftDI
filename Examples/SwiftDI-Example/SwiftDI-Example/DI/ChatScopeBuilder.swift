//
//  ChatScopeBuilder.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 03.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import SwiftDI

struct ChatScopeBuilder {
    let injector: Injector
    let chat: Chat

    func build() -> Injector {
        let chatListScopeInjector = injector.plus()

        chatListScopeInjector.bind(Chat.self)
            .with(chat)

        chatListScopeInjector.bind(ChatViewModel.self)
            .with(ChatViewModel.init)

        return chatListScopeInjector
    }
}
