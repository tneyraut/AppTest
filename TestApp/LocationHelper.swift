//
//  LocationHelper.swift
//  TestApp
//
//  Created by Thomas Mac on 23/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import MapKit

class LocationHelper
{
    private static let locationManager = CLLocationManager()
    
    static func getLocation()
    {
        let geoCoder = CLGeocoder()
        
        let location = locationManager.location
        
        geoCoder.reverseGeocodeLocation(location!, completionHandler:
        { (placemarks, error) -> Void in
            let placeMark = placemarks?[0]
            
            let city = placeMark?.addressDictionary!["City"] as! String
            
            let state = placeMark?.addressDictionary!["State"] as! String
            
            let country = placeMark?.addressDictionary!["Country"] as! String
            
            let result = "\(city), \(state), \(country)"
            
            NotificationCenter.default.post(
                name: Notification.Name.init(Constants.UpdateLocationMessage),
                object: result)
        })
    }
}
