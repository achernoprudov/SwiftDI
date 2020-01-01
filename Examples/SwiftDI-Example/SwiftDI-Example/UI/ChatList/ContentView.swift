//
//  ContentView.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    var viewModel: ChatListViewModel

    var body: some View {
        VStack {
            List(viewModel.chats) { chat in
                Text(chat.name)
            }.onAppear {
                self.viewModel.loadChats()
            }
            Text("Hello, World!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    struct RepositoryStub: ChatListRepositoryProtocol {
        func fetchChats() -> [Chat] {
            return [
                Chat(id: 1, name: "foo"),
            ]
        }
    }

    static var previews: some View {
        let repository = RepositoryStub()
        let viewModel = ChatListViewModel(repository: repository)
        return ContentView(viewModel: viewModel)
    }
}
