//
//  EditProfileViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 21/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class EditProfileViewController : BaseViewController, UITextFieldDelegate
{
    @IBOutlet var UsernameTextField : ACFloatingTextfield!
    @IBOutlet var EmailTextField : ACFloatingTextfield!
    @IBOutlet var PhoneNumberTextField : ACFloatingTextfield!
    @IBOutlet var LocationTextField : ACFloatingTextfield!
    
    @IBOutlet var UpdateLocationButton : UIButton!
    
    var editProfileModel : EditProfileModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setViewElement()
        
        hideKeyboard()
        
        addCancelButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateLocationNotificationRecieved), name: Notification.Name.init(Constants.UpdateLocationMessage), object: nil)
    }
    
    private func setViewElement()
    {
        title = NSLocalizedString("EDIT_PROFILE_VIEW_TITLE", comment: "")
        
        UsernameTextField.placeholder = NSLocalizedString("EDIT_PROFILE_VIEW_USERNAME", comment: "")
        UsernameTextField.text = editProfileModel.Username
        UsernameTextField.applyBaseStyle()
        UsernameTextField.delegate = self
        
        PhoneNumberTextField.placeholder = NSLocalizedString("EDIT_PROFILE_VIEW_PHONE_NUMBER", comment: "")
        PhoneNumberTextField.text = editProfileModel.PhoneNumber
        PhoneNumberTextField.applyBaseStyle()
        PhoneNumberTextField.delegate = self
        
        EmailTextField.placeholder = NSLocalizedString("EDIT_PROFILE_VIEW_EMAIL", comment: "")
        EmailTextField.text = editProfileModel.Email
        EmailTextField.applyBaseStyle()
        EmailTextField.delegate = self
        
        LocationTextField.placeholder = NSLocalizedString("EDIT_PROFILE_VIEW_LOCATION", comment: "")
        LocationTextField.text = editProfileModel.Location
        LocationTextField.applyBaseStyle()
        LocationTextField.isEnabled = false
        
        UpdateLocationButton.setTitle(NSLocalizedString("EDIT_PROFILE_VIEW_UPDATE_LOCATION", comment: ""), for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("SHARE_SAVE", comment: ""),
            style: .done,
            target: self,
            action: #selector(saveCommand))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        switch textField
        {
        case UsernameTextField:
            return EmailTextField.becomeFirstResponder()
        case EmailTextField:
            return PhoneNumberTextField.becomeFirstResponder()
        default:
            saveCommand()
            return true
        }
    }
    
    @objc private func UpdateLocationNotificationRecieved(notification: NSNotification)
    {
        LocationTextField.text = notification.object as! String
    }
    
    @IBAction func updateLocationCommand()
    {
        LocationHelper.getLocation()
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
