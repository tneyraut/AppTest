//
//  NavigationControllerExtension.swift
//  TestApp
//
//  Created by Thomas Mac on 20/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

extension UINavigationController
{
    func applyBaseNavigationBarStyle()
    {
        navigationBar.barTintColor = AppColors.MainColor
        
        navigationBar.tintColor = UIColor.white
        
        let shadow = NSShadow()
        shadow.shadowColor = AppColors.ShadowColor
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        
        navigationBar.titleTextAttributes = NSDictionary(objects: [AppColors.NavigationTextColor, shadow, UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forKeys: [NSForegroundColorAttributeName as NSCopying, NSShadowAttributeName as NSCopying, NSFontAttributeName as NSCopying]) as? [String : AnyObject]
    }
}
