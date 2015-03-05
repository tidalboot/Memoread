//
//  nodeHandler.swift
//  Memoread
//
//  Created by Nick Jones on 05/03/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation
import UIKit

class NodeHandler {
    
    
    
    func hideNodes (buttonsToHide: [UIButton]?, labelsToHide: [UILabel]?,
        textFieldsToHide: [UITextField]?, indicatorsToHide: [UIActivityIndicatorView]?) {
            var uiButtons: [UIButton] = buttonsToHide!
            var uiLabels: [UILabel] = labelsToHide!
            var textFeilds: [UITextField] = textFieldsToHide!
            var activityIndicators: [UIActivityIndicatorView] = indicatorsToHide!
            
            for button in uiButtons {
                button.hidden = true
            }
            for label in uiLabels {
                label.hidden = true
            }
            for textField in textFeilds {
                textField.hidden = true
            }
            for activityIndicator in activityIndicators {
                activityIndicator.hidden = true
            }
    }
    
    func showNodes (buttonsToHide: [UIButton]?, labelsToHide: [UILabel]?,
        textFieldsToHide: [UITextField]?, indicatorsToHide: [UIActivityIndicatorView]?) {
            var uiButtons: [UIButton] = buttonsToHide!
            var uiLabels: [UILabel] = labelsToHide!
            var textFeilds: [UITextField] = textFieldsToHide!
            var activityIndicators: [UIActivityIndicatorView] = indicatorsToHide!
            
            for button in uiButtons {
                button.hidden = false
            }
            for label in uiLabels {
                label.hidden = false
            }
            for textField in textFeilds {
                textField.hidden = false
            }
            for activityIndicator in activityIndicators {
                activityIndicator.hidden = false
            }
    }
}