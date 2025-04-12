//
//  ProductProviding.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 12/04/2025.
//

protocol ProductProviding {
    func fetchProducts(completion: @escaping ([Product]) -> Void)
}
