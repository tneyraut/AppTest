//
//  EditProfileViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 21/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class EditProfileViewController : BaseViewController
{
    @IBOutlet var UsernameTextField : ACFloatingTextfield!
    @IBOutlet var EmailTextField : ACFloatingTextfield!
    @IBOutlet var PhoneNumberTextField : ACFloatingTextfield!
    
    var editProfileModel : EditProfileModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setViewElement()
        
        hideKeyboard()
        
        addCancelButton()
    }
    
    private func setViewElement()
    {
        title = NSLocalizedString("EDIT_PROFILE_VIEW_TITLE", comment: "")
        
        UsernameTextField.placeholder = NSLocalizedString("EDIT_PROFILE_VIEW_USERNAME", comment: "")
        UsernameTextField.text = editProfileModel.Username
        UsernameTextField.applyBaseStyle()
        
        PhoneNumberTextField.placeholder = NSLocalizedString("EDIT_PROFILE_VIEW_PHONE_NUMBER", comment: "")
        PhoneNumberTextField.text = editProfileModel.PhoneNumber
        PhoneNumberTextField.applyBaseStyle()
        
        EmailTextField.placeholder = NSLocalizedString("EDIT_PROFILE_VIEW_EMAIL", comment: "")
        EmailTextField.text = editProfileModel.Email
        EmailTextField.applyBaseStyle()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("SHARE_SAVE", comment: ""),
            style: .done,
            target: self,
            action: #selector(saveCommand))
    }
    
    @objc private func saveCommand()
    {
        if (UsernameTextField.text?.isEmpty)! || (EmailTextField.text?.isEmpty)! || (PhoneNumberTextField.text?.isEmpty)!
        {
            let alertController = UIAlertController(title: nil, message: NSLocalizedString("EDIT_PROFILE_VIEW_ERROR_MESSAGE", comment: ""), preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("SHARE_OK", comment: ""), style: .default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
            if (UsernameTextField.text?.isEmpty)!
            {
                UsernameTextField.showError()
            }
            if (EmailTextField.text?.isEmpty)!
            {
                EmailTextField.showError()
            }
            if (PhoneNumberTextField.text?.isEmpty)!
            {
                PhoneNumberTextField.showError()
            }
            
            return
        }
        
        let userDefaults = CacheHelper.getUserDefaults()
        
        userDefaults.set(UsernameTextField.text, forKey: Constants.UsernameCacheKey)
        userDefaults.set(EmailTextField.text, forKey: Constants.EmailCacheKey)
        userDefaults.set(PhoneNumberTextField.text, forKey: Constants.PhoneNumberCacheKey)
        
        userDefaults.synchronize()
        
        closeModal()
    }
}
