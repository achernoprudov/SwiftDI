//
//  ChatView.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 03.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject
    var viewModel: ChatViewModel

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.messages) { message in
                    Text(message.text)
                }
            }
            .navigationBarTitle(viewModel.chat.name)
            .onAppear {
                self.viewModel.loadMessages()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    struct RepositoryStub: MessageRepositoryProtocol {
        func fetchMessages(forChat chat: ChatId) -> [Message] {
            return [
                Message(id: 0, own: true, text: "foo", author: "Me"),
                Message(id: 1, own: false, text: "bar", author: "Dima"),
            ]
        }

        func add(message: String, toChat chat: ChatId) {
        }
    }

    static var previews: some View {
        let repository = RepositoryStub()
        let chat = Chat(id: 0, name: "Dima")
        let viewModel = ChatViewModel(chat: chat, repository: repository)
        return ChatView(viewModel: viewModel)
    }
}
