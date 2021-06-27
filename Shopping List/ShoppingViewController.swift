//
//  ShoppingViewController.swift
//  Shopping List
//
//  Created by Barış Can Akkaya on 25.06.2021.
//

import UIKit
import RealmSwift

class ShoppingViewController: UITableViewController {
    
    
    
    let localRealm = try! Realm()
    
    var shoppingList = [Shopping]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData()
        
        
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new product!", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { alertAction in
            if let text = textField.text {
                let shop = Shopping()
                shop.product = text
                self.shoppingList.append(Shopping(product: text))
                self.saveNewData(data: Shopping(product: text))
            }
        }
        alert.addTextField { UITextField in
            UITextField.placeholder = "Product"
            textField = UITextField
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        let shop = localRealm.objects(Shopping.self)[indexPath.row]
        
        cell.textLabel?.text = shop.product
        cell.accessoryType = shop.isSelected ? .checkmark : .none
        return cell
        
    }
    
    @objc func bos(){
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! localRealm.write {
                localRealm.delete(shoppingList[indexPath.row])
            }
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let shopToUpdate = localRealm.objects(Shopping.self)[indexPath.row]
        print(shopToUpdate.isSelected)
        try! localRealm.write {
            shopToUpdate.isSelected = !shopToUpdate.isSelected
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = shopToUpdate.isSelected ? .checkmark : .none
        
    }

}

extension ShoppingViewController {
    func saveNewData(data: Shopping) {
        do {
            try localRealm.write{
                localRealm.add(data)
            }
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    func loadData() {
        shoppingList.removeAll()
        let shopping = localRealm.objects(Shopping.self)
        for shop in shopping {
            shoppingList.append(shop)
        }
        tableView.reloadData()
    }
}





