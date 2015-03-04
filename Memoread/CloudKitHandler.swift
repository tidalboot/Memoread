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
    
    
    func doesUserHavePet (callback: (userHasPet: Bool) -> ()) {
        
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
                        return callback(userHasPet: userHasPet)
                    }
                    println("After fetching data userHasPet boolean is \(userHasPet)")
                })
            }
        })
        return
    }
    
    func getUserID (callback: (userID: String) -> ()) {
        var userID : String!
        container.fetchUserRecordIDWithCompletionHandler { (recordID, errorMessage
            ) -> Void in
            userID = recordID.recordName
            return callback(userID: userID)
        }
        return
    }
    
    func saveTextWhenUserIDHasBeenFetched(userID: String) {
        let textRecord = CKRecord(recordType: "DataStore")
        textRecord.setValue(1, forKey: "HasPet")
        textRecord.setValue(userID, forKey: "UserID")
        privateDB.saveRecord(textRecord, completionHandler: { (record, error) -> Void in
            NSLog("Saved to cloud kit")
        })
    }
//    
//    func saveText() {
//        let textRecord = CKRecord(recordType: "DataStore")
//        var lol = textRecord.recordID
//        textRecord.setValue(1, forKey: "HasPet")
//        textRecord.setValue("_b6957aeb96fbcf69fd3b80638e113f26", forKey: "UserID")
//        privateDB.saveRecord(textRecord, completionHandler: { (record, error) -> Void in
//            NSLog("Saved to cloud kit")
//        })
//        var lolol = CKRecord(recordType: "DataStore", recordID: lol)
//        var trolol = lolol.creatorUserRecordID
//    }
    
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