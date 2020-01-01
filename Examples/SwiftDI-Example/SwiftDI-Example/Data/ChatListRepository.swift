//
//  ChatListRepository.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

protocol ChatListRepositoryProtocol {
    func fetchChats() -> [Chat]
}

class ChatListRepository: ChatListRepositoryProtocol {
    // MARK: - Instance variables

    private var chats: [Chat]

    // MARK: - Public

    init(chats: [Chat]) {
        self.chats = chats
    }

    func fetchChats() -> [Chat] {
        return chats
    }
}
