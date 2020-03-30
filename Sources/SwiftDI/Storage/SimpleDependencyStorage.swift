//
//  DependencyStorage.swift
//  SimpleDependencyStorage
//
//  Created by Andrey Chernoprudov on 21/06/2019.
//

class SimpleDependencyStorage: DependencyStorageProtocol {
    // MARK: - Instance variables

    private var dependencies: [DependencyKey: DependencyProvider] = [:]

    // MARK: - Public

    func fetchProvider(by key: DependencyKey) -> DependencyProvider? {
        return dependencies[key]
    }

    func save(_ provider: DependencyProvider, for key: DependencyKey) {
        dependencies[key] = provider
    }

    func keys() -> Set<DependencyKey> {
        return Set(dependencies.keys)
    }
}
