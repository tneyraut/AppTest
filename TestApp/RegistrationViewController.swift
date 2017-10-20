//
//  RegistrationViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 20/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class RegistrationViewController : UIViewController, UITextFieldDelegate
{
    @IBOutlet var UsernameTextField : ACFloatingTextfield!
    @IBOutlet var PhoneNumberTextField : ACFloatingTextfield!
    @IBOutlet var EmailTextField : ACFloatingTextfield!
    @IBOutlet var PasswordTextField : ACFloatingTextfield!
    @IBOutlet var PasswordConfirmationTextField : ACFloatingTextfield!
    
    @IBOutlet var ContinueButton : RoundedButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        hideKeyboard()
        
        setViewElements()
    }
    
    private func setViewElements()
    {
        title = NSLocalizedString("REGISTRATION_VIEW_TITLE", comment: "")
        
        UsernameTextField.placeholder = NSLocalizedString("REGISTRATION_VIEW_USERNAME", comment: "")
        UsernameTextField.applyBaseStyle()
        UsernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        PhoneNumberTextField.placeholder = NSLocalizedString("REGISTRATION_VIEW_PHONE_NUMBER", comment: "")
        PhoneNumberTextField.applyBaseStyle()
        PhoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        EmailTextField.placeholder = NSLocalizedString("REGISTRATION_VIEW_EMAIL", comment: "")
        EmailTextField.applyBaseStyle()
        EmailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        PasswordTextField.placeholder = NSLocalizedString("REGISTRATION_VIEW_PASSWORD", comment: "")
        PasswordTextField.applyBaseStyle()
        PasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        PasswordConfirmationTextField.placeholder = NSLocalizedString("REGISTRATION_VIEW_PASSWORD_CONFIRMATION", comment: "")
        PasswordConfirmationTextField.applyBaseStyle()
        PasswordConfirmationTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        ContinueButton.setTitle(NSLocalizedString("REGISTRATION_VIEW_CONTINUE", comment: ""), for: .normal)
        
        let isEnabled = UsernameTextField.text != ""
            && PhoneNumberTextField.text != ""
            && EmailTextField.text != ""
            && PasswordTextField.text != ""
            && PasswordConfirmationTextField.text != ""
        
        ContinueButton.setIsEnabledAndBackgroundColor(enabled: isEnabled)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField)
    {
        if textField == PhoneNumberTextField
        {
            // TODO format
        }
        
        let isEnabled = UsernameTextField.text != ""
            && PhoneNumberTextField.text != ""
            && EmailTextField.text != ""
            && PasswordTextField.text != ""
            && PasswordConfirmationTextField.text != ""
        
        ContinueButton.setIsEnabledAndBackgroundColor(enabled: isEnabled)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        switch textField
        {
        case UsernameTextField:
            return PhoneNumberTextField.becomeFirstResponder()
        case PhoneNumberTextField:
            return EmailTextField.becomeFirstResponder()
        case EmailTextField:
            return PasswordTextField.becomeFirstResponder()
        case PasswordTextField:
            return PasswordConfirmationTextField.becomeFirstResponder()
        default:
            continueCommand()
            return true
        }
    }
    
    @IBAction func continueCommand()
    {
        if (PasswordTextField.text != PasswordConfirmationTextField.text)
        {
            let alertView = UIAlertView(
                title: nil,
                message: NSLocalizedString("REGISTRATION_VIEW_PASSWORD_ERROR", comment: ""),
                delegate: self,
                cancelButtonTitle: NSLocalizedString("SHARE_OK", comment: ""))
            
            alertView.show()
            
            PasswordConfirmationTextField.showError()
            PasswordTextField.showError()
            
            return
        }
        
        // TODO ajouter des erreurs pour le phone number et l'email ?
        
        let storyboard = UIStoryboard(name: Constants.LoginStoryboardId, bundle: nil)
        
        let picturesViewController = storyboard.instantiateViewController(withIdentifier: Constants.PicturesViewControllerId) as! PicturesViewController
        
        picturesViewController.registrationModel = RegistrationModel(
            username: UsernameTextField.text!,
            password: PasswordTextField.text!,
            email: EmailTextField.text!,
            phoneNumber: PhoneNumberTextField.text!)
        
        navigationController?.pushViewController(picturesViewController, animated: true)
    }
}
