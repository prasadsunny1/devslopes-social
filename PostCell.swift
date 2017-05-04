//
//  PostCell.swift
//  devslopes social
//
//  Created by Admin on 21/04/2017.
//  Copyright © 2017 Creativeios. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg:UIImageView!
    @IBOutlet weak var usernameLbl:UILabel!
    @IBOutlet weak var postImg:UIImageView!
    @IBOutlet weak var caption:UITextView!
    @IBOutlet weak var likesLbl:UILabel!
    
    var post :Post!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post :Post, img:UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
     
        if img != nil {
    
            self.postImg.image = img
    
        }
        else{
            
            let ref = FIRStorage.storage().reference(forURL: post.imgURL)
            ref.data(withMaxSize: 2*1024*1024, completion: { (data, error) in
              
                if error != nil{
                    print("unable to download image from firebase")
                }else{
                    print("image downloaded from Firebase storage")
                    if let imageData  = data{
                        if let image = UIImage(data: imageData){
                            self.postImg.image = image
                            FeedVC.imageCache.setObject(image, forKey: post.imgURL as NSString)
                        }
                    }
                }
            
            })
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
