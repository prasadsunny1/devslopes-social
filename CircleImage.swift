//
//  CircleImage.swift
//  devslopes social
//
//  Created by Admin on 21/04/2017.
//  Copyright © 2017 Creativeios. All rights reserved.
//

import UIKit

class CircleView:UIImageView{
    
    override func awakeFromNib() {
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 5
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = self.frame.width / 2
    }
    
}
