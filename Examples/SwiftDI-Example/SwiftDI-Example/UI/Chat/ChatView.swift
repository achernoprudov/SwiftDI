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
            .navigationBarTitle("Chat")
            .onAppear {
                self.viewModel.loadMessages()
            }
        }
    }
}
