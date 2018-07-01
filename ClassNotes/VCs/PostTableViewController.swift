//
//  PostTableViewController.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/28.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import UIKit
import ImagePicker

class PostTableViewController: UITableViewController, UITextFieldDelegate {

    var pageCount = 0
    @IBOutlet weak var selectedimageView: UIImageView!
    @IBOutlet weak var noteNameTextField: UITextField!
    @IBOutlet weak var noteDetailTextView: UITextView!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var post_Btn: UIButton!
    @IBOutlet weak var goPage_Btn: UIButton!
    @IBOutlet weak var backPage_Btn: UIButton!
    
    var selectedImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedimageView.image = selectedImages[pageCount]
        print("selectedImages1: \(selectedImages)")
     
        post_Btn.setTitleColor(UIColor.lightText, for: UIControlState.normal)
        post_Btn.isEnabled = false
        handleTextDidChanged()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePhotoChanged()
        handlePhotoChanged2()
    }
    
   
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
            self.view.endEditing(true)
            if (noteNameTextField.isFirstResponder) || (categoryTextField.isFirstResponder){
                
                noteNameTextField.resignFirstResponder()
                categoryTextField.resignFirstResponder()
            }
            
        }
    
    
    func handlePhotoChanged(){
        guard selectedimageView.image != selectedImages[0] else{
           return backPage_Btn.isEnabled = false
        }
        backPage_Btn.isEnabled = true
    }
    
    func handlePhotoChanged2(){
        guard selectedimageView.image != selectedImages.last else{
            return goPage_Btn.isEnabled = false
        }
        goPage_Btn.isEnabled = true
    }
    
    func handleTextDidChanged(){
        noteNameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        categoryTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange(){
        guard let noteName = noteNameTextField.text, !noteName.isEmpty, let category = categoryTextField.text, !category.isEmpty else{
            
            post_Btn.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            post_Btn.isEnabled = false
            return
        }
        post_Btn.setTitleColor(.white, for: UIControlState.normal)
        post_Btn.isEnabled = true
    }
    
   
    @IBAction func canel_touchUpInside(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func goPage_touchUpInside(_ sender: Any) {
        pageCount += 1
        selectedimageView.image = selectedImages[pageCount]
        handlePhotoChanged()
        handlePhotoChanged2()
    }
    
    @IBAction func backPage_touchUpInside(_ sender: Any) {
        pageCount -= 1
        selectedimageView.image = selectedImages[pageCount]
        handlePhotoChanged()
        handlePhotoChanged2()
    }
    
    
    
    @IBAction func post_touchUpInside(_ sender: Any) {
        
    }
  
    
}


