//
//  RoundBtn.swift
//  devslopes social
//
//  Created by Admin on 08/04/2017.
//  Copyright © 2017 Creativeios. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = frame.height/2

        imageView?.contentMode = .scaleAspectFit
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2

        
    }
}
