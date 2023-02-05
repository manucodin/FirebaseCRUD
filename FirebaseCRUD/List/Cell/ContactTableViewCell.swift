//
//  ContactTableViewCell.swift
//  FirebaseCRUD
//
//  Created by Manuel Rodriguez Sebastian on 3/2/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var contact: Contact? {
        didSet {
            guard let contact else { return }
        
            setup(contact)
        }
    }
    
    private func setup(_ contact: Contact) {
        nameLabel.text = contact.name ?? ""
        phoneLabel.text = contact.phone ?? ""
    }
}
