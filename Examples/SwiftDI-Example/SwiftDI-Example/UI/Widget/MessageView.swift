//
//  MessageView.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 13.01.2020.
//  Copyright © 2020 Naumen. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    let message: Message

    var body: some View {
        VStack(alignment: message.own ? .trailing : .leading, spacing: 2) {
            Text(message.author)
                .font(.footnote)
                .foregroundColor(Color.gray)

            HStack {
                Spacer().frame(height: 0)
            }

            Text(message.text)
                .lineLimit(nil)
                .padding(8)
                .font(.body)
                .background(message.own ? Color.gray : Color.blue)
                .cornerRadius(8)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        let messages = [
            Message(id: 0, own: true, text: "Kolbasa!", author: "John"),
            Message(id: 1, own: false, text: "Lorem ipsum", author: "Me"),
        ]

        return List(messages) { message in
            MessageView(message: message)
        }
    }
}
