//
//  ChatView.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 03.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import SwiftDI
import SwiftUI

struct ChatView: View {
    let injector: Injector

    @ObservedObject
    var viewModel: ChatViewModel
    @State
    private var messageText = ""

    @EnvironmentObject
    private var keyboardObserver: KeyboardObserver

    init(injector: Injector, chat: Chat) {
        self.injector = injector
        viewModel = ChatViewModel(
            chat: chat,
            repository: injector.resolve()
        )
    }

    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                MessageView(message: message)
            }
            .onTapGesture { self.endEditing(force: true) }

            Divider()

            HStack {
                TextField("New message", text: $messageText, onCommit: sendMessage)
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding([.top, .leading, .trailing])
        }
        .padding(.bottom, keyboardObserver.height + 16)
        .navigationBarTitle(Text(viewModel.chat.name), displayMode: .inline)
        .animation(.easeInOut)
        .onAppear {
            self.viewModel.loadMessages()
        }
    }

    // MARK: - Private

    private func sendMessage() {
        viewModel.add(message: messageText)
        messageText = ""
        endEditing(force: true)
    }

    private func endEditing(force: Bool) {
        UIApplication.shared.windows
            .forEach { $0.endEditing(force) }
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
        let injector = Injector()
        injector.bind(MessageRepositoryProtocol.self)
            .with(repository)

        return ChatView(injector: injector, chat: chat)
            .environmentObject(KeyboardObserver.shared)
    }
}
