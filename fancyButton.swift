//
//  fancyButton.swift
//  devslopes social
//
//  Created by Admin on 08/04/2017.
//  Copyright © 2017 Creativeios. All rights reserved.
//

import UIKit

class fancyButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 5
        layer.cornerRadius = 2
        layer.masksToBounds = true
    }

}
