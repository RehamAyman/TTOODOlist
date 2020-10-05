//
//  ViewController.swift
//  TTOODOlist
//
//  Created by Reham Ayman on 5/28/20.
//  Copyright © 2020 Reham Ayman. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
class TODOTabelViewController: swipeTableViewController {
    
    let realm = try! Realm()
    
    
    var selectedMainItem : MainItem? {
        didSet {
            loadData()
        }
    }
    
    
    var AllItems : Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         tableView.separatorStyle = .none
        
    }
    
    
    
    // tabel view functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let cellitem = AllItems?[indexPath.row]{
            
            cell.textLabel?.text = cellitem.itemTitle
            if let color = UIColor(hexString: selectedMainItem!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(AllItems!.count)) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                
            }
            
            cell.accessoryType = cellitem.done ? .checkmark : .none
            
        } else {
            
            cell.textLabel?.text = "No Items Added Yet .. "
        }
       
        
        return cell
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let items = AllItems?[indexPath.row] {
        do {
            try realm.write{
                items.done = !items.done
            }
            
           
            
        } catch {
            print("error with saving done property ,., ")
        }
         }
        
       // AllItems[indexPath.row].done = !AllItems[indexPath.row].done
      
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
        
    }
    
    
    
    
    
    
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "إضافه مهمه جديده ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title:"تأكيد ", style: .default) { (action) in
            // what will happend when we click add button
            if let currentmainItem = self.selectedMainItem {
                do {
                    try self.realm.write {
                        let newitem = Item()
                        newitem.itemTitle =  textfield.text!
                        newitem.dateOfCreation = Date()
                        currentmainItem.itemsRel.append(newitem)
                       
                    }
                    
                } catch {
                    print("error saving data  ,\(error)")
                }
        }
            
            
            self.tableView.reloadData()
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "اسم المهمه ... "
            textfield = alertTextField
        }
        
        alert.addAction(action)
        present(alert , animated: true , completion: nil)
    }
    
    
    
    
    //MARK: - save data
    
    //MARK: - load data ?????????????????????????
    func loadData ( ){
        
        
        AllItems = selectedMainItem?.itemsRel.sorted(byKeyPath: "itemTitle", ascending: true)
        self.tableView.reloadData()
    }
    
   
    override func update(at indexpath: IndexPath) {
        if let item = AllItems?[indexpath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            }catch {
                print("error with deleting from todovc \(error)")
            }
        }
    
}

//MARK: - search bar methods
//extension TODOTabelViewController : UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        AllItems = AllItems?.filter("itemTitle CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateOfCreation", ascending: true)
//        tableView.reloadData()
//
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//       if searchBar.text?.count == 0 {
//
//        DispatchQueue.main.async {
//            searchBar.resignFirstResponder()
//        }
//
//            self.loadData()
//        }
//    }
//
//
//    }
}
