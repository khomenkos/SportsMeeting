//
//  DatabaseManager.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 01.03.2023.
//

import FirebaseDatabase

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
    public func insertNewUser(firstName: String,
                              lastName: String,
                              dayOfBirth: String,
                              gender: String,
                              phoneNumber:String,
                              email: String,
                              completion: @escaping (Bool) -> Void) {
        
        let key = email.safeDatabaseKey()
        let userData = ["firstName": firstName,
                        "lastName": lastName,
                        "phoneNumber": phoneNumber,
                        "email": email,
                        "gender": gender,
                        "dayOfBirth": dayOfBirth] as [String : Any]
        
        database.child(key).setValue(userData) { error, _ in
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
    
    func getUserData(email: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let key = email.safeDatabaseKey()
        database.child(key).observeSingleEvent(of: .value) { (snapshot) in
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
