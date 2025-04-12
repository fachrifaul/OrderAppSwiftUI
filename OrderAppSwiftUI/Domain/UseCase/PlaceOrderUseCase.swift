//
//  PlaceOrderUseCase.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//

struct PlaceOrderUseCase {
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
        var packages: [Package] = []

        let sortedItems = items.sorted { $0.price > $1.price }

        var currentItems: [Product] = []
        var currentTotal: Double = 0.0

        for (index, item) in sortedItems.enumerated() {
            if currentTotal + item.price < 250 {
                currentItems.append(item)
                currentTotal += item.price
            } else {
                packages.append(makePackage(from: currentItems))
                currentItems = [item]
                currentTotal = item.price
            }

            let isLastItem = index == sortedItems.count - 1
            if isLastItem {
                packages.append(makePackage(from: currentItems))
            }
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
