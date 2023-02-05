//
//  DetailViewController.swift
//  FirebaseCRUD
//
//  Created by Manuel Rodriguez Sebastian on 3/2/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addresField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
      
    let detailViewModel: ContactDetailViewModel
    
    init(detailViewModel: ContactDetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        setupContactInfo()
        setupView()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: detailViewModel.isEditing ? "Guardar" : "Crear",
            style: .done,
            target: self,
            action: #selector(saveContact)
        )
    }
    
    private func setupContactInfo() {
        nameField.text = detailViewModel.contact.name ?? ""
        phoneField.text = detailViewModel.contact.phone ?? ""
        addresField.text = detailViewModel.contact.address ?? ""
        deleteButton.isHidden = !detailViewModel.isEditing
    }
    
    private func setupView() {
        nameField.addTarget(self, action: #selector(didChangeTextField), for: .editingChanged)
        phoneField.addTarget(self, action: #selector(didChangeTextField), for: .editingChanged)
        addresField.addTarget(self, action: #selector(didChangeTextField), for: .editingChanged)
    }
    
    @objc func didChangeTextField(_ sender: UITextField) {
        if sender == nameField {
            detailViewModel.contact.name = sender.text ?? ""
        }
        
        if sender == phoneField {
            detailViewModel.contact.phone = sender.text ?? ""
        }
        
        if sender == addresField {
            detailViewModel.contact.address = sender.text ?? ""
        }
    }
    
    @objc func saveContact() {
        if detailViewModel.isEditing {
            detailViewModel.updateContact {
                self.navigationController?.popViewController(animated: true)
            } errorCallback: {
                debugPrint("ERROR")
            }
        } else {
            detailViewModel.addContact {
                self.navigationController?.popViewController(animated: true)
            } errorCallback: {
                debugPrint("ERROR")
            }
        }
    }
    
    @IBAction func didTapDelete(_ sender: Any) {
        detailViewModel.deleteContact {
            self.navigationController?.popViewController(animated: true)
        } errorCallback: {
            debugPrint("ERROR")
        }

    }
}
