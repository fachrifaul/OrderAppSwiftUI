//
//  CourierRule.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//
import Foundation

struct CourierRule: Codable {
    let min_weight: Double
    let max_weight: Double
    let unit: String
    let charge: Double
}
