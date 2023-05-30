//
//  HomeViewModel.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 04.04.2023.
//

import ProgressHUD

protocol EventsVMDelegate: AnyObject {
    func didUpdateEvents(_ events: [Event])
    func didShowAlert()
}

class HomeViewModel {
    weak var delegate: EventsVMDelegate?
    
    var allEvents = [Event]()
    
    var events: [Event] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdateEvents(self.events)
                if self.events.isEmpty {
                    self.events = self.allEvents
                    self.delegate?.didShowAlert()
                }
            }
        }
    }
    
    func fetchEvents() {
        DatabaseManager.shared.fetchEvents { events in
            self.events = events.sorted(by: { $0.timestamp > $1.timestamp })
            self.allEvents = events
        }
    }
}

extension HomeViewModel {
    func filterEventsBySportType(_ sportType: String?) {
        if let type = sportType, type != "All" {
            
            events = allEvents.filter { $0.sportType == type }
        } else {
            fetchEvents()
        }
    }
    
    func filterEventsByLocation(_ location: String?) {
        if let city = location?.trimmingCharacters(in: .whitespacesAndNewlines), !city.isEmpty {
            let filteredEvents = allEvents.filter { $0.location.range(of: city, options: .caseInsensitive) != nil }
            self.events = filteredEvents.isEmpty ? [] : filteredEvents
        } else {
            fetchEvents()
        }
    }
}
