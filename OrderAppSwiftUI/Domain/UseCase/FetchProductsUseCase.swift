//
//  FetchProductsUseCase.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//


class FetchProductsUseCase {
    private let repository: ProductProviding

    
    init(repository: ProductProviding
) {
        self.repository = repository
    }
    
    func execute(completion: @escaping ([Product]) -> Void) {
        repository.fetchProducts(completion: completion)
    }
}
