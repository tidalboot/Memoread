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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidden = true
        noiCloudAccountLabel.hidden = true
        networkErrorLabel.hidden = true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitToCloud(sender: AnyObject) {
        
        noiCloudAccountLabel.hidden = true
        networkErrorLabel.hidden = true
        
        var doesUserHaveiCloudAccount = cloudKitHandler.doesUserHaveiCloudAccount()

        if doesUserHaveiCloudAccount {
            dispatch_async(dispatch_get_main_queue(), {
                self.submitButton.hidden = true
                self.loadingIndicator.hidden = false
                self.loadingIndicator.startAnimating()
            })
            cloudKitHandler.doesUserHavePet(complete)
        }
        else {
            submitButton.hidden = false
            noiCloudAccountLabel.hidden = false
        }
    }
    
    
    
    func complete(userHasPet: Bool, errorOccured: Bool) {
        let vc : AnyObject!
        println(userHasPet)

        if errorOccured == false {
            networkErrorLabel.hidden = false

            if userHasPet{
                vc = self.storyboard!.instantiateViewControllerWithIdentifier("petView")
            }
            else {
                vc = self.storyboard!.instantiateViewControllerWithIdentifier("noPetView")
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.showViewController(vc as! UIViewController, sender: vc)
            })
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                self.networkErrorLabel.hidden = false
                self.submitButton.hidden = false
                self.loadingIndicator.hidden = true
                self.loadingIndicator.stopAnimating()
            })
        }
        
        

    }


    @IBAction func getLatestText(sender: AnyObject) {
    }
}

