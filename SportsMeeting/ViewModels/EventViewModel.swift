//
//  EventViewModel.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 07.03.2023.
//

import Foundation
import UIKit

struct EventViewModel {
    // MARK: - Properties
    
    let event: Event
    let user: User
    
    var profileImageUrl: URL? {
        return event.user.profileImageUrl
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: event.timestamp, to: now) ?? "2m"
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullName,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: " ・ \(timestamp)",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                     .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(event: Event) {
        self.event = event
        self.user = event.user
    }
}
