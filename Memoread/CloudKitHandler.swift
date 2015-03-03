//
//  CloudKitHandler.swift
//  Memoread
//
//  Created by Nick Jones on 03/03/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitHandler {
    let container : CKContainer
    let publicDB : CKDatabase
    let privateDB : CKDatabase
    var currentUserID : String?
    
    init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    
    func doesUserHavePet () -> Bool {
        
        var userHasPet = false
        
        container.fetchUserRecordIDWithCompletionHandler({
            recordID, error in
            if let err = error {
                // Failed to get record ID
            } else {
                let userID = recordID.recordName
                println(userID)
                let userIDToFind = NSPredicate(format: "UserID = %@", userID)
                let userIDQuery = CKQuery(recordType: "DataStore", predicate: userIDToFind)
                self.publicDB.performQuery(userIDQuery, inZoneWithID: nil,  completionHandler: {
                    results, error in
                    if error != nil {
                        println("Data unreachable")
                    }
                    else {
                        var record : NSArray = results
                        var userInfo = record.count
                        println(record.count)
                        if userInfo == 0 {
                            userHasPet = false
                        }
                        else {
                            userHasPet = true
                        }
                    }
                    println("After fetching data userHasPet boolean is \(userHasPet)")
                })
            }
        })
        return userHasPet
    }
    
    
    func saveText(userName : String) {
        let textRecord = CKRecord(recordType: "Users")
        textRecord.setValue(userName, forKey: "userID")
        textRecord.setValue(1, forKey: "HasLoggedIn")
        publicDB.saveRecord(textRecord, completionHandler: { (record, error) -> Void in
            NSLog("Saved to cloud kit")
        })
    }
    
    func retrieveText () {
        
        let textToFind = NSPredicate(format: "TextId = %d", 14)
        let textQuery = CKQuery(recordType: "DataStore", predicate: textToFind)
        publicDB.performQuery(textQuery, inZoneWithID: nil) {
            results, error in
            if error != nil {
                return
            }
            else {
                var record = results[0] as! CKRecord
                var textResults = record.objectForKey("TextToRemember") as! String
                NSLog(textResults)
            }
            }
    }
}