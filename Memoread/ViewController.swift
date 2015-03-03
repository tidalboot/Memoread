//
//  ViewController.swift
//  Memoread
//
//  Created by Nick Jones on 03/03/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textToRetrieveField: UILabel!
    @IBOutlet weak var textToSaveField: UITextField!
    var cloudKitHandler = CloudKitHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitToCloud(sender: AnyObject) {
        
        cloudKitHandler.doesUserHavePet(complete)
    }
    
    func complete(userHasPet: Bool) {
        let vc : AnyObject!
        
        if userHasPet {
            vc = self.storyboard!.instantiateViewControllerWithIdentifier("petView")
        }
        else {
            vc = self.storyboard!.instantiateViewControllerWithIdentifier("noPetView")
        }
    }

    
    

        

    @IBAction func getLatestText(sender: AnyObject) {
    }
}

