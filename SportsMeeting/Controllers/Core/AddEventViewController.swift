//
//  AddEventViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit

class AddEventViewController: UIViewController {
    
    // MARK: View
    private var views = AddEventView()
    
    // MARK: Lifecycle
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Event"
        view.backgroundColor = .systemBackground
        setupKeyboard()
        setupEventHandlers()
    }
    
    // MARK: Actions
    private func setupEventHandlers() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
        views.locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    @objc private func locationButtonTapped() {
        let mapVC = MapViewController(mapType: .AddEventMap)
        mapVC.mapViewControllerDelegate = self
        present(mapVC, animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        guard let nameEvent = views.eventTextField.text, !nameEvent.isEmpty,
              let location = views.locationTextField.text, !nameEvent.isEmpty else {
            showAlert(withTitle: "Event creation error",
                      message: "Make sure that the fields 'Event Name' and 'Location' have been filled in!")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let dataTime = dateFormatter.string(from: views.datePicker.date)
        
        DatabaseManager.shared.insertNewEvent(nameEvent: nameEvent, location: location, dateTime: dataTime, sportType: views.selectedSportType ?? views.sports[0], comment: views.peopleTextField.text ?? "") { inserted in
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
        
        if let activeTextField = views.activeTextField {
            
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

extension AddEventViewController: MapViewControllerDelegate {
    func getAddress(_ address: String?) {
        views.locationTextField.text = address
    }
}

