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
    @IBOutlet var noUsernameEnterredAlert: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var submitButton: UIButton!
    
    var cloudKitHandler = CloudKitHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func userNameTextFieldDoneButtonClicked(sender: AnyObject) {
        sender .resignFirstResponder()
    }
    
    @IBAction func petClicked(sender: AnyObject) {
        let userName = UserNameTextField.text
        
        if userName == ""{
                self.noUsernameEnterredAlert.text = "Oops, looks like you haven't given yourself a nickname!"
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
    
    func showPetViewAfterDataHasBeenSaved () {
        dispatch_async(dispatch_get_main_queue(), {
            let vc : AnyObject!
            vc = self.storyboard!.instantiateViewControllerWithIdentifier("petView")
            self.showViewController(vc as! UIViewController, sender: vc)
        })
        
    }

}
