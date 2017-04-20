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
import SwiftKeychainWrapper


class SignInVC: UIViewController {
    var handle:FIRAuthStateDidChangeListenerHandle!
    
    @IBOutlet weak var emailAddress: FancyTextField!
    
    @IBOutlet weak var password: FancyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

//        var a = Dictionary<String, Any>()
//        a = ["name":"sunny","surname":"prasad"]
//        let ref = FIRDatabase.database().reference()
//        ref.setValue(a)
//        ref.child("name").setValue(a)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            print("id found in keychain")
            performSegue(withIdentifier: "home", sender: nil)
      
        }

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
                if let user = user{
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }
    @IBAction func EmailLoginTapped(_ sender: fancyButton) {
        if let email = emailAddress.text,let pwd = password.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, err) in
                
                if err == nil{
                    print("success: \(email) and \(pwd) authenticate with firebase via email")
                    if let user = user{
                        self.completeSignIn(id: user.uid)

                    }
                }
                else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (usr, errr) in
                        if errr != nil{
                            print("some error creating a user \(String(describing: errr))" )
                        }else{
                            print("user created successfully")
                            print("user \(String(describing: usr))")
                            if let usr = usr {
                                self.completeSignIn(id: usr.uid)

                            }
                        }
                    })
                }
                
            })
        }
        
        
    }

    func completeSignIn(id : String ){
       let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("data saved to key chain : \(keyChainResult)")
        performSegue(withIdentifier: "home", sender: nil)

    }
}

