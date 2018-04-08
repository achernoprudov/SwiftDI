//
//  Injector+Config.swift
//  SwiftDI
//
//  Created by Андрей Чернопрудов on 08/04/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

extension Injector {
    
    /// Config of default options for Injector dependencies
    public struct Config {
        public static let `default`: Config = Config(tag: "", singleton: true, lazy: true)
        
        public var tag: String
        public var singleton: Bool
        public var lazy: Bool
    }
}
