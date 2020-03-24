//
//  ChatListView.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import SwiftDI
import SwiftUI

struct ChatListView: View {
    let injector: Injector
    @ObservedObject
    var viewModel: ChatListViewModel

    init(injector: Injector) {
        self.injector = injector
        viewModel = ChatListViewModel(repository: injector.resolve())
    }

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.chats) { chat in
                    NavigationLink(destination: ChatView(injector: self.injector, chat: chat)) {
                        Text(chat.name)
                    }
                }
            }
            .navigationBarTitle(Text("Chats"), displayMode: .inline)
            .onAppear {
                self.viewModel.loadChats()
            }
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    struct RepositoryStub: ChatListRepositoryProtocol {
        func fetchChats() -> [Chat] {
            return [
                Chat(id: 1, name: "Ivan"),
            ]
        }
    }

    static var previews: some View {
        let repository = RepositoryStub()
        let injector = Injector()
        injector.bind(ChatListRepositoryProtocol.self)
            .with(repository)

        return ChatListView(injector: injector)
    }
}
