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


class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var addImage: UIImageView!
  

    var posts = [Post]()
    var imagePicker:UIImagePickerController!
    
    static var imageCache:NSCache<NSString,UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
                print(snapshot.value ?? "default Value Hit")
            if let snap = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snap{
                    print("snap\(snap)")
                    if let postDict = snap.value as? Dictionary<String,AnyObject>{
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
        
        
    }

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            addImage.image = image
        }else{
            print("invalid, image was selected")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        print(post.imgURL)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell{
            
            if let image = FeedVC.imageCache.object(forKey: post.imgURL as NSString){
                print("loaded image from cache")
                cell.configureCell(post: posts[indexPath.row], img: image)
                return cell
            }else{
                
                cell.configureCell(post: post)
                return cell
            }
            
        }else{
            return PostCell()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func signOUt(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("signedOut")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }

}
