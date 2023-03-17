//
//  AddEventViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit
import MapKit
import CoreLocation

class AddEventViewController: UIViewController {
    
    var activeTextField : UITextField? = nil
    let scrollView = UIScrollView()
    
    var selectedSportType: String?
    let sports = ["Run", "Gym", "Football", "Basketball", "Tennis", "Volleyball", "Hockey"]
    
    // MARK: Outlets

    // Containers
    private lazy var eventContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Event Name", view: eventTextField)
        return stack
    }()
    
    private lazy var locationContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Location", view: locationTextField)
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
    
    private lazy var commentContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Special Comment:", view: commentTextField)
        return stack
    }()
    
    // Text Fields
    private lazy var eventTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Enter event name")
        textField.delegate = self
        textField.returnKeyType = .continue
        return textField
    }()
    
    private lazy var locationTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Select location")
        textField.delegate = self
        textField.returnKeyType = .continue
        return textField
    }()
    
    private lazy var commentTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Enter a comment")
        textField.delegate = self
        textField.returnKeyType = .continue
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.datePickerMode = .dateAndTime
        datePicker.contentHorizontalAlignment = .center
        datePicker.contentVerticalAlignment = .center
        return datePicker
    }()
    
    private lazy var sportTypePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Event"
        view.backgroundColor = .systemBackground
        setupKeyboard()
        setupUI()
    }
    
    // MARK: Actions
    
    @objc func closeBtn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        guard let nameEvent = eventTextField.text, !nameEvent.isEmpty,
              let location = locationTextField.text, !nameEvent.isEmpty else {
            showAlert(withTitle: "Event creation error",
                      message: "Make sure that the fields 'Event Name' and 'Location' have been filled in!")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dataTime = dateFormatter.string(from: datePicker.date)
        
        DatabaseManager.shared.insertNewEvent(nameEvent: nameEvent, location: location, dateTime: dataTime, sportType: selectedSportType ?? sports[0], comment: commentTextField.text ?? "") { inserted in
            if inserted {
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            } else {
                self.showAlert(withTitle: "Event creation error",
                               message: "Make sure that the fields 'Event Name' and 'Location' have been filled in!")
            }
        }
    }
    
    // MARK: Setting UI
    private func setupBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
    }
    
    private func setupUI() {
        setupBarItem()
        
        let stackView = UIStackView(arrangedSubviews: [eventContainer, locationContainer, dateContainer, sportTypeContainer, commentContainer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        scrollView.keyboardDismissMode = .onDrag
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
 
        NSLayoutConstraint.activate([
            eventTextField.heightAnchor.constraint(equalToConstant: 50),
            locationTextField.heightAnchor.constraint(equalToConstant: 50),
            commentTextField.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
    
    // MARK: Setting Keyboard
    
    private func setupKeyboard() {
        hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension AddEventViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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

extension AddEventViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}
