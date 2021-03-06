//
//  AuthService.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/27.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    
    static func signIn(email:String, password:String, onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?)->Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    
    static func signUp(username:String, email:String, password:String, imageData:Data, onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?)->Void){
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            let user = Auth.auth().currentUser
            let uid = user?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF ).child("profile_image").child(uid!)
    
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    return
                }
                //error: let profileImageUrl = metadata?.downloadURL()?.absoluteString
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    print("URL文字列の送信に成功しました。")
                    let profileImageUrl = url!.absoluteString
                    self.setInfomation(profileImageUrl: profileImageUrl, username: username, email:  email, uid: uid!, onSuccess: onSuccess)
                })
            })
        })
    }
    
    static func setInfomation(profileImageUrl:String, username:String, email:String, uid:String, onSuccess:@escaping () -> Void){
        let ref = Database.database().reference()
        let userReference = ref.child("users")
        let newuserReference = userReference.child(uid)
        //newuserReference = Database.database().reference().child("users").child(uid!)
        
        newuserReference.setValue(["username": username,"username_lowercase":username.lowercased(), "email":email, "profileImageUrl":profileImageUrl])
        onSuccess()
    }
    
    static func logOut(onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?)->Void){
        do{
            try Auth.auth().signOut()
            onSuccess()
        }catch let logerror {
            print(logerror.localizedDescription)
        }
    }
}
