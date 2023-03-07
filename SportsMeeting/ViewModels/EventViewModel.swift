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
    
    init(event: Event) {
        self.event = event
        self.user = event.user
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: "Published by user: " + user.firstName + " " + user.lastName,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        return title
    }

}
