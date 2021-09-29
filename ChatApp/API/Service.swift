//
//  Service.swift
//  ChatApp
//
//  Created by L on 2021/8/23.
//

import Firebase

struct Service {
    
    // 獲取users資料
    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard var users = snapshot?.documents.map({ User(dictionary: $0.data())}) else { return }
            
            if let myUser = users.firstIndex(where: { $0.uid == Auth.auth().currentUser?.uid }) {
                users.remove(at: myUser)
            }
            
//            snapshot?.documents.forEach({ document in
//
//                let dictionary = document.data()
//                let user = User(dictionary: dictionary)
//
//                users.append(user)
                completion(users)
                
                //                print("DEBUG: Username is \(user.username)")
                //                print("DEBUG: Fullname is \(user.fullname)")
                
//            })
        }
    }
    
    // 獲取單個用戶
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void ) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchConversations(completion: @escaping ([Conversation]) -> Void) {
        var conversations: [Conversation] = []
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timestamp")
        
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                
                self.fetchUser(withUid: message.chatPartnerId) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
            })
        }
        
    }
    
    // 獲取用戶及訊息，然後按時間排序聊天內容，
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        var message:[Message] = []
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
        
        // 持續偵測資料是否有更新
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    message.append(Message(dictionary: dictionary))
                    completion(message)
                }
            })
        }
    }
    
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
            
            COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(user.uid).setData(data)
            
            COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUid).setData(data)
            
        }
        
    }
    
}
