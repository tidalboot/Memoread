//
//  NoPetViewController.swift
//  Memoread
//
//  Created by Nick Jones on 03/03/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit

class NoPetViewController: UIViewController {

    var cloudKitHandler = CloudKitHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func petClicked(sender: AnyObject) {
        cloudKitHandler.saveText()
        let vc : AnyObject!
        vc = self.storyboard!.instantiateViewControllerWithIdentifier("petView")
        self.showViewController(vc as! UIViewController, sender: vc)

    }

}
