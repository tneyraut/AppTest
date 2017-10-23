//
//  EditProfileModel.swift
//  TestApp
//
//  Created by Thomas Mac on 21/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

class EditProfileModel
{
    var Username : String?
    var Email : String?
    var PhoneNumber : String?
    var Location : String?
    
    init(username: String, email: String, phoneNumber: String, location: String)
    {
        Username = username
        Email = email
        PhoneNumber = phoneNumber
        Location = location
    }
}
