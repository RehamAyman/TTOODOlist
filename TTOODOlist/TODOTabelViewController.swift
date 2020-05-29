//
//  ViewController.swift
//  TTOODOlist
//
//  Created by Reham Ayman on 5/28/20.
//  Copyright © 2020 Reham Ayman. All rights reserved.
//

import UIKit

class TODOTabelViewController: UITableViewController{
    let defaults = UserDefaults.standard
    
    var itemarray = [ "item1" , "item 2 " , "item 3 " , "item4 "]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let itemsdef = UserDefaults.standard.array(forKey: "ItemsKeyStorage") as? [String] {
            itemarray = itemsdef
        }
    }
    
    
    
    // tabel view functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TODOITEMCELL", for: indexPath)
        cell.textLabel?.text = itemarray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemarray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "إضافه قائمة مهام جديده ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title:"تأكيد ", style: .default) { (action) in
            // what will happend when we click add button
            self.itemarray.append(textfield.text!)
            self.defaults.set(self.itemarray, forKey: "ItemsKeyStorage")
            self.tableView.reloadData()
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "إسم القائمه الجديده"
            
            
            textfield = alertTextField
        }
        alert.addAction(action)
        present(alert , animated: true , completion: nil)
    }
    
    
}

