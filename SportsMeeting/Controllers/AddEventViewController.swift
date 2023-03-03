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
    let contentView = UIView()
    
    var selectedSportType: String?
    let sports = ["Run", "Gym", "Football", "Basketball", "Tennis", "Volleyball", "Hockey"]
    
    // MARK: - Properties
    
    private let eventTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter event name"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private let locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select location"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
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
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a comment"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Event"
        view.backgroundColor = .systemBackground
        setupBarItem()
        setupKeyboard()
        setupUI()
        eventTitleTextField.delegate = self
        locationTextField.delegate = self
        commentTextField.delegate = self
    }
    
    private func setupBarItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(closeBtn))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
    }
    
    // MARK: Actions
    
    @objc func closeBtn() {
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        guard let nameEvent = eventTitleTextField.text, !nameEvent.isEmpty,
              let location = locationTextField.text, !nameEvent.isEmpty else {
            alertError()
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
                self.alertError()
            }
        }
    }
    
    private func alertError() {
        let alert = UIAlertController(title: "Event creation error",
                                      message: "Make sure that the fields 'Event Name' and 'Location' have been filled in!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    private func setupUI() {
        
        // Hide keyboard while scrolling
        scrollView.keyboardDismissMode = .onDrag
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Event Name"
        titleLabel.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(eventTitleTextField)
        
        let locationLabel = UILabel()
        locationLabel.text = "Location"
        locationLabel.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(locationTextField)
        
        let dateLabel = UILabel()
        dateLabel.text = "Time & Date"
        dateLabel.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(datePicker)
        
        let sportTypeLabel = UILabel()
        sportTypeLabel.text = "Sport"
        sportTypeLabel.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        stackView.addArrangedSubview(sportTypeLabel)
        stackView.addArrangedSubview(sportTypePicker)
        
        let commentLabel = UILabel()
        commentLabel.text = "Special Comment"
        commentLabel.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        stackView.addArrangedSubview(commentLabel)
        stackView.addArrangedSubview(commentTextField)
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            eventTitleTextField.heightAnchor.constraint(equalToConstant: 50),
            locationTextField.heightAnchor.constraint(equalToConstant: 50),
            commentTextField.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        ])
    }
    
    // MARK: Setting Keyboard
    
    private func setupKeyboard() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGestureRecognizer)
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
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
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
