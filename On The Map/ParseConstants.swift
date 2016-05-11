//
//  ParseConstants.swift
//  On The Map
//
//  Created by Gabriele on 5/7/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

extension ParseClient {
    struct Constants {
        static let BaseAPIURL: String = "https://api.parse.com"
        static let APIKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let AppID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    }
    
    struct JSONResponseKeys {
        static let results = "results"
        static let objectID = "objectID"
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let latitude = "latitude"
        static let longitude = "longitude"
        
    }
}