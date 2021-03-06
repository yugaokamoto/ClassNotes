//
//  SignUpViewController.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/26.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUp_Btn: UIButton!
    
    var selectedImage: UIImage!
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectProfileView))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        signUp_Btn.isEnabled = false
        handleTextField()
    }
    
    func handleTextField(){
        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        
    }
    
    @objc func textFieldDidChange(){
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else{
            
            signUp_Btn.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            signUp_Btn.isEnabled = false
            return
        }
        signUp_Btn.setTitleColor(.white, for: UIControlState.normal)
        signUp_Btn.isEnabled = true
    }
    
    @objc func handleSelectProfileView(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func dismiss_touchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUp_touchUpInside(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Wating for...", interaction: false)
        if let profileImage = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImage, 0.1){
            AuthService.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, imageData: imageData, onSuccess: {
                ProgressHUD.showSuccess("Success")
                self.performSegue(withIdentifier: "signUpToTabBar", sender: nil)
            }, onError: { (errorString) in
                ProgressHUD.showError(errorString!)
            })
        }else{
            ProgressHUD.showError("画像を選択してください。")
        }
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("did Finish Picking Media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = image
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

