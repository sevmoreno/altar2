//
//  TabBarGeneral.swift
//  altar
//
//  Created by Juan Moreno on 1/29/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class TabBarGeneral: UITabBarController {

    class TabBarController: UITabBarController {

        private lazy var firstController: UIViewController = {
            let controller = UIViewController()
            controller.title = "First"
            controller.view.backgroundColor = .lightGray
            return controller
        }()

        private lazy var secondController: UIViewController = {
            let controller = UIViewController()
            controller.title = "Second"
            controller.view.backgroundColor = .darkGray
            return controller
        }()

        private var controllers: [UIViewController] {
            return [firstController, secondController]
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            tabBar.tintColor = .magenta
            tabBar.unselectedItemTintColor = .white
            tabBar.barTintColor = .black

            firstController.tabBarItem = UITabBarItem(title: "First", image: UIImage(), tag: 0) // replace with your image
            secondController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(), tag: 1) // replace with your image

            viewControllers = controllers
            selectedViewController = firstController
        }
    }

  

}
