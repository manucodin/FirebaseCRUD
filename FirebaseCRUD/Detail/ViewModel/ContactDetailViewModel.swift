//
//  ContactDetailViewModel.swift
//  FirebaseCRUD
//
//  Created by Manuel Rodriguez Sebastian on 5/2/23.
//

import Foundation
import FirebaseFirestore

class ContactDetailViewModel {
    private let dbReference = Firestore.firestore().collection("contacts")
    var contact = Contact()
    
    var isEditing: Bool {
        return contact.id != nil
    }
    
    init(contact: Contact = Contact()) {
        self.contact = contact
    }
    
    func addContact(successCallback: @escaping (() -> Void), errorCallback: @escaping (() -> Void)) {
        do {
            _ = try dbReference.addDocument(from: contact) { error in
                if error != nil {
                    errorCallback()
                } else {
                    successCallback()
                }
            }
        } catch let error {
            debugPrint(error)
            errorCallback()
        }
    }
    
    func updateContact(successCallback: @escaping (() -> Void), errorCallback: @escaping (() -> Void)) {
        guard let id = contact.id else { return }
        
        do {
            try dbReference.document(id).setData(from: contact) { error in
                if error != nil {
                    errorCallback()
                } else {
                    successCallback()
                }
            }
        } catch let error {
            debugPrint(error)
            errorCallback()
        }
    }
    
    func deleteContact(successCallback: @escaping (() -> Void), errorCallback: @escaping (() -> Void)) {
        guard let id = contact.id else { return }
        
        dbReference.document(id).delete { error in
            if error != nil {
                errorCallback()
            } else {
                successCallback()
            }
        }
    }
}
