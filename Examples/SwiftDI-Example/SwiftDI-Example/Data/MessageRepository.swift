//
//  MessageRepository.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

protocol MessageRepositoryProtocol {
    typealias ChatId = Int

    func fetchMessages(forChat chat: ChatId) -> [Message]

    func add(message: String, toChat chat: ChatId)
}

class MessageRepository: MessageRepositoryProtocol {
    // MARK: - Instance variables

    private var chats: [ChatId: [Message]]

    // MARK: - Public

    init(chats: [ChatId: [Message]]) {
        self.chats = chats
    }

    func fetchMessages(forChat chat: ChatId) -> [Message] {
        return chats[chat] ?? []
    }

    func add(message: String, toChat chat: ChatId) {
        var messages = chats[chat] ?? []
        let newMessage = Message(
            id: messages.last?.id ?? 0,
            own: true,
            text: message,
            author: "Me"
        )
        messages.append(newMessage)
        chats[chat] = messages
    }
}
