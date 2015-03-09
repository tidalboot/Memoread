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
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var noiCloudAccountLabel: UILabel!
    @IBOutlet var networkErrorLabel: UILabel!

    var cloudKitHandler = CloudKitHandler()
    var nodeHandler = NodeHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nodeHandler.hideNodes([noiCloudAccountLabel, networkErrorLabel, loadingIndicator])
    }

    @IBAction func submitToCloud(sender: AnyObject) {
        
        nodeHandler.hideNodes([noiCloudAccountLabel, networkErrorLabel])
        
        var doesUserHaveiCloudAccount = cloudKitHandler.doesUserHaveiCloudAccount()

        if doesUserHaveiCloudAccount {
                nodeHandler.hideNodes([self.submitButton])
                nodeHandler.showNodes([self.loadingIndicator])
            cloudKitHandler.doesUserHavePet(complete)
        }
        else {
            nodeHandler.showNodes([submitButton, noiCloudAccountLabel])
        }
    }
    
    
    func complete(userHasPet: Bool, errorOccured: Bool) {
        let vc : AnyObject!
        println(userHasPet)

        if errorOccured == false {
            
            nodeHandler.showNodes([networkErrorLabel])

            if userHasPet{
                vc = self.storyboard!.instantiateViewControllerWithIdentifier("petView")
            }
            else {
                vc = self.storyboard!.instantiateViewControllerWithIdentifier("noPetView")
            }
    
                self.showViewController(vc as! UIViewController, sender: vc)
        }
        else {
                self.nodeHandler.showNodes([self.submitButton, self.networkErrorLabel])
                self.nodeHandler.hideNodes([self.loadingIndicator])
        }
    }
    //-------
}

