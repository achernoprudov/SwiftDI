//
//  ChatListViewModel.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 Naumen. All rights reserved.
//

import SwiftUI

class ChatListViewModel: ObservableObject {
    // MARK: - Instance variables

    @Published
    var chats: [Chat] = []

    private let repository: ChatListRepositoryProtocol

    // MARK: - Public

    init(repository: ChatListRepositoryProtocol) {
        self.repository = repository
    }

    func loadChats() {
        chats = repository.fetchChats()
    }
}
