//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 19/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class ProfileViewController : UIViewController
{
    @IBOutlet var LogoutButton : RoundedButton!
    @IBOutlet var UsernameTextField : ACFloatingTextfield!
    @IBOutlet var PhoneNumberTextField : ACFloatingTextfield!
    @IBOutlet var EmailTextField : ACFloatingTextfield!
    
    @IBOutlet var LoginButton : RoundedButton!
    
    private var profileModel : ProfileModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewElements()
        
        showOrHiddenViewElements()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        showOrHiddenViewElements()
    }
    
    private func setViewElements()
    {
        title = NSLocalizedString("PROFILE_VIEW_TITLE", comment: "")
        
        LoginButton.setTitle(NSLocalizedString("PROFILE_VIEW_LOGIN", comment: ""), for: .normal)
        LogoutButton.setTitle(NSLocalizedString("PROFILE_VIEW_LOGOUT", comment: ""), for: .normal)
        
        UsernameTextField.placeholder = NSLocalizedString("PROFILE_VIEW_USERNAME", comment: "")
        UsernameTextField.applyBaseStyle()
        UsernameTextField.isEnabled = false
        
        PhoneNumberTextField.placeholder = NSLocalizedString("PROFILE_VIEW_PHONE_NUMBER", comment: "")
        PhoneNumberTextField.applyBaseStyle()
        PhoneNumberTextField.isEnabled = false
        
        EmailTextField.placeholder = NSLocalizedString("PROFILE_VIEW_EMAIL", comment: "")
        EmailTextField.applyBaseStyle()
        EmailTextField.isEnabled = false
    }
    
    private func showOrHiddenViewElements()
    {
        let userDefaults = CacheHelper.getUserDefaults()
        
        let isConnected = userDefaults.bool(forKey: Constants.IsConnectedCacheKey)
        
        LoginButton.isHidden = isConnected
        
        LogoutButton.isHidden = !isConnected
        UsernameTextField.isHidden = !isConnected
        PhoneNumberTextField.isHidden = !isConnected
        EmailTextField.isHidden = !isConnected
        
        if isConnected
        {
            setProfileModel()
        }
    }
    
    private func setProfileModel()
    {
        let userDefaults = CacheHelper.getUserDefaults()
        
        if profileModel == nil
        {
            profileModel = ProfileModel(
                username: userDefaults.string(forKey: Constants.UsernameCacheKey)!,
                email: userDefaults.string(forKey: Constants.EmailCacheKey)!,
                phoneNumber: userDefaults.string(forKey: Constants.PhoneNumberCacheKey)!)
            
            return
        }
        
        profileModel.Username = userDefaults.string(forKey: Constants.UsernameCacheKey)
        profileModel.Email = userDefaults.string(forKey: Constants.EmailCacheKey)
        profileModel.PhoneNumber = userDefaults.string(forKey: Constants.PhoneNumberCacheKey)
        
        UsernameTextField.text = profileModel.Username
        EmailTextField.text = profileModel.Email
        PhoneNumberTextField.text = profileModel.PhoneNumber
    }
    
    @IBAction func LoginCommand()
    {
        let storyboard = UIStoryboard(name: Constants.LoginStoryboardId, bundle: nil)
        
        let loginViewController = storyboard.instantiateViewController(withIdentifier: Constants.LoginViewControllerId)
        
        ShowModal(viewController: loginViewController)
    }
    
    @IBAction func LogoutCommand()
    {
        let userDefaults = CacheHelper.getUserDefaults()
        
        userDefaults.set(false, forKey: Constants.IsConnectedCacheKey)
        
        userDefaults.synchronize()
        
        showOrHiddenViewElements()
    }
}
