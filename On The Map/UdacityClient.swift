//
//  UdacityClient.swift
//  On The Map
//
//  Created by Gabriele on 4/30/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    var session = NSURLSession.sharedSession()
    
    var sessionID: String? = nil
    var userID: String? = nil
    
    var studentName: StudentName?
    
    struct StudentName {
        var firstName = ""
        var lastName = ""
        var fullName: String {
            return "\(firstName) \(lastName)"
        }
    }
    
    override init() {
        super.init()
    }
    
    /*
     Issue POST request with username and password
     Upon receiving successful response, grab the "key" from the "account" and set that equal to the userID
     Issue GET request to grab user first name and last name using the userID
     Issue DELETE request when user signs out
 */
    
    
    func loginWithUserCredentials(userName: String, password: String, completionHandlerForLogin: (result: AnyObject!, error: String?) -> Void) -> NSURLSessionDataTask {
        
        // Build request URL
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        
        request.HTTPMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(error: String) {
                print(error)
                completionHandlerForLogin(result: nil, error: "Could not connect to Udacity servers")
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data?.subdataWithRange(NSMakeRange(5, data!.length - 5)) else {
                sendError("No data was returned by the request!")
                return
            }
            
            //self.convertDataWithCompletionHandler(data, completionHandlerForConvertData:completionHandlerForLogin)
            // Parse Data
            var parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                print("Failed to convert data")
            }
            
            guard let account = parsedResult[UdacityClient.JSONResponseKeys.account] as? NSDictionary else {
                print("Could not find account info")
                return
            }
            
            guard let userID = account[UdacityClient.JSONResponseKeys.userID] as? String else {
                print("Could not find user id")
                return
            }
            
            self.userID = userID
            
            print(userID)
            
            print(account)
            print(self.userID)
            
            
            completionHandlerForLogin(result: true, error: nil)
        }
        task.resume()
        return task
    }
    
    
    func logout(completionHandlerForLogout: (result: AnyObject!, error: String?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        
        request.HTTPMethod = "DELETE"
        
        var xsrfCookie: NSHTTPCookie? = nil
        
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        
        for cookie in sharedCookieStorage.cookies! {
            
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
            
        }
        
        if let xsrfCookie = xsrfCookie {
            
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            
        }
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            if error != nil {
                completionHandlerForLogout(result: false, error: "There was an error logging out")
                return
                
            } else {
                self.userID = nil
                completionHandlerForLogout(result: true, error: nil)
            }
        }
        
        task.resume()
    }
    
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: String?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            completionHandlerForConvertData(result: nil, error: "Failed to convert data: \(data)")
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}
