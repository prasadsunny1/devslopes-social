//
//  CircleImage.swift
//  devslopes social
//
//  Created by Admin on 21/04/2017.
//  Copyright © 2017 Creativeios. All rights reserved.
//

import UIKit

class CircleImage:UIImageView{
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2

        clipsToBounds = true
    }
   
    
}
