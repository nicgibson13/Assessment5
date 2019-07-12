//
//  ContactTableViewCell.swift
//  Assessment5
//
//  Created by Nic Gibson on 7/12/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var contact: Contact? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    func updateViews() {
        guard let contact = contact else { return }
        nameTextField.text = contact.name
        phoneNumberTextField.text = "\(contact.phoneNumber)"
        emailTextField.text = contact.email
    }
    
}
