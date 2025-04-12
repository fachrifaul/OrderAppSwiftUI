//
//  PlaceOrderEvenlyDistributeUseCase.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 12/04/2025.
//

import Foundation

struct PlaceOrderEvenlyDistributeUseCase {
    func execute(_ selectedItems: [Product], courierRules: [CourierRule]) -> [Package] {
        if selectedItems.isEmpty {
            return []
        }
        
        let totalPrice = selectedItems.reduce(0) { $0 + $1.price }
        if totalPrice <= 250 {
            let totalWeight = selectedItems.reduce(0) { $0 + $1.weight }
            let courierPrice = courierCharge(for: totalWeight, using: courierRules)
            return [
                Package(
                    items: selectedItems,
                    totalPrice: totalPrice,
                    totalWeight: totalWeight,
                    courierPrice: courierPrice
                )
            ]
        } else {
            return splitPackages(selectedItems)
        }
    }
    
    private func courierCharge(for weight: Double, using rules: [CourierRule]) -> Double {
        for rule in rules {
            if weight > rule.min_weight && weight <= rule.max_weight {
                return rule.charge
            }
        }
        return 0
    }
    
    private func splitPackages(_ items: [Product]) -> [Package] {
        var remaining = items
        var packages: [Package] = []
        
        while !remaining.isEmpty {
            var bestCombo: [Product] = []
            var bestTotal: Double = 0
            
            // Try every combination of items to get as close to $250 as possible
            let count = remaining.count
            for i in 1..<1<<count {
                var combo: [Product] = []
                var total: Double = 0
                
                for j in 0..<count {
                    if i & (1 << j) != 0 {
                        let product = remaining[j]
                        total += product.price
                        combo.append(product)
                    }
                }
                
                if total < 250, total > bestTotal {
                    bestTotal = total
                    bestCombo = combo
                }
            }
            
            // If no valid combo found, take one item to avoid infinite loop
            if bestCombo.isEmpty, let first = remaining.first {
                bestCombo = [first]
            }
            
            // Remove selected items from remaining
            let ids = Set(bestCombo.map { $0.name }) // assuming name is unique
            remaining.removeAll { ids.contains($0.name) }
            
            packages.append(makePackage(from: bestCombo))
        }
        
        return packages
    }
    
    private func makePackage(from items: [Product]) -> Package {
        let totalPrice = items.reduce(0) { $0 + $1.price }
        let totalWeight = items.reduce(0) { $0 + $1.weight }
        let courierPrice = 15.0
        return Package(
            items: items,
            totalPrice: totalPrice,
            totalWeight: totalWeight, courierPrice: courierPrice
        )
    }
}
