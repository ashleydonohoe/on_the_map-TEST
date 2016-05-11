//
//  TableViewController.swift
//  On The Map
//
//  Created by Gabriele on 5/2/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ParseClient.sharedInstance().getStudentLocations { (result, error) in
            if error == nil {
                if let results = result?.valueForKey(ParseClient.JSONResponseKeys.results) as? [[String : AnyObject]] {
                    print("HEre are results")
                    print(results)
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        for location in ParseClient.sharedInstance().studentLocations {
            print(location)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logout(sender: AnyObject) {
        UdacityClient.sharedInstance().logout { (success, error) in
            performUIUpdatesOnMain {
                if (success != nil) {
                    self.performSegueWithIdentifier("loginScreen", sender: self)
                }
            }
        }
    }
}
