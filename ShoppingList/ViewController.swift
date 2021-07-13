//
//  ViewController.swift
//  ShoppingList
//
//  Created by Atin Agnihotri on 13/07/21.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavBar()
    }
    
    func setNavBar() {
        // Set Nav Bar Title
        title = "Shopping List"
        // Add Item Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptNewItem))
        // Clear List Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
    }
    
    @objc func clearList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptNewItem() {
        let ac = UIAlertController(title: "Enter new item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submit = UIAlertAction(title: "Submit", style: .default) { [weak ac, weak self] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.addNewItem(item)
        }
        ac.addAction(submit)
        present(ac, animated: true)
    }
    
    func addNewItem(_ item: String) {
        guard !item.isEmpty else {
            showError(title: "Error", message: "Name of the item cannot be empty")
            return
        }
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func showError(title: String, message: String) {
        let ec = UIAlertController(title: "⚠️ " + title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        ec.addAction(ok)
        present(ec, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItem", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

}

