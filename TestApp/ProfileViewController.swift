//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 19/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class ProfileViewController : BaseViewController
{
    @IBOutlet var ChangePasswordButton : RoundedButton!
    @IBOutlet var LogoutButton : RoundedButton!
    @IBOutlet var UsernameTextField : ACFloatingTextfield!
    @IBOutlet var PhoneNumberTextField : ACFloatingTextfield!
    @IBOutlet var EmailTextField : ACFloatingTextfield!
    @IBOutlet var LocationTextField : ACFloatingTextfield!
    
    @IBOutlet var LoginButton : RoundedButton!
    
    @IBOutlet var EditButton : UIBarButtonItem!
    
    private var profileModel : ProfileModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewElements()
        
        showOrHiddenViewElements()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateProfileInfoNotificationRecieved), name: Notification.Name.init(Constants.UpdateProfileInfoMessage), object: nil)
    }
    
    @objc private func UpdateProfileInfoNotificationRecieved(notification: NSNotification)
    {
        showOrHiddenViewElements()
    }
    
    private func setViewElements()
    {
        navigationController?.applyBaseNavigationBarStyle()
        
        title = NSLocalizedString("PROFILE_VIEW_TITLE", comment: "")
        
        LoginButton.setTitle(NSLocalizedString("PROFILE_VIEW_LOGIN", comment: ""), for: .normal)
        LogoutButton.setTitle(NSLocalizedString("PROFILE_VIEW_LOGOUT", comment: ""), for: .normal)
        ChangePasswordButton.setTitle(NSLocalizedString("PROFILE_VIEW_CHANGE_PASSWORD", comment: ""), for: .normal)
        
        UsernameTextField.placeholder = NSLocalizedString("PROFILE_VIEW_USERNAME", comment: "")
        UsernameTextField.applyBaseStyle()
        UsernameTextField.isEnabled = false
        
        PhoneNumberTextField.placeholder = NSLocalizedString("PROFILE_VIEW_PHONE_NUMBER", comment: "")
        PhoneNumberTextField.applyBaseStyle()
        PhoneNumberTextField.isEnabled = false
        
        EmailTextField.placeholder = NSLocalizedString("PROFILE_VIEW_EMAIL", comment: "")
        EmailTextField.applyBaseStyle()
        EmailTextField.isEnabled = false
        
        LocationTextField.placeholder = NSLocalizedString("PROFILE_VIEW_LOCATION", comment: "")
        LocationTextField.applyBaseStyle()
        LocationTextField.isEnabled = false
        
        EditButton.title = NSLocalizedString("PROFILE_VIEW_EDIT", comment: "")
        EditButton.tintColor = AppColors.WhiteColor
    }
    
    private func showOrHiddenViewElements()
    {
        let userDefaults = CacheHelper.getUserDefaults()
        
        let isConnected = userDefaults.bool(forKey: Constants.IsConnectedCacheKey)
        
        LoginButton.isHidden = isConnected
        
        ChangePasswordButton.isHidden = !isConnected
        LogoutButton.isHidden = !isConnected
        UsernameTextField.isHidden = !isConnected
        PhoneNumberTextField.isHidden = !isConnected
        EmailTextField.isHidden = !isConnected
        LocationTextField.isHidden = !isConnected
        
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
                phoneNumber: userDefaults.string(forKey: Constants.PhoneNumberCacheKey)!,
                location: userDefaults.string(forKey: Constants.LocationCacheKey)!)
        }
        else
        {
            profileModel.Username = userDefaults.string(forKey: Constants.UsernameCacheKey)
            profileModel.Email = userDefaults.string(forKey: Constants.EmailCacheKey)
            profileModel.PhoneNumber = userDefaults.string(forKey: Constants.PhoneNumberCacheKey)
            profileModel.Location = userDefaults.string(forKey: Constants.LocationCacheKey)
        }
        
        UsernameTextField.text = profileModel.Username
        EmailTextField.text = profileModel.Email
        PhoneNumberTextField.text = profileModel.PhoneNumber
        LocationTextField.text = profileModel.Location
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
    
    @IBAction func EditProfileCommand()
    {
        let storyboard = UIStoryboard(name: Constants.MenuStoryboardId, bundle: nil)
        
        let editProfileViewController = storyboard.instantiateViewController(withIdentifier: Constants.EditProfileViewControllerId) as! EditProfileViewController
        
        editProfileViewController.editProfileModel = EditProfileModel(
            username: profileModel.Username!,
            email: profileModel.Email!,
            phoneNumber: profileModel.PhoneNumber!,
            location: profileModel.Location!)
        
        ShowModal(viewController: editProfileViewController)
    }
    
    @IBAction func ChangePasswordCommand()
    {
        let storyboard = UIStoryboard(name: Constants.MenuStoryboardId, bundle: nil)
        
        let changePasswordViewController = storyboard.instantiateViewController(withIdentifier: Constants.ChangePasswordViewControllerId)
        
        ShowModal(viewController: changePasswordViewController)
    }
}
