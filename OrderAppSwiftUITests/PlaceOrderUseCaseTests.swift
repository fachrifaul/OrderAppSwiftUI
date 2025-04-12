//
//  PlaceOrderUseCaseTests.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//

import XCTest
@testable import OrderAppSwiftUI

final class PlaceOrderUseCaseTests: XCTestCase {

    var useCase: PlaceOrderUseCase!
    var mockCourierRules: [CourierRule]!

    override func setUp() {
        super.setUp()
        useCase = PlaceOrderUseCase()
        if let url = Bundle(for: type(of: self)).url(forResource: "couriers", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([CourierRule].self, from: data) {
            mockCourierRules = decoded
        } else {
            mockCourierRules = []
        }
    }

    func test_singlePackage_whenTotalPriceIsLessThanOrEqualTo250() {
        let products = [
            Product(name: "Item 1", price: 10, weight: 200),
            Product(name: "Item 6", price: 40, weight: 10),
            Product(name: "Item 7", price: 200, weight: 10)
        ]
        let result = useCase.execute(products, courierRules: mockCourierRules)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.totalPrice, 250)
        XCTAssertEqual(result.first?.courierPrice, 10)
    }
    
    func test_splitPackages_whenTotalPriceExceeds250_shouldNotExceedPerPackageLimit() {
        let products = [
            Product(name: "Item 1", price: 10, weight: 200),
            Product(name: "Item 2", price: 100, weight: 20),
            Product(name: "Item 3", price: 30, weight: 300),
            Product(name: "Item 4", price: 20, weight: 500),
            Product(name: "Item 6", price: 40, weight: 10),
            Product(name: "Item 7", price: 200, weight: 10)
        ]
        let result = useCase.execute(products, courierRules: mockCourierRules)

        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.allSatisfy { $0.totalPrice < 250 })
        XCTAssertTrue(result.allSatisfy { $0.courierPrice == 15 })
        XCTAssertEqual(result[0].totalWeight, 510)
        XCTAssertEqual(result[0].totalPrice, 240)
        XCTAssertEqual(result[0].courierPrice, 15)
        XCTAssertEqual(result[1].totalWeight, 530)
        XCTAssertEqual(result[1].totalPrice, 160)
        XCTAssertEqual(result[1].courierPrice, 15)
    }

    func test_emptySelection_returnsNoPackages() {
        let products: [Product] = []
        let result = useCase.execute(products, courierRules: mockCourierRules)

        XCTAssertTrue(result.isEmpty)
    }
}
