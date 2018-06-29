//
//  SendDataService.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/27.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import Foundation
import Firebase
import ProgressHUD
class SendDataService{
    
    static func sendDataToDatabase(photoUrl:String,caption: String,onSuccess: @escaping  () -> Void ){
        let newPostId = Api.Post.REF_POSTS.childByAutoId().key
        let newpostReference = Api.Post.REF_POSTS.child(newPostId)
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let currentUserId = currentUser.uid
        var dict = ["uid": currentUserId,"photoUrl": photoUrl,"caption": caption] as [String : Any]
        
        newpostReference.setValue(dict, withCompletionBlock: { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            ProgressHUD.showSuccess("Success")
            onSuccess()
        })
        
        
    }
}
