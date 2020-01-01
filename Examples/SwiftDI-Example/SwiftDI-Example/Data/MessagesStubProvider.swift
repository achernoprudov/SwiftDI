//
//  MessagesStubProvider.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 Naumen. All rights reserved.
//

struct MessagesStubProvider {
    func provideMessages() -> [Int: [Message]] {
        return [
            1: [
                Message(id: 0, own: false, text: "Hi!", author: "Olga"),
                Message(id: 1, own: false, text: "Why are you ignoring me?!", author: "Olga"),
            ],
            2: [
                Message(id: 0, own: false, text: "You owe me 500$", author: "Sergey"),
                Message(id: 1, own: true, text: "So what?", author: "Me"),
                Message(id: 2, own: false, text: "So its better for you to return it back tomorrow👊🏼", author: "Sergey"),
            ],
            3: [
                Message(id: 0, own: true, text: "Hi guys!", author: "Me"),
                Message(id: 1, own: false, text: "Hi)", author: "Ivan"),
                Message(id: 2, own: false, text: "Может по-русски будем говорить? Я ничего не понимаю 😣", author: "Маша"),
            ],
        ]
    }
}
