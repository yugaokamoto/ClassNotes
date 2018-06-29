//
//  PostTableViewController.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/28.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {
    @IBOutlet weak var noteNameTextField: UITextField!
    
    @IBOutlet weak var noteDetailTextView: UITextView!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var post_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func post_touchUpInside(_ sender: Any) {
        
    }
    
    @IBAction func addPhoto_Btn(_ sender: Any) {
        print("ghghghghg")
    }
    
    
}
