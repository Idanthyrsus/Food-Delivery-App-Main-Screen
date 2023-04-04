//
//  HomeInteractor.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation

protocol HomeInteracting {
    func getFood() async -> MexicanFood
}

class HomeInteractor {
    var service: FoodAPI
    
    init(service: FoodAPI) {
        self.service = service
    }
}

extension HomeInteractor: HomeInteracting {
    func getFood() async -> MexicanFood {
        do {
            let data = try await service.fetchFood()
            return data
        } catch  {
            return []
        }
    }
}
