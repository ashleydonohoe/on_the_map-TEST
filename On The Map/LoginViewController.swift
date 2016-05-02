//
//  LoginViewController.swift
//  On The Map
//
//  Created by Gabriele on 4/30/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var debugTextLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var session: NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginPressed(sender: UIButton) {
        UdacityClient.sharedInstance().loginWithUserCredentials(emailTextField.text!, password: passwordTextField.text!) { (success, errorString) in
            performUIUpdatesOnMain {
                if success != nil {
                    self.completeLogin()
                } else {
                    self.displayError(errorString)
                }
            }
        }    
    }
    
    func completeLogin() {
        print("Login completed")
        performSegueWithIdentifier("tabView", sender: self)
    }

}

extension LoginViewController {
    private func displayError(errorString: String?) {
        if let errorString = errorString {
            debugTextLabel.text = errorString
        }
    }
}
