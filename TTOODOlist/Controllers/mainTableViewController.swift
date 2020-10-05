//
//  mainTableViewController.swift
//
//  Created by Reham Ayman on 6/11/20.
//  Copyright © 2020 Reham Ayman. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework




class mainTableViewController: swipeTableViewController {
    let realm = try! Realm()
    
//     let ContainerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    var MainItemArray : Results<MainItem>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
              loadData()
       tableView.separatorStyle = .none
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MainItemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cellitem = MainItemArray?[indexPath.row]
       
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = MainItemArray?[indexPath.row].name ?? "no items added ..  "
        
       
        
        cell.backgroundColor = UIColor(hexString: MainItemArray?[indexPath.row].color ?? "F52D31")
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToTodolist", sender: self)
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! TODOTabelViewController
            if let indexpathh = tableView.indexPathForSelectedRow{
                destinationVC.selectedMainItem = MainItemArray?[indexpathh.row]
            }
        
    
        
    
   
    }
    
    
    

    
    @IBAction func addbutton(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "إضافه قائمة مهام جديده ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title:"تأكيد ", style: .default) { (action) in
            
            // what will happend when we click add button
            
            let newitem = MainItem()
            newitem.name = textfield.text!
            newitem.color = UIColor.randomFlat.hexValue()
            self.saveData(mainitem: newitem)
            
     
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "إسم القائمه الجديده"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        present(alert , animated: true , completion: nil)
    }
    
    
    //MARK: - save data
    
    func saveData (mainitem : MainItem) {
        
        
        do {
            try realm.write {
                realm.add(mainitem)
            }
          
        } catch {
            print("error saving data  ,\(error)")
        }
        self.tableView.reloadData()
        
        
    }
    //MARK: - load data
    
    func loadData  (){
        
        MainItemArray = realm.objects(MainItem.self)
     
        tableView.reloadData()
    }
    
    override func update(at indexpath: IndexPath) {
       
            
            if let item = self.MainItemArray?[indexpath.row] {
                                    do  {
                                        try self.realm.write{
                                            self.realm.delete(item)
                                        }
                                    } catch {
                                        print("error with deleting .. ")
                                    }
                
                                }

        }
    
    
        
    }




