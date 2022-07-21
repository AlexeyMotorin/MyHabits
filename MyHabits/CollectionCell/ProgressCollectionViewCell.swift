//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Алексей Моторин on 21.07.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
     lazy var progress: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.trackTintColor = ColorStyle.systemGray2.colorSetings
        progress.progressTintColor = ColorStyle.purple.colorSetings
        return progress
    }()
    
    private lazy var doItLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всё получится!"
        label.font = TextFontStyle.footnoteStatus.textFont
        label.textColor = TextFontStyle.footnoteStatus.textColor
        return label
    }()
    
     lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = TextFontStyle.footnoteStatus.textFont
        label.textColor = TextFontStyle.footnoteStatus.textColor
        return label
    }()
    
    private lazy var stakeLabels: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(stakeLabels)
        contentView.addSubview(progress)
        
        stakeLabels.addArrangedSubview(doItLabel)
        stakeLabels.addArrangedSubview(progressLabel)
        
        NSLayoutConstraint.activate([
            stakeLabels.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stakeLabels.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stakeLabels.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            progress.centerXAnchor.constraint(equalTo: stakeLabels.centerXAnchor),
            progress.topAnchor.constraint(equalTo: stakeLabels.bottomAnchor, constant: 12),
            progress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            progress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            progress.heightAnchor.constraint(equalToConstant: 7)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

