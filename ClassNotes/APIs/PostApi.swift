//
//  PostApi.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/27.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import Foundation
import Firebase

class PostApi{
    var REF_POSTS = Database.database().reference().child("posts")
    
}
