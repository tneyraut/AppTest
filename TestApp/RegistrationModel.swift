//
//  RegistrationModel.swift
//  TestApp
//
//  Created by Thomas Mac on 20/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

class RegistrationModel
{
    var Username : String?
    var Password : String?
    var Email : String?
    var PhoneNumber : String?
    
    init(username: String, password: String, email: String, phoneNumber: String)
    {
        Username = username
        Password = password
        Email = email
        PhoneNumber = phoneNumber
    }
}
