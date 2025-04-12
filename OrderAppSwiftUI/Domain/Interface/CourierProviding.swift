//
//  CourierProviding.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 12/04/2025.
//

protocol CourierProviding {
    func fetchCourierRules(completion: @escaping ([CourierRule]) -> Void)
}
