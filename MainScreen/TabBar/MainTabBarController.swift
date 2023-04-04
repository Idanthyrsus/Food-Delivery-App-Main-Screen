//
//  MainTabBarController.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation
import UIKit

typealias MainTabs = (
menu: UIViewController,
contacts: UIViewController,
profile: UIViewController,
cart: UIViewController
)

class MainTabBarController: UITabBarController {
    
    init(tabs: MainTabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.menu,
                           tabs.contacts,
                           tabs.profile,
                           tabs.cart]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = UIColor(cgColor: CGColor(red: 253/255,
                                                                   green: 58/255,
                                                                   blue: 105/255,
                                                                   alpha: 1))
        UITabBar.appearance().isTranslucent = true
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
          
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}
