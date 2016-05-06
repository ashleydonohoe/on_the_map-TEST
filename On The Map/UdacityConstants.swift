//
//  UdacityConstants.swift
//  On The Map
//
//  Created by Gabriele on 4/30/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    struct Constants {
        static let BaseAPIURL: String = "https://www.udacity.com/api/"
    }
    
    struct Methods {
        static let Session = "session"
        static let Users = "/users/{userID}"
    }
    
    struct JSONResponseKeys {
        static let account = "account"
        static let userID = "key"
    }
}
