//
//  Authservice.swift
//  ChatApp
//
//  Created by L on 2021/8/22.
//

import UIKit
import Firebase

struct RegisterCredentials {
    let profileImage: UIImage
    let email: String
    let password: String
    let fullname: String
    let username: String
}


class Authservice {
    static let shared = Authservice()
    
    //自訂completion
    func Userlogin(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            if let error = error {
//                print("DEBUG: Failed to log in with error : \(error.localizedDescription)")
//                completion!(error)
//                return
//            }
//
//            print("DEBUG: User login successful")
//
//            //登入後關閉
//            //self.dismiss(animated: true, completion: nil)
//
//        }
//        print("DEBUG: Handle login here..")
    }
    
    func creatUser(credentials: RegisterCredentials, completion: ((Error?) -> Void)?) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "profile_images/\(filename)")
        // 上傳圖片
        ref.putData(imageData, metadata: nil) { meta, error in
            if let error = error {
                print("DEBUG: Failed to upload image with error : \(error.localizedDescription)")
                completion!(error)
                return
            }
            
            ref.downloadURL { url, erro in
                // 圖片網址
                guard let profileImageUrl = url?.absoluteString else { return }
                // 創建用戶
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                    if let error = error {
                        print("DEBUG: Failed to creat user with error : \(error.localizedDescription)")
                        completion!(error)
                        return
                    }
                    
                    // result call back
                    guard let uid = result?.user.uid else { return }
                    let data = ["profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "email": credentials.email,
                                "fullname": credentials.fullname,
                                "username": credentials.username] as [String : Any]
                    
                    // 傳入data，並訪問數據庫，創建數據庫users
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                    
                    // 註冊完關閉，並顯示用戶介面。
                    // self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
