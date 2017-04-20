//
//  SignInVC.swift
//  devslopes social
//
//  Created by Admin on 08/04/2017.
//  Copyright © 2017 Creativeios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit


class SignInVC: UIViewController {
    var handle:FIRAuthStateDidChangeListenerHandle!
    override func viewDidLoad() {
        super.viewDidLoad()

//        var a = Dictionary<String, Any>()
//        a = ["name":"sunny","surname":"prasad"]
//        let ref = FIRDatabase.database().reference()
//        ref.setValue(a)
//        ref.child("name").setValue(a)
    
    }
    override func viewWillAppear(_ animated: Bool) {
      handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            // ...
        
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)

    }

    @IBAction func FacebookButton(_ sender: RoundBtn) {

    let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, err) in
            if err != nil{
                print("unable to authenticate with facebook \(String(describing: err))")
                
                
            }
            else if result?.isCancelled == true{
                print("user cancled the facebook login")
                
            }
            else{
                print("authenticated successfully with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthenticate(credential)
            }
        }
    }
    
    
    func firebaseAuthenticate(_ credential : FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, err) in
            if err != nil {
                print("unable to authenticate with Firebase \(String(describing: err))")
            }else{
                print("successfull authenticated with firebase")
            }
        })
    }

}

