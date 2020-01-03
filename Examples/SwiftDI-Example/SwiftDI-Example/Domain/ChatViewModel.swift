//
//  ChatViewModel.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 03.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    // MARK: - Public variables

    @Published
    var messages: [Message] = []

    // MARK: - Instance variables

    private let chat: Chat
    private let repository: MessageRepositoryProtocol

    // MARK: - Public

    init(chat: Chat, repository: MessageRepositoryProtocol) {
        self.chat = chat
        self.repository = repository
    }

    func loadMessages() {
        messages = repository.fetchMessages(forChat: chatId)
        objectWillChange.send()
    }

    func add(message: String) {
        repository.add(message: message, toChat: chatId)
        loadMessages()
    }
}
