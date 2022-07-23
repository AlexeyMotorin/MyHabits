//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Алексей Моторин on 23.07.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habit: Habit?
    var numberHubitInArray: Int?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        tableView.backgroundColor = ColorStyle.white.colorSetings
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorStyle.white.colorSetings
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(showHabitVC))
        tableViewSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let numberHubitInArray = numberHubitInArray else { return }
        habit = HabitsStore.shared.habits[numberHubitInArray]
        title = habit?.name
    }
    
    private func tableViewSettings()  {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func showHabitVC() {
        let habitVC = HabitViewController()
        habitVC.habit = habit
        habitVC.numberHubitInArray = numberHubitInArray
        habitVC.saveButton.isEnabled = true
        habitVC.delegate = self
        let vc = UINavigationController(rootViewController: habitVC)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func closeVC() {
        dismiss(animated: true)
    }
}

// показываем даты с момента установки приложения
extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        // проверяем была ты трекнута привычка в конкретный день, если да, ставим checkmark
        if let habit = habit {
            if HabitsStore.shared.habit(habit, isTrackedIn: HabitsStore.shared.dates[indexPath.row]) {
                cell.accessoryType = .checkmark
                cell.tintColor = ColorStyle.purple.colorSetings
            }
        }
        return cell
    }
}

extension HabitDetailsViewController: HabitViewControllerDelegate {
    func deleteHabit() {
        guard let numberHubitInArray = self.numberHubitInArray else { return }
        HabitsStore.shared.habits.remove(at: numberHubitInArray)
        navigationController?.popViewController(animated: true)
    }
}
