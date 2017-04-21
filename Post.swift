//
//  Post.swift
//  devslopes social
//
//  Created by Admin on 21/04/2017.
//  Copyright © 2017 Creativeios. All rights reserved.
//

import Foundation
class Post{
    private var _caption:String!
    private var _imgURL:String!
    private var _postKey:String!
    private var _likes:Int!
    
    var caption:String{
        return _caption
    }
    
    var imgURL:String{
        return _imgURL
    }
    
    var postKey:String{
        return _postKey
    }
    
    var likes:Int{
        return _likes
    }
    
    init(caption:String,imgURL:String,likes:Int) {
        self._caption = caption
        self._imgURL = imgURL
        self._likes = likes
    }

    init(postKey:String,postData:Dictionary<String,AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String{
            self._caption = caption
        }
        
        if let imageUrl = postData["imgURL"] as? String{
            self._imgURL = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        
    }
    



}
