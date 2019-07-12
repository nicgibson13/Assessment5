//
//  Contact.swift
//  Assessment5
//
//  Created by Nic Gibson on 7/12/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    var name: String
    var phoneNumber: Int?
    var email: String?
    let ckRecordID: CKRecord.ID
    
    init(name: String, phoneNumber: Int?, email: String?, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.ckRecordID = ckRecordID
    }

    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[ContactConstants.nameKey] as? String,
        let phoneNumber = ckRecord[ContactConstants.phoneNumberKey] as? Int?,
            let email = ckRecord[ContactConstants.emailKey] as? String? else {return nil}
        
        self.init(name: name, phoneNumber: phoneNumber, email: email, ckRecordID: ckRecord.recordID)
        
    }
}

extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ContactConstants.typeKey, recordID: contact.ckRecordID)
        self.setValue(contact.name, forKey: ContactConstants.nameKey)
        self.setValue(contact.phoneNumber, forKey: ContactConstants.phoneNumberKey)
        self.setValue(contact.email, forKey: ContactConstants.emailKey)
    }
    
}

struct ContactConstants {
    static let typeKey = "Contact"
    fileprivate static let nameKey = "name"
    fileprivate static let phoneNumberKey = "number"
    fileprivate static let emailKey = "email"
}
