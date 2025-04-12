//
//  CourierRepository.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//

import Foundation

class CourierRepository: CourierProviding {
    func fetchCourierRules(completion: @escaping ([CourierRule]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let rules: [CourierRule]
            if let url = Bundle.main.url(forResource: "couriers", withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let decoded = try? JSONDecoder().decode([CourierRule].self, from: data) {
                rules = decoded
            } else {
                rules = []
            }

            DispatchQueue.main.async {
                completion(rules)
            }
        }
    }
}
