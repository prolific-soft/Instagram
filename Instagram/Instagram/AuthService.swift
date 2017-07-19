//
//  AuthService.swift
//  Instagram
//
//  Created by Chidi Emeh on 7/18/17.
//  Copyright © 2017 Chilly Bean. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AuthService {
    
    
    //Handles sign In
    static func signIn(email: String, password: String, onSuccess: @escaping ()-> Void, onError: @escaping (_ errorMessage: String?)-> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            onSuccess()
            
        })
    }
    
    
    //Handles sign Up
    static func signUp(username: String, email: String, password: String, imageData:Data, onSuccess: @escaping ()-> Void, onError: @escaping (_ errorMessage: String?)-> Void){
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user : User?, error: Error?) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            let uid = user?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("profile_image").child(uid!)
            
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                let profileImageUrl = metadata?.downloadURL()?.absoluteString
                self.setUserInformation(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid!, onSuccess: onSuccess)
            })
        })
        
    }
    
    static func setUserInformation(profileImageUrl: String, username: String, email:String, uid:String, onSuccess: @escaping ()-> Void ) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        //print(usersReference.description())
        
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": username, "email": email, "profileImageUrl" : profileImageUrl])
        onSuccess()
    }
    
    
    
    
}










