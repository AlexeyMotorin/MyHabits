//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Алексей Моторин on 21.07.2022.
//

import UIKit

protocol HabitCollectionViewCellDelegate: AnyObject {
    func reloadData()
}

class HabitCollectionViewCell: UICollectionViewCell {
    
    var delegate: HabitCollectionViewCellDelegate?
    
    var habit: Habit? {
        didSet {
            nameLabel.text = habit?.name
            nameLabel.textColor = habit?.color
            timeLabel.text = habit?.dateString
            counterLabel.text = "Счетчик " + String(habit!.trackDates.count)
    
            guard let isAlreadyTakenToday = habit?.isAlreadyTakenToday else { return }
            
            if isAlreadyTakenToday {
                doneButtom.backgroundColor = habit?.color
                doneButtom.layer.borderColor = habit?.color.cgColor
                let image = UIImage(systemName: "checkmark")
                doneButtom.setImage(image, for: .normal)
            }
            else {
                doneButtom.backgroundColor = nil
                doneButtom.layer.borderColor = habit?.color.cgColor
                doneButtom.setImage(nil, for: .normal)
            }
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = TextFontStyle.headline.textFont
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = "Cчетчик"
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var doneButtom: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBackground
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(doneHabit), for: .touchUpInside)
        return button
    }()
    
    private lazy var doneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark.circle.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderColor = ColorStyle.systemGray2.colorSetings.cgColor
        image.layer.borderWidth = 3
        image.layer.cornerRadius = 18
        image.clipsToBounds = true
        image.isHidden = true
        return image
    }()
    
    private lazy var stakeLabels: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(stakeLabels)
        stakeLabels.addArrangedSubview(nameLabel)
        stakeLabels.addArrangedSubview(timeLabel)
        
        contentView.addSubview(counterLabel)
        contentView.addSubview(doneButtom)
    
        NSLayoutConstraint.activate([
            stakeLabels.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stakeLabels.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stakeLabels.trailingAnchor.constraint(equalTo: doneButtom.leadingAnchor),
            
            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            counterLabel.heightAnchor.constraint(equalToConstant: 30),
            counterLabel.trailingAnchor.constraint(equalTo: doneButtom.leadingAnchor),
 
            doneButtom.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            doneButtom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            doneButtom.heightAnchor.constraint(equalToConstant: 35),
            doneButtom.widthAnchor.constraint(equalToConstant: 35),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func doneHabit() {
        guard let habit = habit else { return }
        if habit.isAlreadyTakenToday {
            return
        }
        HabitsStore.shared.track(habit)
        delegate?.reloadData()
    }
}
