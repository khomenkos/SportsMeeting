//
//  AuthManager.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 01.03.2023.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Public
    public func registerNewUser(firstName: String,
                                lastName: String,
                                dayOfBirth: String,
                                gender: String,
                                phoneNumber:String,
                                email: String,
                                password: String,
                                completion: @escaping (Bool) -> Void) {
        /*
         - Check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(firstName: firstName,
                                                lastName: lastName,
                                                dayOfBirth: dayOfBirth,
                                                gender: gender,
                                                phoneNumber: phoneNumber,
                                                email: email) { canCreate in
            if canCreate {
                /*
                 - Create account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    guard let uid = result?.user.uid else { return }
                    
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(uid: uid,
                                                         firstName: firstName,
                                                         lastName: lastName,
                                                         dayOfBirth: dayOfBirth,
                                                         gender: gender,
                                                         phoneNumber: phoneNumber,
                                                         email: email) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            // Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                // Either username or email does not exist
                completion(false)
            }
        }
    }
    
    public func loginUser(email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // Email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
    
    // Attempt to log out Firebase user
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
}

