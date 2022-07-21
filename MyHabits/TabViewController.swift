//
//  TabViewController.swift
//  MyHabits
//
//  Created by Алексей Моторин on 21.07.2022.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarVC()
    }
    
    private func setupTabBarVC() {
        viewControllers = [
        genericVC(UINavigationController(rootViewController: HabitsViewController()),
                  title: "Привычки",
                  image: UIImage(systemName: "checklist")),
        genericVC(UINavigationController(rootViewController: InfoViewController()),
                  title: "Информация",
                  image: UIImage(systemName: "info.circle.fill"))
        ]
    }
    
    private func genericVC(_ vc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
}


