//
//  HomeViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 19/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class HomeViewController : BaseViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setViewElement()
    }
    
    private func setViewElement()
    {
        navigationController?.applyBaseNavigationBarStyle()
    }
}
