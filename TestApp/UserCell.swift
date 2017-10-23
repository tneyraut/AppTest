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
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLikeCommand))
        rightSwipeGesture.direction = .right
        
        addGestureRecognizer(rightSwipeGesture)
    }
    
    func setUser(user: User)
    {
        self.user = user
        
        UsernameLabel.text = user.Username
        ImageView.image = UIImage(named: user.PictureName!)
        
        setLikeButtonImage()
    }
    
    @IBAction func LikeCommand()
    {
        user?.IsLiked = !(user?.IsLiked)!
        
        setLikeButtonImage()
    }
    
    private func setLikeButtonImage()
    {
        LikeButton.setImage(UIImage(named: (user?.IsLiked)! ? "fillHeart" : "heart"), for: .normal)
    }
    
    @objc private func swipeLikeCommand(gesture: UISwipeGestureRecognizer)
    {
        let size = CGSize(width: frame.width, height: frame.height)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseIn,
            animations:
            {
                let position = CGPoint(x: (self.window?.frame.width)! / 2, y: self.frame.origin.y)
                
                self.frame = CGRect(origin: position, size: size)
            },
            completion:
            { (finished: Bool) in
                
                self.user?.IsLiked = !(self.user?.IsLiked)!
                
                self.setLikeButtonImage()
                
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseIn,
                    animations:
                    {
                        let position = CGPoint(x: 0, y: self.frame.origin.y)
                        
                        self.frame = CGRect(origin: position, size: size)
                    },
                    completion: nil)
            })
    }
}
