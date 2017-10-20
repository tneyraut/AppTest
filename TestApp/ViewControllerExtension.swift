//
//  ViewExtension.swift
//  TestApp
//
//  Created by Thomas Mac on 19/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

extension UIViewController
{
    func hideKeyboard()
    {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        tapGestureRecognizer.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func ShowModal(viewController: UIViewController)
    {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.applyBaseNavigationBarStyle()
        
        viewController.addCloseButton()
        
        present(navigationController, animated: true, completion: nil)
    }
    
    func addCloseButton()
    {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("SHARE_CLOSE", comment: ""),
            style: .done,
            target: self,
            action: #selector(closeModal))
    }
    
    func closeModal()
    {
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
