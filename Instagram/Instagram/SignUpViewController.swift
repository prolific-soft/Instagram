//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Chidi Emeh on 7/5/17.
//  Copyright © 2017 Chilly Bean. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        profileImage.layer.cornerRadius = 15
        profileImage.clipsToBounds = true
        profileImage.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectedProfileImageView))
        profileImage.addGestureRecognizer(tapGesture)
        
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.tintColor = .white
        usernameTextField.textColor = .white
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!
            , attributes: [NSForegroundColorAttributeName: UIColor(white:1.0, alpha: 0.6)])
        let bottomLayerUsername = CALayer()
        bottomLayerUsername.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerUsername.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1).cgColor
        
        usernameTextField.layer.addSublayer(bottomLayerUsername)
        
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = .white
        emailTextField.textColor = .white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!
            , attributes: [NSForegroundColorAttributeName: UIColor(white:1.0, alpha: 0.6)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1).cgColor
        
        emailTextField.layer.addSublayer(bottomLayerEmail)
        
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.tintColor = .white
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!
            , attributes: [NSForegroundColorAttributeName: UIColor(white:1.0, alpha: 0.6)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1).cgColor
        
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        handleTextField()
        signUpButton.isEnabled = false
        
    }
    
    
    //Checks for empty textfield and disables signup button
    func handleTextField(){
        usernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: .editingChanged)
    }
    
    func textFieldDidChange(){
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else{
                
                signUpButton.setTitleColor(UIColor.lightText, for: .normal)
                signUpButton.isEnabled = false
                return
        }
        
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.isEnabled = true
    }
    
    //Handle selection of photo for Profile Image
    func handleSelectedProfileImageView(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signUpBtn_TouchUpInside(_ sender: Any){
        
        if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            
            AuthService.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, imageData: imageData, onSuccess: {
                self.performSegue(withIdentifier: "signUpToTabbarVC", sender: nil)
            }, onError: {(errorString) in
                print(errorString!)
            })
        }else {
            print("Profile Image can't be empty")
        }
    }
    
    
    
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}//End SignUpVC



extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            profileImage.image = image
        }
        
        print("did finish picking image")
        //profileImage.image = infoPhoto
        
        dismiss(animated: true, completion: nil)
    }
    
    
}



























