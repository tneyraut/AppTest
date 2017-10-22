//
//  User.swift
//  TestApp
//
//  Created by Thomas Mac on 22/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

class User
{
    var Username : String?
    var Email : String?
    var PhoneNumber : String?
    var IsLiked : Bool?
    
    init(username: String, email: String, phoneNumber: String, isLiked: Bool)
    {
        Username = username
        Email = email
        PhoneNumber = phoneNumber
        IsLiked = isLiked
    }
}
