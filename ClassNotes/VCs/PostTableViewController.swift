//
//  PostTableViewController.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/28.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import UIKit
import ImagePicker
import ProgressHUD
import Firebase
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
    
    
    var photoStringDelegate:String?
   
 
    
    @IBAction func post_touchUpInside(_ sender: Any) {
        //データをまとめてデータベースに投げる処理
        ProgressHUD.show("Waiting...", interaction: false)
        for selectedImage in selectedImages {
              print("selectedImage times: \(selectedImage)")
            
            if selectedImage == selectedImages.first{
                if  let imageData = UIImageJPEGRepresentation(selectedImage, 0.1) {
                    print("selectedImage[0]: \(selectedImage)")
                    let photoIdString = NSUUID().uuidString
                     print("photoIdString[0]: \(photoIdString)")
                    photoStringDelegate = photoIdString
                    let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("posts").child("\(photoIdString)").child(photoIdString)
               sendDataTostorage(storageRef: storageRef, imageData: imageData)
                    
                }
            }

            if selectedImage != selectedImages.first{
                if  let imageData = UIImageJPEGRepresentation(selectedImage, 0.1) {
                    print("selectedImage[other]: \(selectedImage)")
                    let photoIdString = NSUUID().uuidString
                    let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("posts").child(photoStringDelegate!).child(photoIdString)
                    print("photoStringDelegate: \(photoStringDelegate)")
               sendDataTostorage2(storageRef: storageRef, imageData: imageData)
            }
       }
            
            
    }
    
  }
    
    func sendDataTostorage(storageRef:StorageReference,imageData:Data){
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil{
                return
            }
            storageRef.downloadURL(completion: { (url, error) in
                if error != nil{
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                if let mainPhotoUrl = url?.absoluteString {
                    self.sendToDatabase(mainPhotoUrl:mainPhotoUrl)
                }
            })
        }
    }

    func sendDataTostorage2(storageRef:StorageReference,imageData:Data){
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil{
                return
            }
            storageRef.downloadURL(completion: { (url, error) in
                if error != nil{
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                if let subPhotoUrl = url?.absoluteString {
                    self.sendToDatabase(subPhotoUrl:subPhotoUrl)
                }
            })
        }
    }

  func sendToDatabase(mainPhotoUrl:String? = nil,subPhotoUrl:String? = nil){
        let newPostId = Api.Post.REF_POSTS.childByAutoId().key
        let newPostReference = Api.Post.REF_POSTS.child(newPostId)
     
        
        
          var dict = [:] as [String:Any]
        if let mainPhotoUrl = mainPhotoUrl {
            dict["mainPhotoUrl"] = mainPhotoUrl
            
        }
        if let subPhotoUrl = subPhotoUrl{
            dict["subPhotoUrl"] = subPhotoUrl
        }
        //dictにsubPhotoUrlの値をぶち込む
        
        newPostReference.setValue(dict, withCompletionBlock: {
            (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
    })
    }
    
    
    
    
    
}
    
    



//    func sendToDatabase2(subPhotoUrl:String? = nil){
//        let newPostId = Api.Post.REF_POSTS.childByAutoId().key
//        let newPostReference = Api.Post.REF_POSTS.child(newPostId)
//
//        //newPostIdはsendToDatabaseから取ってくる。
//
//        var dict = [:] as [String:Any]
//
//        if let subPhotoUrl = subPhotoUrl{
//            dict["subPhotoUrl"] = subPhotoUrl
//        }
//        //dictにsubPhotoUrlの値をぶち込む
//
//        
//
//        newPostReference.setValue(dict, withCompletionBlock: {
//            (error, ref) in
//            if error != nil {
//                ProgressHUD.showError(error!.localizedDescription)
//                return
//            }
//            ProgressHUD.showSuccess("Success")
//        })
//    }
//





