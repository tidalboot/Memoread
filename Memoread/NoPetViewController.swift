//
//  NoPetViewController.swift
//  Memoread
//
//  Created by Nick Jones on 03/03/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit

class NoPetViewController: UIViewController {

    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet var noUsernameEnterredLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var errorMessageLabel: UILabel!
    
    var cloudKitHandler = CloudKitHandler()
    var nodeHandler = NodeHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nodeHandler.hideNodes([loadingIndicator, errorMessageLabel, noUsernameEnterredLabel])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func userNameTextFieldDoneButtonClicked(sender: AnyObject) {
        sender .resignFirstResponder()
    }
    
    
    @IBAction func petClicked(sender: AnyObject) {
        let userName = UserNameTextField.text
        
        nodeHandler.hideNodes([submitButton, errorMessageLabel, noUsernameEnterredLabel])
        
        if userName == ""{
            
            nodeHandler.showNodes([noUsernameEnterredLabel, submitButton])
        }
        else {
            
            nodeHandler.hideNodes([submitButton])
            nodeHandler.showNodes([loadingIndicator])
            loadingIndicator.startAnimating()
            cloudKitHandler.getUserID(saveTextAndShowPetView)
        }
    }

    func saveTextAndShowPetView (userID: String) {
            cloudKitHandler.saveWhenUserIDHasBeenFetched(userID, username: UserNameTextField.text, callback: showPetViewAfterDataHasBeenSaved)
    }
    
    func showPetViewAfterDataHasBeenSaved (errorOccured: Bool) {
        
        if errorOccured  {
            dispatch_async(dispatch_get_main_queue(), {
                self.nodeHandler.hideNodes([self.loadingIndicator])
                self.nodeHandler.showNodes([self.submitButton, self.errorMessageLabel])
                self.loadingIndicator.stopAnimating()
            })
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                let vc : AnyObject!
                vc = self.storyboard!.instantiateViewControllerWithIdentifier("petView")
                self.showViewController(vc as! UIViewController, sender: vc)
            })
        }
    }

}
