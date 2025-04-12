//
//  Package.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//

import Foundation

struct Package: Identifiable {
    let id = UUID()
    let items: [Product]
    let totalPrice: Double
    let totalWeight: Double
    let courierPrice: Double
}
