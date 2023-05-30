//
//  ProfileViewModel.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 04.04.2023.
//

import FirebaseAuth

class ProfileViewModel {
    weak var delegate: EventsVMDelegate?
    
    var user: User? {
        didSet {
            self.fetchEvents()
        }
    }
    
    var events: [Event] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdateEvents(self.events)
            }
        }
    }
    
    func deleteEvent(withID eventID: String) {
        guard let index = events.firstIndex(where: { $0.eventID == eventID }) else {
            return
        }
        events.remove(at: index)
    }
    
    func fetchEvents() {
        guard let user = user else { return }
        DatabaseManager.shared.fetchEvents(forUser: user) { events in
            self.events = events
        }
    }
    
    func loadData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        DatabaseManager.shared.fetchUser(uid: uid) { user in
            self.user = user
            
            if self.events.isEmpty {
                self.delegate?.didUpdateEvents(self.events)
            }
        }
    }
}

