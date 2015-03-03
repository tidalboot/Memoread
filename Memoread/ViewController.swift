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
                
        var doesUserHavePet = false

        var serialQueue: dispatch_queue_t = dispatch_queue_create("com.blah.queue", DISPATCH_QUEUE_SERIAL);
            dispatch_async(serialQueue, {
                doesUserHavePet = self.cloudKitHandler.doesUserHavePet()
                });
        
        dispatch_async(serialQueue, {
                println("fuck you")
                println(doesUserHavePet)
        });
    }

    
    
//        let vc : AnyObject!
//        
//        if doesUserHavePet {
//            vc = self.storyboard!.instantiateViewControllerWithIdentifier("petView")
//        }
//        else {
//            vc = self.storyboard!.instantiateViewControllerWithIdentifier("noPetView")
//        }
        

    @IBAction func getLatestText(sender: AnyObject) {
    }
}

