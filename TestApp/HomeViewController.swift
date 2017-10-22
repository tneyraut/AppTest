//
//  HomeViewController.swift
//  TestApp
//
//  Created by Thomas Mac on 19/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class HomeViewController : BaseViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var tableView : UITableView!
    
    private var usersArray = [User]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setViewElement()
        
        getUsers()
    }
    
    private func setViewElement()
    {
        title = NSLocalizedString("HOME_VIEW_TITLE", comment: "")
        
        navigationController?.applyBaseNavigationBarStyle()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // TODO faire une database et récupérer les info
    private func getUsers()
    {
        usersArray.append(User(
            username: "Anakin",
            email: "anakin@gmail.com",
            phoneNumber: "1234567890",
            isLiked: false))
        
        usersArray.append(User(
            username: "Dark Vador",
            email: "vador@gmail.com",
            phoneNumber: "1234567890",
            isLiked: true))
        
        usersArray.append(User(
            username: "Obiwan",
            email: "obi@gmail.com",
            phoneNumber: "1234567890",
            isLiked: false))
        
        usersArray.append(User(
            username: "Dark Maul",
            email: "maul@gmail.com",
            phoneNumber: "1234567890",
            isLiked: false))
        
        usersArray.append(User(
            username: "Rey",
            email: "rey@gmail.com",
            phoneNumber: "1234567890",
            isLiked: false))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UserCellId, for: indexPath) as! UserCell
        
        cell.setUser(user: usersArray[indexPath.row])
        
        return cell
    }
}
