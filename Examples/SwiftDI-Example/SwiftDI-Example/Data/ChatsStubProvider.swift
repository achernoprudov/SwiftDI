//
//  ChatsStubProvider.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

struct ChatsStubProvider {
    func provideChats() -> [Chat] {
        return [
            Chat(id: 1, name: "Olga"),
            Chat(id: 2, name: "Sergey"),
            Chat(id: 3, name: "Birthday party"),
        ]
    }
}
