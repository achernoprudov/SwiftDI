//
//  MainScopeBuilder.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import SwiftDI

struct MainScopeBuilder {
    func build() -> Injector {
        let injector = Injector()

        injector.bind(ScreenFactory.self)
            .scope(.weak)
            .with(ScreenFactoryImpl.init)

        injector.bind(ChatsStubProvider.self)
            .with(ChatsStubProvider.init)

        injector.bind(MessagesStubProvider.self)
            .with(MessagesStubProvider.init)

        injector.bind(ChatListRepositoryProtocol.self)
            .scope(.singleton)
            .with { (provider: ChatsStubProvider) -> ChatListRepositoryProtocol in
                ChatListRepository(chats: provider.provideChats())
            }

        injector.bind(MessageRepositoryProtocol.self)
            .scope(.singleton)
            .with { (provider: MessagesStubProvider) -> MessageRepositoryProtocol in
                MessageRepository(chats: provider.provideMessages())
            }

        return injector
    }
}
