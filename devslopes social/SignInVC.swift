//
//  SignInVC.swift
//  devslopes social
//
//  Created by Admin on 08/04/2017.
//  Copyright © 2017 Creativeios. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignInVC: UIViewController {
    var handle:FIRAuthStateDidChangeListenerHandle!
    override func viewDidLoad() {
        super.viewDidLoad()

        var a = Dictionary<String, Any>()
        a = ["name":"sunny","surname":"prasad"]
        let ref = FIRDatabase.database().reference()
        ref.setValue(a)
        ref.child("name").setValue(a)
    
    }
    override func viewWillAppear(_ animated: Bool) {
      handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            // ...
        
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

