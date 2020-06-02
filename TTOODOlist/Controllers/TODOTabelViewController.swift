//
//  ViewController.swift
//  TTOODOlist
//
//  Created by Reham Ayman on 5/28/20.
//  Copyright © 2020 Reham Ayman. All rights reserved.
//

import UIKit

class TODOTabelViewController: UITableViewController{
    
    
    let DataFileBath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("itemsData.plist")
    
    
    var itemarray = [itemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.loadData()
        
    }
    
    
    
    // tabel view functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellitem = itemarray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TODOITEMCELL", for: indexPath)
        cell.textLabel?.text = cellitem.itemTitle
        
        // value = condition? trueValue : FalseValue
        cell.accessoryType = cellitem.doneOrNot ? .checkmark : .none
        
        
        return cell
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemarray[indexPath.row])
        
        itemarray[indexPath.row].doneOrNot = !itemarray[indexPath.row].doneOrNot
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "إضافه قائمة مهام جديده ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title:"تأكيد ", style: .default) { (action) in
            // what will happend when we click add button
            let newitem = itemModel()
            newitem.itemTitle = textfield.text!
            self.itemarray.append(newitem)
            //self.defaults.set(self.itemarray, forKey: "ItemsKeyStorage")
            self.saveData()
            
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "إسم القائمه الجديده"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        present(alert , animated: true , completion: nil)
    }
    
    
    
    // save using encoding
    func saveData () {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemarray)
            try data.write(to: DataFileBath!)
            tableView.reloadData()
        
        } catch {
           print("error encoding with saving data  ,\(error)")
        }
        
        
        
    }
    func loadData () {
        if let data = try? Data(contentsOf: DataFileBath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemarray = try decoder.decode([itemModel].self, from: data)
                
            }catch {
                print("error with decoding data ,\(error) ")
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

