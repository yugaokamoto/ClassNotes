//
//  HomeViewController.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/27.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import UIKit
import ProgressHUD
import Firebase
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("現在のユーザ\(Auth.auth().currentUser?.uid)")
    }

    
    @IBAction func logOut_touchUpInside(_ sender: Any) {
        AuthService.logOut(onSuccess: {
            let storyboard = UIStoryboard(name: "Start", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(signInVC, animated: true, completion: nil)
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
}
