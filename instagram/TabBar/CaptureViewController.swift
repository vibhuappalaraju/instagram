//
//  CaptureViewController.swift
//  instagram
//
//  Created by Vibhu Appalaraju on 10/3/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit

class CaptureViewController: ViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var instagramImage: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instagramImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
    instagramImage.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapGesture() {
        if instagramImage.image == UIImage(named:"image_placeholder"){
//            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//                let imagePicker = UIImagePickerController()
//                imagePicker.delegate = self
//                imagePicker.sourceType = .photoLibrary;
//                imagePicker.allowsEditing = true
//                self.present(imagePicker, animated: true, completion: nil)
//            }
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                print("Camera is available 📸")
                let vc = UIImagePickerController()
                vc.delegate = self
                vc.allowsEditing = true
                vc.sourceType = UIImagePickerControllerSourceType.camera
                vc.sourceType = .camera
                self.present(vc, animated: true, completion: nil)
            } else {
                print("Camera 🚫 available so we will use photo library instead")
                //vc.sourceType = .photoLibrary
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
           
            
        }
    }
    
   

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
//        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
       
            instagramImage.image = editedImage
      
        
   
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onSubmitPicture(_ sender: Any) {
        Post.postUserImage(image: instagramImage.image, withCaption: captionTextField.text ){
            (success: Bool, error:Error?)
            in print(error?.localizedDescription as Any)
        }
        instagramImage.image = UIImage(named:"image_placeholder")
        captionTextField.text = ""
    }
    
}
