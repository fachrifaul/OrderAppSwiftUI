//
//  ProductRepository.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//

import Foundation

class ProductRepository: ProductProviding {
    func fetchProducts(completion: @escaping ([Product]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let products: [Product]
            if let url = Bundle.main.url(forResource: "products", withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let decoded = try? JSONDecoder().decode([Product].self, from: data) {
                products = decoded
            } else {
                products = []
            }

            DispatchQueue.main.async {
                completion(products)
            }
        }
    }
}
