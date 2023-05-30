//
//  User.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 03.03.2023.
//

import Foundation

struct User {
    let uid: String
    var firstName: String
    var lastName: String
    var dayOfBirth: String
    var gender: String
    var phoneNumber:String
    let email: String
    var profileImageUrl: URL?
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? ""
        self.gender = dictionary["gender"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.dayOfBirth = dictionary["dayOfBirth"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profileImage"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}

extension User {
    var fullName: String {
        firstName + " " + lastName
    }
}
