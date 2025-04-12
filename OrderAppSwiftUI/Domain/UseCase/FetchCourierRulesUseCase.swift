//
//  FetchCourierRulesUseCase.swift
//  OrderAppSwiftUI
//
//  Created by Fachri Febrian on 10/04/2025.
//


class FetchCourierRulesUseCase {
    private let repository: CourierProviding

    init(repository: CourierProviding) {
        self.repository = repository
    }

    func execute(completion: @escaping ([CourierRule]) -> Void) {
        repository.fetchCourierRules(completion: completion)
    }
}
