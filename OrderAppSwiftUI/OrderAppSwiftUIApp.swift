//
//  OrderAppSwiftUIApp.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//

import SwiftUI

@main
struct OrderAppSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            
            let productRepository = ProductRepository()
            let courierRepository = CourierRepository()
            
            let fetchProductsUseCase = FetchProductsUseCase(repository: productRepository)
            let fetchCourierRulesUseCase = FetchCourierRulesUseCase(repository: courierRepository)
            
            let viewModel = OrderViewModel(
                fetchProductsUseCase: fetchProductsUseCase,
                fetchCourierRulesUseCase: fetchCourierRulesUseCase
            )
            
            OrderView(viewModel: viewModel)
        }
    }
}
