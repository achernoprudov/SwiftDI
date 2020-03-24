//
//  ChatListViewModel.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import SwiftUI

class ChatListViewModel: ObservableObject, Identifiable {
    // MARK: - Public variables

    @Published
    var chats: [Chat] = []

    // MARK: - Instance variables

    private let repository: ChatListRepositoryProtocol

    // MARK: - Public

    init(repository: ChatListRepositoryProtocol) {
        self.repository = repository
    }

    func loadChats() {
        chats = repository.fetchChats()
        objectWillChange.send()
    }
}
