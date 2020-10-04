//
//  swipeTableViewController.swift
//  TTOODOlist
//
//  Created by Reham Ayman on 7/5/20.
//  Copyright © 2020 Reham Ayman. All rights reserved.
//

import UIKit
import SwipeCellKit
class swipeTableViewController: UITableViewController ,SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.rowHeight = 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        
        return cell
    }
        
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            guard orientation == .right else { return nil }
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
              self.update(at: indexPath)
            }
            
            // customize the action appearance
            deleteAction.image = UIImage(named: "Trash-circle")
            
            return [deleteAction]
        }
        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .destructive
            
            return options
        }
    func update ( at indexpath: IndexPath) {
        
    }
    }

