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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidden = true
        errorMessageLabel.hidden = true
        noUsernameEnterredLabel.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func userNameTextFieldDoneButtonClicked(sender: AnyObject) {
        sender .resignFirstResponder()
    }
    
    
    @IBAction func petClicked(sender: AnyObject) {
        let userName = UserNameTextField.text
        submitButton.hidden = true
        errorMessageLabel.hidden = true
        noUsernameEnterredLabel.hidden = true
        
        if userName == ""{
                self.noUsernameEnterredLabel.hidden = false
                submitButton.hidden = false
        }
        else {
            submitButton.hidden = true
            loadingIndicator.hidden = false
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
            self.submitButton.hidden = false
            self.loadingIndicator.hidden = true
            self.loadingIndicator.stopAnimating()
            self.errorMessageLabel.hidden = false
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
