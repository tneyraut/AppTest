//
//  PicturesViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 20/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class PicturesViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet var MainImageView : RoundedPlaceholderImageView!
    @IBOutlet var SecondImageView : RoundedPlaceholderImageView!
    @IBOutlet var ThirdImageView : RoundedPlaceholderImageView!
    
    @IBOutlet var RegistrationButton : UIButton!
    
    var registrationModel : RegistrationModel!
    
    private var imageViewSelected : UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setViewElements()
    }
    
    private func setViewElements()
    {
        title = NSLocalizedString("PICTURES_VIEW_TITLE", comment: "")
        
        RegistrationButton.setTitle(NSLocalizedString("PICTURES_VIEW_REGISTRATION", comment: ""), for: .normal)
        
        MainImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPictureCommand)))
        SecondImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPictureCommand)))
        ThirdImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPictureCommand)))
    }
    
    @objc private func selectPictureCommand(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let imageView = tapGestureRecognizer.view as! UIImageView
        
        let actionSheet = UIAlertController(
            title: NSLocalizedString("PICTURES_VIEW_OPTIONS", comment: ""),
            message: nil,
            preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            actionSheet.addAction(UIAlertAction(
                title: NSLocalizedString("PICTURES_VIEW_TAKE_PHOTO", comment: ""),
                style: .default,
                handler: {(alert: UIAlertAction!) in self.takePicture(imageView: imageView)}))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            actionSheet.addAction(UIAlertAction(
                title: NSLocalizedString("PICTURES_VIEW_CHOOSE_PHOTO", comment: ""),
                style: .default,
                handler: {(alert: UIAlertAction!) in self.choosePicture(imageView: imageView)}))
        }
        
        if imageView.image != nil
        {
            if imageView as? RoundedPlaceholderImageView != MainImageView
            {
                actionSheet.addAction(UIAlertAction(
                    title: NSLocalizedString("PICTURES_VIEW_CHOOSE_AS_MAIN_PHOTO", comment: ""),
                    style: .default,
                    handler: {(alert: UIAlertAction!) in self.chooseAsMainPicture(imageView: imageView)}))
            }
            
            actionSheet.addAction(UIAlertAction(
                title: NSLocalizedString("PICTURES_VIEW_DELETE", comment: ""),
                style: .destructive,
                handler: {(alert: UIAlertAction!) in self.removePicture(imageView: imageView)}))
        }
        
        actionSheet.addAction(UIAlertAction(
            title: NSLocalizedString("PICTURES_VIEW_CANCEL", comment: ""),
            style: .cancel,
            handler: {(alert: UIAlertAction!) in }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func takePicture(imageView: UIImageView)
    {
        imageViewSelected = imageView
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func choosePicture(imageView: UIImageView)
    {
        imageViewSelected = imageView
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageViewSelected.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    private func chooseAsMainPicture(imageView: UIImageView)
    {
        let image = MainImageView.image
        
        MainImageView.image = imageView.image
        
        imageView.image = image
    }
    
    private func removePicture(imageView: UIImageView)
    {
        imageView.image = nil
    }
    
    @IBAction func registrationCommand()
    {
        let userDefaults = CacheHelper.getUserDefaults()
        
        userDefaults.set(registrationModel.Username, forKey: Constants.UsernameCacheKey)
        userDefaults.set(registrationModel.Email, forKey: Constants.EmailCacheKey)
        userDefaults.set(registrationModel.PhoneNumber, forKey: Constants.PhoneNumberCacheKey)
        userDefaults.set(registrationModel.Password, forKey: Constants.PasswordCacheKey)
        
        userDefaults.set(true, forKey: Constants.IsConnectedCacheKey)
        
        userDefaults.synchronize()
        
        navigationController?.popViewController(animated: true)
    }
}
