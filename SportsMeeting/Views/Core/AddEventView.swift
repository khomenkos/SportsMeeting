//
//  AddEventView.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 03.04.2023.
//

import UIKit

class AddEventView: UIView {
    
    // MARK: - Variables
    private(set) var activeTextField : UITextField? = nil
    private(set) var selectedSportType: String?
    let sports = ["Run", "Gym", "Football", "Basketball", "Tennis", "Volleyball", "Hockey"]
    
    // MARK: Outlets
    private let scrollView = UIScrollView()

    // Containers
    private lazy var eventContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Event Name", view: eventTextField)
        return stack
    }()
    
    private lazy var locationTitleContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Location", view: locationContainer)
        return stack
    }()
    
    private lazy var locationContainer: UIStackView = {
        let stack = Utilities().imageContainerView(withImage: locationTextField, textField: locationButton)
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var dateContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Time & Date", view: datePicker)
        return stack
    }()
    
    private lazy var sportTypeContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Sport:", view: sportTypePicker)
        return stack
    }()
    
    private lazy var peopleContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Number of people", view: peopleTextField)
        return stack
    }()
    
    // Text Fields
    private(set) var eventTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Enter event name")
        textField.returnKeyType = .continue
        return textField
    }()
    
    private(set) var locationTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Select location")
        textField.returnKeyType = .continue
        return textField
    }()
    
    private(set) lazy var peopleTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Enter the number of people")
        textField.returnKeyType = .continue
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private(set) var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.contentHorizontalAlignment = .center
        datePicker.contentVerticalAlignment = .center
        return datePicker
    }()
    
    private(set) var sportTypePicker = UIPickerView()
    
    // Buttons
    private(set) var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location"), for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        sportTypePicker.delegate = self
        peopleTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup UI
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [eventContainer, locationTitleContainer, dateContainer, sportTypeContainer, peopleContainer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        scrollView.keyboardDismissMode = .onDrag
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
 
        NSLayoutConstraint.activate([
            eventTextField.heightAnchor.constraint(equalToConstant: 50),
            locationTextField.heightAnchor.constraint(equalToConstant: 50),
            peopleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
        ])
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension AddEventView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sports[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSportType = sports[row]
    }
}

extension AddEventView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}

