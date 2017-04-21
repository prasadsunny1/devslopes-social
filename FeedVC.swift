//
//  FeedVC.swift
//  devslopes social
//
//  Created by Admin on 20/04/2017.
//  Copyright © 2017 Creativeios. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView:UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
                print(snapshot.value ?? "default Value Hit")
        })
        
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "postcell") as! PostCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    @IBAction func signOUt(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("signedOut")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }

}
