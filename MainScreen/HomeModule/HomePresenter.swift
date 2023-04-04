//
//  HomePresenter.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation

protocol HomePresenting {
    func viewDidLoad()
    func select(category: CategoryType)
}

class HomePresenter {
    var interactor: HomeInteracting?
    var router: HomeRouting?
    weak var view: HomeView?
    
    init(interactor: HomeInteracting, router: HomeRouting, view: HomeView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension HomePresenter: HomePresenting {
    func viewDidLoad() {
        Task {
           let result = await interactor?.getFood()
           let pizzasList = result?.compactMap({ MexicanFoodViewModel(using: $0) })
           self.view?.updateTable(with: pizzasList ?? [])
        }
    }
    func select(category: CategoryType) {
        view?.displaySelected(category: category)
    }
}
