//
//  HomeModuleBuilder.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation
import UIKit

class HomeModuleBuilder {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor(service: HTTPService.shared)
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router, view: view)
        view.presenter = presenter
        return factory(view)
    }
}
