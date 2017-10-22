//
//  UserCell.swift
//  TestApp
//
//  Created by Thomas Mac on 22/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class UserCell : UITableViewCell
{
    @IBOutlet var LikeButton : UIButton!
    @IBOutlet var UsernameLabel : UILabel!
    @IBOutlet var ImageView : UIImageView!
    
    private var user : User?
    
    func setUser(user: User)
    {
        self.user = user
        
        UsernameLabel.text = user.Username
        //LikeButton TODO change image
        // TODO set image
    }
    
    @IBAction func LikeCommand()
    {
        
    }
}
