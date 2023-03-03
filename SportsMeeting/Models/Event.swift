//
//  Event.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 03.03.2023.
//

import Foundation

struct Event {
    let nameEvent: String
    let eventID: String
    var location: String
    var dateTime: Date!
    let sportType: String
    let user: User
    var comment: String

    init(user: User, eventID: String, dictionary: [String: Any]) {
        self.eventID = eventID
        self.user = user
        
        self.nameEvent = dictionary["nameEvent"] as? String ?? ""
        self.location = dictionary["location"] as? String ?? ""
        self.sportType = dictionary["sportType"] as? String ?? ""
        self.comment = dictionary["comment"] as? String ?? ""
        
        if let dateTime = dictionary["dateTime"] as? Double {
            self.dateTime = Date(timeIntervalSince1970: dateTime)
        }
    }
}
