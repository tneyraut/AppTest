//
//  RoundedView.swift
//  TestApp
//
//  Created by Thomas Mac on 22/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class RoundedView : UIView
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        layer.cornerRadius = 25
        
        layer.borderColor = AppColors.ShadowColor.cgColor
        layer.borderWidth = 2.5
        
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.8
        
        layer.masksToBounds = true
    }
}
