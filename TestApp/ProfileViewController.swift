//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 19/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class ProfileViewController : UIViewController
{
    @IBOutlet var LoginButton : RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginButton.setTitle(NSLocalizedString("PROFILE_VIEW_LOGIN", comment: ""), for: .normal)
    }
    
    @IBAction func LoginCommand()
    {
        let storyboard = UIStoryboard(name: Constants.LoginStoryboardId, bundle: nil)
        
        let loginViewController = storyboard.instantiateViewController(withIdentifier: Constants.LoginViewControllerId)
        
        ShowModal(viewController: loginViewController)
    }
}
