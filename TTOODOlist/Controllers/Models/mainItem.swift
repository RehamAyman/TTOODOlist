//
//  mainItem.swift
//  TTOODOlist
//
//  Created by Reham Ayman on 6/23/20.
//  Copyright © 2020 Reham Ayman. All rights reserved.
//

import Foundation
import RealmSwift
class MainItem : Object  {
   @objc dynamic var name : String = ""
   @objc dynamic var color : String = ""
    
    // relationship with items
    
    var itemsRel = List<Item>()
}
