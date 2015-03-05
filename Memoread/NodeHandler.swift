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
    
    func hideNodes (objectsToHide: [UIView]) {
        var objectArray = objectsToHide
        for object in objectArray {
            if object is UIActivityIndicatorView {
                (object as! UIActivityIndicatorView).stopAnimating()
                object.hidden = true
            }
            else {
                object.hidden = true
            }
        }
    }
    
    func showNodes (objectsToShow: [UIView]) {
        var objectArray = objectsToShow
        for object in objectArray {
            if object is UIActivityIndicatorView {
                (object as! UIActivityIndicatorView).startAnimating()
                object.hidden = false
            }
            else {
                object.hidden = false
            }
        }
    }
}