//
//  UserApi.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/27.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import Foundation
import Firebase

class UserApi{
    var REF_USERS = Database.database().reference().child("users")
    var REF_CRRENT_USER: DatabaseReference?{
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }
        return REF_USERS.child(currentUser.uid)
    }
   
}
