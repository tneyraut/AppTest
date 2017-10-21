//
//  ChangePasswordViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 21/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class ChangePasswordViewController : BaseViewController
{
    @IBOutlet var CurrentPasswordTextField : ACFloatingTextfield!
    @IBOutlet var NewPasswordTextField : ACFloatingTextfield!
    @IBOutlet var NewPasswordConfirmationTextField : ACFloatingTextfield!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setViewElements()
        
        hideKeyboard()
        
        addCancelButton()
    }
    
    private func setViewElements()
    {
        title = NSLocalizedString("CHANGE_PASSWORD_VIEW_TITLE", comment: "")
        
        CurrentPasswordTextField.placeholder = NSLocalizedString("CHANGE_PASSWORD_VIEW_CURRENT_PASSWORD", comment: "")
        CurrentPasswordTextField.applyBaseStyle()
        
        NewPasswordTextField.placeholder = NSLocalizedString("CHANGE_PASSWORD_VIEW_NEW_PASSWORD", comment: "")
        NewPasswordTextField.applyBaseStyle()
        
        NewPasswordConfirmationTextField.placeholder = NSLocalizedString("CHANGE_PASSWORD_VIEW_NEW_PASSWORD_CONFIRMATION", comment: "")
        NewPasswordConfirmationTextField.applyBaseStyle()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("SHARE_SAVE", comment: ""),
            style: .done,
            target: self,
            action: #selector(saveCommand))
    }
    
    @objc private func saveCommand()
    {
        let userDefaults = CacheHelper.getUserDefaults()
        
        var alertController : UIAlertController?
        
        if userDefaults.string(forKey: Constants.PasswordCacheKey) != CurrentPasswordTextField.text
        {
            alertController = UIAlertController(title: nil, message: NSLocalizedString("CHANGE_PASSWORD_VIEW_ERROR_WRONG_CURRENT_PASSWORD", comment: ""), preferredStyle: .alert)
            
            CurrentPasswordTextField.showError()
        }
        
        if alertController == nil && (NewPasswordTextField.text?.isEmpty)!
        {
            alertController = UIAlertController(title: nil, message: NSLocalizedString("CHANGE_PASSWORD_VIEW_ERROR_NO_NEW_PASSWORD", comment: ""), preferredStyle: .alert)
            
            NewPasswordTextField.showError()
        }
        
        if alertController == nil && NewPasswordTextField.text != NewPasswordConfirmationTextField.text
        {
            alertController = UIAlertController(title: nil, message: NSLocalizedString("CHANGE_PASSWORD_VIEW_ERROR_CONFIRMATION_NEW_PASSWORD", comment: ""), preferredStyle: .alert)
            
            NewPasswordTextField.showError()
            
            NewPasswordConfirmationTextField.showError()
        }
        
        if alertController != nil
        {
            alertController?.addAction(UIAlertAction(title: NSLocalizedString("SHARE_OK", comment: ""), style: .default, handler: nil))
            
            present(alertController!, animated: true, completion: nil)
            
            return
        }
        
        userDefaults.set(NewPasswordTextField.text, forKey: Constants.PasswordCacheKey)
        
        userDefaults.synchronize()
        
        closeModal()
    }
}
