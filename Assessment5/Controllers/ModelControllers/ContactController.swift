//
//  ContactController.swift
//  Assessment5
//
//  Created by Nic Gibson on 7/12/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    // Private Database
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // Singleton
    static let sharedInstance = ContactController()
    
    // Source of TWOOTH
    var contacts = [Contact]()
    
    // CRUD
    // Create
    func createContactWith(name: String, phoneNumber: Int?, email: String?, completion: @escaping (Contact?) -> Void) {
        // initialize a new contact
        let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        // convert the contact into a record
        let newRecord = CKRecord(contact: newContact)
        // save the record to the DB
        privateDB.save(newRecord) { (record, error) in
            if let error = error {
                print("There was an error in \(#function) : \(error) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            // Make sure there is a record
            guard let record = record,
                // if there is a record, convert it into a contact
                let contact = Contact(ckRecord: record) else { completion(nil) ; return }
            // Add the contact to the source of truth
            self.contacts.append(contact)
            completion(contact)
        }
    }
    // Read
    func fetchAllContacts(completion: @escaping ([Contact]?) -> Void) {
        // 3. create the predicate for the query
        let predicate = NSPredicate(value: true)
        // 2. create the query for the perform
        let query = CKQuery(recordType: ContactConstants.typeKey, predicate: predicate)
        // 1. perform a query to the DB to fetch the desired records
        privateDB.perform(query, inZoneWith: nil) { (record, error) in
            if let error = error {
                print("There was an error in \(#function) : \(error) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            // Make sure the record exists
            guard let records = record else { completion(nil) ; return }
            // Iterate through the new array, creating a contact from each record
            let contacts = records.compactMap({Contact(ckRecord: $0)})
            // Add to source of truth
            self.contacts = contacts
            // Complete with contacts
            completion(contacts)
        }
    }
    // Update
//    func updateContact(contact: Contact, withName name: String, phoneNumber: Int?, )
    func updateContacts(name: String, phoneNumber: Int?, email: String?, completion: @escaping (Bool) -> Void) {
        let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        let newRecord = CKRecord(contact: newContact)
        // 2. initialize the operation
        let operation = CKModifyRecordsOperation()
        // 3. give the operation the required properties
        operation.recordsToSave = [newRecord]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
        }
        // 1. Add an operation that will (hopefully) update the records
        privateDB.add(operation)
    
    // Delete*
    }
}
