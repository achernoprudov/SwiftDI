//
//  ChatViewModel.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 03.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import Combine
import SwiftUI

class ChatViewModel: ObservableObject {
    // MARK: - Public variables

    let objectWillChange = PassthroughSubject<Void, Never>()

    let chat: Chat

    @Published
    var messages: [Message] = []

    // MARK: - Instance variables

    private let repository: MessageRepositoryProtocol

    // MARK: - Public

    init(chat: Chat, repository: MessageRepositoryProtocol) {
        self.chat = chat
        self.repository = repository
    }

    func loadMessages() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.messages = self.repository.fetchMessages(forChat: self.chat.id)
        }
    }

    func add(message: String) {
        repository.add(message: message, toChat: chat.id)
        loadMessages()
    }
}
