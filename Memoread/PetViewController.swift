//
//  PetViewController.swift
//  Memoread
//
//  Created by Nick Jones on 03/03/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit

class PetViewController: UIViewController {


    @IBOutlet var usernameLabel: UILabel!
    
    var cloudKitHandler = CloudKitHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cloudKitHandler.getUserID(getUsernameAndReturn)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view .endEditing(true)
    }
    
    
    func getUsernameAndReturn (userID: String) {
        cloudKitHandler.getUsername(userID, callback: displayUsername)
    }
    
    func displayUsername (username: String){
        println("Welcome back \(username)")
        
        dispatch_async(dispatch_get_main_queue(), {
            self.usernameLabel.text = "Welcome back \(username)"
        })
    }

}
