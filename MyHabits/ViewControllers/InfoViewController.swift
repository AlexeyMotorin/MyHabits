//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Алексей Моторин on 21.07.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = ColorStyle.white.colorSetings
        return scroll
    }()
    
    private lazy var contentMode: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = ColorStyle.white.colorSetings
        return content
    }()
    
    private lazy var textLabel: UILabel = {
       let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = Info.info
        text.numberOfLines = 0
        text.font = TextFontStyle.body.textFont
        return text
    }()
    
    private lazy var tittleTextLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Info.tittle
        label.font = TextFontStyle.title.textFont
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setingsVC()
    }

    private func setingsVC() {
        view.backgroundColor = ColorStyle.white.colorSetings
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Информация"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentMode)
        contentMode.addSubview(textLabel)
        contentMode.addSubview(tittleTextLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentMode.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentMode.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentMode.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentMode.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            tittleTextLabel.topAnchor.constraint(equalTo: contentMode.topAnchor, constant: 10),
            tittleTextLabel.centerXAnchor.constraint(equalTo: contentMode.centerXAnchor),
            tittleTextLabel.leadingAnchor.constraint(equalTo: contentMode.leadingAnchor, constant: 20),
            tittleTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: tittleTextLabel.bottomAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentMode.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentMode.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
