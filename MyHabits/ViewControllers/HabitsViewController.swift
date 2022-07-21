//
//  ViewController.swift
//  MyHabits
//
//  Created by Алексей Моторин on 20.07.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setingsVC()
    }
    
    private func setingsVC() {
        view.backgroundColor = ColorStyle.white.colorSetings
        title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddHabitVC))
       
    }
    
    @objc private func showAddHabitVC() {
        
    }
}

