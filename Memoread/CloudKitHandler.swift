//
//  CloudKitHandler.swift
//  Memoread
//
//  Created by Nick Jones on 03/03/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

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
    
    func doesUserHaveiCloudAccount () -> Bool {
        
        var detectIsUserHasiCloudAccount = NSFileManager.defaultManager().ubiquityIdentityToken
        
        if detectIsUserHasiCloudAccount == nil {
            return false
        }
        else{
            return true
        }
    }

    
    func doesUserHavePet (callback: (userHasPet: Bool, errorOccured: Bool) -> ()) {
        var userHasPet = false
        
        container.fetchUserRecordIDWithCompletionHandler({
            recordID, error in
            if let err = error {
                return callback(userHasPet: false, errorOccured: true)
            } else {
                let userID = recordID.recordName
                println(userID)
                let userIDToFind = NSPredicate(format: "UserID = %@", userID)
                let userIDQuery = CKQuery(recordType: "DataStore", predicate: userIDToFind)
                self.privateDB.performQuery(userIDQuery, inZoneWithID: nil,  completionHandler: {
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
                        return callback(userHasPet: userHasPet, errorOccured: false)
                    }
                    println("After fetching data userHasPet boolean is \(userHasPet)")
                })
            }
        })
        return
    }

    
    func getUserID (callback: (userID: String) -> ()) {
        var userID : String!
        container.fetchUserRecordIDWithCompletionHandler({
            recordID, error in
            var userIDToReturn = recordID.recordName
                return callback(userID: userIDToReturn)
        })
        return
    }
    
    func getUsername (userID: String, callback: (username: String) -> ()) {
        let userIDToFind = NSPredicate(format: "UserID = %@", userID)
        let userIDToQuery = CKQuery(recordType: "DataStore", predicate: userIDToFind)
        privateDB.performQuery(userIDToQuery, inZoneWithID: nil, completionHandler:  {
            returnedUserRecord, errorMessage in
            var recordFound : NSArray = returnedUserRecord
            if recordFound.count != 0 {
                var recordRaw = recordFound[0] as! CKRecord
                var usernameReturned: String = recordRaw.valueForKey("Username") as! String
                return callback(username: usernameReturned)
            }
        })
    }
    
    func saveWhenUserIDHasBeenFetched(userID: String, username: String?,
        callback: (didErorOccur: Bool) -> ()) {
        let textRecord = CKRecord(recordType: "DataStore")
        textRecord.setValue(1, forKey: "HasPet")
        textRecord.setValue(userID, forKey: "UserID")
        textRecord.setValue(username, forKey: "Username")
        privateDB.saveRecord(textRecord, completionHandler:
            { (record, error) -> Void in
            
                if error != nil {
                    NSLog("Not saved to cloud kit")
                    return callback(didErorOccur: true)
                }
                else {
                    NSLog("Saved to cloud kit")
                    return callback(didErorOccur: false)
                }
        })
        return
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