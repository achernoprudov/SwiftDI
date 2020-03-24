//
//  Message.swift
//  SwiftDI-Example
//
//  Created by Andrey Chernoprudov on 01.01.2020.
//  Copyright © 2020 LittleStars. All rights reserved.
//

struct Message: Identifiable {
    let id: Int
    let own: Bool
    let text: String
    let author: String
}
