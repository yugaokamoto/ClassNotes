//
//  SignInViewController.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/26.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import UIKit
import ProgressHUD
import Firebase
class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signIn_Btn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    //背景色の変更
        let topColor = UIColor(red: 42/255, green:245/255, blue: 152/255, alpha:1)
        let bottomColor = UIColor(red:8/255, green:174/255, blue:234/255, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            performSegue(withIdentifier: "signInToTabBar", sender: nil)
        }
    }
    
    func handleTextField(){
        emailTextField.addTarget(self, action: #selector(SignInViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignInViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        
    }
    
    @objc func textFieldDidChange(){
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else{
            
            signIn_Btn.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            signIn_Btn.isEnabled = false
            return
        }
        signIn_Btn.setTitleColor(.white, for: UIControlState.normal)
        signIn_Btn.isEnabled = true
  }
    
    @IBAction func signIn_touchUpInside(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Wating for...", interaction: false)
        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess:{
            ProgressHUD.showSuccess("Success")
            self.performSegue(withIdentifier: "signInToTabBar", sender: nil)
        }, onError:{error in
            ProgressHUD.showError(error!)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
