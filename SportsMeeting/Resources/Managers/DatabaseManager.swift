//
//  DatabaseManager.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 01.03.2023.
//

import Firebase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - Public
    
    // Check if  email is available
    public func canCreateNewUser(firstName: String,
                                 lastName: String,
                                 dayOfBirth: String,
                                 gender: String,
                                 phoneNumber:String,
                                 email: String,
                                 completion: (Bool) -> Void) {
        completion(true)
    }
    
    // Inserts new user data to database
    public func insertNewUser(uid: String,
                              firstName: String,
                              lastName: String,
                              dayOfBirth: String,
                              gender: String,
                              phoneNumber:String,
                              email: String,
                              completion: @escaping (Bool) -> Void) {
        
        let userData = ["firstName": firstName,
                        "lastName": lastName,
                        "phoneNumber": phoneNumber,
                        "email": email,
                        "gender": gender,
                        "dayOfBirth": dayOfBirth] as [String : Any]
        
        database.child("users").child(uid).setValue(userData) { error, _ in
            if error == nil {
                // Succeeded
                completion(true)
                return
            } else {
                // Failed
                completion(false)
                return
            }
        }
    }
    
    public func insertNewEvent(nameEvent: String,
                               location: String,
                               dateTime: String,
                               sportType:String,
                               comment: String,
                               completion: @escaping (Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["uid": uid,
                        "nameEvent": nameEvent,
                        "location": location,
                        "dateTime": dateTime,
                        "sportType": sportType,
                        "comment": comment] as [String : Any]
        let ref = database.child("events").childByAutoId()

        ref.setValue(userData) { error, _ in
            if error == nil {
                // Succeeded
                guard let tweetID = ref.key else { return }
                self.database.child("user-tweets").child(uid).setValue([tweetID: 1])
                completion(true)
                return
            } else {
                // Failed
                completion(false)
                return
            }
        }
    }
    
    func getUserData(uid: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        database.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let userData = snapshot.value as? [String: Any] {
                completion(userData, nil)
            } else {
                completion(nil, nil)
            }
        } withCancel: { (error) in
            completion(nil, error)
        }
    }
}
