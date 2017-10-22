//
//  RoundedButton.swift
//  TestApp
//
//  Created by Thomas Mac on 19/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class RoundedButton : UIButton
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        layer.borderColor = AppColors.MainColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 23
        
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.8
        
        self.setTitleColor(AppColors.WhiteColor, for: .normal)
        
        self.setTitleColor(AppColors.MainColor, for: .disabled)
        
        setIsEnabledAndBackgroundColor(enabled: isEnabled)
    }
    
    func setIsEnabledAndBackgroundColor(enabled: Bool)
    {
        self.isEnabled = enabled
        
        self.backgroundColor = enabled ? AppColors.MainColor : AppColors.WhiteColor
    }
}
