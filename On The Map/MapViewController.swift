//
//  MapViewController.swift
//  On The Map
//
//  Created by Gabriele on 5/2/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ParseClient.sharedInstance().getStudentLocations { (result, error) in
            if error == nil {
                print("There was no error")
                guard let testData = result else {
                    print("There was an error setting testData to be the result")
                    return
                }
               /* for location in ParseClient.sharedInstance().studentLocations {
                    print(location.firstName)
                } */
            }
        }

    func viewWillAppear(animated: Bool) {
    }
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func logout(sender: AnyObject) {
        UdacityClient.sharedInstance().logout { (success, error) in
            performUIUpdatesOnMain {
                if (success != nil) {
                    self.performSegueWithIdentifier("loginScreen", sender: self)
                }
            }
        }
        }
    }
}

