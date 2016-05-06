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
    
    @IBAction func logoutPressed(sender:UIButton) {
        UdacityClient.sharedInstance().logout { (success, error) in
            performUIUpdatesOnMain {
                if (success != nil) {
                    self.performSegueWithIdentifier("loginScreen", sender: self)
                }
            }
        }
    }
    
    func completeLogin() {
        performSegueWithIdentifier("tabView", sender: self)
    }

    @IBAction func signUp(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signup")!)
    }
}

extension LoginViewController {
    private func displayError(errorString: String?) {
        if let errorString = errorString {
            debugTextLabel.text = errorString
        }
    }
}
