//
//  RoundedPlaceholderImageView.swift
//  TestApp
//
//  Created by Thomas Mac on 20/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class RoundedPlaceholderImageView : UIImageView
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        isUserInteractionEnabled = true
        
        backgroundColor = AppColors.GrayPlaceholderColor
        
        layer.cornerRadius = 25
        
        layer.shadowColor = AppColors.ShadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        
        layer.masksToBounds = true
    }
}
