//
//  StudentLocationModel.swift
//  On The Map
//
//  Created by Gabriele on 5/7/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation


struct StudentLocation {
    var objectID: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Float
    var longitude: Float
    
    init( studentLocations: [String: AnyObject]) {
        objectID = studentLocations[ParseClient.JSONResponseKeys.objectID] as! String
        uniqueKey = studentLocations[ParseClient.JSONResponseKeys.uniqueKey] as! String
        firstName = studentLocations[ParseClient.JSONResponseKeys.firstName] as! String
        lastName = studentLocations[ParseClient.JSONResponseKeys.lastName] as! String
        mapString = studentLocations[ParseClient.JSONResponseKeys.mapString] as! String
        mediaURL = studentLocations[ParseClient.JSONResponseKeys.mediaURL] as! String
        latitude = studentLocations[ParseClient.JSONResponseKeys.latitude] as! Float
        longitude = studentLocations[ParseClient.JSONResponseKeys.longitude] as! Float
    }
    
}