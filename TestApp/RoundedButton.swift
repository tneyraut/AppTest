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
        
        self.layer.borderColor = AppColors.ButtonColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 23
        
        self.layer.shadowColor = AppColors.ShadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        self.setTitleColor(AppColors.ButtonTextColor, for: .normal)
        
        self.setTitleColor(AppColors.ButtonColor, for: .disabled)
        
        setIsEnabledAndBackgroundColor(enabled: isEnabled)
    }
    
    func setIsEnabledAndBackgroundColor(enabled: Bool)
    {
        self.isEnabled = enabled
        
        self.backgroundColor = enabled ? AppColors.ButtonColor : AppColors.WhiteColor
    }
}
