//
//  ViewController.swift
//  MyHabits
//
//  Created by Алексей Моторин on 20.07.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    var progress = HabitsStore.shared.todayProgress
    var textProgress = String(format: "%.0f", HabitsStore.shared.todayProgress * 100) + "%"
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCollectionCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ColorStyle.white.colorSetings
        return collectionView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setingsVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func setingsVC() {
        view.backgroundColor = ColorStyle.white.colorSetings
        title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddHabitVC))
        
        view.addSubview(contentView)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    @objc private func showAddHabitVC() {
        let habitVC = HabitViewController()
        habitVC.deleteButton.isHidden = true
        let vc = UINavigationController(rootViewController: habitVC)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // возращаем кол-во секций
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    // определяем кол-во ячеек в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : HabitsStore.shared.habits.count
    }
    
    // создаем ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressViewCell", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionCell", for: indexPath)
                cell.backgroundColor = .black
                return cell
            }
            cell.layer.cornerRadius = 12
            cell.backgroundColor = .white
            cell.progress.progress = progress
            cell.progressLabel.text = textProgress
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath) as? HabitCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionCell", for: indexPath)
                cell.backgroundColor = .black
                return cell
            }
            cell.delegate = self
            cell.layer.cornerRadius = 12
            cell.habit = HabitsStore.shared.habits[indexPath.row]
            cell.backgroundColor = .white
            return cell
        }
    }
    
    // высота секции
    private func widthForSection(collectionViewWidth: CGFloat, numberOfItems: CGFloat, indent: CGFloat) -> CGFloat {
        return (collectionViewWidth - indent * (numberOfItems + 1)) / numberOfItems
    }
    
    // ширина и высота cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let width = widthForSection(collectionViewWidth: collectionView.frame.width, numberOfItems: 1, indent: 16)
        return sizeForItemAt.section == 0 ? CGSize(width: width, height: 60) : CGSize(width: width, height: 120)
    }
    
    // расстояния между cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        section == 0 ? UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16) : UIEdgeInsets(top: 18, left: 16, bottom: 22, right: 16)
    }
    
    // Показ данных о выбранной привычке
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habitDetailsViewController = HabitDetailsViewController()
        habitDetailsViewController.habit = HabitsStore.shared.habits[indexPath.row]
        habitDetailsViewController.numberHubitInArray = indexPath.row
        navigationController?.pushViewController(habitDetailsViewController, animated: true)
    }
    
}

extension HabitsViewController: HabitCollectionViewCellDelegate {
    func reloadData() {
        progress = HabitsStore.shared.todayProgress
        textProgress = String(format: "%.0f", HabitsStore.shared.todayProgress * 100) + "%"
        collectionView.reloadData()
    }
}
