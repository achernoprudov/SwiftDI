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
    let screenFactory: ScreenFactory
    @ObservedObject
    var viewModel: ChatListViewModel

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.chats) { chat in
                    NavigationLink(destination: self.screenFactory.chat(for: chat)) {
                        Text(chat.name)
                    }
                }
            }
            .navigationBarTitle("Chats")
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
        let viewModel = ChatListViewModel(repository: repository)
        let screenFactory = ScreenFactory(injector: Injector())
        return ChatListView(screenFactory: screenFactory, viewModel: viewModel)
    }
}
