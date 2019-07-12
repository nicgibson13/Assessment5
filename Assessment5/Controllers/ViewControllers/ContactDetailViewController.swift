//
//  ContactDetailViewController.swift
//  Assessment5
//
//  Created by Nic Gibson on 7/12/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var contact: Contact?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
        let phoneNumber = phoneNumberTextField.text,
        let email = emailTextField.text, !name.isEmpty
            else { return }
        if contact == nil {
            ContactController.sharedInstance.createContactWith(name: name, phoneNumber: Int(phoneNumber), email: email) { (true) in
            }
        } else {
            ContactController.sharedInstance.updateContacts(name: name, phoneNumber: Int(phoneNumber), email: email) { (success) in
                print("yay")
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
