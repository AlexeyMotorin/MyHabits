//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Алексей Моторин on 21.07.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = ColorStyle.white.colorSetings
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = ColorStyle.white.colorSetings
        return contentView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "НАЗВАНИЕ"
        label.font = TextFontStyle.body.textFont
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "бегать по утрам, спать 8 часов и т.п. "
        textField.delegate = self
        textField.returnKeyType = .done
        
        //если текст филд пустой saveButton не активна
        textField.addTarget(self,
                            action: #selector(textFeldChangeed),
                            for: .editingChanged)
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = TextFontStyle.body.textFont
        label.text = "ЦВЕТ"
        return label
    }()
    
    lazy var colorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorStyle.orange.colorSetings
        button.layer.cornerRadius = 20
        button.addTarget(self,
                         action: #selector(showColorPicker),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Сохранить",
                                     style: .plain,
                                     target: self,
                                     action: #selector(saveHabit))
        button.isEnabled = false
        return button
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = TextFontStyle.body.textFont
        label.text = "ВРЕМЯ"
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каждый день в"
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.locale? = Locale(identifier: "Russian")
        picker.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        return picker
    }()
    
    var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.addTarget(HabitViewController.self, action: #selector(deleteHabit), for: .touchUpInside)
        return button
    }()
    
    private var curentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat =   "HH.mm"
        return formatter.string(from: datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController()
    }
    
    private func setupNavController() {
        view.backgroundColor = .white
        navigationItem.title = "Создать"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancel))
        navigationItem.rightBarButtonItem = saveButton
        nameTextField.textColor = colorButton.backgroundColor
        valueChanged(datePicker)
        addSubViews()
    }
    
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorButton)
        contentView.addSubview(timeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            colorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            colorLabel.heightAnchor.constraint(equalToConstant: 40),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor),
            colorButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            colorButton.heightAnchor.constraint(equalToConstant: 40),
            colorButton.widthAnchor.constraint(equalToConstant: 40),
            
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    // действие для кнопки сохранить
    @objc private func saveHabit() {
        
        guard let nameHabit = nameTextField.text else { return }
        guard let color = colorButton.backgroundColor else { return }
        
        let newHabit = Habit(name: nameHabit,
                             date: datePicker.date,
                             color: color)
        HabitsStore.shared.habits.insert(newHabit, at: 0)
        dismiss(animated: true)
    }
    
    // получаем дату из даты пикера
    @objc private func valueChanged(_ sender: UIDatePicker) {
        nameTextField.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH.mm"
        let dataValue = formatter.string(from: sender.date)
        let attribute =  [NSAttributedString.Key.foregroundColor: ColorStyle.purple.colorSetings,
                          NSAttributedString.Key.font: TextFontStyle.body.textFont]
        let atrrString = NSAttributedString(string: dataValue, attributes: attribute)
        
        dateLabel.text =  "Каждый день в " + dataValue
        
        let baseStr = NSMutableAttributedString(string: "Каждый день в ",
                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        baseStr.append(atrrString)
        dateLabel.attributedText = baseStr
        
    }
    
    // действие для кнопки отмена
    @objc private func cancel() {
        dismiss(animated: true)
    }
    
    // запустить colorPicker
    @objc private func showColorPicker() {
        nameTextField.endEditing(true)
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = colorButton.backgroundColor ?? .systemOrange
        picker.title = "Выберать цвет"
        present(picker, animated: true)
    }
    
    @objc private func deleteHabit() {
        showAlert(tittle: "Удалить привычку", message: "Вы хотите удалить привычку\n\(nameTextField.text ?? "")?")
    }
    
    private func showAlert(tittle: String, message: String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        let cancelAlert = UIAlertAction(title: "Отмена", style: .cancel)
        let deleteAlert = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            
            // будем удалять привычку
            self.dismiss(animated: true)
        }
        alert.addAction(cancelAlert)
        alert.addAction(deleteAlert)
        present(alert, animated: true)
    }
}

extension HabitViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    //  если текст филд пустой saveButton и deleteButton не активна
    @objc private func textFeldChangeed() {
        if nameTextField.text != "" {
            saveButton.isEnabled = true
            deleteButton.isEnabled = true
            deleteButton.setTitleColor(UIColor.systemRed, for: .normal)
        } else {
            saveButton.isEnabled = false
            deleteButton.isEnabled = false
            deleteButton.setTitleColor(UIColor.systemGray, for: .normal)
        }
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
        nameTextField.textColor = viewController.selectedColor
    }
}


