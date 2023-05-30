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
                                profileImage: UIImage,
                                completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.canCreateNewUser(firstName: firstName,
                                                lastName: lastName,
                                                dayOfBirth: dayOfBirth,
                                                gender: gender,
                                                phoneNumber: phoneNumber,
                                                email: email,
                                                profileImage: profileImage) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {

                        completion(false)
                        return
                    }
                    guard let uid = result?.user.uid else { return }
                    DatabaseManager.shared.insertNewUser(uid: uid,
                                                         firstName: firstName,
                                                         lastName: lastName,
                                                         dayOfBirth: dayOfBirth,
                                                         gender: gender,
                                                         phoneNumber: phoneNumber,
                                                         email: email,
                                                         profileImage: profileImage) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    public func loginUser(email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
    
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

