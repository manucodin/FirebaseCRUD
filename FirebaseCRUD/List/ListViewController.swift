//
//  ListViewController.swift
//  FirebaseCRUD
//
//  Created by Manuel Rodriguez Sebastian on 3/2/23.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 65
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
      
    private let listViewModel = ContactListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listViewModel.fetchContacts {
            self.tableView.reloadData()
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addContact)
        )
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: String(describing: ContactTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ContactTableViewCell.self))
    }
    
    @objc func addContact() {
        let detailViewModel = ContactDetailViewModel()
        let detailViewController = DetailViewController(detailViewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.numberOfContacs
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = listViewModel.contact(atIndexPath: indexPath)
        let detailViewModel = ContactDetailViewModel(contact: contact)
        let detailViewController = DetailViewController(detailViewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactTableViewCell.self), for: indexPath) as! ContactTableViewCell
        let contact = listViewModel.contact(atIndexPath: indexPath)
        cell.contact = contact
        return cell
    }
}
