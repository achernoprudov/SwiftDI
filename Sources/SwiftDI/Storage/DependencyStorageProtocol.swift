//
//  DependencyStorageProtocol.swift
//  SwiftDI
//
//  Created by Andrey Chernoprudov on 30.03.2020.
//

/// Common dependency storatge protocol
protocol DependencyStorageProtocol {
    func fetchProvider(by key: DependencyKey) -> DependencyProvider?

    func save(_ provider: DependencyProvider, for key: DependencyKey)

    func keys() -> Set<DependencyKey>
}
