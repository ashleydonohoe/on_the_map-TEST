//
//  ParseClient.swift
//  On The Map
//
//  Created by Gabriele on 5/7/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation


class ParseClient: NSObject {
    
    var session = NSURLSession.sharedSession()
    
    var studentLocations = [StudentLocation]()
    
    override init() {
        super.init()
    }
    
    func getStudentLocations(completionHandlerForGetStudentLocations: (result: AnyObject!, error: String?) -> Void) -> NSURLSessionDataTask {
        
        // Build request URL
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation?limit=100&-updatedAt")!)
        
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-Application-Id")
        
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(error: String) {
                print(error)
                completionHandlerForGetStudentLocations(result: nil, error: "Could not connect to Udacity servers")
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
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            // Parse Data
            var parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                print("Failed to convert data")
            }
        }
        
        task.resume()
        return task
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
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
}