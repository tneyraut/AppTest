//
//  FirstViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 19/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class LoginViewController : BaseViewController, UITextFieldDelegate
{
    @IBOutlet var LoginButton : RoundedButton!
    @IBOutlet var CreateAccountButton : RoundedButton!
    @IBOutlet var UsernameTextField : ACFloatingTextfield!
    @IBOutlet var PasswordTextField : ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewElements()
        
        self.hideKeyboard()
    }
    
    private func setViewElements()
    {
        self.title = NSLocalizedString("LOGIN_VIEW_TITLE", comment: "")
        
        LoginButton.setTitle(NSLocalizedString("LOGIN_VIEW_LOGIN", comment: ""), for: .normal)
        
        CreateAccountButton.setTitle(NSLocalizedString("LOGIN_VIEW_CREATE_ACCOUNT", comment: ""), for: .normal)
        
        UsernameTextField.placeholder = NSLocalizedString("LOGIN_VIEW_USERNAME", comment: "")
        UsernameTextField.applyBaseStyle()
        UsernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        PasswordTextField.placeholder = NSLocalizedString("LOGIN_VIEW_PASSWORD", comment: "")
        PasswordTextField.applyBaseStyle()
        PasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        LoginButton.setIsEnabledAndBackgroundColor(enabled: PasswordTextField.text != "" && UsernameTextField.text != "")
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField)
    {
        LoginButton.setIsEnabledAndBackgroundColor(enabled: PasswordTextField.text != "" && UsernameTextField.text != "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == UsernameTextField
        {
            return PasswordTextField.becomeFirstResponder()
        }
        
        loginCommand()
        
        return true
    }
    
    @IBAction func loginCommand()
    {
        let userDefaults = CacheHelper.getUserDefaults()
        
        if (UsernameTextField.text != userDefaults.string(forKey: Constants.UsernameCacheKey)
            || PasswordTextField.text != userDefaults.string(forKey: Constants.PasswordCacheKey))
        {
            let alertView = UIAlertView(
                title: nil,
                message: NSLocalizedString("LOGIN_VIEW_ERROR_CREDENTIALS", comment: ""),
                delegate: self,
                cancelButtonTitle: NSLocalizedString("SHARE_OK", comment: ""))
            
            alertView.show()
            
            UsernameTextField.showError()
            PasswordTextField.showError()
            
            return
        }
        
        userDefaults.set(true, forKey: Constants.IsConnectedCacheKey)
        
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountCommand()
    {
        let storyboard = UIStoryboard(name: Constants.LoginStoryboardId, bundle: nil)
        
        let registrationViewController = storyboard.instantiateViewController(withIdentifier: Constants.RegistrationViewControllerId)
        
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
}
