//
//  Item.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//
import Foundation

struct Product: Identifiable, Codable {
    let id = UUID()
    let name: String
    let price: Double
    let weight: Double
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, price, weight
    }
}
