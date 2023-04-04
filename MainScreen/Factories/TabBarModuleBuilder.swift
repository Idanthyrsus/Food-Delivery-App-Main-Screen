//
//  TabBarModuleBuilder.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation
import UIKit

class TabBarModuleBuilder {
    static func build(submodules: TabBarRouter.Modules) -> UITabBarController {
        let tabItems = TabBarRouter.tabs(usingModules: submodules)
        let tabBarController = MainTabBarController(tabs: tabItems)
        return tabBarController
    }
}
