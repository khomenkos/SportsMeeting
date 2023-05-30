//
//  DatabaseManager.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 01.03.2023.
//

import Firebase

struct DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    private let storage = Storage.storage().reference()
    
    // MARK: - Public
    
    public func canCreateNewUser(firstName: String,
                                 lastName: String,
                                 dayOfBirth: String,
                                 gender: String,
                                 phoneNumber:String,
                                 email: String,
                                 profileImage: UIImage,
                                 completion: (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(uid: String,
                              firstName: String,
                              lastName: String,
                              dayOfBirth: String,
                              gender: String,
                              phoneNumber:String,
                              email: String,
                              profileImage: UIImage,
                              completion: @escaping (Bool) -> Void) {
        
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = storage.child("profile_images").child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (_, _) in
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                let userData = ["firstName": firstName,
                                "lastName": lastName,
                                "phoneNumber": phoneNumber,
                                "email": email,
                                "gender": gender,
                                "dayOfBirth": dayOfBirth,
                                "profileImage": profileImageUrl] as [String : Any]
                
                self.database.child("users").child(uid).setValue(userData) { error, _ in
                    if error == nil {
                        completion(true)
                        return
                    } else {
                        completion(false)
                        return
                    }
                }
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
                        "comment": comment,
                        "timestamp": Int(NSDate().timeIntervalSince1970)] as [String : Any]
        
        database.child("events").childByAutoId().updateChildValues(userData) { error, ref in
            if error == nil {
                guard let eventID = ref.key else { return }
                database.child("user-events").child(uid).updateChildValues([eventID: 1])
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        database.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    func fetchEvents(completion: @escaping([Event]) -> Void) {
        var events = [Event]()
        
        database.child("events").observe(.childAdded) { snapshot in
            let eventID = snapshot.key
            
            self.fetchEvent(withEventID: eventID) { event in
                events.append(event)
                completion(events.sorted(by: { $0.timestamp > $1.timestamp }))
            }
        }
    }
    
    func fetchEvents(forUser user: User, completion: @escaping([Event]) -> Void) {
        var events = [Event]()
        database.child("user-events").child(user.uid).observe(.childAdded) { snapshot in
            let eventID = snapshot.key
            
            fetchEvent(withEventID: eventID) { event in
                events.append(event)
                completion(events.sorted(by: { $0.timestamp > $1.timestamp }))
            }
        }
    }
    
    func fetchEvent(withEventID eventID: String, completion: @escaping(Event) -> Void) {
        database.child("events").child(eventID).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            fetchUser(uid: uid) { user in
                let event = Event(user: user, eventID: eventID, dictionary: dictionary)
                completion(event)
            }
        }
    }
    
    public func deleteEvent(eventID: String, completion: @escaping (Bool) -> Void) {
        // Remove the event from the "events" node
        database.child("events").child(eventID).removeValue { error, _ in
            if error == nil {
                // Remove the event reference from the "user-events" node for all users
                database.child("user-events").observeSingleEvent(of: .value) { snapshot in
                    guard let userEventsDict = snapshot.value as? [String: AnyObject] else {
                        completion(false)
                        return
                    }
                    
                    for (userID, userEvents) in userEventsDict {
                        if let userEventDict = userEvents as? [String: Int], userEventDict[eventID] != nil {
                            database.child("user-events").child(userID).child(eventID).removeValue()
                        }
                    }
                    
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
}
