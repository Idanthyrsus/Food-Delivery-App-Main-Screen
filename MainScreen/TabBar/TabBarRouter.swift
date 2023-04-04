//
//  TabBarRouter.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation
import UIKit

class TabBarRouter {
    var viewController: UIViewController
    
    typealias Modules = (
        menu: UIViewController,
        contacts: UIViewController,
        profile: UIViewController,
        cart: UIViewController
    )
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension TabBarRouter {
    static func tabs(usingModules modules: Modules) -> MainTabs {
        let menuTabBarItem = UITabBarItem(title: "Меню", image: UIImage(named: "Menu"), tag: 10)
        let contactsTabBarItem = UITabBarItem(title: "Контакты", image: UIImage(named: "Contacts"), tag: 11)
        let profileTabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "Profile"), tag: 12)
        let cartTabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "Cart"), tag: 13)

        modules.menu.tabBarItem = menuTabBarItem
        modules.contacts.tabBarItem = contactsTabBarItem
        modules.profile.tabBarItem = profileTabBarItem
        modules.cart.tabBarItem = cartTabBarItem
        
        return (
            menu: modules.menu,
            contacts: modules.contacts,
            profile: modules.profile,
            cart: modules.cart
        )
    }
}
