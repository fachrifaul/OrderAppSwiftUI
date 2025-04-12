//
//  OrderViewModel.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//

import SwiftUI


class OrderViewModel: ObservableObject {
    @Published private(set) var packages: [Package] = []
    @Published var products: [Product] = []
    private var courierRules: [CourierRule] = []

    private let fetchProductsUseCase: FetchProductsUseCase
    private let fetchCourierRulesUseCase: FetchCourierRulesUseCase
    private let placeOrderUseCase = PlaceOrderUseCase()

    init(
        fetchProductsUseCase: FetchProductsUseCase = FetchProductsUseCase(repository: ProductRepository()),
        fetchCourierRulesUseCase: FetchCourierRulesUseCase = FetchCourierRulesUseCase(repository: CourierRepository())
    ) {
        self.fetchProductsUseCase = fetchProductsUseCase
        self.fetchCourierRulesUseCase = fetchCourierRulesUseCase
    }

    func loadProducts() {
        fetchProductsUseCase.execute { [weak self] products in
            self?.products = products
        }
    }

    func loadCourierRules() {
        fetchCourierRulesUseCase.execute { courierRules in
            self.courierRules = courierRules
        }
    }

    func placeOrder() {
        let selectedItems = products.filter { $0.isSelected }
        packages = placeOrderUseCase.execute(selectedItems, courierRules: courierRules)
    }

    func resetPackages() {
        packages = []
    }
}
