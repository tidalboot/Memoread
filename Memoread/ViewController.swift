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
        
        nodeHandler.hideNodes([], labelsToHide: [noiCloudAccountLabel, networkErrorLabel], textFieldsToHide: [], indicatorsToHide: [loadingIndicator])
//        
//        loadingIndicator.hidden = true
//        noiCloudAccountLabel.hidden = true
//        networkErrorLabel.hidden = true
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
                self.nodeHandler.hideNodes([self.submitButton], labelsToHide: [], textFieldsToHide: [], indicatorsToHide: [])
//                self.submitButton.hidden = true
                self.nodeHandler.showNodes([], labelsToHide: [], textFieldsToHide: [], indicatorsToHide: [self.loadingIndicator])
//                self.loadingIndicator.hidden = false
                self.loadingIndicator.startAnimating()
            })
            cloudKitHandler.doesUserHavePet(complete)
        }
        else {
            
            nodeHandler.showNodes([submitButton], labelsToHide: [noiCloudAccountLabel], textFieldsToHide: [], indicatorsToHide: [])
//            submitButton.hidden = false
//            noiCloudAccountLabel.hidden = false
        }
    }
    
    
    
    func complete(userHasPet: Bool, errorOccured: Bool) {
        let vc : AnyObject!
        println(userHasPet)

        if errorOccured == false {
            
            nodeHandler.showNodes([], labelsToHide: [networkErrorLabel], textFieldsToHide: [], indicatorsToHide: [])
//            networkErrorLabel.hidden = false

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
                self.nodeHandler.showNodes([self.submitButton], labelsToHide: [self.networkErrorLabel], textFieldsToHide: [], indicatorsToHide: [])
                self.nodeHandler.hideNodes([], labelsToHide: [], textFieldsToHide: [], indicatorsToHide: [self.loadingIndicator])
//                
//                self.networkErrorLabel.hidden = false
//                self.submitButton.hidden = false
//                self.loadingIndicator.hidden = true
                self.loadingIndicator.stopAnimating()
            })
        }
        
        

    }


    @IBAction func getLatestText(sender: AnyObject) {
    }
}

