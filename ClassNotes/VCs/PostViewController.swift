//
//  PostViewController.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/27.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import UIKit
import ImagePicker
class PostViewController: UIViewController,ImagePickerDelegate{
   
    var selectedImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 42/255, green:245/255, blue: 152/255, alpha:1)

    }
    
    @IBAction func openCamera_touchUpInside(_ sender: Any) {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 4
        present(imagePickerController, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Post_PostTableSegue"{
            let PostTableVC = segue.destination as! PostTableViewController
            PostTableVC.selectedImages = self.selectedImages
            
        }
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        selectedImages = images
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "Post_PostTableSegue", sender: nil)
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true,completion: nil)
    }
   
}
