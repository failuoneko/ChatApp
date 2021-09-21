//
//  Service.swift
//  ChatApp
//
//  Created by L on 2021/8/23.
//

import Firebase

struct Service {
    
    static func fetchUser(completion: @escaping ([User]) -> Void) {
        
        var users: [User] = []
        
        //獲取users資料
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                users.append(user)
                completion(users)
//
//                print("DEBUG: Username is \(user.username)")
//                print("DEBUG: Fullname is \(user.fullname)")

            })
        }
    }
}
