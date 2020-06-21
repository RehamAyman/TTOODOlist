//
//  ViewController.swift
//  TTOODOlist
//
//  Created by Reham Ayman on 5/28/20.
//  Copyright © 2020 Reham Ayman. All rights reserved.
//

import UIKit
import CoreData

class TODOTabelViewController: UITableViewController{
    
    let ContainerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var selectedMainItem : Main? {
        didSet {
            loadData()
        }
    }
    
     //    let DataFileBath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("itemsData.plist")
    
    
    var itemarray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
       
        
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
        cell.accessoryType = cellitem.done ? .checkmark : .none
        
        
        return cell
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemarray[indexPath.row])
        
        itemarray[indexPath.row].done = !itemarray[indexPath.row].done
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    
    
    
    
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "إضافه مهمه جديده ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title:"تأكيد ", style: .default) { (action) in
            // what will happend when we click add button
            let newitem = Item(context: self.ContainerContext)
            newitem.itemTitle = textfield.text!
            newitem.done = false
            newitem.mainitem = self.selectedMainItem
            self.itemarray.append(newitem)
            //self.defaults.set(self.itemarray, forKey: "ItemsKeyStorage")
            self.saveData()
            
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "اسم المهمه ... "
            textfield = alertTextField
        }
        
        alert.addAction(action)
        present(alert , animated: true , completion: nil)
    }
    
    
    
    
    //MARK: - save data
    func saveData () {
    
        
        do {
           try ContainerContext.save()
           
        
        } catch {
           print("error saving data  ,\(error)")
        }
         self.tableView.reloadData()
        
        
    }
    //MARK: - load data ?????????????????????????
    func loadData (with request : NSFetchRequest <Item> = Item.fetchRequest() , predicate : NSPredicate? = nil ){
        
        
        
        let selMainItempredicate = NSPredicate(format: "mainitem.name MATCHES %@", selectedMainItem!.name!)
        
        if let additionalpredecaite = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [selMainItempredicate , additionalpredecaite])
        } else {
            request.predicate = selMainItempredicate
        }
        //let comppredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate,selMainItempredicate])
        //request.predicate = comppredicate
        do {
            try itemarray = ContainerContext.fetch(request)
        } catch {
            print("error with loading data .. ")
        }
        self.tableView.reloadData()
    }
    
   
    
    
}

//MARK: - search bar methods
extension TODOTabelViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let req : NSFetchRequest<Item> = Item.fetchRequest()
        //req.predicate = NSPredicate(format: "itemTitle CONTAINS[cd] %@", searchBar.text!)
         let predicate = NSPredicate(format: "itemTitle CONTAINS[cd] %@", searchBar.text!)
        req.sortDescriptors = [NSSortDescriptor(key: "itemTitle", ascending: true)]
        
        loadData(with: req, predicate: predicate)
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       if searchBar.text?.count == 0 {
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
            
            self.loadData()
        }
    }
    
    
}
