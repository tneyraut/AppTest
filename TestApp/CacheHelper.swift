//
//  CacheHelper.swift
//  TestApp
//
//  Created by Thomas Mac on 20/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class CacheHelper
{
    private static let userDefaults = UserDefaults()
    
    static func getUserDefaults() -> UserDefaults
    {
        return userDefaults
    }
}
