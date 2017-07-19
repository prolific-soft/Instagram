//
//  HomeViewController.swift
//  Instagram
//
//  Created by Chidi Emeh on 7/5/17.
//  Copyright © 2017 Chilly Bean. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //Signs user out and switches to the sign in screen
    @IBAction func logout_TouchUpInside(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
       let storyboard = UIStoryboard(name: "Start", bundle: nil)
       let signInVC =  storyboard.instantiateViewController(withIdentifier: "SignInViewController")
    self.present(signInVC, animated: true, completion: nil)
       
    }


}
