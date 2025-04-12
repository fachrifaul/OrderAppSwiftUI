//
//  OrderView.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//


import SwiftUI
import Foundation

struct OrderView: View {
    @StateObject private var viewModel: OrderViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    init(viewModel: OrderViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    List {
                        ForEach(viewModel.products.indices, id: \.self) { index in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(viewModel.products[index].name)
                                    Text("Price: $\(viewModel.products[index].price, specifier: "%.2f")")
                                    Text("Weight: \(viewModel.products[index].weight, specifier: "%.0f")g")
                                }
                                Spacer()
                                Toggle("", isOn: Binding(
                                    get: { viewModel.products[index].isSelected },
                                    set: { viewModel.products[index].isSelected = $0 }
                                ))
                                .labelsHidden()
                            }
                        }
                    }
                    .frame(height: geometry.size.height * 0.5)
                    
                    Spacer()
                    
                    VStack {
                        Button("Random Select") {
                            if viewModel.products.isEmpty { return }
                            for i in viewModel.products.indices {
                                viewModel.products[i].isSelected = Bool.random()
                            }
                        }
                        .padding(.top)
                        
                        HStack {
                            Button(action: {
                                if viewModel.products.filter({ $0.isSelected }).isEmpty {
                                    alertMessage = "Please select at least one item before placing an order."
                                    showAlert = true
                                } else {
                                    viewModel.placeOrder()
                                }
                            }) {
                                Text("Order")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .font(.system(size: 10))
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                if viewModel.products.filter({ $0.isSelected }).isEmpty {
                                    alertMessage = "Please select at least one item before placing an order."
                                    showAlert = true
                                } else {
                                    viewModel.placeOrderEvenDistribute()
                                }
                            }) {
                                Text("Order Evenly Distribute")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .font(.system(size: 10))
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        
                        Button("Reset") {
                            viewModel.loadProducts()
                            viewModel.loadCourierRules()
                            viewModel.resetPackages()
                        }
                        .padding(.bottom)
                        .foregroundColor(.red)
                        
                        List(Array(viewModel.packages.enumerated()), id: \.element.id) { index, pkg in
                            VStack(alignment: .leading) {
                                Text("Package \(index + 1)").bold()
                                Text("Items - \(pkg.items.map { $0.name }.joined(separator: ", "))")
                                Text("Total Price: $\(pkg.totalPrice, specifier: "%.2f")")
                                Text("Total Weight: \(pkg.totalWeight, specifier: "%.0f")g")
                                Text("Courier Fee: $\(pkg.courierPrice, specifier: "%.2f")")
                            }
                        }
                        .frame(maxHeight: .infinity)
                    }
                }
            }
            .navigationTitle("Order Items")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .task {
                viewModel.loadProducts()
                viewModel.loadCourierRules()
            }
        }
    }
}

#Preview {
    OrderView(viewModel: OrderViewModel())
}
