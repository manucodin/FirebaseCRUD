//
//  ContactListViewModel.swift
//  FirebaseCRUD
//
//  Created by Manuel Rodriguez Sebastian on 5/2/23.
//

import Foundation
import FirebaseFirestore

class ContactListViewModel {
    private let dbReference = Firestore.firestore().collection("contacts")
    private (set) var contacts = [Contact]()
    
    var numberOfContacs: Int {
        return contacts.count
    }
    
    func contact(atIndexPath indexPath: IndexPath) -> Contact {
        return contacts[indexPath.row]
    }
    
    func fetchContacts(successCallback: @escaping (() -> Void)) {
        dbReference.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            
            self.contacts = documents.compactMap{ try? $0.data(as: Contact.self) }
            successCallback()
        }
    }
}
